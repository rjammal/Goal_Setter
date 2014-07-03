feature Goal do
  
  let!(:goal) do 
    user = User.create!(username: 'Daniel', password: 'password')
    user.goals.create!(title: "gooooooooaaaaaalllll")
  end
  
  context "when logged in" do
    before(:each) do
      visit new_session_url
      fill_in 'username', with: 'Daniel'
      fill_in 'password', with: 'password'
      click_button "Sign In"
    end
    
    feature "index" do
      it "starts at the the index page" do 
        expect(page).to have_content("Goals")
      end
      
      it "shows only your own goals" do 
        expect(page).to have_content("gooooooooaaaaaalllll")
        user2 = User.create!(username: 'Rosemary', password: 'password')
        user2.goals.create!(title: 'new goal')
        visit goals_url
        expect(page).to_not have_content('new goal')
      end
      
      it "has a link to create a new Goal" do
        expect(page).to have_link("Create New Goal")
      end
      
      it "has links to each goal" do
        expect(page).to have_link("gooooooooaaaaaalllll")
      end
      
    end
    
    feature "new" do
      before(:each) { visit new_goal_url }
      
      it "lets you create a goal" do
        fill_in "Title", with: "goal title"
        click_button "Create New Goal"
        expect(page).to have_content("goal title")
      end
      
      it "requires a title" do
        click_button "Create New Goal"
        expect(page).to have_content("Title can't be blank")
      end
    end
    
    feature "edit" do
      before(:each) { visit edit_goal_url(goal) }
      
      it "lets you edit a goal" do
        fill_in "Title", with: "something"
        click_button "Update Goal"
        expect(page).to have_content("something")
        expect(page).to_not have_content("gooooooooaaaaaalllll")
      end
      
      it "should have the fields prefilled" do
        title_text = find_field("Title").value
        expect(title_text).to eq("gooooooooaaaaaalllll")
      end
      
      it "lets you mark the goal as completed" do
        check("Completed?")
        click_button "Update Goal"
        expect(page).to have_content("Completed")
      end
    end
    
    feature "show" do
      before(:each) { visit goal_url(goal) }
      
      it "shows the goal" do
        expect(page).to have_content(goal.title)
      end
      
      it "should have a link to edit" do
        click_link("Edit")
        expect(page).to have_content("Update Goal")
      end
      
      it "allows deletion" do
        click_button("Delete")
        expect(page).to_not have_content(goal.title)
      end
    end
  end
  
  context "when logged out" do
    it "redirects to the login page with an error" do
      visit goals_url
      expect(page).to have_content("You must be logged in for that")
    end
  end
end