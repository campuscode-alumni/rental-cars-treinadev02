class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def new
        @user = User.new
        @subsidiarys = Subsidiary.all
    end

    def show
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = 'Usuario criado com sucesso'
            redirect_to @user
        else 
            @subsidiarys = Subsidiary.all
            render :new
        end
    end
    
    private 

    def user_params
        require(:user).permit(:email,:password,:subsidiarys_id)
    end
end