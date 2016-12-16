module NotesHelper

  def decryptor(field)
    crypt = ActiveSupport::MessageEncryptor.new(ENV['KEY'])
    @decrypted_content = crypt.decrypt_and_verify(field)
    content_tag(:span, @decrypted_content)
  end

end
