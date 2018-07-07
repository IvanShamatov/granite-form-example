module Granite
  module Form
    module ReformRailsDriver

      def self.included(base)
        require 'reform'
        require 'reform/form/active_model/validations'
        base.extend ClassMethods
      end

      def inputs(args)
        @_gf_inputs = OpenStruct.new(args)
        self
      end

      def valid?
        validate!
        @_gf_form.valid?
      end

      def validate!
        @_gf_form ||= self.class._form_object.new(@_gf_inputs)
      end

      def errors
        validate!
        @_gf_form.errors
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
