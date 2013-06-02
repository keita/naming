module Naming
  # Meta is a container of name and value. This is super class of all naming
  # classes.
  class Meta < StructX
    class << self
      # Extract values which have the same name from the array.
      #
      # @param array [Array]
      #   target of value extraction
      #
      # @example
      #   Naming::A.values([
      #     Naming.A(1),
      #     Naming.B(2),
      #     "abc",
      #     Naming.A(3),
      #     123,
      #     nil
      #   ]) #=> [1, 3]
      def values(array)
        array.select{|elt| elt.kind_of?(self)}.map{|elt| elt.value}
      end

      # Collect objects from the array excluding named objects which have the
      # same name.
      #
      # @param array [Array]
      #   target of value extraction
      #
      # @example
      #   Naming::A.values([
      #     Naming.A(1),
      #     Naming.B(2),
      #     "abc",
      #     Naming.A(3),
      #     123,
      #     nil
      #   ]) #=> [Naming.B(2), "abc", 123, nil]
      def others(array)
        array.select{|elt| not(elt.kind_of?(self))}
      end

      # Return the name as symbol. It is just name, doesn't include module path.
      #
      # @return [Symbol]
      #   the name
      #
      # @example
      #   Naming::A.name #=> :A
      def name
        self.to_s.split("::").last.to_sym
      end
    end

    forward :class, :name
    member :value
  end
end
