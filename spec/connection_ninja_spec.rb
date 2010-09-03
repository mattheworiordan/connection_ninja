require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe ActiveRecord::Base, "methods" do
  before do
    ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
  end

  it "should have configurations" do
    ActiveRecord::Base.configurations.should_not == {}
  end

  it "should have connection ninja methods" do
    ActiveRecord::Base.should respond_to(:use_connection_ninja)
  end
end

describe ConnectionNinja::Orms::ActiveRecord, "exception" do
  it "should raise an error if connection group not in database.yml" do
    lambda{ActiveRecord::Base.use_connection_ninja(:fial)}.should raise_error(::ActiveRecord::AdapterNotFound)
  end
end

describe Customer do
  before do
    ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
    @connection = Customer.establish_connection
  end
  
  it "should be connected to the default database" do
    Customer.connection.execute('SELECT name FROM db').should == [{"name"=>'ninja_one', 0=>"ninja_one"}]
  end
end

describe Order do
  before do
    ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
    @connection = Order.send(:use_connection_ninja, :other)
  end

  it "should return correct configuration" do
    Order.send(:ninja_config, :other).should == {"adapter"=>"sqlite3", "database"=>"spec/db/ninja_two.sqlite3"}
  end

  it "should be connected to the alternate database" do
    Order.connection.execute('SELECT name FROM db').should == [{"name"=>'ninja_two', 0=>"ninja_two"}]
  end
end