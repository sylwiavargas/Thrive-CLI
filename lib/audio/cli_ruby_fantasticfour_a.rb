class RubysFantasticFourA


  def self.display_methods_a
    table_data = [
    {:method => "select", :use => "Use it if you answer YES to both questions:"},
    {:method => " ", :use => " 1. Are you trying to choose a few elements out of an array?,"},
    {:method => " ", :use => " 2. Do you have any kind of comparison (e.g. name == XYZ)?"},
    {:method => "map", :use => "Use it if you answer YES to both questions:"},
    {:method => " ", :use => " 1. Is there no comparison?"},
    {:method => " ", :use => " 2. Are you just want to get an attr. of a given instance?"},
    {:method => "find", :use => "Use it to find the 1st thing that fulfills some condition."},
    {:method => "each", :use => "Use when nothing else works or when you are feeling lazy."}]
    # {:method => "map", :use => "Use it if you answer YES to both questions: \n 1. Are you trying to choose a few elements out of an array?, \n 2. Is there no comparison and/or you just want to get \na specific part of a given instance (e.g. 'show only names')?"},
    # {:method => "find", :use => "Use it if you are looking for the first thing that fulfills some condition?"}
    # {:method => "each", :use => "Use it if you are not getting the result you wanna or if you're just lazy, \n resort to each (though remember that it shows poor character)"}

    Formatador.display_table(table_data)
    CliStart.alex_say("You are on the Rubys Fantastic Four page. This page contains a table explaining four Ruby methods, or the Fantastic Four.")
  end

  def self.after_table_a(user)
    CliStart.sam_say("Use the down arrow key and enter to go back to the Ruby category page.")
    prompt = TTY::Prompt.new
    nav = prompt.select('', %w(Back))
    if nav == "Back"
      user.category_search_page_a
    end
  end

  def self.go_a(user)
    system 'clear'
    # system "artii RUBY'S FANTASTIC FOUR | red"
    puts "\n🔹 Here's the most important thing we learned: 🔹 \n\nYou have to nail Ruby's Fantastic Four methods."
    sleep 1
    RubysFantasticFourA.display_methods_a
    CliStart.sam_say("The most important thing we learnt at the bootcamp is that you need to nail these four methods. How to choose the right method? Here is a lit of questions, which will help you decide.")
    CliStart.sam_say("Row first. Method: select. Description. Use it if you answer YES to both questions: 1. Are you trying to choose a few elements out of an array? 2. Do you have any kind of comparison (e.g. name == 'XYZ')?")
    CliStart.sam_say("Row second. Method: map. Description. Use it if you answer YES to both questions: 1. Is there no comparison? 2. Are you just want to get an attr. of a given instance?")
    CliStart.sam_say("Row second. Method: find. Description. Use it to find the 1st thing that fulfills some condition.")
    CliStart.sam_say("Row second. Method: each. Description. Use when nothing else works or when you are feeling lazy.")
    RubysFantasticFourA.after_table_a(user)
  end

end
