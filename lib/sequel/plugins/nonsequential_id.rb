require 'securerandom'

module Sequel
  module Plugins
    module NonsequentialId
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
        def around_create
          begin
            set_nonsequential_id
            super
          rescue Sequel::UniqueConstraintViolation => e
            if e.message =~ /\b#{model.table_name}\.#{model.id_field}\b/
              retry
            else
              raise
            end
          end
        end


        private def set_nonsequential_id
          method = :"#{model.id_field}="
          id = SecureRandom.hex.hex.to_s(36)
          set_column_value(method, id)
        end
      end
    end
  end
end