require 'bundler'
Bundler.require
require_relative '../lib/concerns/findable.rb'
require_all 'lib'

# Why do we have two of these modules in different places?
# why is this version of the module slightly different from the other?

# module Concerns
#     # module Findable
#     #     def find_by_name(name)
#     #       self.all.detect {|object| object.name == name}
#     #     end
    
#     #     def find_or_create_by_name(name)
#     #       if self.find_by_name(name).nil?
#     #         self.create(name)
#     #       else
#     #         self.find_by_name(name)
#     #       end
#     #     end
#     # end
# end



