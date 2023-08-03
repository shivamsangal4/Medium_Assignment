class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
class Post < ApplicationRecord
  # Add any associations, validations, or other model logic here
end