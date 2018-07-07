module Granite
  module Form
    module ActiveDataDriver

      def self.included(base)
        require 'active_data'
        base.extend ClassMethods
      end

      # Common interface for all drivers
      # inputs to set form data
      # valid?, validate!, errors to check form data

      def inputs(args)
        @inputs ||= self.class._form_object.new(args)
        self
      end

      def valid?
        @inputs.valid?
      end

      def validate!
        @inputs.validate!
      end

      def errors
        @inputs.errors
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
