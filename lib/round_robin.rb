require 'pry'

def schedule_tournament(names)
  matchups = generate_matchups(names)
  matches_per_round = names.count / 2
  schedule = []
  (names.count - 1).times do
    schedule << create_round(schedule, matchups, matches_per_round)
  end
  schedule
end

def create_round(schedule, matchups, matches_per_round)
  round = []
  matchups.each do |matchup|
    round << matchup unless used_matchup?(schedule, matchup) || used_name?(round, matchup)
    # binding.pry
    return round if round.count == matches_per_round
  end
end

def used_matchup?(schedule, matchup)
  schedule.any? do |round| 
    round.any? do |previous_matchup|
      previous_matchup == matchup || previous_matchup == matchup.reverse
    end
  end
end

def used_name?(round, matchup)
  name_one, name_two = matchup[0], matchup[1]
  round.any? do |existing_matchup| 
    existing_matchup.any? { |name| name == name_one || name == name_two }
  end
end

def generate_matchups(names)
  matchups = []
  names.each_with_index do |name, i|
    offset = 1
    (names.count - 1).times do 
      if (i + offset) <= (names.count - 1)
        matchups << [name, names[i + offset]]
      else
        matchups << [name, names[0 + ( (i + offset) - names.count)] ]
      end
      offset += 1
    end
  end
  matchups
end

# p generate_matchups(['Dan', 'Tom', 'Frank', 'Fred', 'Marcus', 'Zak'])
p schedule_tournament(['Dan', 'Tom', 'Frank', 'Fred', 'Marcus', 'Zak'])
