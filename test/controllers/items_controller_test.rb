require 'test_helper'

class ItemsControllerTest < ActionController::TestCase

  def setup
    @item = items(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Item.count' do
      post :create, item: { name: "Shirt", price: "10.00", store: "express", img: "blank.png" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Item.count' do
      delete :destroy, id: @item
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong item" do
    log_in_as(users(:michael))
    item = items(:seven)
    assert_no_difference 'Item.count' do
      delete :destroy, id: item
    end
    assert_redirected_to root_url
  end
end