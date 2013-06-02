require 'naming'

$list = [
  Naming.A(1),
  Naming.B(2),
  "abc",
  Naming.A(3),
  123,
  nil
]

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
    Naming::A.values($list).should == [1, 3]
    Naming::B.values($list).should == [2]
    Naming.others($list).should == ["abc", 123, nil]
  end

  it 'should equal when the names and values are same' do
    Naming.A(1).should == Naming.A(1)
  end

  it 'should not equal when names are different' do
    Naming.A(1).should.not == Naming.B(1)
  end

  it 'should not equal when values are different' do
    Naming.A(1).should.not == Naming.A(2)
  end

  it 'should get the name set' do
    Naming[:A, :B].should.kind_of(Naming::NameSet)
    Naming[:A, :B].should.include(Naming::A)
    Naming[:A, :B].should.include(Naming::B)
  end
end

describe "Naming::Meta" do
  it "should get values" do
    Naming::A.values($list).should == [1, 3]
  end

  it "should get others" do
    Naming::A.others($list).should == [Naming.B(2), "abc", 123, nil]
  end

  it "should get the name" do
    Naming::A.name.should == :A
  end
end

describe "Naming::NameSet" do
  before do
    @set = Naming::NameSet.new(:A, :B)
  end

  it 'should be a set' do
    @set.should.kind_of(Set)
  end

  it 'should include element names' do
    @set.should.include Naming::A
    @set.should.include Naming::B
  end

  it "should not include other names" do
    @set.should.not.include Naming::C
  end

  it 'should get the values' do
    @set.values($list).should == [1, 2, 3]
  end

  it 'should get other values' do
    @set.others($list).should == ["abc", 123, nil]
  end
end
