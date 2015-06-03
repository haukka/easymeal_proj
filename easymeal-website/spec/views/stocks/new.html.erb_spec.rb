# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "stocks/new" do
  before(:each) do
    assign(:stock, stub_model(Stock,
      :home_id => 1
    ).as_new_record)
  end

  it "renders new stock form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stocks_path, "post" do
      assert_select "input#stock_home_id[name=?]", "stock[home_id]"
    end
  end
end
