class GroupMembersController < ApplicationController
  before_action :set_group_member, only: [:show, :update, :destroy]

  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = GroupMember.all

    render json: @group_members
  end

  # GET /group_members/1
  # GET /group_members/1.json
  def show
    render json: @group_member
  end

  # POST /group_members
  # POST /group_members.json
  def create
    @group_member = GroupMember.new(group_member_params)

    if @group_member.save
      render json: @group_member, status: :created, location: @group_member
    else
      render json: @group_member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group_members/1
  # PATCH/PUT /group_members/1.json
  def update
    @group_member = GroupMember.find(params[:id])

    if @group_member.update(group_member_params)
      head :no_content
    else
      render json: @group_member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
    @group_member.destroy

    head :no_content
  end

  private

    def set_group_member
      @group_member = GroupMember.find(params[:id])
    end

    def group_member_params
      params[:group_member]
    end
end
