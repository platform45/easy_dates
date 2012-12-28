require 'spec_helper'

class Record < ActiveRecord::Base
  attr_accessible :start_date

  attr_accessible :formatted_start_date

  define_easy_dates do
    format_for :start_date, :format => "%m/%d/%Y", :type => :date
  end
end


describe EasyDates do
  it "should create a valid DateTime" do
    check = DateTime.parse("2012/12/21")
    record = Record.new(:formatted_start_date => "12/21/2012")
    record.start_date.should eq check
  end
  
  it "should allow nill dates" do
    record = Record.create(:formatted_start_date => nil)
    record.save.should be_true
  end
end
