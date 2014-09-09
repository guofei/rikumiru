class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_check, only: [:set_admin_cookie]

  def set_admin_cookie
    if (cookies[:showadmin] == 't')
      cookies[:showadmin] = { :value => 'f' }
    else
      cookies[:showadmin] = { :value => 't' }
    end
    redirect_to request.referrer || root_path
  end
end
