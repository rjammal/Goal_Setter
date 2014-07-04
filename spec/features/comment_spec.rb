feature Comment do
  
  context "commenting on users" do
    let(:user) { User.create!(username: "Bob", password: "password") }
    before(:each) do
      visit new_session_url
      fill_in "username", with: user.username
      fill_in "password", with: user.password
      click_button "Sign In"
    end
    
    context "on your own page" do
      before(:each) { visit user_url(user) }
            
      it "lets you comment on yourself" do
        fill_in "Comment", with: "comment comment"
        click_button("Add Comment")
        expect(page).to have_content "comment comment"
      end
      
      it "lets you delete comments about yourself" do
        user2 = User.create!(username: "Meanie", password: "password")
        comment = user.comments.create!(body: "You suck", author_id: user2.id)
        visit user_url(user)
        expect(page).to have_content "You suck"
        click_button "#{comment.id}"
        expect(page).to_not have_content "You suck"
      end
      
      it "does not let you make a blank comment" do
        click_button "Add Comment"
        expect(page).to have_content "Body can't be blank"
      end
    end
    
    context "not on your own page" do
      let(:user2) {User.create!(username: "Meanie", password: "password")}
      let!(:meanie_comment)  do
        user2.comments.create!(body: "I suck", author_id: user2.id)
      end
      
      before(:each) do
        visit user_url(user2)
      end
      
      it "lets you create a comment on another user" do
        fill_in "Comment", with: "comment for you!"
        click_button "Add Comment"
        expect(page).to have_content("comment for you!")
      end
    
      it "lets you view comments" do
        expect(page).to have_content("I suck")
      end
    
      it "lets you delete your own comments" do
        comment = user2.comments.create!(body: "Hello", author_id: user.id)
        visit user_url(user2)
        expect(page).to have_content("Hello")
        click_button("#{comment.id}")
        expect(page).to_not have_content("Hello")
      end
    
      it "doesn't let you delete others' comments unless they are on you" do
        expect(page).to_not have_button(meanie_comment.id.to_s)
      end
    end
  end
  
  
  context "commenting on goals" do
    
    let(:user2) { User.create!(username: "Meanie", password: "password") }
    let(:goal) { user.goals.create!(title: "Win at the world") }
    
    let(:meanie_goal)  do
      user2.goals.create!(title: "Make user lose at the world") 
    end
    
    let!(:meanie_comment)  do
      goal.comments.create!(body: "Not while I'm around", author_id: user2.id)
    end
    
    let!(:meanie_self_comment) do
      meanie_goal.comments.create!(body: "I have confidence", author_id: user2.id)
    end
    
    it "lets you create a comment on another person's public goal" do
      visit goal_url(meanie_goal)
      fill_in "Comment", with: "I am nice"
      click_button("Add Comment")
      expect(page).to have_content("I am nice")
    end
    
    it "lets you delete your own comments" do
      my_comment = meanie_goal.comments.create!(body: "You can do it", author_id: user.id)
      visit goal_url(meanie_goal)
      expect(page).to have_content("You can do it")
      click_button(my_comment.id.to_s)
      expect(page).to_not have_content("You can do it")
    end
    
    it "lets you delete comments about your goals" do
      visit goal_url(goal)
      click_button(meanie_comment.id)
      expect(page).to_not have_content("Not while I'm around")
    end
    
    it "doesn't let you delete others' comments unless they are on you" do
      visit goal_url(meanie_goal)
      expect(page).to_not have_button(meanie_self_comment.id.to_s)
    end
  end
end