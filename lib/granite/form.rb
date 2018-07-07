require_relative 'form/drivers/active_data_driver'
require_relative 'form/drivers/active_model_driver'
require_relative 'form/drivers/reform_rails_driver'
require_relative 'form/drivers/dry_validation_driver'

module Granite
  module Form
    # It can be done via some registration process
    # Constant for simplicity
    MODULE_MAPPING = {
      active_data: ActiveDataDriver,
      active_model: ActiveModelDriver,
      reform: ReformRailsDriver,
      dry_validation: DryValidationDriver
    }.freeze

    # EXAMPLES

    # class ReformExample
    #   include Granite::Form[:reform]

    #   form do
    #     property :title
    #     validates :title, presence: true
    #   end
    # end

    # class DryValidationExample
    #   include Granite::Form[:dry_validation]

    #   form do
    #     required(:title).filled(:str?)
    #   end
    # end

    def self.[](driver)
      MODULE_MAPPING[driver]
    end
  end
end
