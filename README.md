# naming

naming is a ruby library for generating classes that consist from name and
value. You can get naming class by sending class method +[]+ with the
name.

## Installation

    $ gem install naming

## Usage

### Basic

```ruby
#
# naming object of A with the value 123
#
a = Naming.A(123)
a.value #=> 123
a.name  #=> :A
a.class #=> Naming::A
````

### Collect values by name from array

```ruby
#
# collect objects by name
#
list = [
  Naming.A(1),
  Naming.B(2),
  "abc",
  Naming.A(3),
  123,
  nil
]
# collect values of A objects
Naming::A.values(list) #=> [1, 3]
# collect values of B objects
Naming::B.values(list) #=> [2]
# collect objects excluding naming objects
Naming.others(list)    #=> ["abc", 123, nil]
```

### Case Selecting

```ruby
#
# case control flow with name
#
def message(obj)
  case obj
  when Naming::A
    "This is case A: %s" % obj.value
  when Naming::B
    "This is case B: %s" % obj.value
  else
    "This is case others: %s" % obj
  end
end
message(Naming.A(1)) #=> "This is case A: 1"
message(Naming.B(2)) #=> "This is case B: 2"
message(true) #=> "This is case others: true"
```

## Licence

naming is free software distributed under MIT licence.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
