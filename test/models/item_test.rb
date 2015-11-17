require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @item = @user.items.build(name: "Shirt", price: "10.00", store: "express", img: "blank.png")
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "user id should be present" do
    @item.user_id = nil
    assert_not @item.valid?
  end

  test "order should be most recent first" do
    assert_equal items(:most_recent), Item.first
  end

  test "name should be present" do
    @item.name = "   "
    assert_not @item.valid?
  end

  test "price should be number" do
    @item.price = "a"
    assert_not @item.valid?
  end

  test "price should be greater than 0" do
    @item.price = -3
    assert_not @item.valid?
  end
end
