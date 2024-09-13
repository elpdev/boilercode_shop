class Billings::InfosController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update(billing_params)
      flash[:notice] = "Billing info saved successfully."
    else
      flash[:alert] = "Something went wrong."
    end
    redirect_back_or_to billing_path
  end

  private

  def billing_params
    params.require(:user).permit(:extra_billing_info)
  end
end
