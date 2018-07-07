module Granite
  module Form
    module ReformDriver

      def self.included(base)
        require 'reform'
        require 'reform/form/active_model/validations'
        base.extend ClassMethods
      end

      # Common interface for all drivers
      # inputs to set form data
      # valid?, validate!, errors to check form data

      def inputs(args)
        @data = OpenStruct.new(args)
        self
      end

      def valid?
        validate!
        @inputs.valid?
      end

      def validate!
        @inputs ||= self.class._form_object.new(@data)
      end

      def errors
        validate!
        @inputs.errors
      end

      module ClassMethods
        attr_accessor :_form_object

        def form(&block)
          self._form_object = Class.new(Reform::Form) do
            include Reform::Form::ActiveModel::Validations
            class_exec(&block)
          end
        end
      end
    end
  end
end
