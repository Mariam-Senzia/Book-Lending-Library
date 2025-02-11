class AuthController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:signup, :login]
    def signup
        user = User.new(user_params)
    
        if user.save
            respond_to do |format|
                format.html { redirect_to login_path, notice: "User created successfully" }
                format.json { render json: { message: "User created successfully", user: user }, status: :created }
            end
        else
            respond_to do |format|
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: { errors: user.errors.full_messages }, status: :unprocessable_entity }
            end
        end
    end
    

    def login
        user = User.find_by(email: params[:email])
    
        if user&.authenticate(params[:password])
            session[:id] = user.id
            respond_to do |format|
                format.html { redirect_to books_path, notice: "Login successful" }
                format.json { render json: { message: "Login successful", user: user }, status: :ok }
        end
        else
            respond_to do |format|
                format.html { render :new, alert: "Invalid email or password" }
                format.json { render json: { error: "Invalid email or password" }, status: :unauthorized }
            end
        end
    end

    private

        def user_params
            params.require(:user).permit(:name, :email, :password)
        end
end
