require 'naming'

describe 'Naming' do
  it 'should generate a class dynamically' do
    Naming::A.should.be.kind_of Class
  end

  it 'should have name' do
    Naming::A.name.should == :A
    Naming.A(1).name.should == :A
  end

  it 'should have value' do
    Naming.A(1).value.should == 1
    Naming.A(true).value.should == true
    Naming.A("str").value.should == "str"
  end

  it 'should filter by name' do
    list = [
      Naming.A(1),
      Naming.B(2),
      "abc",
      Naming.A(3),
      123,
      nil
    ]
    Naming::A.values(list).should == [1, 3]
    Naming::B.values(list).should == [2]
    Naming.others(list).should == ["abc", 123, nil]
  end

  it 'should equal when the names and values are same' do
    Naming.A(1).should == Naming.A(1)
  end

  it 'should equal when names are different' do
    Naming.A(1).should.not == Naming.B(1)
  end

  it 'should equal when values are different' do
    Naming.A(1).should.not == Naming.A(2)
  end
end
