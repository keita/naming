require 'set'

require 'forwardablex'
require 'structx'

require 'naming/version'
require 'naming/meta'
require 'naming/name-set'

# Naming is a module for generating naming classes that consist by name and
# value. Naming classes are generated dynamically when you refer it.
#
# @example
#   #
#   # naming object of A with the value 123
#   #
#   a = Naming.A(123)
#   a.value #=> 123
#   a.name  #=> :A
#   a.class #=> Naming::A
# @example
#   #
#   # collect objects by name
#   #
#   list = [
#     Naming.A(1),
#     Naming.B(2),
#     "abc",
#     Naming.A(3),
#     123,
#     nil
#   ]
#   # collect values of A objects
#   Naming::A.values(list) #=> [1, 3]
#   # collect values of B objects
#   Naming::B.values(list) #=> [2]
#   # collect objects excluding naming objects
#   Naming.others(list)    #=> ["abc", 123, nil]
# @example
#   #
#   # case control flow with name
#   #
#   def message(obj)
#     case obj
#     when Naming::A
#       "This is case A: %s" % obj.value
#     when Naming::B
#       "This is case B: %s" % obj.value
#     else
#       "This is case others: %s" % obj
#     end
#   end
#   message(Naming.A(1)) #=> "This is case A: 1"
#   message(Naming.B(2)) #=> "This is case B: 2"
#   message(true) #=> "This is case others: true"
module Naming
  class << self
    # Generate a new naming class and call the constructor with value.
    #
    # @api private
    def method_missing(name, *args)
      const_get(name)
      send(name, *args)
    end

    # Generate a new naming class.
    #
    # @api private
    def const_missing(name)
      cls = Class.new(Meta)
      self.singleton_class.class_exec do
        define_method(name) do |value|
          cls.new(value)
        end
      end
      const_set(name, cls)
    end

    # Collect objects from the array excluding naming objects.
    #
    # @param array [Array]
    #   collection target array
    #
    # @example
    #   Naming.others([
    #     Naming.A(1),
    #     Naming.B(2),
    #     "abc",
    #     Naming.A(3),
    #     123,
    #     nil
    #   ]) #=> ["abc", 123, nil]
    def others(array)
      array.select{|elt| not(elt.kind_of?(Meta))}
    end

    # Return the name set object.
    #
    # @param names [Array<Symbol>]
    #   names
    # @return [NameSet]
    def [](*names)
      NameSet.new(*names)
    end
  end
end
