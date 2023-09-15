class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 8 } 

  def self.authenticate_with_credentials(email, password)
    trimed_email = email.gsub(/\s+/, '') # removes extra spaces
    user = self.find_by_email(trimed_email) # self.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end 

  # override default find_by_email to implement a case-insensitive search by email
  def self.find_by_email(email)
    User.where('lower(email) = ?', email.downcase).first
  end 

end
