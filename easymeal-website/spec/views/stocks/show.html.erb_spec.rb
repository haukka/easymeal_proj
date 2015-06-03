# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "stocks/show" do
  before(:each) do
    @stock = assign(:stock, stub_model(Stock,
      :home_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
