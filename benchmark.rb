require_relative './lib/granite/form'
require 'pry'

require 'active_data'
require 'benchmark/ips'
require 'benchmark/memory'

ActiveData.logger = Logger.new('/dev/null')

class ActiveDataFormExample
  include Granite::Form[:active_data]

  form do
    attribute :title, String
    validates :title, presence: true
  end
end

class ActiveDataExample
  include ActiveData::Model

  attribute :title, String
  validates :title, presence: true
end

class DryValidationExample
  include Granite::Form[:dry_validation]

  form do
    required(:title).filled(:str?)
  end
end

class ActiveModelExample
  include Granite::Form[:active_model]

  form do
    attr_accessor :title
    validates :title, presence: true
  end
end

class ReformRailsExample
  include Granite::Form[:reform]

  form do
    property :title
    validates :title, presence: true
  end
end

params = { title: 'test', c: 1 }.freeze

Benchmark.ips do |x|
  x.report('ActiveData') { ActiveDataExample.new(params).valid? }
  x.report('ActiveData::Form') { ActiveDataFormExample.new.inputs(params).valid? }
  # x.report('ActiveModel') { ActiveModelExample.new.inputs(params).valid? }
  x.report('reform-rails') { ReformRailsExample.new.inputs(params).valid? }
  x.report('dry-validation') { DryValidationExample.new.inputs(params).valid? }
end

n = 1000

Benchmark.memory do |x|
  x.report('ActiveData') { n.times { ActiveDataExample.new(params).valid? }}
  x.report('ActiveData::Form') { n.times { ActiveDataFormExample.new.inputs(params).valid?  }}
  # x.report('ActiveModel') { n.times { ActiveModelExample.new.inputs(params).valid? }}
  x.report('reform-rails') { n.times { ReformRailsExample.new.inputs(params).valid? }}
  x.report('dry-validation') { n.times { DryValidationExample.new.inputs(params).valid? }}
end
