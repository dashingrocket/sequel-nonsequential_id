require 'securerandom'

module Sequel
  module Plugins
    module UniqueId
      def self.configure(model, opts = {})
        model.instance_eval do
          @id_field = opts[:id_field] || :id
        end
      end

      module ClassMethods
        attr_reader :id_field
        Sequel::Plugins.inherited_instance_variables(self, :@id_field => nil)
      end

      module InstanceMethods
        def before_create
          set_unique_id
          super
        end

        private def set_unique_id
          method = :"#{model.id_field}="

          loop do
            id = SecureRandom.alphanumeric
            unless model.first("#{model.id_field}": id)
              set_column_value(method, id)
              return id
            end
          end
        end
      end
    end
  end
end