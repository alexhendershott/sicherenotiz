class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    unless current_user
      redirect_to new_user_session_path
    else
      if params[:search]
        @notes = Note.where('title LIKE ?', "%#{params[:search]}%").where("user_id = ?", current_user.id).order("updated_at DESC")
      else
        @notes = Note.where("user_id = ?", current_user.id).all.order("updated_at DESC")
      end
      @note = Note.where("user_id = ?", current_user.id).last
    end
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = current_user.notes.build(note_params)

    if @note.save

    else
      render :new
    end
  end

  def update
    @note.update(note_params)
    redirect_to root_path
    respond_to do |format|
      format.js
      format.html
    end
  end

  def refreshUpdatedAt
    @note = Note.find(params[:note_id])
  end

  def refreshSidebar
    @notes = Note.all.order("updated_at DESC")
  end

  def new_blank
    @note = Note.new(title: 'Untitled', user_id: current_user.id)
    if @note.save
      redirect_to "/"
    else
      render :new
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :content)
    end

    def correct_user
      @note = current_user.notes.find_by(id: params[:id])
      redirect_to notes_path, notice: "Not authorized to edit this note" if @note.nil?
    end
end
