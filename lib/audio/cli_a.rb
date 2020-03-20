require 'colorize'
require 'artii'
require 'lolcat'

class CommandLineInterfaceA
  ##################  This is just for fun  #####################
  def self.logo_art_a
    # logo = puts "//".colorize(:cyan) + " ♥".colorize(:red)
    art = puts <<-'EOF'

             ████████╗██╗  ██╗██████╗ ██╗██╗   ██╗███████╗
             ╚══██╔══╝██║  ██║██╔══██╗██║██║   ██║██╔════╝
                ██║   ███████║██████╔╝██║██║   ██║█████╗
                ██║   ██╔══██║██╔══██╗██║╚██╗ ██╔╝██╔══╝
                ██║   ██║  ██║██║  ██║██║ ╚████╔╝ ███████╗
                ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚══════╝
                                  ###
                            #  ### #### #
                          #  ### \/#|### |/####
                           ##\/#/ \||/##/_/##/_#
                      #   ###  \/###|/ \/ # ###
                       ###_\_\_\## | #/###_/_####
                      ## #### # \ #| /  #### ##/##
                 #  ###__#_--###'  |{,###---###-~####
                                 \ }{
                                  }}{
                                  }}{
                                  {{}
                             , -=-~{ .-^- _
                                  '}
                                   {
                  TIPS TO SURVIVE WEB DEV BOOTCAMP
      EOF
      # puts logo
    puts art
    puts "           [audio announcement playing, text will proceed]"
  end

  ### Enabled here, as a class method - to be called anywhere ###
  def self.exit_a
    puts "\n❤  Come back soon ❤\n"
    CliStart.sam_say('Come back soon')
    system 'exit!'
  end


  ############# Next 4 methods pertain to login #################
  def self.fail_name_check_a
    puts "That name does not match our records"
    CliStart.sam_say('That name does not match our records')
    CliStart.sam_say('Select top option to try again and bottom option to go back to the homepage')
    system 'clear'
    self.logo_art_a
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Retry? Back))
    if nav == "Retry?"
      self.log_in_name_a
    else
      self.landing_page_a
    end
  end

  def self.fail_pw_check_a(username_query)
    puts "Incorrect password"
    CliStart.sam_say('Incorrect password. Top option - try again, bottom option - go back.')
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Retry? Back))
    if nav == "Retry?"
      self.log_in_pw_a(username_query)
    else
      self.landing_page_a
    end
  end


  def self.log_in_name_a
    system 'clear'
    self.logo_art_a
    puts "\n"
    CliStart.sam_say('What is your username?')
    prompt = TTY::Prompt.new
    username_query = prompt.ask("Username:")
    if username_query == 'nil'
      User.name_fail_a
    else
      username_query = username_query.downcase
      User.check_name_a(username_query)
    end
  end


  def self.log_in_pw_a(username_query)
    system 'clear'
    self.logo_art_a
    puts "\n"
    puts "Username: " + username_query
    CliStart.sam_say("Your username is #{username_query}")
    CliStart.sam_say("Please write your password")
    prompt = TTY::Prompt.new
    heart = prompt.decorate('❤ ', :red)
    password_query = prompt.mask("Password:", mask: heart).downcase
    User.check_password_a(username_query, password_query)
  end


  ##################### Main User Home Page #####################
  def self.user_home_page_a(user)
    prompt = TTY::Prompt.new
    system 'clear'
    CliStart.sam_say('You are on the homepage. Use arrows to choose first option to explore more tips, second option to access your saved tips and third to logout.')
    choices = ["More Tips", "Saved Tips", "Logout"]
    nav = prompt.select("\n", choices)
    if nav == "More Tips"
      user.select_a_tip_a
    elsif nav == "Saved Tips"
      user.user_saved_tips_a
    else
      CommandLineInterfaceA.landing_page_a
    end
  end

  ################ Home Page Upon Signup & Login ################
  def self.temp_home_page_a(user)
    puts "           [audio announcement playing, text will proceed]"
    CliStart.sam_say('Hello. You are on the homepage. Here is todays tip: Although pry may seem a little counter-intuitive (for instance, you may think why would I stop my process to use pry?!?), it will save you a lot of trouble if you pry often.')
    sleep (0.5)
    CliStart.sam_say('Use arrows to choose first option to explore more tips, second option to access your saved tips and third to logout.')
    prompt = TTY::Prompt.new
    system 'clear'
    puts "Hello"
    choices = ["More Tips", "Saved Tips", "Logout"]
    nav = prompt.select("\n🔹  Here's today's tip: 🔹\n\n#{Tip.first.content}\n", choices)
    if nav == "More Tips"
      user.select_a_tip_a
    elsif nav == "Saved Tips"
      user.user_saved_tips_a
    else
      CommandLineInterfaceA.landing_page_a
    end
  end



  #################### Main App Landing Page ####################
  def self.landing_page_a
    system 'clear'
    self.logo_art_a
    CliStart.sam_say('You are now back on the landing page.')
    CliStart.sam_say('What would you like to do?')
    CliStart.sam_say('Use arrows to choose first option to create an account, second option to login and third to exit the app.')
    prompt = TTY::Prompt.new
    nav = prompt.select("\nWhat would you like to do?", %w(Create Login Exit))
    if nav == "Create"
      new_user = User.create_a_user_a
      temp_home_page_a(new_user)
    elsif nav == "Login"
      self.log_in_name_a
    elsif nav == "Exit"
      CommandLineInterfaceA.exit_a
    end
  end

  #################### Main App Landing Page ####################
  def self.first_landing_page_a
    system 'clear'
    self.logo_art_a
    CliStart.sam_say('You are now on the landing page of Thrive. Tips to survive web dev bootcamp.')
    CliStart.alex_say('This landing page features a picture of a tree composed out of different keyboard characters and symbols. The tree has many branches, leaves, roots and appears strong and well-grounded.')
    CliStart.sam_say('What would you like to do?')
    CliStart.sam_say('Use arrows to choose first option to create an account, second option to login and third to exit the app.')
    prompt = TTY::Prompt.new
    nav = prompt.select("\nWhat would you like to do?", %w(Create Login Exit))
    if nav == "Create"
      new_user = User.create_a_user_a
      temp_home_page_a(new_user)
    elsif nav == "Login"
      self.log_in_name_a
    elsif nav == "Exit"
      CommandLineInterfaceA.exit_a
    end
  end
end
