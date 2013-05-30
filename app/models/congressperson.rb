require_relative '../../db/config'

class CongressPerson < ActiveRecord::Base
  
  def name
    # "name_method: #{firstname}"
    "#{firstname}#{name_helper(middlename)} #{lastname}#{name_helper(name_suffix)}".strip
  end

  def name_helper(name_part)
    name_part ? " " + name_part : ""
  end

end
