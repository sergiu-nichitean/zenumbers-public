require "application_system_test_case"

class AmazonOrderItemsTest < ApplicationSystemTestCase
  setup do
    @amazon_order_item = amazon_order_items(:one)
  end

  test "visiting the index" do
    visit amazon_order_items_url
    assert_selector "h1", text: "Amazon Order Items"
  end

  test "creating a Amazon order item" do
    visit amazon_order_items_url
    click_on "New Amazon Order Item"

    fill_in "Amazon Orders", with: @amazon_order_item.amazon_orders_id
    fill_in "Amz", with: @amazon_order_item.amz_id
    fill_in "Currency", with: @amazon_order_item.currency
    fill_in "Item Price", with: @amazon_order_item.item_price
    fill_in "Item Tax", with: @amazon_order_item.item_tax
    fill_in "Product Name", with: @amazon_order_item.product_name
    fill_in "Quantity Purchased", with: @amazon_order_item.quantity_purchased
    fill_in "Shipping Price", with: @amazon_order_item.shipping_price
    fill_in "Shipping Tax", with: @amazon_order_item.shipping_tax
    fill_in "Sku", with: @amazon_order_item.sku
    click_on "Create Amazon order item"

    assert_text "Amazon order item was successfully created"
    click_on "Back"
  end

  test "updating a Amazon order item" do
    visit amazon_order_items_url
    click_on "Edit", match: :first

    fill_in "Amazon Orders", with: @amazon_order_item.amazon_orders_id
    fill_in "Amz", with: @amazon_order_item.amz_id
    fill_in "Currency", with: @amazon_order_item.currency
    fill_in "Item Price", with: @amazon_order_item.item_price
    fill_in "Item Tax", with: @amazon_order_item.item_tax
    fill_in "Product Name", with: @amazon_order_item.product_name
    fill_in "Quantity Purchased", with: @amazon_order_item.quantity_purchased
    fill_in "Shipping Price", with: @amazon_order_item.shipping_price
    fill_in "Shipping Tax", with: @amazon_order_item.shipping_tax
    fill_in "Sku", with: @amazon_order_item.sku
    click_on "Update Amazon order item"

    assert_text "Amazon order item was successfully updated"
    click_on "Back"
  end

  test "destroying a Amazon order item" do
    visit amazon_order_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Amazon order item was successfully destroyed"
  end
end
