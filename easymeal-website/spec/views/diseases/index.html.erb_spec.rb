# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "diseases/index" do
  before(:each) do
    assign(:diseases, [
      stub_model(Disease),
      stub_model(Disease)
    ])
  end

  it "renders a list of diseases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
