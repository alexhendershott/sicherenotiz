module NotesHelper

  def decryptor(field)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets[:KEY])
    @decrypted_content = crypt.decrypt_and_verify(field)
    return @decrypted_content
  end

end
