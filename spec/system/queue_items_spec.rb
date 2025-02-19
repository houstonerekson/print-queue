require 'rails_helper'

RSpec.describe "QueueItems", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "allows a user to create a new queue item" do
    visit new_queue_item_path
    fill_in "Name", with: "Test Print Job"
    fill_in "Color", with: "Test Color"
    choose "Pending"
    click_button "Create"
  
    expect(page).to have_content "Queue item created successfully!"
    expect(QueueItem.last.status).to eq("pending")
  end
  

  it "shows errors when the form is submitted without a name" do
    visit new_queue_item_path

    click_button "Create"

    expect(page).to have_content("Name can't be blank")
  end
end