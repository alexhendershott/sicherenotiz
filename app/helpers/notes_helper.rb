module NotesHelper

  def decryptor(field)
    crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY'])
    @decrypted_content = crypt.decrypt_and_verify(field)
    return @decrypted_content
  end

end
