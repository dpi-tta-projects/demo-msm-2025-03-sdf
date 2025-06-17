module Movie::Ransackable
  extend ActiveSupport::Concern

  class_methods do
    def ransackable_attributes(auth_object = nil)
      ["title", "year"]
    end

    def ransackable_associations(auth_object = nil)
      ["director"]
    end
  end
end
