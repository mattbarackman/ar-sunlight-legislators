require 'csv'
require_relative '../app/models/congressperson'

DESIRED_FIELDS = %w(title firstname middlename lastname name_suffix email webform phone fax website party gender
                    birthdate twitter_id in_office state)

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      args = {}
      row.each do |field, value|
        args[field.to_sym] = value if DESIRED_FIELDS.include?(field)
      end
      CongressPerson.create(args)
    end
  end

  def self.update_names
    puts "updated"
    congresspeople = CongressPerson.all
    congresspeople.each do |congressperson|
      id = congressperson.id
      CongressPerson.update(id, { :name => congressperson.name })     
    end 
  end
end

begin
  raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
  SunlightLegislatorsImporter.import(ARGV[0])
  SunlightLegislatorsImporter.update_names
rescue ArgumentError => e
  $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
rescue NotImplementedError => e
  $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
end
