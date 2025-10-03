require "test_helper"

class Admin::HospitalsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_hospitals_new_url
    assert_response :success
  end

  test "should get index" do
    get admin_hospitals_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_hospitals_show_url
    assert_response :success
  end

  test "should get create" do
    get admin_hospitals_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_hospitals_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_hospitals_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_hospitals_destroy_url
    assert_response :success
  end
end
