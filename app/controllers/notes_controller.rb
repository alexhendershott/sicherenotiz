class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:search]
      @notes = Note.where('title LIKE ?', "%#{params[:search]}%").order("updated_at DESC")
    else
      @notes = Note.all.order("updated_at DESC")
    end
    @note = Note.order("updated_at").last
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
      redirect_to root_path, notice: 'Note was successfully created.'
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
