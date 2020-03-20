require 'pry'
require 'rest-client'
require 'json'
require 'net/http'
require 'tty-prompt'
require 'open-uri'
require 'nokogiri'

class WellnessCliA

    # https://www.wikihow.com/Meditate-on-Breath

############################# BREATHING METHODS ############################################################
  def self.invite_for_breathing_a
    prompt = TTY::Prompt.new
    choices = ["30 seconds", "1 minute", "2 minutes", "3 minutes"]
    CliStart.sam_say("How much time do you have for this exercise?")
    CliStart.sam_say("Use the down arrow key and enter to choose your option. Top option: 30 seconds. Second option: 1 minute. Third option: 2 minutes. Fourth option: 3 minutes.")
    time = prompt.select('How much time do you have for this exercise?', choices)
    number = 1 if time == "30 seconds"
    number = 2 if time == "1 minute"
    number = 4 if time == "2 minutes"
    number = 6 if time == "3 minutes"
    puts "\n 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 \n"
    CliStart.sam_say("Stress is real.")
    puts "Stress is real."
    sleep (0.5)
    CliStart.sam_say("One of the ways to tackle it is through intentional breathing.")
    puts "One of the ways to tackle it is through intentional breathing."
    sleep (0.5)
    CliStart.sam_say("We invite you to do a simple exercise.")
    puts "We invite you to do a simple exercise."
    sleep (0.5)
    CliStart.sam_say("Follow our guidance.")
    puts "Follow our guidance."
    sleep (0.5)
    CliStart.sam_say("You will inhale for 4 seconds through your nose.")
    puts "You'll inhale for 4 seconds through your nose."
    sleep (0.5)
    CliStart.sam_say("Then you will hold your breath for 7 seconds.")
    puts "Then you'll hold your breath for 7 seconds."
    sleep (0.5)
    CliStart.sam_say("Finally, you will exhale for 8 seconds through your mouth.")
    puts "Finally, you'll exhale for 8 seconds through your mouth."
    puts "\n 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 🔹 \n "
    sleep 1
    breathing_circle_a(number)
  end

  def self.breathing_circle_a(number)
    number.times do
      CliStart.sam_say_slow("Breathe in")
        sleep 4
      CliStart.sam_say_slow("Hold in")
        sleep 7
      CliStart.sam_say_slow("Breathe out")
        sleep 8
      CliStart.sam_say_slow("Repeat one more time")
      CliStart.sam_say_slow("Breathe in")
        sleep 4
      CliStart.sam_say_slow("Hold in")
        sleep 7
      CliStart.sam_say_slow("Breathe out")
        sleep 8
    end
    CliStart.sam_say_slow("Great job!")
    WellnessCliA.go_a
  end


  def self.breathing_a
    WellnessCliA.invite_for_breathing_a
    #next step
  end

  ############################# QUOTES ############################################################

  def self.get_inspirational_quote_a(user)
    system 'clear'
    inspiration_api = JSON.parse(RestClient.get("http://quotes.rest/qod.json?category=inspire"))
    quote = inspiration_api["contents"]["quotes"][0]["quote"]
    author = inspiration_api["contents"]["quotes"][0]["author"]
    puts "\n\n                                 🔹 🔹 🔹                                       \n\n"
    puts "Here is your inspirational quote for today: \n\n '#{quote}'" +  "\n\n                               (#{author})"
    puts "\n\n                                 🔹 🔹 🔹                                       \n\n"
    CliStart.sam_say("Here is your inspirational quote for today by #{author}: #{quote}")
    CliStart.sam_say("Use the down arrow key and enter to go back to Wellness Category")
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Back))
    if nav == "Back"
      WellnessCli.go(user)
    end
  end


  def self.get_management_quote_a(user)
    # binding.pry
    system 'clear'
    management_api = JSON.parse(RestClient.get("http://quotes.rest/qod.json?category=management"))
    quote = management_api["contents"]["quotes"][0]["quote"]
    author = management_api["contents"]["quotes"][0]["author"]
    puts "\n\n                                 🔹 🔹 🔹                                       \n\n"
    puts "Here is your management quote for today: \n\n '#{quote}'" +  "\n                            (#{author})"
    puts "\n\n                                 🔹 🔹 🔹                                       \n\n"
    quote_accessible = quote.to_s.gsub(/'s/, ' is').gsub(/\n/, '')
    CliStart.sam_say("Here is your management quote for today by #{author}: #{quote_accessible}")
    CliStart.sam_say("Use the down arrow key and enter to go back to Wellness Category")
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Back))
    if nav == "Back"
      WellnessCli.go(user)
    end
  end

    ############################# TIPS ############################################################
    ###This data has been seeded instead, find this method in the seed file
    # def self.scrape_tips
    #     list = []
    #
    #     html = open("https://ggia.berkeley.edu/")
    #     doc = Nokogiri::HTML(html)
    #     tips = doc.search(".article__content") #selects 1(0.5) tips
    #
    #     tips.map.with_index do |tip, index|
    #         new_tip = Tip.new #create a new Tip instance
    #         new_tip.title = tip.css('h4').text
    #         new_tip.content = tip.css('p').text
    #         # new_tip.content = tip.attr("href")
    #         # list[index] = new_tip
    #     end
    #     #
    #     # list.sort_by! {|obj| BY WHAT}
    #     list
    # end

    ############################# EVERYTHING TOGETHER #############################################

  def self.wellness_options_a(user)
    # breathing = "Breathing exercise"
    # inspiration = "Inspirational quote of today"
    # management = "Management quote of today"
    # tips = "Bootcamp wellness tips"
    # back = "Back"
    prompt = TTY::Prompt.new
    CliStart.sam_say("You are on the Wellness category page. What are you interested in?")
    CliStart.sam_say("Use the down arrow key and enter to choose option. Top option: Breathing exercise. Second option: Inspirational quote. Third option: management quote. Fourth option: Wellness tips. Fifth option: Fun animation. Sixth option: Back to the homepage.")
    nav = prompt.select("What are you interested in?", %w(Breathing Inspiration Management Tips Fun Back))
    if nav == "Breathing"
      WellnessCliA.breathing_a(user)
    elsif nav == "Inspiration"
      WellnessCliA.get_inspirational_quote_a(user)
    elsif nav == "Management"
      WellnessCliA.get_management_quote_a(user)
    elsif nav == "Tips"
      user.category_tips_a('Wellness')
    elsif nav == "Fun"
      BananaManA.go_a(user)
    else
      user.category_search_page_a
    end
  end

  def self.go_a(user)
    wellness_options_a(user)
  end

end
