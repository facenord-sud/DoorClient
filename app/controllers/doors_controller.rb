class DoorsController < ApplicationController

  # GET /doors
  # GET /doors.json
  def index
    @doors = Door.all
    @door = Door.new
    respond_to do |format|
      format.html { render 'index' }
    end
  end

  def show
    @show_door =  Door.find(params[:id])
    @open = Open.fetch(@show_door.open_uri)
    @open.door = @show_door

    @open_form = Open.new
    @lock = Lock.fetch(@show_door.lock_uri)
    @lock.door = @show_door
    @lock_form = Lock.new
    @doors = Door.all

    if !@open.save or !@lock.save
      flash[:alert] = 'An error has occurs while getting info from the server'
      @show_door = nil
      @open = nil
      @lock = nil
      @open_form = nil
      @lock_form = nil
    else
      @show_door.register_for_notifications(@show_door.lock_uri, notify_door_locks_url(door_id: @show_door))
      @show_door.register_for_notifications(@show_door.open_uri, notify_door_opens_url(door_id: @show_door))
    end
      respond_to do |format|
      format.html do
        @door = Door.new
        render 'index'
      end
      format.js { render 'show' }
    end
  end

  def create
    uri = params[:protocol][:type]+params[:door][:uri]
    a_door = Door.fetch(uri)
    @doors = Door.all
    if a_door.save
      @door = Door.new
      a_door.register_for_notifications(a_door.lock_uri, notify_door_locks_url(door_id: a_door))
      a_door.register_for_notifications(a_door.open_uri, notify_door_opens_url(door_id: a_door))
    else
      @door = a_door
    end
    respond_to do |format|
      format.js {render 'create'}
    end
  end

  def destroy
    door = Door.find params[:id]
    door.un_register_for_notifications(door.lock_uri, notify_door_locks_url(door_id: door))
    door.un_register_for_notifications(door.open_uri, notify_door_opens_url(door_id: door))
    door.destroy
    @doors = Door.all
    respond_to do |format|
      format.js {render 'destroy'}
    end
  end

  private

end
