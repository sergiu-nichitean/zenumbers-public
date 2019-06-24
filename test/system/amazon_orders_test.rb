require "application_system_test_case"

class AmazonOrdersTest < ApplicationSystemTestCase
  setup do
    @amazon_order = amazon_orders(:one)
  end

  test "visiting the index" do
    visit amazon_orders_url
    assert_selector "h1", text: "Amazon Orders"
  end

  test "creating a Amazon order" do
    visit amazon_orders_url
    click_on "New Amazon Order"

    fill_in "Amz", with: @amazon_order.amz_id
    fill_in "Buyer Email", with: @amazon_order.buyer_email
    fill_in "Buyer Name", with: @amazon_order.buyer_name
    fill_in "Buyer Phone Number", with: @amazon_order.buyer_phone_number
    fill_in "Company", with: @amazon_order.company_id
    fill_in "Payments Date", with: @amazon_order.payments_date
    fill_in "Purchase Date", with: @amazon_order.purchase_date
    click_on "Create Amazon order"

    assert_text "Amazon order was successfully created"
    click_on "Back"
  end

  test "updating a Amazon order" do
    visit amazon_orders_url
    click_on "Edit", match: :first

    fill_in "Amz", with: @amazon_order.amz_id
    fill_in "Buyer Email", with: @amazon_order.buyer_email
    fill_in "Buyer Name", with: @amazon_order.buyer_name
    fill_in "Buyer Phone Number", with: @amazon_order.buyer_phone_number
    fill_in "Company", with: @amazon_order.company_id
    fill_in "Payments Date", with: @amazon_order.payments_date
    fill_in "Purchase Date", with: @amazon_order.purchase_date
    click_on "Update Amazon order"

    assert_text "Amazon order was successfully updated"
    click_on "Back"
  end

  test "destroying a Amazon order" do
    visit amazon_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Amazon order was successfully destroyed"
  end
end
