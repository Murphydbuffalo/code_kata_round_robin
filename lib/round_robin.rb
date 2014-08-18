require 'pry'

def schedule_tournament(names)
  matchups = generate_matchups(names)
  number_of_participants = names.count
  tournament = create_rounds(number_of_participants)
  matches_per_round = number_of_participants / 2

  tournament.each do |round|
    while round.count < matches_per_round
      matchups.each do |matches_by_name|
        if used_matchup?(round, matches_by_name)
          matches_by_name.push(matches_by_name.shift)
        else
          round.push(matches_by_name.shift)
        end
        break if round.count == matches_per_round
      end
    end
    add_bye(round, tournament, names) if odd?(number_of_participants)
  end
  tournament
end

def odd?(number_of_participants)
  (number_of_participants % 2 != 0)
end

def add_bye(round, tournament, names)
  round.push([names.pop]) unless used_name?(tournament, names.last) 
end

def used_name?(tournament, bye_name)
  tournament.flatten.any? { |existing_name| existing_name == [bye_name] }
end

def used_matchup?(round, matches_by_name)
  round.flatten.any? do |name|
    name == matches_by_name.first[0] || name == matches_by_name.first[1]
  end
end

def create_rounds(number_of_participants)
  schedule = []
  number_of_rounds = (number_of_participants - 1)
  number_of_rounds += 1 if odd?(number_of_participants)
  (number_of_rounds).times { schedule << [] }
  schedule
end

def generate_matchups(names)
  matchups = []
  names.each_with_index do |name, i|
    offset = 1
    name_matches = []
    (names.count - 1).times do 
      if (i + offset) <= (names.count - 1)
        name_matches << [name, names[i + offset]]
      else
        name_matches << [name, names[0 + ( (i + offset) - names.count)] ]
      end
      offset += 1
    end
    matchups << name_matches
  end
  matchups
end

# p generate_matchups(['Dan', 'Tom', 'Frank', 'Fred', 'Marcus', 'Zak'])
# p create_rounds(['Dan', 'Tom', 'Frank', 'Fred', 'Marcus', 'Zak'])
p schedule_tournament(['Dan', 'Tom', 'Frank', 'Fred', 'Marcus', 'Zak', 'Gavin'])
