module Granite
  module Form
    module DryValidationDriver

      def self.included(base)
        require 'dry-validation'
        base.extend ClassMethods
      end

      def inputs(args)
        @_gf_inputs = args
        self
      end

      def valid?
        validate!
        @_gf_form.success?
      end

      def validate!
        @_gf_form ||= self.class._form_object.call(@_gf_inputs)
      end

      def errors
        validate!
        @_gf_form.errors
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
