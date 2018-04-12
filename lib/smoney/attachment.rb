module Smoney
  class Attachment < Entity::Base
    PATH = ""

    collection

    value :id
    value :name
    value :type
    value :size
    value :href
  end
end
