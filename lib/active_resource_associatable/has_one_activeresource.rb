module AssociationBuilder

  class HasOneActiveResource

    def self.build(model, klass_name, options)
      klass_name = options[:class_name] || klass_name
      model.class_eval do 
        define_method("#{klass_name.to_s.downcase}") do
          if self.is_a?(ActiveResource::Base)
            klass_name.to_s.classify.constantize.find_by("#{model.element_name}_id": self.id)
          else
            klass_name.to_s.classify.constantize.find("#{self.send(klass_name.to_s + '_id')}")
          end
        end
      end
    end

  end

end
