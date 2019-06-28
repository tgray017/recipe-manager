class User < ActiveRecord::Base
  has_many :recipes
  has_secure_password
  
  def self.current_user(session)
    User.find(session[:user_id])
  end
  
  def self.logged_in?(session)
    !!session[:user_id]
  end  
  
end

