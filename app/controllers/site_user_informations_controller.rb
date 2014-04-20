class SiteUserInformationsController < ApplicationController
  def show
    @site_user_information = SiteUserInformation.find(params[:id])
    @title = @site_user_information.to_title
  end

  def edit
    @site_user_information = SiteUserInformation.find(params[:id])
  end

  def update
    @site_user_information = SiteUserInformation.find(params[:id])
    @site_user_information.update_attributes(site_user_information_params)
    if @site_user_information
      redirect_to site_user_information_path(@site_user_information)
    else
      redirect_to edit_site_user_information_path(@site_user_information)
    end
  end

  def destroy
    SiteUserInformation.find(params[:id]).destroy
  end

  private

  def site_user_information_params
    params.require(:site_user_information).permit(:site_user, :name, :surname, :nick, :date_of_birth, :reputation, :country)
  end


end
