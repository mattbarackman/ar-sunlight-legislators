require_relative '../../db/config'

class CongressPerson < ActiveRecord::Base
  
  def name
    # "name_method: #{firstname}"
    @name = "#{firstname.rstrip}#{name_helper(middlename).rstrip} #{lastname.rstrip}#{name_helper(name_suffix).rstrip}"
  end

  def name_helper(name_part)
    name_part ? " " + name_part : ""
  end

end
