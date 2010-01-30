class JavascriptFunction < String
  def initialize(*args)
    super()
    if args.size == 1
      arguments = []
      code = args[0]
    else
      arguments = args[0]
      code = args[1]
    end
    self << %Q[function(#{arguments.join(', ')}) { #{code} }]
  end

  def to_json(*args)
    self
  end
end
