module MyConcernModule
  extend ActiveSupport::Concern

  included do
    after_save :do_something
  end

  def do_something
     byebug
  end
end