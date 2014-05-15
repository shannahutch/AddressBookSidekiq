class ContactsController < ApplicationController
  before_action :load_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = current_user.contacts
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to root_path
    else
      flash[:errors] = @contact.errors.full_messages
      render :new
    end
  end

  def edit
    
  end

  def update
    if @contact.update(contact_params)
      redirect_to @contact
    else
      flash[:errors] = @contact.errors.full_messages
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to root_path
  end

  def new_email

    @contact = Contact.find(params[:id])

    # Should return a view that allows the user to create an email
  end

  def send_email
    load_contact
     # Does the actual sending of the email by calling
    # the other rails server
    response = Typhoeus.post("localhost:3001/email", params: {email: params[:email]})

    #   email.json", 
    # params: {contact: params[:email]})
    redirect_to email_sent_path(@contact)
    # Does the actual sending of the email by calling
    # the other rails server
  end

  def sent_email
    load_contact

    params[:email][:email] = @contact.email

    Typhoeus.post("http://localhost3001/email.json", params: {email: params[:email]})
    redirect_to email_send_path @contact
    # A response page that shows that the user's email got sent
  end

  private

  def load_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :address, :photo)
  end
end
