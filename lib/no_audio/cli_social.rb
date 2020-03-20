class SocialCli
  def self.social_art
    art = puts <<-'EOF'
    ___________________
    | _______________ |
    | |XXXXXXXXXXXXX| |
    | |XXX FIND XXXX| |
    | |XXX SOME XXXX| |
    | |XX FRIENDS XX| |
    | |XXXXXXXXXXXXX| |
    |_________________|
        _[_______]_
    ___[___________]___
   |         [_____] []|__
   |         [_____] []|  \__
   L___________________J     \ \___\/
    ___________________      /\
   /###################\    (__)
    EOF
    art
  end

  def self.output(meetup_api, results, counter)
    results = meetup_api['results']
    num = rand(1...20)
    if results[num]['name'] != nil
      meetup_name = results[num]['name']
    end
    if results[num]['description'] != nil
      meetup_description = results[num]['description'].tr('/', '').slice!(3, 300)
    end
    if results[num]['event_url']
      meetup_url = results[num]['event_url']
    end
    if results[num]['name'] != nil && results[num]['description'] != nil && results[num]['event_url'] != nil
      puts "#{counter}. " + '🔹  ' + meetup_name + ' 🔹' + "\n What: " + meetup_description + '(...)' + "\n RSVP: " + meetup_url + "\n\n"
    else
      self.output(meetup_api, results, counter)
    end
  end

  def self.random_five(user)
    meetup_api = JSON.parse(RestClient.get('https://api.meetup.com/2/concierge?key=2f673325f5b422527f3d7e1c683f&sign=true&photo-host=public&country=United States&city=New York City&category_id=34'))
    system 'clear'
    self.social_art
    results = meetup_api['results']
    puts "\nHere's what's happening around you in tech:\n\n"
    counter = 0
    5.times do
      counter += 1
      self.output(meetup_api, results, counter)
    end
    self.after_meetups(user)
  end

  def self.after_meetups(user)
    prompt = TTY::Prompt.new
    nav = prompt.select('What do you want to do next?', %w[More Back])
    if nav == 'More'
      self.random_five(user)
    else
      user.category_search_page
    end
  end

end
