class Licenses::ArchivesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_license

  def create
    @license.archive
    redirect_to licenses_path, notice: "License has been archived."
  end

  private

  def set_license
    @license = current_user.licenses.find(params[:license_id])
  end
end
