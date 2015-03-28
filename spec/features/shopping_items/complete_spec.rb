require 'spec_helper'

describe "Completing todo items" do
  let!(:todo_list) { ShoppingList.create(title: "Groceries", description: "Grocery List.") }
  let!(:todo_item) { todo_list.shopping_items.create(content: "Milk") }

  it "is successful when marking a single item complete" do
    expect(todo_item.completed_at).to be_nil
    visit_list(todo_list)
    within dom_id_for(todo_item) do
      click_link "Mark Complete"
    end
    todo_item.reload
    expect(todo_item.completed_at).to_not be_nil
  end

end