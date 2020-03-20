class SignUpAndLogIn

  ############################## Sign Up Methods ###############################
  def check_username(username)
    if User.all.map(&:name).include?(username)
      puts 'That username is taken'
      sleep 5 / 2
      set_username
    else
      username
    end
  end

  def set_username
    system 'clear'
    prompt = TTY::Prompt.new
    username = prompt.ask('What is your username?') do |q|
      q.required true
    end
    username = username.downcase
    check_username(username)
  end

  def set_pw_page(username)
    system 'clear'
    puts 'What is your username? ' + username
  end

  def set_password
    prompt = TTY::Prompt.new
    heart = prompt.decorate('❤ ', :red)
    prompt.mask('What is your password?', mask: heart)
  end

  def validate_pw(confirm, password, username)
    if confirm != password
      puts('Your passwords do not match.')
      sleep 3 / 2
      confirm_password(username)
    end
  end

  def confirm_password(username)
    set_pw_page(username)
    password = set_password
    prompt = TTY::Prompt.new
    heart = prompt.decorate('❤ ', :red)
    confirm = prompt.mask('Please confirm your password?', mask: heart)
    validate_pw(confirm, password, username)
    password
  end

  def set_email
    prompt = TTY::Prompt.new
    prompt.ask('What is your email?') do |q|
      q.validate(/\A\w+@\w+\.\w+\Z/) # copied from TTY prompt documentation
      q.messages[:valid?] = 'Invalid email address'
    end
  end

  def create_a_user
    username = set_username
    password = confirm_password(username)
    email = set_email
    sign_up = CommandLineInterface.new
    sign_up.user_setup(username, password, email)
  end

  ############################### Log In Methods ###############################
  def check_password(username_query, password_query)
    user = User.where('name = ?', username_query)
    if user[0].password == password_query
      user = user[0]
      CommandLineInterface.temp_home_page(user)
    else
      CommandLineInterface.fail_pw_check(username_query)
    end
  end

  def check_name(username_query)
    if User.all.map(&:name).include?(username_query)
      CommandLineInterface.log_in_pw(username_query)
    else
      CommandLineInterface.fail_name_check
    end
  end

  def name_fail
    puts 'That username does not match our records'
  end

  def log_in(username_query, password_query)
    if !User.all.map(&:name).include?(username_query.downcase)
      self.name_fail
    elsif !User.where('name = ?', username_query).map(&:password).include?(password_query)
      puts 'Password is incorrect. Try again.'
    else
      User.select('name = ?', username_query && 'password = ?', password_query)
    end
  end

end
