class ApplicationController < ActionController::Base

  protected

  def authorize_admin
    unless current_user.admin?
      flash[:notice] = 'Você não tem autorização para realizar esta ação'
      redirect_to root_path
    end
  end
end
