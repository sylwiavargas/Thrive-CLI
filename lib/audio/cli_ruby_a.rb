class RubyTipsA

  def self.google_search_a(user)
    CliStart.sam_say("What Ruby topic would you like to search? Write your keyword.")
    prompt = TTY::Prompt.new
    query = prompt.ask("What Ruby topic would you like to search?")
    html = open("https://www.google.com/search?q=Ruby #{query}")
    doc = Nokogiri::HTML(html)

    link_and_description = doc.search(".g")

    new_tip = Tip.create()

    new_tip.name = link_and_description.first.search('h3').text
    new_tip.content = link_and_description.first.search('.s').css('span').text
    new_tip.category = "Ruby"
    new_tip.user_created = true

    junk_url = link_and_description.first.search('.r').search('a').attr('href').text
    new_tip.url = junk_url.split('?q=')[1].split('&sa=')[0]

    new_tip.save!
    user.save_tip_from_search_a(new_tip)
  end


  def self.ask_to_exit_a(user)
    CliStart.sam_say("You are on the Ruby Tips page. Use arrows to choose first option to search again, second to go back to Ruby category and third to go back to the homepage.")
    prompt = TTY::Prompt.new
    choices = ["Search Again", "Back", "Exit to Home Page"]
    nav = prompt.select('', choices)
    if nav == "Search Again"
      google_search_a(user)
    elsif nav == "Back"
      ruby_nav_a(user)
    else
      CommandLineInterfaceA.user_home_page_a(user)
    end
  end

  def self.ruby_nav_a(user)
    CliStart.sam_say("You are on the Ruby Tips page. Use arrows to choose first option to search again, second to go back to Ruby category and third to go back to the homepage.")
    prompt = TTY::Prompt.new
    system 'clear'
    choices = ["Tips", "Fantastic Four", "Search the Web", "Back"]
    nav = prompt.select("\nWe have some great Ruby Tips! You can also search for more.\n", choices)
    if nav == 'Tips'
      user.category_tips_a('Ruby')
    elsif nav == "Fantastic Four"
      RubysFantasticFourA.go_a(user)
    elsif nav == 'Search the Web'
      google_search_a(user)
    else
      user.category_search_page_a
    end
  end

end
