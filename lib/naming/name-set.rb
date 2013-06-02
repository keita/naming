module Naming
  class NameSet < Set
    # @param names [Array<Symbol,Naming::Meta>]
    #   element names of the set
    def initialize(*names, &b)
      elts = names.map {|name| name.kind_of?(Symbol) ? Naming.const_get(name) : name}
      super(elts, &b)
    end

    # Extract values which have the same name from the array.
    #
    # @param array [Array]
    #   target of value extraction
    #
    # @example
    #   Naming::NameSet.new(:A, :B).values([
    #     Naming.A(1),
    #     Naming.B(2),
    #     "abc",
    #     Naming.A(3),
    #     123,
    #     nil
    #   ]) #=> [1, 2, 3]
    def values(array)
      array.select{|elt| any?{|name| elt.kind_of?(name)}}.map{|elt| elt.value}
    end

    def others(array)
      array.select{|elt| not(any?{|name| elt.kind_of?(name)})}
    end
  end
end
