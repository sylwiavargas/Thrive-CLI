class User < ActiveRecord::Base
  has_many :directories
  has_many :tips, through: :directories

  ############################## Sign Up Methods ###############################
  def self.check_username_a(username)
    if all.map(&:name).include?(username)
      puts 'That username is taken'
      CliStart.sam_say("This username is taken")
      CliStart.sam_say("What is your username?")
      set_username_a
    else
      username
    end
  end

  def self.set_username_a
    system 'clear'
    prompt = TTY::Prompt.new
    username = prompt.ask('What is your username?') do |q|
      q.required true
    end
    username = username.downcase
    check_username_a(username)
  end

  def self.set_pw_page_a(username)
    system 'clear'
    puts 'What is your username? ' + username
  end

  def self.set_password_a
    CliStart.sam_say("What is your password?")
    prompt = TTY::Prompt.new
    heart = prompt.decorate('❤ ', :red)
    prompt.mask('What is your password?', mask: heart)
  end

  def self.validate_pw_a(confirm, password, username)
    if confirm != password
      puts('Your passwords do not match.')
      CliStart.sam_say("Your passwords do not match")
      confirm_password_a(username)
    end
  end

  def self.confirm_password_a(username)
    set_pw_page_a(username)
    password = set_password_a
    CliStart.sam_say("Please confirm your password?")
    prompt = TTY::Prompt.new
    heart = prompt.decorate('❤ ', :red)
    confirm = prompt.mask('Please confirm your password?', mask: heart)
    validate_pw_a(confirm, password, username)
    password
  end

  def self.set_email_a
    prompt = TTY::Prompt.new
    prompt.ask('What is your email?') do |q|
      q.validate(/\A\w+@\w+\.\w+\Z/) # copied from TTY prompt documentation
      q.messages[:valid?] = CliStart.sam_say("Invalid email address")
    end
  end

  def self.user_setup_a(username, password, email)
    user = User.create(name: username, password: password, email: email)
    puts "Your username is #{username} and email is #{email}."
    CliStart.sam_say("Your username is #{username} and email is #{email}.")
    user
  end

  def self.create_a_user_a
    CliStart.sam_say("What is your username?")
    username = set_username_a
    CliStart.sam_say("Your username is #{username}")
    password = confirm_password_a(username)
    CliStart.sam_say("What is your email?")
    email = set_email_a
    user_setup_a(username, password, email)
  end

  ############################### Log In Methods ###############################
  def self.check_password_a(username_query, password_query)
    user = where('name = ?', username_query)
    if user[0].password == password_query
      user = user[0]
      CommandLineInterfaceA.temp_home_page_a(user)
    else
      CommandLineInterfaceA.fail_pw_check_a(username_query)
    end
  end

  def self.check_name_a(username_query)
    if User.all.map(&:name).include?(username_query)
      CommandLineInterfaceA.log_in_pw_a(username_query)
    else
      CommandLineInterfaceA.fail_name_check_a
    end
  end

  def self.name_fail_a
    CliStart.sam_say("That username does not match our records")
    puts 'That username does not match our records'
  end

  def self.log_in_a(username_query, password_query)
    if !User.all.map(&:name).include?(username_query.downcase)
      self.name_fail_a
    elsif !User.where('name = ?', username_query).map(&:password).include?(password_query)
      CliStart.sam_say("Password is incorrect. Try again.")
      puts 'Password is incorrect. Try again.'
    else
      User.select('name = ?', username_query && 'password = ?', password_query)
    end
  end

  ###################### Save Tip, Label, and Comment ##########################
  def users_label_a
    CliStart.sam_say("How would you like to label this tip?")
    puts "\n"
    prompt = TTY::Prompt.new
    users_label_a = prompt.ask("How would you like to label this tip?")
    users_label_a
  end

  def users_comment_a
    CliStart.sam_say("Is there any comment you would like to add for yourself?")
    puts "\n"
    prompt = TTY::Prompt.new
    users_comment_a = prompt.ask("Is there any comment you would like to add for yourself?")
    users_comment_a
  end

  def save_tip_from_search_a(new_tip)
    prompt = TTY::Prompt.new
    system 'clear'
    puts "\n🔹  #{new_tip.name.to_s} 🔹"
    puts "\n\n" + new_tip.content.to_s + "\n\n"
    name = new_tip.name.to_s
    content = new_tip.content.to_s
    CliStart.sam_say("#{name}")
    CliStart.sam_say("#{content}")
    sleep (0.5)
    CliStart.sam_say("Use the arrow keys and enter to choose an option. Top option: save the tip. Second option: go back. Bottom option: exit to homepage.")
    choices = ["Save the Tip", "Back", "Exit to Home Page"]
    save_or_back = prompt.select('', choices)
    if save_or_back == 'Save the Tip'
      save_tip_a(new_tip)
      RubyTipsA.ask_to_exit_a(self)
    elsif save_or_back == 'Back'
      RubyTipsA.ask_to_exit_a(self)
    else
      CommandLineInterfaceA.user_home_page_a(self)
    end
  end

  def save_tip_a(tip)
    label = users_label_a
    comment = users_comment_a
    Directory.create(user_id: id, tip_id: tip.id, label: label, comment: comment)
    puts 'Your tip has been saved 👍'
    CliStart.sam_say("Your tip has been saved. Yay!")
  end

  def save_or_back_a(tip, nav)
    prompt = TTY::Prompt.new
    CliStart.sam_say("Use the arrow keys and enter to choose an option. Top option: save the tip. Bottom option: go back.")
    choices = ["Save the Tip", "Back"]
    choice = prompt.select('', choices)
    save_ti_ap(tip) if choice == 'Save the Tip'
    category_tips_a(nav)
  end

  def save_or_back_or_read_a(tip, nav)
    prompt = TTY::Prompt.new
    CliStart.sam_say("Use the arrow keys and enter to choose an option. Top option: save the tip. Second option: search the web. Bottom option: go back.")
    choices = ["Save the Tip", "Search the Web", "Back"]
    choice = prompt.select('', choices)
    if choice == 'Save the Tip'
      save_tip_a(tip)
      save_or_back_or_read_a(tip, nav)
    elsif choice == 'Search the Web'
      system("open -a Safari #{tip.url}")
      save_or_back_or_read_a(tip, nav)
    else
      category_tips_a(nav)
    end
  end

  ############################ Navigation Methods ##############################
  def chosen_tip_a(tip, nav)
    if tip == nil
      return
    end
    content = tip.content.to_s.gsub(/'s/, ' is').gsub(/\n/, '')
    if tip.title != nil
      name = tip.title.gsub(/'s/, ' is').gsub(/\n/, '')
    else
      name = tip.name.gsub(/'s/, ' is').gsub(/\n/, '')
    end
    if tip.url != nil
      url = tip.url.gsub(/'s/, ' is').gsub(/\n/, '')
    end
    puts "[audio announcement playing, text will proceed]"
    CliStart.sam_say("Here is the tips title: #{name}")
    CliStart.sam_say("Here is the tips content: #{content}")
    CliStart.sam_say("You can read more here: #{url}")
    puts "\n🔹  #{tip.name} 🔹\n\n"
    puts tip.content.to_s + "\n"
    puts "\nYou can read more here: #{tip.url}"
    if tip.how_to != nil
      howto = tip.how_to.gsub(/'s/, ' is').gsub(/\n/, '')
      puts "\nHere's how to do that: " + tip.how_to
      CliStart.sam_say("Here is how to do that:  #{howto}")
    end
    if tip.url == nil
      save_or_back_a(tip, nav)
    else
      save_or_back_or_read_a(tip, nav)
    end
  end

  def tip_result_a(choice)
    if choice.include? "\n"
      choice = choice.tr("\n", '')
    end
    Tip.where('name = ?', choice)
  end

  def category_tips_a(nav)
    prompt = TTY::Prompt.new
    all_tips = Tip.where('category = ?', nav)
    no_user_tips = all_tips.where('user_created = ?', false)
    choices = no_user_tips.map { |tip| "#{tip.name}" }
    if choices.length > 7
      choices.shuffle!
      choices = choices.slice(0, 7)
      choices.sort!
      choices.last.insert(-1, "\n")
      choices.push("See More")
    else
      choices.last.insert(-1, "\n")
    end
    choices.push('Back')
    choices.push('Exit to Home Page')
    system 'clear'
    choices_a = choices.each {|choice| choice.gsub(/'s/, ' is').gsub(/\n/, '')}
    CliStart.sam_say("Choose a tip.")
    counter = 0
    choices_a.each do |choice|
      CliStart.sam_say("#{counter +=1} #{choice}")
    end
    choice = prompt.select("Choose a tip.\n", choices, per_page: 5)
    if choice == 'Back'
      self.category_search_page_a
    elsif choice == 'See More'
      self.category_tips_a(nav)
    elsif choice == 'Exit to Home Page'
      CommandLineInterfaceA.user_home_page_a(self)
    else
      tip = tip_result_a(choice)[0]
      chosen_tip_a(tip, nav)
    end
  end

  def category_search_page_a
    system 'clear'
    CatPageArtA.display_a
    CliStart.sam_say("Which category would you like to view?")
    CliStart.sam_say("Use the arrow keys and enter to choose an option. Top option: Ruby. Second option: wellness. Third option: Career. Fourth option: Social. Bottom option: back to homepage.")
    prompt = TTY::Prompt.new
    choices = ["Ruby", "Wellness", "Career", "Social", "Back to Home Page"]
    nav = prompt.select("\nWhich category would you like to view?\n", choices)
    if nav == 'Back to Home Page'
      CommandLineInterfaceA.user_home_page_a(self)
    elsif nav == 'Wellness'
      WellnessCliA.go_a(self)
    elsif nav == 'Ruby'
      CliStart.sam_say("You are on the Ruby category page. Use arrows to choose first option to see Ruby tips, second to go to Ruby's Fantastic Four, third to search the web for a Ruby question, and fourth to go back to the homepage.")
      RubyTipsA.ruby_nav_a(self)
    elsif nav == 'Social'
      SocialCliA.random_meetup_a(self)
    else
      category_tips_a(nav)
    end
  end

  def select_a_tip_a
    tip = category_search_page_a
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

  def empty_directory_a
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
    puts "\nLooks like you haven't saved any tips yet!"
    CliStart.sam_say("Looks like you have not saved any tips yet!")
    sleep (0.5)
    CliStart.alex_say("This page features a picture of confused face composed out of different characters such as brackets.")
    sleep (0.5)


  end

  def get_user_labels_a(user)
    counter = 0
    all_users_tips = Directory.where('user_id = ?', user.id)
    users_labels = all_users_tips.map(&:label).uniq
    output = users_labels.map { |label| "#{counter += 1}. #{label}" }
    if counter == 0
      # Add an animation if ther are no saved tips#
      self.empty_directory_a
      puts 'You currently have no saved tips. Choose "More" to find new ones!'
      CliStart.sam_say("You currently have no saved tips. Choose the optiongo back to your homepage and use the option more to find new ones!")
      CommandLineInterfaceA.user_home_page_a(self)
    else
      output
    end
  end

  def user_saved_tips_a
    prompt = TTY::Prompt.new
    system 'clear'
    labels = get_user_labels_a(self)
    return if labels == nil
    labels.push('Back')
    counter = 0
    CliStart.sam_say("These are your saved labels")
    labels.each do |label|
      label = label.gsub(/'s/, 'is').gsub(/\n/, '')
      CliStart.sam_say("#{counter += 1}. #{label}")
    end
    nav = prompt.select('These are your saved labels:', labels)

    if nav == 'Back'
      CommandLineInterfaceA.user_home_page_a(self)
    else
      your_chosen_label = nav.split('. ')[1]

      all_labels = Directory.where('label = ?', your_chosen_label)
      the_labels = all_labels.where('user_id = ?', id)
      counter = 0

      choices = the_labels.map do |user_dir|
        tip = Tip.where('id = ?', user_dir.tip_id)[0]
        content = tip.content
        CliStart.sam_say("#{counter += 1}. #{content}")
      end

      prompt = TTY::Prompt.new
      choice = prompt.select(' ', choices).split('. ')

      choice.delete_at(0)
      choice = choice.join('. ')
      tip = Tip.where('content = ?', choice)

      all_dir = Directory.where('tip_id = ?', tip[0].id)
      dir = all_dir.where('user_id = ?', id)
      dir[0].display_and_edit_tip_a(tip, self)
    end
  end
end
