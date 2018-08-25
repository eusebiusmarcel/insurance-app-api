class V1::NoLoginsController < ApplicationController
  def index_user
    users = User.all.order(:id)
<<<<<<< HEAD
    render json: users, status: :ok
=======
    render json: { status: 'OK', users: users }, status: :ok
>>>>>>> parent of ef2db41... Update json for no login collection per FE request.
  end

  def index_policy
    policies = Policy.all.order(:id)
<<<<<<< HEAD
    render json: policies, status: :ok
=======
    render json: { status: 'OK', policies: policies }, status: :ok
>>>>>>> parent of ef2db41... Update json for no login collection per FE request.
  end

  def show_policies_of_one_user
    user = User.find(params[:id])
    policies = user.policies.all.order(:id)
<<<<<<< HEAD
    render json: policies, status: :ok
=======
    render json: { status: 'OK', policies: policies }, status: :ok
>>>>>>> parent of ef2db41... Update json for no login collection per FE request.
  end

  def show_user
    user = User.find(params[:id])
<<<<<<< HEAD
    render json: user, status: :ok
=======
    render json: { status: 'OK', user: user }, status: :ok
>>>>>>> parent of ef2db41... Update json for no login collection per FE request.
  end

  def show_policy
    policy = Policy.find(params[:id])
<<<<<<< HEAD
    render json: policy, status: :ok
=======
    render json: { status: 'OK', policy: policy }, status: :ok
>>>>>>> parent of ef2db41... Update json for no login collection per FE request.
  end
end