class Admin::DashboardController < ApplicationController

  before_filter :must_be_admin

  def show
  end
end
