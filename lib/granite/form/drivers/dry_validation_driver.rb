module Granite
  module Form
    module DryValidationDriver

      def self.included(base)
        require 'dry-validation'
        base.extend ClassMethods
      end

      # Common interface for all drivers
      # inputs to set form data
      # valid?, validate!, errors to check form data

      def inputs(args)
        @data = args
        self
      end

      def valid?
        validate!
        @inputs.success?
      end

      def validate!
        @inputs ||= self.class._form_object.call(@data)
      end

      def errors
        validate!
        @inputs.errors
      end

      module ClassMethods
        attr_accessor :_form_object

        def form(&block)
          self._form_object = Dry::Validation.Params(&block)
        end
      end
    end
  end
end
