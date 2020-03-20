class User < ActiveRecord::Base
  has_many :directories
  has_many :tips, through: :directories

  ########################## Tip Navigation Methods ############################
  def chosen_tip(tip, nav)
    if tip == nil
      return
    end
    puts "\n🔹  #{tip.name} 🔹\n\n"
    puts tip.content.to_s + "\n"
    puts "\nYou can read more here: #{tip.url}"
    if tip.how_to != nil
      puts "\nHere's how to do that: " + tip.how_to
    end
    if tip.url == nil
      tip.save_or_back(self, nav)
    else
      tip.save_or_back_or_read(self, nav)
    end
  end

  def tip_result(choice)
    if choice.include? "\n"
      choice = choice.tr("\n", '')
    end
    Tip.where('name = ?', choice)
  end

  def shorten_category(choices)
    if choices.length > 7
      choices.shuffle!
      choices = choices.slice(0, 7)
      choices.sort!
      choices.last.insert(-1, "\n")
      choices.push("See More")
    else
      choices.last.insert(-1, "\n")
    end
    choices
  end

  def fetch_category_choices(nav)
    all_tips = Tip.where('category = ?', nav)
    no_user_tips = all_tips.where('user_created = ?', false)
    choices = no_user_tips.map { |tip| "#{tip.name}" }
    choices = shorten_category(choices)
    choices.push('Back')
    choices.push('Exit to Home Page')
    choices
  end

  def category_tips(nav)
    prompt = TTY::Prompt.new
    system 'clear'
    choices = fetch_category_choices(nav)
    choice = prompt.select("Choose a tip.\n", choices, per_page: 10)
    if choice == 'Back'
      self.category_search_page
    elsif choice == 'See More'
      self.category_tips(nav)
    elsif choice == 'Exit to Home Page'
      CommandLineInterface.user_home_page(self)
    else
      tip = tip_result(choice)[0]
      chosen_tip(tip, nav)
    end
  end

  def select_a_tip
    tip = category_search_page
    if tip == nil
      return
    end
    system 'clear'
    if tip != nil
      tip.map do |tip|
        puts tip.name
        puts tip.content
      end
    end
    chosen_tip(tip[0])
  end


  ####################### Main Category Navigation Page ########################
  def category_search_page
    system 'clear'
    CatPageArt.display
    prompt = TTY::Prompt.new
    choices = ["Ruby", "Wellness", "Career", "Social", "Back to Home Page"]
    nav = prompt.select("\nWhich category would you like to view?\n", choices)
    if nav == 'Back to Home Page'
      CommandLineInterface.user_home_page(self)
    elsif nav == 'Wellness'
      WellnessCli.go(self)
    elsif nav == 'Ruby'
      RubyTips.ruby_nav(self)
    elsif nav == 'Social'
      SocialCli.random_five(self)
    else
      category_tips(nav)
    end
  end


  ########################## No Saved Tips Animation ###########################
  def empty_directory
    puts "\n              Uh-oh...\n\n"
    puts '─────────▄▄───────────────────▄▄──'
    sleep 0.06
    puts '──────────▀█───────────────────▀█─'
    sleep 0.06
    puts '──────────▄█───────────────────▄█─'
    sleep 0.06
    puts  '──█████████▀───────────█████████▀─'
    sleep 0.06
    puts  '───▄██████▄─────────────▄██████▄──'
    sleep 0.06
    puts '─▄██▀────▀██▄─────────▄██▀────▀██▄'
    sleep 0.06
    puts '─██────────██─────────██────────██'
    sleep 0.06
    puts  '─██───██───██─────────██───██───██'
    sleep 0.06
    puts '─██────────██─────────██────────██'
    sleep 0.06
    puts '──██▄────▄██───────────██▄────▄██─'
    sleep 0.06
    puts  '───▀██████▀─────────────▀██████▀──'
    sleep 0.06
    puts  '──────────────────────────────────'
    sleep 0.06
    puts  '──────────────────────────────────'
    sleep 0.06
    puts  '──────────────────────────────────'
    sleep 0.06
    puts  '───────────█████████████──────────'
    sleep 0.06
    puts  '──────────────────────────────────'
    sleep 0.06
    puts  '──────────────────────────────────'
    puts "\n Looks like you haven't saved any tips yet!"
  end


  ############################# User Saved Tips ################################
  def get_user_labels(user)
    counter = 0
    all_users_tips = Directory.where('user_id = ?', user.id)
    users_labels = all_users_tips.map(&:label).uniq
    output = users_labels.map { |label| "#{counter += 1}. #{label}" }
    if counter == 0
      self.empty_directory
      puts 'You currently have no saved tips. Choose "More" to find new ones!'
      sleep 3
      CommandLineInterface.user_home_page(self)
    else
      output
    end
  end

  def user_saved_tips
    prompt = TTY::Prompt.new
    system 'clear'
    labels = get_user_labels(self)
    return if labels == nil
    labels.push('Back')
    nav = prompt.select('These are your saved labels', labels)

    if nav == 'Back'
      CommandLineInterface.user_home_page(self)
    else
      your_chosen_label = nav.split('. ')[1]

      all_labels = Directory.where('label = ?', your_chosen_label)
      the_labels = all_labels.where('user_id = ?', id)
      counter = 0

      choices = the_labels.map do |user_dir|
        tip = Tip.where('id = ?', user_dir.tip_id)[0]
        "#{counter += 1}. #{tip.content}"
      end

      prompt = TTY::Prompt.new
      choice = prompt.select(' ', choices).split('. ')

      choice.delete_at(0)
      choice = choice.join('. ')
      tip = Tip.where('content = ?', choice)

      all_dir = Directory.where('tip_id = ?', tip[0].id)
      dir = all_dir.where('user_id = ?', id)
      dir[0].display_and_edit_tip(tip, self)
    end
  end

end
