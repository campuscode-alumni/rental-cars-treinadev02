class ApplicationController < ActionController::Base
    before_action :subsidiary_start, if: :devise_controller?, only: [:new]
    
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:subsidiary_id])
    end

    private 

    def subsidiary_start
        @subsidiaries = Subsidiary.all
    end

end
