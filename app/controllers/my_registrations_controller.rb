class MyRegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      Note.create(title: 'Untitled', content: 'Start typing note content...', user_id: @user.id)
    end
  end

end
