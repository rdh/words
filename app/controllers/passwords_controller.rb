class PasswordsController < ApplicationController

  def index
    @passwords = Passwords.new
  end

  def create
    @passwords = Passwords.new( params )
    render :action => ( @passwords.valid? ? :edit : :index )
  end
end