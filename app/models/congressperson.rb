require_relative '../../db/config'

class CongressPerson < ActiveRecord::Base
  
  def name_scrub
    @name = "#{firstname.rstrip}#{name_helper(middlename).rstrip} #{lastname.rstrip}#{name_helper(name_suffix).rstrip}"
  end

  def name_helper(name_part)
    name_part ? " " + name_part : ""
  end

  def phone_scrub
    phone.gsub!(/(\d{3})[-|\s]*(\d{3})[-|\s]*(\d{4})/, '\1\2\3')
  end

  def fax_scrub
    fax.gsub!(/(\d{3})[-|\s]*(\d{3})[-|\s]*(\d{4})/, '\1\2\3')
  end

end
