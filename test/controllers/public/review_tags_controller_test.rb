require "test_helper"

class Public::ReviewTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_review_tags_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_review_tags_destroy_url
    assert_response :success
  end
end
