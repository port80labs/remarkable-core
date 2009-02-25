require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Remarkable::DSL::Optionals do
  before(:each) do
    @matcher = Remarkable::Specs::Matchers::BeAPersonMatcher.new
  end

  it "should create optional methods on the fly" do
    @matcher.first_name('José')
    @matcher.instance_variable_get('@options')[:first_name].should == 'José'

    @matcher.last_name('Valim')
    @matcher.instance_variable_get('@options')[:last_name].should == 'Valim'
  end

  it "should allow defaults values" do
    @matcher.age
    @matcher.instance_variable_get('@options')[:age].should == 18
  end

  it "should allow alias to be set" do
    @matcher.family_name('Valim')
    @matcher.instance_variable_get('@options')[:last_name].should == 'Valim'
  end

  it 'should provide a description with optionals' do
    @matcher = Remarkable::Specs::Matchers::SingleContainMatcher.new(1)
    @matcher.description.should == 'contain 1 and not checking for blank'

    @matcher.allow_blank(10)
    @matcher.description.should == 'contain 1 and blank equal 10'

    @matcher.allow_blank(true)
    @matcher.description.should == 'contain 1 and blank equal true'

    @matcher.allow_nil(true)
    @matcher.description.should == 'contain 1, allowing nil, and blank equal true'

    @matcher.allow_nil(false)
    @matcher.description.should == 'contain 1, not allowing nil, and blank equal true'
  end
end
