class ShortcutsController < ApplicationController
  before_action :set_shortcut, only: [:twilio, :edit, :update, :destroy]

  def twilio
    account_sid = 'AC686caf4e50e0db29ee0e0f23ad159fb7'
    auth_token = '61d44c891c9ca3585712e9e38192149d'
    phone_number = '+1' + params['number']
    message = 'Hi, check out this awesome website:  ' + @shortcut.path

    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.api.account.messages.create(
      from: '+15128293862',
      to:   phone_number,
      body: message
    )
    flash[:notice] = 'Your link has been sent!'
    redirect_to root_path
  end

  def index
    @search_term = params[:shortlink]
    @shortcuts = if @search_term.present?
      Shortcut.where(name: @search_term)
    else
      Shortcut.all
    end

    @go_term = params[:go_link]
    if @go_term.present?
      @shortcut = Shortcut.find_by_name(@go_term)
      redirect_to @shortcut.path
    end
  end

  def new
    @shortcut = Shortcut.new
  end

  # GET /shortcuts/1/edit
  def edit
  end

  # POST /shortcuts
  # POST /shortcuts.json
  def create
    @shortcut = Shortcut.new(shortcut_params)

    respond_to do |format|
      if @shortcut.save
        format.html { redirect_to root_path, notice: 'Shortcut was successfully created.' }
        format.json { render :show, status: :created, location: @shortcut }
      else
        format.html { render :new }
        format.json { render json: root_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shortcuts/1
  # PATCH/PUT /shortcuts/1.json
  def update
    respond_to do |format|
      if @shortcut.update(shortcut_params)
        format.html { redirect_to root_path, notice: 'Shortcut was successfully updated.' }
        format.json { render :show, status: :ok, location: @shortcut }
      else
        format.html { render :edit }
        format.json { render json: @shortcut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shortcuts/1
  # DELETE /shortcuts/1.json
  def destroy
    @shortcut.destroy
    respond_to do |format|
      format.html { redirect_to shortcuts_url, notice: 'Shortcut was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shortcut
      @shortcut = Shortcut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shortcut_params
      params.require(:shortcut).permit(:name, :path)
      # params.fetch(:shortcut, {})
    end

    def error_check(shortcut)
      if shortcut
        return false
      else
        error_message = "Im sorry, we can not find that shortlink"
        flash[:notice] = error_message
        return true
      end
    end
end
