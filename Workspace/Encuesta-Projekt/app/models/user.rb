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
  has_many :surveys, :dependent => :destroy

  belongs_to :roll

  attr_accessor :passwort
  attr_accessible :name, :vorname, :email, :login, :passwort, :passwort_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #Überprüft, ob der Name und das Passwort die richtige Länge aufweist
  validates_length_of :name, :maximum => 50,
  					  :message => "ist zu lang. Bitte kleineres eingeben"
  					  
  validates_length_of :passwort, :within => 6..40, 
  					  :too_short => "ist zu kurz. Bitte laengers eingeben",
  					  :too_long => "ist zu lang. Bitte kleineres eingeben", 
  					  :allow_blank => true
  					 
  #Überprüft, ob die Email das richtige Format anhand der Regex hat
  validates_format_of :email, 
  					  :with => email_regex,
  					  :message => "Format ist falsch. Format: test@xyz.de",
  					  :allow_blank => true
                   
  # Automatically create the virtual attribute 'passwort_confirmation'.

  # Prüfung, ob zu Passwort eine Bestätigung (confirmation) ebenfalls existiert
  # zudem wird geprüft

  validates_confirmation_of :passwort,
  						   :message => "ist nicht gleich. Das Passwort muss gleich sein",
                           :on => :create
                          
  #Prüft, ob die Eingabefelder leer sind                
  validates_presence_of :login, :passwort, :vorname, :email, :name, 
  						:message => "darf nicht leer sein." 

  #Prüft, ob der Login und die E-Mail schon vorhanden sind
  validates_uniqueness_of :login, :email,
 						  :case_sensitive => false,
                          :message => "ist schon vorhanden. Bitte neues eintragen"
                         
                        	
# 'before_save' ruft die folgende Methode zum encrypten/verschlüsseln des Passwortes auf, bevor der Datensatz zum User in die Datenbank gespeichert wird
  before_save :encrypt_passwort
  
  # Methode, die aus dem übergebenen Passwort ein verschlüsseltes erstellt...
  # dieses ist für die spätere Benutzererkennung nötig
  def has_password?(submitted_passwort)
    encrypted_passwort == encrypt(submitted_passwort)
  end

#Methode überprüft, ob ein Unser mit dem 'login' vorhanden ist
# wenn nicht, wird ein null-wert ausgegeben
# wenn ja wird der User ausgegeben, sofern das passwort über die methode has_password? erkannt wurde
  def self.authenticate(login, submitted_passwort)
    user = find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_passwort)
  end


  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

# gibt alles Umfragen zum User aus, der momentan eingelogt ist
  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    Survey.where("user_id = ?", id)
  end

  private
  
 # erstellt aus der aktuellen Zeit und dem übergebenen Passwort einen hashcode zur Verschlüsselung des PW
   def make_salt
    secure_hash("#{Time.now.utc}--#{passwort}")
  end
  
# macht mit einem neuen hashcode zu verschlüsselung und setzt ihn zu dem User
  def encrypt_passwort
    self.salt = make_salt if new_record?
    self.encrypted_passwort = encrypt(passwort)
  end
 
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

 

 

end