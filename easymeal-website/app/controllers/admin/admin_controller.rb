class Admin::AdminController < ApplicationController
  before_action :adminOnly
  
  layout "admin"
  
end