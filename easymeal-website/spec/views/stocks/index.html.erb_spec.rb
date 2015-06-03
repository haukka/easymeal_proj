# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "stocks/index" do
  before(:each) do
    assign(:stocks, [
      stub_model(Stock,
        :home_id => 1
      ),
      stub_model(Stock,
        :home_id => 1
      )
    ])
  end

  it "renders a list of stocks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
