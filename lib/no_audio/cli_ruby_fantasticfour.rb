class RubysFantasticFour

  def self.computer_love_art
    puts <<-'EOF'
     _______________                        |*\_/*|________
    |  ___________  |     .-.     .-.      ||_/-\_|______  |
    | |           | |    .****. .****.     | |           | |
    | |   0   0   | |    .*****.*****.     | |   0   0   | |
    | |     -     | |     .*********.      | |     -     | |
    | |   \___/   | |      .*******.       | |   \___/   | |
    | |___     ___| |       .*****.        | |___________| |
    |_____|\_/|_____|        .***.         |_______________|
      _|__|/ \|_|_.............*.............._|________|_
     / ********** \                          / ********** \
   /  ************  \                      /  ************  \
  --------------------                    --------------------
    EOF
  end

  def self.display_methods
    table_data = [
    {:method => "select", :use => "Use it if you answer YES to both questions:"},
    {:method => " ", :use => " 1. Are you trying to choose a few elements out of an array?,"},
    {:method => " ", :use => " 2. Do you have any kind of comparison (e.g. name == 'XYZ')?"},
    {:method => "map", :use => "Use it if you answer YES to both questions:"},
    {:method => " ", :use => " 1. Is there no comparison?"},
    {:method => " ", :use => " 2.Are you just want to get an attr. of a given instance?"},
    {:method => "find", :use => "Use it to find the 1st thing that fulfills some condition."},
    {:method => "each", :use => "Use when nothing else works or when you're feeling lazy."}]

    Formatador.display_table(table_data)
  end

  def self.after_table(user)
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Back))
    if nav == "Back"
      user.category_search_page
    end
  end

  def self.go(user)
    system 'clear'
    sleep 1
    self.computer_love_art
    puts "\n🔹 Here's the most important thing we learned: 🔹 \n\nYou have to nail Ruby's Fantastic Four methods."
    sleep 1
    self.display_methods
    self.after_table(user)
  end

end
