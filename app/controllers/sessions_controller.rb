class SessionsController < ApplicationController

    def new
    end

    def create
        entered_email = params["email"]
        entered_password = params ["password"]
        #check email
        @user = User.find_by({email: entered_email}) #use find_by when expecting only one value
        
        if @user # yes, email matches
            #check the password 
            if BCrypt::Password.new(@user.password) == entered_password
                #password matches
                flash[:notice] = "Welcome!"
                redirect_to "/companies"
            else
                flash[:notice] = "Password is incorrect"
                redirect_to "/sessions/new"
            end

        else 
            #email doesn't match, send back to the login page
            flash[:notice] = "Email does not match"
            redirect_to "/sessions/new"
        end
    end
