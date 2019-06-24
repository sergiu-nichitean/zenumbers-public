require 'test_helper'

class AmazonOrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amazon_order_item = amazon_order_items(:one)
  end

  test "should get index" do
    get amazon_order_items_url
    assert_response :success
  end

  test "should get new" do
    get new_amazon_order_item_url
    assert_response :success
  end

  test "should create amazon_order_item" do
    assert_difference('AmazonOrderItem.count') do
      post amazon_order_items_url, params: { amazon_order_item: { amazon_orders_id: @amazon_order_item.amazon_orders_id, amz_id: @amazon_order_item.amz_id, currency: @amazon_order_item.currency, item_price: @amazon_order_item.item_price, item_tax: @amazon_order_item.item_tax, product_name: @amazon_order_item.product_name, quantity_purchased: @amazon_order_item.quantity_purchased, shipping_price: @amazon_order_item.shipping_price, shipping_tax: @amazon_order_item.shipping_tax, sku: @amazon_order_item.sku } }
    end

    assert_redirected_to amazon_order_item_url(AmazonOrderItem.last)
  end

  test "should show amazon_order_item" do
    get amazon_order_item_url(@amazon_order_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_amazon_order_item_url(@amazon_order_item)
    assert_response :success
  end

  test "should update amazon_order_item" do
    patch amazon_order_item_url(@amazon_order_item), params: { amazon_order_item: { amazon_orders_id: @amazon_order_item.amazon_orders_id, amz_id: @amazon_order_item.amz_id, currency: @amazon_order_item.currency, item_price: @amazon_order_item.item_price, item_tax: @amazon_order_item.item_tax, product_name: @amazon_order_item.product_name, quantity_purchased: @amazon_order_item.quantity_purchased, shipping_price: @amazon_order_item.shipping_price, shipping_tax: @amazon_order_item.shipping_tax, sku: @amazon_order_item.sku } }
    assert_redirected_to amazon_order_item_url(@amazon_order_item)
  end

  test "should destroy amazon_order_item" do
    assert_difference('AmazonOrderItem.count', -1) do
      delete amazon_order_item_url(@amazon_order_item)
    end

    assert_redirected_to amazon_order_items_url
  end
end
