require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get mypage" do
    get users_mypage_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get update" do
    get users_update_url
    assert_response :success
  end

  test "should get publish_unpublish" do
    get users_publish_unpublish_url
    assert_response :success
  end

  test "should get unsubcribe" do
    get users_unsubcribe_url
    assert_response :success
  end

  test "should get withdraw" do
    get users_withdraw_url
    assert_response :success
  end
end
