class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  # To test the mailer view:
  # http://localhost:3000/rails/mailers/user_mailer/welcome

  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'Bienvenue sur iLunch')
  end
end
