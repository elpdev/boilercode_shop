require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get products_url
    assert_response :success
    assert_match products(:one_time).name, response.body
  end

  test "hidden products not on index" do
    get products_url
    assert_response :success
    assert_no_match products(:hidden).name, response.body
  end

  test "show" do
    get product_url(products(:one_time))
    assert_response :success
    assert_match "Buy now", response.body
  end

  test "show hidden product" do
    get product_url(products(:hidden))
    assert_response :success
  end
end
