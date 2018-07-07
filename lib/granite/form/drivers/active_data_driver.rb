module Granite
  module Form
    module ActiveDataDriver

      def self.included(base)
        require 'active_data'
        base.extend ClassMethods
      end

      def inputs(args)
        @_gf_inputs = args
        self
      end

      def valid?
        validate!
        @_gf_form.valid?
      end

      def validate!
        @_gf_form ||= self.class._form_object.new(@_gf_inputs)
        @_gf_form.validate!
      end

      def errors
        validate!
        @_gf_form.errors
      end

      module ClassMethods
        attr_accessor :_form_object

        def form(&block)
          self._form_object = Class.new do
            include(ActiveData::Model)
            class_exec(&block)
          end
        end
      end
    end
  end
end
