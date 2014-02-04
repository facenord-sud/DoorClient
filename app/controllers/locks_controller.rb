
class LocksController < ApplicationController

  # GET /locks
  # GET /locks.json
  def index
    @lock = Lock.new
  end

  # PATCH/PUT /locks/1
  # PATCH/PUT /locks/1.json
  def update
    door = Door.find params[:door_id]
    lock = Lock.new(lock_params)
    respond_to do |format|
      if lock.send_to_server(door.lock_uri)
        format.js { redirect_to door_path(door), format: 'js', success: 'request successful!' }
      else
        flash[:alert] = 'Unable to do the request'
        format.js { render 'update' }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def lock_params
      params.require(:lock).permit(:state)
    end
end
