class Directory < ActiveRecord::Base
  belongs_to :tip
  belongs_to :user


  def auto_directory_a(new_dir)
    starting_tip_id = Tip.where('name = "Golden Rule"')[0].id
    new_dir.tip_id = starting_tip_id
    new_dir
  end


  def edit_label_a(tip, user)
    prompt = TTY::Prompt.new
    CliStart.sam_say("What would you like to update your label to? Please write a new name.")
    new_label = prompt.ask("What would you like to update your label to?")
    self.update(label: new_label)
    puts "Your label has been updated to #{new_label}."
    CliStart.sam_say("Your label has been updated to #{new_label}.")
    display_and_edit_tip_a(tip, user)
  end


  def edit_comment_a(tip, user)
    prompt = TTY::Prompt.new
    CliStart.sam_say("What would you like to change your comment to? Please write a new comment.")
    new_comment = prompt.ask("How would you like to change your comment?")
    self.update(comment: new_comment)
    puts "Your comment has been updated to #{new_comment}."
    CliStart.sam_say("Your comment has been updated to #{new_comment}.")
    display_and_edit_tip_a(tip, user)
  end


  def delete_tip_a(tip, user)
    prompt = TTY::Prompt.new
    CliStart.sam_say("Are you sure? Choose top option for yes and bottom option for no.")
    gets = prompt.select("Are you sure?", %w[Yes No])
    if gets == "Yes"
      self.delete
      puts "This tip has been deleted"
    CliStart.sam_say("Your tip has been deleted.")
    end
    user.user_saved_tips_a
  end


  def display_and_edit_tip_a(tip, user)
    system "clear"
    prompt = TTY::Prompt.new
    puts tip[0].name
    puts tip[0].content
    CliStart.sam_say("Use the down arrow key and enter to choose an option. Top option: edit your tip. Second option: delete this tip. Bottom option: go back.")
    nav = prompt.select(" ", %w[Edit Delete Back])
    if nav == "Edit"
      edit_label_a(tip, user)
    elsif nav == "Delete"
      delete_tip_a(tip, user)
    else
      user.user_saved_tips_a
    end
  end

end
