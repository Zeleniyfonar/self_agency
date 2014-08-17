class SessionsController < ApplicationController
  skip_before_action :authorize
  def new  
  end

  def create
    client = Client.find_by(email: params[:session_user][:email].downcase)
    
    if client && client.authenticate(params[:session_user][:password]) 
      # Sign the client in and redirect to the client's show page.
      if !client.active?
        #redirect_to '', notice: "Вы ещё не активировали пользователя"
        # Create an error message and re-render the signin form.
        flash.now[:error] = 
          'Вы ещё не активировали пользователя.<br>
          Пожалуйста зайдите на электронную почту и подтвердите регистрацию.'.html_safe # Not quite right!
        render 'new'
      else
        sign_in client
        flash[:success] = "Здравствуйте, #{client.name}. Вы вошли на сайт.";
        redirect_back_or ''
      end
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 
        'Введена неправильная комбиация почты и пароля.<br>
        Пожалуйста, повторите попытку.'.html_safe # Not quite right!
      render 'new'
    end  
  end

  def destroy
    sign_out
    redirect_to ''
  end
end
