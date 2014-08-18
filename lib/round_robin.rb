require 'pry'

def schedule_tournament(names)
  matchups = generate_matchups(names)
  tournament = create_rounds(names)
  tournament.each do |round|
    matchups.each do |matches_by_name|
      unless used_matchup?(round, matches_by_name)
        round.push(matches_by_name.shift)
      end
      break if round.count == 3
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
  (names.count - 1).times { schedule << [] }
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
