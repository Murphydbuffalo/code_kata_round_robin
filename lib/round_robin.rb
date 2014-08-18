require 'pry'

def schedule_tournament(names)
  matchups = generate_matchups(names)
  tournament = create_rounds(names)
  matches_per_round = names.count / 2
  matches_per_round += 1 if names.count % 2 != 0

  tournament.each do |round|
    while round.count < 3
      matchups.each do |matches_by_name|
        if used_matchup?(round, matches_by_name)
          matches_by_name.push(matches_by_name.shift)
        else
          round.push(matches_by_name.shift)
        end
        break if round.count == 3
      end
    end
  end
  tournament
end

def used_matchup?(round, matches_by_name)
  round.flatten.any? do |name|
    name == matches_by_name.first[0] || name == matches_by_name.first[1]
  end
end

def create_rounds(names)
  schedule = []
  number_of_rounds = (names.count - 1)
  number_of_rounds += 1 if names.count % 2 != 0
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
p schedule_tournament(['Dan', 'Tom', 'Frank', 'Fred', 'Marcus', 'Zak'])
