class Note < ApplicationRecord
  belongs_to :user

  

  private
   def encrypted_content
     salt = ENV['SALT'] # We save the value of: SecureRandom.random_bytes(64)
     key = ENV['KEY']   # We save the value of: ActiveSupport::KeyGenerator.new('password').generate_key(salt)
     crypt = ActiveSupport::MessageEncryptor.new(key)
     content = self.content # Input value from our form
     encrypted_data = crypt.encrypt_and_sign(content) # or crypt.encrypt_and_sign(self.consumer_key)
     self.content = encrypted_data
     # You can refactor to make these steps shorter.
   end

end
