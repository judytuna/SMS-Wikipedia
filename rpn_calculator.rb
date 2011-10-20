class RPNCalculator 

  def initialize
    @myarray = []
  end
  
  def push(i)
    @myarray << i
  end
  
  def plus
    a = @myarray.pop
    b = @myarray.pop
    if (a == nil) || (b == nil)
      raise "calculator is empty"
    else
      @myarray << b + a
    end
  end

  def minus
    a = @myarray.pop
    b = @myarray.pop
    if (a == nil) || (b == nil)
      raise "calculator is empty"
    end
    @myarray << (b - a)
  end

  def divide
    a = @myarray.pop
    b = @myarray.pop
    if (a == nil) || (b == nil)
      raise "calculator is empty"
    end
    @myarray << ((b + 0.0) / a)
  end

  def times
    a = @myarray.pop
    b = @myarray.pop
    if (a == nil) || (b == nil)
      raise "calculator is empty"
    end
    @myarray << (b * a)
  end

  def value
    @myarray.last
  end

  def tokens(str)
    thisarray = []
    str.split.each do |thing|
      if thing =~ /\d/
        thisarray << thing.to_i
      else
        thisarray << thing.to_sym
      end
    end
    return thisarray
  end 

  def evaluate(str)
    tokens(str).each do |thing|
      case thing
        when :+
          plus
        when :-
          minus
        when :*
          times
        when :/
          divide
        else
          push(thing)
      end
      
    end
    value
  end
  
end
