require "test_helper"

class Public::HospitalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_hospitals_new_url
    assert_response :success
  end

  test "should get index" do
    get public_hospitals_index_url
    assert_response :success
  end

  test "should get show" do
    get public_hospitals_show_url
    assert_response :success
  end

  test "should get create" do
    get public_hospitals_create_url
    assert_response :success
  end

  test "should get update" do
    get public_hospitals_update_url
    assert_response :success
  end
end
