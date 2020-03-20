class Tip < ActiveRecord::Base
  has_many :directories
  has_many :users, through: :directories

  ########################## Save, Label or Comment ############################
  def users_label
    prompt = TTY::Prompt.new
    puts "\n"
    prompt.ask("How would you like to label this tip?")
  end

  def users_comment
    prompt = TTY::Prompt.new
    puts "\n"
    prompt.ask("Is there any comment you'd like to add for youself?")
  end

  def save_tip(user)
    label = users_label
    comment = users_comment
    Directory.create(user_id: user.id, tip_id: self.id, label: label, comment: comment)
    puts "\nYour tip has been saved 👍"
    sleep 3 / 2
  end

  def save_tip_from_search(user)
    prompt = TTY::Prompt.new
    system 'clear'
    puts "\n🔹  #{self.name.to_s} 🔹"
    puts "\n\n" + self.content.to_s + "\n\n"
    choices = ["Save the Tip", "Back", "Exit to Home Page"]
    save_or_back = prompt.select('', choices)
    if save_or_back == 'Save the Tip'
      save_tip(user)
      RubyTips.ask_to_exit(user)
    elsif save_or_back == 'Back'
      RubyTips.ask_to_exit(user)
    else
      CommandLineInterface.user_home_page(user)
    end
  end

  def save_or_back(user, nav)
    prompt = TTY::Prompt.new
    choices = ["Save the Tip", "Back"]
    choice = prompt.select('', choices)
    save_tip(user) if choice == 'Save the Tip'
    user.category_tips(nav)
  end

  def save_or_back_or_read(user, nav)
    prompt = TTY::Prompt.new
    choices = ["Save the Tip", "Search the Web", "Back"]
    choice = prompt.select('', choices)
    if choice == 'Save the Tip'
      save_tip(user)
      save_or_back_or_read(user, nav)
    elsif choice == 'Search the Web'
      system("open -a Safari #{self.url}")
      save_or_back_or_read(user, nav)
    else
      user.category_tips(nav)
    end
  end

end
