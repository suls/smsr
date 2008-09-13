require File.dirname(__FILE__) + '/../spec_helper'

require 'fileutils'
require 'date'

describe SmsR::Config, "fresh" do

  before(:each) do
    @test_file = "/tmp/smsr_test"
    FileUtils.rm @test_file, :force => true
  end
  
  after(:each) do
    FileUtils.rm @test_file, :force => true
  end
  
  it "should create new file while saving" do
    c = SmsR::Config.new @test_file
    c.save!
    
    File.exists?(@test_file).should be_true
  end

  it "should initialize new config while loading" do
    c = SmsR::Config.load @test_file
    
    c.should be_instance_of(SmsR::Config)
  end
end

describe SmsR::Config, "existing" do
  before(:each) do
    @test_file = "/tmp/smsr_test"
    FileUtils.touch @test_file
  end
  
  after(:each) do
    FileUtils.rm @test_file, :force => true
  end
  
  it "should use file for saving" do
    before_t = DateTime.parse(File.stat(@test_file).mtime.to_s)
    
    c = SmsR::Config.new @test_file
    sleep 1 # FIXME: remove sleeper. find better way
    c.save!    
    
    after_t = DateTime.parse(File.stat(@test_file).mtime.to_s)    
    after_t.should > before_t
  end
  
  it "should read config while loading" do
    c_created = SmsR::Config.new @test_file
    c_created.save!
    
    c_loaded = SmsR::Config.load @test_file
    c_loaded.last_saved.should eql(c_created.last_saved)
  end
  
  it "should check if the config version is compatible" 
end

describe SmsR::Config, "accessing values" do
  it "should store user,pwd for a given provider"
  it "should return the stored values for the rovider"
end
