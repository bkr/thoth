require 'spec_helper'
require 'thoth/rails/railtie'

DummyUser = Struct.new(:id)
class ControllerWithThothContextController < ActionController::Base
  include Thoth::Rails::ControllerContext

  def show
    @context = Thoth.context
    head 200
  end

  def current_user
    DummyUser.new(1)
  end
end

describe ControllerWithThothContextController, type: :controller do
  before do
    routes.draw { get "show" => "controller_with_thoth_context#show" }
  end

  context "on any action" do
    it "stores params in the Thoth.context" do
      get :show
      expect(assigns(:context)).to eq({"controller"=>"controller_with_thoth_context", "action"=>"show", "current_user"=>1})
    end
  end
end