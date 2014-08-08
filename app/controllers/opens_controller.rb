class OpensController < ApplicationController

  # GET /opens
  # GET /opens.json
  def index
    @open = Open.new
  end

  # PATCH/PUT /opens/1
  # PATCH/PUT /opens/1.json
  def update
    door = Door.find params[:door_id]
    open = Open.new(open_params)
    respond_to do |format|
      if open.send_to_server(door.open_uri)
        format.js { redirect_to door_path(door), format: 'js', success: 'request successful!' }
      else
        flash[:alert] = 'Unable to do the request'
        format.js { render 'update' }
      end
    end
  end

  def pub

    open = Open.new(position: params['position'], state: params['state'].downcase.to_sym)
    logger.error('error while saving open state'+params.to_s) unless open.save
  end

  def notify
    logger.info params.inspect
  end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def open_params
      params.require(:open).permit(:position, :state)
    end
end
