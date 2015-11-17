require 'test_helper'

class ItemsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "item interface" do
    log_in_as(@user)
    get root_path
    # Invalid submission
    assert_no_difference 'Item.count' do
      post items_path, item: { name: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    name = "Cool pants"
    assert_difference 'Item.count', 1 do
      post items_path, item: { name: name, price: 5 }
    end
    assert_redirected_to root_url
    get user_path(@user)
    assert_match name, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_item = @user.items.paginate(page: 1).first
    assert_difference 'Item.count', -1 do
      delete item_path(first_item)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
