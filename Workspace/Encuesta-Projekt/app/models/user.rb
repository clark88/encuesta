# == Schema Information
# Schema version: <timestamp>
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  vorname    :string(255)
#  email      :string(255)
#  login      :string(255)
#  passwort   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :surveys
  belongs_to :roll

  attr_accessor :passwort
  attr_accessible :name, :vorname, :email, :login, :passwort, :passwort_confirmation


  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
                  :length   => { :maximum => 50 }

  validates :vorname, :presence => true

  validates :email, :presence => true,
                   :format   => { :with => email_regex },
                   :uniqueness => { :case_sensitive => false }

  validates :login, :presence => true

  # Automatically create the virtual attribute 'passwort_confirmation'.
  validates :passwort, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

   before_save :encrypt_passwort

  def has_password?(submitted_passwort)
    encrypted_passwort == encrypt(submitted_passwort)
  end
  
   def self.authenticate(login, submitted_passwort)
    user = find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_passwort)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end



  private

    def encrypt_passwort
      self.salt = make_salt if new_record?
      self.encrypted_passwort = encrypt(passwort)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{passwort}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    
    
    

end