module Madmin
  class Users::ImpersonatesController < ApplicationController
    before_action :set_user

    def create
      impersonate_user(@user)
      redirect_to main_app.root_path
    end

    def destroy
      stop_impersonating_user
      redirect_to main_app.root_path
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
