module Types
  class PivotType < Types::BaseObject
    type_map = {
      'string': 'String',
      'integer': 'Int',
      'datetime': 'String'
    }

    %w[Customer Stock].each do |model|
      klass = Object.const_get(model)
      fields = []
      klass.attribute_types.each do |name, type|
        fields << "field :#{name}, #{type_map[type.type]}, null: false"
      end

      class_eval <<-RUBY
          class Types::#{model}Type < Types::BaseObject
            #{fields.join("\n")}
          end
      RUBY

      field model.downcase, "Types::#{model}Type".constantize, null: true
    end
  end
end
