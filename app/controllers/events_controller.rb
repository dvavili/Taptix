require 'open-uri'

class EventsController < ApplicationController
  #before_filter :authenticate_user!, :except=>[:show_all_events,:show]
  # GET /events
  # GET /events.xml
  def index
    
    @events = Event.find_all_events

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json { render :json=>@events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json=>@event }
    end
  end

  def show_event
    @event = Event.find(params[:event_id])

    respond_to do |format|
      format.html "show.html.erb"
      format.xml  { render :xml => @event }
      format.json { render :json=>@event }
    end
  end


  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.user = User.find(params[:user_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end
  
  # GET /events/create_event
  # GET /events/create_event.xml
  def create_event
    @event = Event.new
    @event.user = User.find(params[:user_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end


  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @event.user = User.find(params[:user_id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.user = User.find(params[:user_id])
    if(params[:poster]=='l')
      @event.poster = open(@event.image_link)
    else
      if(params[:poster]=='u')
        @event.image_link ='u'
      end
    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to(user_event_path(params[:user_id],@event), :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json { render :json=>@event }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        if(params[:poster]=='l')
          @event.poster = open(@event.image_link)
        else
          if(params[:poster]=='u')
            @event.image_link ='u'
          end
        end
        @event.save
        format.html { redirect_to(user_event_path(params[:user_id],@event), :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def show_all_events
    @events = Event.find_all_events
    
    respond_to do |format|
      format.html # show_all_events.html.erb
      format.xml  { head :ok }
      format.json { render :json=>@events }
    end
  end

    def show_user_events
    @events = Event.find_user_events(params[:id])

    respond_to do |format|
      format.html # show_all_events.html.erb
      format.xml  { head :ok }
      format.json { render :json=>@events }
    end
  end
end
