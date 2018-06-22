class Smoney::Entity::PostError < StandardError
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def message
    object.data["ErrorMessage"]
  end

  def code
    object.data["Code"]
  end
end
