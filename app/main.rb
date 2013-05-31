require_relative 'models/congressperson'
require_relative '../db/config'

def state_congresspeople(state)
  #prints out senators and reps for each state, with party affiliation
  puts 'Senators:'
  senators = CongressPerson.select('name, party').where('title = ?', 'Sen').where('state = ?', state)
  senators.each {|senator| puts "  #{senator.name} (#{senator.party})" } 

  puts 'Representatives:'
  representatives = CongressPerson.select('name, party').where('title = ?', 'Rep').where('state = ?', state)
  representatives.each {|rep| puts "  #{rep.name} (#{rep.party})" } 
end

def gender_percentage(gender)
  senator_subset = CongressPerson.where('gender = ?', gender).where('title = ?', 'Sen').where('in_office = ?', 1).count
  senators = CongressPerson.where('title = ?', 'Sen').where('in_office = ?', 1).count
  puts "#{gender.capitalize} Senators: #{senator_subset} (#{((senator_subset / senators.to_f)*100).round}%)"

  rep_subset = CongressPerson.where('gender = ?', gender).where('title = ?', 'Rep').where('in_office = ?', 1).count
  representatives = CongressPerson.where('title = ?', 'Rep').where('in_office = ?', 1).count
  puts "#{gender.capitalize} Representatives: #{rep_subset} (#{((rep_subset / representatives.to_f)*100).round}%)"
end

def print_by_state
  states = CongressPerson.select('state').where('in_office', 1).group('state').order('count(*) DESC')

  states.each do |state|
    state_abbr = state.state
    senator_count = CongressPerson.where('state = ?', state_abbr).where('title = ?', 'Sen').where('in_office = ?', 1).count
    rep_count = CongressPerson.where('state = ?', state_abbr).where('title = ?', 'Rep').where('in_office = ?', 1).count

    puts "#{state_abbr}: #{senator_count} Senators, #{rep_count} Representatives"
  end  
end

def count_congresspeople

  senator_count = CongressPerson.where('title = ?', 'Sen').count
  rep_count = CongressPerson.where('title = ?', 'Rep').count

  puts "Senators: #{senator_count}"
  puts "Representatives: #{rep_count}"
end

def delete_inactive!
  CongressPerson.where(:in_office => 0).destroy_all
end

p "state_congresspeople('CA')"
state_congresspeople('CA')

p "gender_percentage('M')"
gender_percentage('M')

p "gender_percentage('F')"
gender_percentage('F')

p "print_by_state"
print_by_state

p "count_congresspeople"
count_congresspeople

p "delete_inactive!"
delete_inactive!

p "count_congresspeople (again)"
count_congresspeople
