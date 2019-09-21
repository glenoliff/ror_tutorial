class UsersController < ApplicationController

  def new
  end

  def show
  	@user = User.find(params[:id])
  	#puts @user.attributes.to_yaml
  end
end
