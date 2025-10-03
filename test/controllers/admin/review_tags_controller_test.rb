require "test_helper"

class Admin::ReviewTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_review_tags_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_review_tags_destroy_url
    assert_response :success
  end
end
