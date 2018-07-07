require_relative './lib/granite/form'
require 'pry'

class ActiveDataExample
  include Granite::Form[:active_data]

  form do
    attribute :title, String
    validates :title, presence: true
  end
end

example = ActiveDataExample.new.inputs(title: 'test title')
puts example.validate!
puts example.valid?
puts example.errors

class ActiveModelExample
  include Granite::Form[:active_model]

  form do
    attr_accessor :title
    validates :title, presence: true
  end
end

example = ActiveModelExample.new.inputs(title: 'test title')
puts example.validate!
puts example.valid?
puts example.errors

class ReformRailsExample
  include Granite::Form[:reform]

  form do
    property :title
    validates :title, presence: true
  end
end

example = ReformRailsExample.new.inputs(title: 'test title')
puts example.validate!
puts example.valid?
puts example.errors

class DryValidationExample
  include Granite::Form[:dry_validation]

  form do
    required(:title).filled(:str?)
  end
end

example = DryValidationExample.new.inputs(title: 'test title')
puts example.validate!
puts example.valid?
puts example.errors
