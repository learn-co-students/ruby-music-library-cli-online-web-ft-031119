
#module Concerns::Findable
=begin
module Concerns
  
  module Findable
    
    def find_by_name(name)
      self.class.all.find{|instance|
        instance.name==name
      }
    end
    
    def find_or_create_by_name(name)
      self.find_by_name(name) || self.class.new(name) 
    end
  end
  
end
=end