require 'active_record/relation/predicate_builder'
require 'active_record/relation/predicate_builder/array_handler'

require 'active_support/concern'

module ActiveRecord
  class PredicateBuilder
    module ArrayHandlerPatch
      extend ActiveSupport::Concern

      included do
        def call_with_feature(attribute, value)
          column = case attribute.try(:relation)
                   when Arel::Nodes::TableAlias, NilClass
                   else
                     cache = ActiveRecord::Base.connection.schema_cache
                     if cache.data_source_exists? attribute.relation.name
                       cache.columns(attribute.relation.name).detect{ |col| col.name.to_s == attribute.name.to_s }
                     end
                   end
          if column && column.respond_to?(:array) && column.array
            predicate_builder.build(attribute, values)
          else
            call_without_feature(attribute, value)
          end
        end

        alias_method_chain(:call, :feature)
      end

      module ClassMethods

      end
    end
  end
end

ActiveRecord::PredicateBuilder::ArrayHandler.send(:include, ActiveRecord::PredicateBuilder::ArrayHandlerPatch)
