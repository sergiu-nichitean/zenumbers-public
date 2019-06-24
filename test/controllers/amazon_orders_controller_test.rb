require 'test_helper'

class AmazonOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amazon_order = amazon_orders(:one)
  end

  test "should get index" do
    get amazon_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_amazon_order_url
    assert_response :success
  end

  test "should create amazon_order" do
    assert_difference('AmazonOrder.count') do
      post amazon_orders_url, params: { amazon_order: { amz_id: @amazon_order.amz_id, buyer_email: @amazon_order.buyer_email, buyer_name: @amazon_order.buyer_name, buyer_phone_number: @amazon_order.buyer_phone_number, company_id: @amazon_order.company_id, payments_date: @amazon_order.payments_date, purchase_date: @amazon_order.purchase_date } }
    end

    assert_redirected_to amazon_order_url(AmazonOrder.last)
  end

  test "should show amazon_order" do
    get amazon_order_url(@amazon_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_amazon_order_url(@amazon_order)
    assert_response :success
  end

  test "should update amazon_order" do
    patch amazon_order_url(@amazon_order), params: { amazon_order: { amz_id: @amazon_order.amz_id, buyer_email: @amazon_order.buyer_email, buyer_name: @amazon_order.buyer_name, buyer_phone_number: @amazon_order.buyer_phone_number, company_id: @amazon_order.company_id, payments_date: @amazon_order.payments_date, purchase_date: @amazon_order.purchase_date } }
    assert_redirected_to amazon_order_url(@amazon_order)
  end

  test "should destroy amazon_order" do
    assert_difference('AmazonOrder.count', -1) do
      delete amazon_order_url(@amazon_order)
    end

    assert_redirected_to amazon_orders_url
  end
end
