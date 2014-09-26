class Cat < ActiveRecord::Base
  attr_accessible :name, :breed

  def evil?
    true
  end
end
