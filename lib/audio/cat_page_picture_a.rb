class CatPageArtA
  def pic_one_a
    art = puts <<-'EOF'


          ,,,                      ,,,
         {{{}}    ,,,             {{{}}    ,,,
      ,,, ~Y~    {{{}},,,      ,,, ~Y~    {{{}},,,
     {{}}} |/,,,  ~Y~{{}}}    {{}}} |/,,,  ~Y~{{}}}
      ~Y~ \|{{}}}/\|/ ~Y~  ,,, ~Y~ \|{{}}}/\|/ ~Y~  ,,,
      \|/ \|/~Y~  \|,,,|/ {{}}}\|/ \|/~Y~  \|,,,|/ {{}}}
      \|/ \|/\|/  \{{{}}/  ~Y~ \|/ \|/\|/  \{{{}}/  ~Y~
      \|/\\|/\|/ \\|~Y~//  \|/ \|/\\|/\|/ \\|~Y~//  \|/
      \|//\|/\|/,\\|/|/|// \|/ \|//\|/\|/,\\|/|/|// \|/
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


   EOF
    art
    puts "[audio announcement playing, text will proceed]"
    CliStart.alex_say("This page features a picture of flowers composed out of different characters such as brackets. The flowers make the page seem more joyful.")
  end

  def pic_two_a
    art = puts <<-'EOF'


         .{{}}}}}}.
        {{{{{{(")}}}.
       {{{(")}}}}}}}}}
      }}}}}}}}}{{("){{{
      }}}}{{{{(")}}{{{{
     {{{(")}}}}}}}{}}}}}
    {{{{{{{{(")}}}}}}}}}}
    {{{{{{{}{{{{(")}}}}}}
     {{{{{(")   {{{{(")}
       """" |   | """
      (")  /     \
     ~~~~~~~~~~~~~~~~~~~


  EOF
    art
    puts "[audio announcement playing, text will proceed]"
    CliStart.alex_say("This page features a picture of an apple tree composed out of different characters such as brackets. The tree looks as if drawn by a child.")
  end

  def pic_three_a
    art = puts <<-'EOF'


           wWWWw               wWWWw
     vVVVv (___) wWWWw         (___)  vVVVv
     (___)  ~Y~  (___)  vVVVv   ~Y~   (___)
      ~Y~   \|    ~Y~   (___)    |/    ~Y~
      \|   \ |/   \| /  \~Y~/   \|    \ |/
     \\|// \\|// \\|/// \\|//  \\|// \\\|///
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


  EOF
    art
    puts "[audio announcement playing, text will proceed]"
    CliStart.alex_say("This page features a picture of flowers composed out of different characters such as brackets. The flowers seem orderly and healthy.")
  end

  def pic_four_a
    art = puts <<-'EOF'

         ,            __ \/ __
     /\^/"\          /o \{}/ o\   If I had a flower for each time
    | \/   |         \   ()   /     I thought of hashes, my garden
    | |    |          "> /\ <"   ,,,     would be full...
    \ \    /  @@@@    (o/\/\o)  {{{}}                 _ _
     '\\//'  @@()@@  _ )    (    ~Y~       @@@@     _{ ' }_
       ||     @@@@ _(_)_   wWWWw .oOOo.   @@()@@   { ".!." }
       ||     ,/  (_)@(_)  (___) OO()OO    @@@@  _ ',_/Y\_,'
       ||  ,\ | /)  (_)\     Y   'OOOO',,,(\|/ _(_)_ {_,_}
   |\  ||  |\\|// vVVVv"|/@@@@    _ \/{{}}}\| (_)@(_)  |  ,,,
   | | ||  | |;,,,(___) |@@()@@ _(_)_| ~Y~ wWWWw(_)\ (\| {{{}}
   | | || / / {{}}} Y  \| @@@@ (_)#(_) \|  (___)   |  \| /~Y~
    \ \||/ /\\|~Y~ \|/  | \ \/  /(_) |/ |/   Y    \|/  |//\|/
jgs\ "\\//",.\|/|//.|/\\|/\\|,\|/ //\|/\|.\\\| // \|\\ |/,\|/
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  EOF
    art
    puts "[audio announcement playing, text will proceed]"
    CliStart.alex_say("This page features a picture of a garden including flowers, bees and a butterfly composed out of different characters such as brackets. There is a sign that reads: If I had a flower for each time I thought of hashes, my garden would be full.")
  end

  def pic_five_a
    art = puts <<-'EOF'

          _________
         / ======= \
        / __________\
       | ___________ |
       | | -       | |
       | |         | |
       | |_________| |_________________________
       \=____________/   computer says no       )
       / """"""""""" \                         /
      / ::::::::::::: \                    =D-/
     (_________________)


  EOF
    art
    puts "[audio announcement playing, text will proceed]"
    CliStart.alex_say("This page features a picture of an old-fashion computer composed out of different characters such as brackets. The computer is unplugged and its screen is empty. There is a sign that reads: Computer says no.")
  end

  def pic_six_a
    art = puts <<-'EOF'


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
    art
    puts "[audio announcement playing, text will proceed]"
    CliStart.alex_say("This page features a picture of two computers composed out of different characters such as brackets. The computers have smiley faces on their screens. The computer on the right seems to be female and the one on the right a male. There is a big heart between them indicating growing affection.")
  end

  def self.display_a
    pic = CatPageArtA.new
    # selector_number = rand(0..5)
    # if selector_number == 0
    #   puts pic.pic_one_a
    # elsif selector_number == 1
    #   puts pic.pic_two_a
    # elsif selector_number == 2
    #   pic.pic_three_a
    # elsif selector_number == 3
    #   pic.pic_four_a
    # elsif selector_number == 4
    #   pic.pic_five_a
    # elsif selector_number == 5
      pic.pic_six_a
    # end
  end

end
