class RubyTips

  def self.google_search(user)
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
    new_tip.save_tip_from_search(user)
  end


  def self.ask_to_exit(user)
    prompt = TTY::Prompt.new
    choices = ["Search Again", "Back", "Exit to Home Page"]
    nav = prompt.select('', choices)
    if nav == "Search Again"
      google_search(user)
    elsif nav == "Back"
      ruby_nav(user)
    else
      CommandLineInterface.user_home_page(user)
    end
  end


  def self.ruby_nav(user)
    prompt = TTY::Prompt.new
    system 'clear'
    choices = ["Tips", "Fantastic Four", "Search the Web", "Back"]
    nav = prompt.select("\nWe have some great Ruby Tips! You can also search for more.\n", choices)
    if nav == 'Tips'
      user.category_tips('Ruby')
    elsif nav == "Fantastic Four"
      RubysFantasticFour.go(user)
    elsif nav == 'Search the Web'
      google_search(user)
    else
      user.category_search_page
    end
  end

end
