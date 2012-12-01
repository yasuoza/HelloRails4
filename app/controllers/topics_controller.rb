class TopicsController < ApplicationController
  include TopicsHelper

  before_filter :authenticate_user!, except: :index
  before_filter :authenticate_user_topic!, only: [:show, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    intfy_pararams_page!
    @topics = Topic.all
                   .where(user_id: current_user.try(:id))
                   .offset((params[:page] - 1) * 5)
                   .limit(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update_attributes(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end


  private
    def authenticate_user!
      redirect_to root_url unless current_user
    end

    def authenticate_user_topic!
      @topic = Topic.find(params[:id])
      redirect_to root_url unless @topic.user_id == current_user.id
    end

    def topic_params
      params.require(:topic).permit(:name)
    end
end
