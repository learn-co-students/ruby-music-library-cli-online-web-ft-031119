module Concerns
  
  module Findable
    def find_by_name(name)
       index = all.find_index {|e| e.name == name}
       if index != nil 
         all.fetch(index)
       else
         nil
       end
    end
    
    def find_or_create_by_name(name)
      e = find_by_name(name)
      if e == nil
        e = create(name)
      end
      e
    end
  end
end