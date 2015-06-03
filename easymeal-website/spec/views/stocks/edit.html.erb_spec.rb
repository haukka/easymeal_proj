# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "stocks/edit" do
  before(:each) do
    @stock = assign(:stock, stub_model(Stock,
      :home_id => 1
    ))
  end

  it "renders the edit stock form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stock_path(@stock), "post" do
      assert_select "input#stock_home_id[name=?]", "stock[home_id]"
    end
  end
end
