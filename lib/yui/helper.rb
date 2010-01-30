module YUI::Helper
  # renders a YUILoader block, requiring the given `libs'.
  #
  # This helper can be used in two forms:
  # - in ERb views:
  #   <% yui 'data_table' do %>
  #     // some JS-code, executed after the required libraries have been loaded
  #   <% end %>
  # - in arbitrary ruby code (e.g. helpers)
  #   yui do |js|
  #     js << "// js code"
  #     js << "// and more js code"
  #   end
  #
  # In the latter version `yui' will return the whole javascript code instead of
  # using `concat' to render it.
  #
  # if the last argument is a Hash, it will be used as additional options for YUILoader.
  # Example:
  #   yui 'data_table', :loadOptional => false do |js|
  #     # ...
  #   end
  #
  def yui(*libs, &block)
    output = ''
    output << javascript_include_tag(YUI::Configuration.build_url + '/yuiloader/yuiloader.js') unless @controller.instance_variable_get("@yui_loader_included")
    @controller.instance_variable_set("@yui_loader_included", true)
    options = (libs.last.kind_of?(Hash) ? libs.pop : { })
    js = ''
    if block.arity > 0 # used in ruby code
      block.call(js)
    else # used in erb view
      js = capture(&block)
    end
    loader_opts = {
      :require => libs,
      :base => YUI::Configuration.build_url,
      :loadOptional => true,
      :onSuccess => js_function(js)
    }.merge(options)
    output << javascript_tag(%Q{
      var loader = new YAHOO.util.YUILoader(#{loader_opts.to_json});
      loader.insert();
    })
    block.arity > 0 ? output : concat(output)
  end

  # renders a YAHOO.widget.Layout widget with the given options
  # valid options are described in http://developer.yahoo.com/yui/docs/YAHOO.widget.Layout.html
  def yui_layout(options)
    yui 'layout' do |js|
      js << %Q[var layout = new YAHOO.widget.Layout(#{options.to_json});]
      js << %Q[layout.render();]
    end
  end

  # renders a YAHOO.widget.Panel widget.
  # `element' is the DOM ID of the element to be used as the panels content.
  # valid options are described in http://developer.yahoo.com/yui/docs/YAHOO.widget.Panel.html
  def yui_panel(element, options)
    yui 'panel' do |js|
      js << %Q[var panel = new YAHOO.widget.Panel(#{element.to_json}, #{options.to_json});]
      js << %Q[panel.render();]
    end
  end

  # builds an anonymous JavaScript function that is correctly rendered on #to_json
  #
  # Examples:
  #   js_function("alert('foo');")
  #     #=> "function() { alert('foo'); }"
  #
  #   js_function(['foo'], "alert(foo);")
  #     #=> "function(foo) { alert(foo); }"
  def js_function(*args)
    JavascriptFunction.new(*args)
  end
end
