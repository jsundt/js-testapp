require 'spec_helper'

describe "Editing todo items" do
  let!(:todo_list) { ShoppingList.create(title: "Groceries", description: "Grocery List.") }
  let!(:todo_item) { todo_list.shopping_items.create(content: "Milk") }

  it "is successful with valid content" do
    visit_list(todo_list)
    within("#shopping_item_#{todo_item.id}") do
      click_link "Edit"
    end

    fill_in "Content", with: "Lots of Milk"
    click_button "Save"

    expect(page).to have_content("Updated List Item.")
    todo_item.reload
    expect(todo_item.content).to eq("Lots of Milk")
  end

  it "is unsuccessful with no content" do
    visit_list(todo_list)
    within("#shopping_item_#{todo_item.id}") do
      click_link "Edit"
    end

    fill_in "Content", with: ""
    click_button "Save"

    expect(page).to_not have_content("Updated List Item.")
    expect(page).to have_content("Content can't be blank")
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end

  it "is unsuccessful with not enough content" do
    visit_list(todo_list)
    within("#shopping_item_#{todo_item.id}") do
      click_link "Edit"
    end

    fill_in "Content", with: "1"
    click_button "Save"

    expect(page).to_not have_content("Updated List Item.")
    expect(page).to have_content("Content is too short")
    todo_item.reload
    expect(todo_item.content).to eq("Milk")
  end

end