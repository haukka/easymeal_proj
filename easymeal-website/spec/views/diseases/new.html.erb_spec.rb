# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "diseases/new" do
  before(:each) do
    assign(:disease, stub_model(Disease).as_new_record)
  end

  it "renders new disease form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", diseases_path, "post" do
    end
  end
end
