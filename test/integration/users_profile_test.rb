require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.items.count.to_s, response.body
    assert_select 'div.pagination'
    @user.items.paginate(page: 1).each do |item|
      assert_match item.name, response.body
      #assert_match item.price, response.body
      assert_match item.store, response.body
      #assert_match item.img, response.body
    end
  end
end
