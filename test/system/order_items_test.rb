require "application_system_test_case"

class OrderItemsTest < ApplicationSystemTestCase
  setup do
    @order_item = order_items(:one)
  end

  test "visiting the index" do
    visit order_items_url
    assert_selector "h1", text: "Order Items"
  end

  test "creating a Order item" do
    visit order_items_url
    click_on "New Order Item"

    fill_in "Description", with: @order_item.description
    fill_in "Order", with: @order_item.order_id
    fill_in "Product", with: @order_item.product_id
    fill_in "Quantity", with: @order_item.quantity
    click_on "Create Order item"

    assert_text "Order item was successfully created"
    click_on "Back"
  end

  test "updating a Order item" do
    visit order_items_url
    click_on "Edit", match: :first

    fill_in "Description", with: @order_item.description
    fill_in "Order", with: @order_item.order_id
    fill_in "Product", with: @order_item.product_id
    fill_in "Quantity", with: @order_item.quantity
    click_on "Update Order item"

    assert_text "Order item was successfully updated"
    click_on "Back"
  end

  test "destroying a Order item" do
    visit order_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order item was successfully destroyed"
  end
end
