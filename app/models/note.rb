class Note < ApplicationRecord
  belongs_to :user
  before_save :default_title
  # before_save :default_content
  before_save :encrypted_content

  private
   def encrypted_content
     salt = Rails.application.secrets[:SALT] # We save the value of: SecureRandom.random_bytes(64)
     key = Rails.application.secrets[:KEY]   # We save the value of: ActiveSupport::KeyGenerator.new('password').generate_key(salt)
     crypt = ActiveSupport::MessageEncryptor.new(key)
     content = self.content # Input value from our form
     encrypted_data = crypt.encrypt_and_sign(content) # or crypt.encrypt_and_sign(self.consumer_key)
     self.content = encrypted_data
     # You can refactor to make these steps shorter.
   end

   def default_title
     if self.title.blank?
       self.title = "Untitled"
     end
   end

  #  def default_content
  #    if self.content.blank?
  #      self.content = "Start typing note content..."
  #    end
  #  end

end
