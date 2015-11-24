class PasswordsController < ApplicationController

  def index
  end

  def create
    @passwords = Passwords.new( params )
    render :action => :edit
  end
end