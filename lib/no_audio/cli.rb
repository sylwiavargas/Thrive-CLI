class CommandLineInterface
  #########################  This is just for fun  #############################
  def self.logo_art
    puts "
             ████████╗ ██╗  ██╗ ██████╗  ██╗ ██╗   ██╗ ███████╗
             ╚══██╔══╝ ██║  ██║ ██╔══██╗ ██║ ██║   ██║ ██╔════╝
                ██║    ███████║ ██████╔╝ ██║ ██║   ██║ █████╗
                ██║    ██╔══██║ ██╔══██╗ ██║ ╚██╗ ██╔╝ ██╔══╝
                ██║    ██║  ██║ ██║  ██║ ██║  ╚████╔╝  ███████╗
                ╚═╝    ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝   ╚═══╝   ╚══════╝\n".colorize(:cyan)
    puts"                                 ###
                            #  ### #### #
                          #  ### \/#|### |/####
                           ##\/#/ \||/##/_/##/_#
                      #   ###  \/###|/ \/ # ###
                       ###_\_\_\## | #/###_/_####
                      ## #### # \ #| /  #### ##/##
                 #  ###__#_--###`  |{,###---###-~####".colorize(:green)
    puts"                                  }{
                                  }}{
                                  }}{
                                  {{}
                             , -=-~{ .-^- _
                                  `}
                                   {\n".colorize(:light_black)
    puts "                   TIPS TO SURVIVE WEB DEV BOOTCAMP\n".colorize(:cyan)
  end


  ################################ Exit method #################################
  def self.exit
    puts "\n❤  Come back soon ❤\n"
    sleep 3/2
    system 'exit!'
  end


  ############################## Sign Up Method ################################
  def user_setup(username, password, email)
    user = User.create(name: username, password: password, email: email)
    puts "Your username is #{username} and email is #{email}."
    sleep 3 / 2
    user
  end


  #################### Next 4 methods pertain to login #########################
  def self.fail_name_check
    puts "That name does not match our records"
    sleep 2
    system 'clear'
    self.logo_art
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Retry? Back))
    if nav == "Retry?"
      self.log_in_name
    else
      self.landing_page
    end
  end

  def self.fail_pw_check(username_query)
    puts "Incorrect password"
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Retry? Back))
    if nav == "Retry?"
      self.log_in_pw(username_query)
    else
      self.landing_page
    end
  end

  def self.log_in_name
    system 'clear'
    self.logo_art
    puts "\n"
    prompt = TTY::Prompt.new
    username_query = prompt.ask("Username:")
    log_in = SignUpAndLogIn.new
    if username_query == 'nil'
      log_in.name_fail
    else
      username_query = username_query.downcase
      log_in.check_name(username_query)
    end
  end

  def self.log_in_pw(username_query)
    system 'clear'
    self.logo_art
    puts "\n"
    puts "Username: " + username_query
    prompt = TTY::Prompt.new
    heart = prompt.decorate('❤ ', :red)
    password_query = prompt.mask("Password:", mask: heart).downcase
    log_in = SignUpAndLogIn.new
    log_in.check_password(username_query, password_query)
  end


  ############################ Main User Home Page #############################
  def self.user_home_page(user)
    prompt = TTY::Prompt.new
    system 'clear'
    self.logo_art
    choices = ["More Tips", "Saved Tips", "Logout"]
    nav = prompt.select("\n", choices)
    if nav == "More Tips"
      user.select_a_tip
    elsif nav == "Saved Tips"
      user.user_saved_tips
    else
      CommandLineInterface.landing_page
    end
  end


  ####################### Home Page Upon Signup & Login ########################
  def self.temp_home_page(user)
    prompt = TTY::Prompt.new
    system 'clear'
    self.logo_art
    puts "Hello"
    choices = ["More Tips", "Saved Tips", "Logout"]
    nav = prompt.select("\n🔹  Here's today's tip: 🔹\n\n#{Tip.first.content}\n", choices)
    if nav == "More Tips"
      user.select_a_tip
    elsif nav == "Saved Tips"
      user.user_saved_tips
    else
      CommandLineInterface.landing_page
    end
  end


  ########################### Main App Landing Page ############################
  def self.landing_page
    system 'clear'
    self.logo_art
    puts "Welcome to Thrive"
    prompt = TTY::Prompt.new
    nav = prompt.select("\nWhat would you like to do?", %w(Create Login Exit))
    if nav == "Create"
      sign_up = SignUpAndLogIn.new
      new_user = sign_up.create_a_user
      temp_home_page(new_user)
    elsif nav == "Login"
      self.log_in_name
    elsif nav == "Exit"
      CommandLineInterface.exit
    end
  end

end
