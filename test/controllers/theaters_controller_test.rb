require 'test_helper'

class TheatersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @theater = theaters(:one)
  end

  test "should get index" do
    get theaters_url
    assert_response :success
  end

  test "should get new" do
    get new_theater_url
    assert_response :success
  end

  test "should create theater" do
    assert_difference('Theater.count') do
      post theaters_url, params: { theater: { capacity: @theater.capacity, name: @theater.name } }
    end

    assert_redirected_to theater_url(Theater.last)
  end

  test "should show theater" do
    get theater_url(@theater)
    assert_response :success
  end

  test "should get edit" do
    get edit_theater_url(@theater)
    assert_response :success
  end

  test "should update theater" do
    patch theater_url(@theater), params: { theater: { capacity: @theater.capacity, name: @theater.name } }
    assert_redirected_to theater_url(@theater)
  end

  test "should destroy theater" do
    assert_difference('Theater.count', -1) do
      delete theater_url(@theater)
    end

    assert_redirected_to theaters_url
  end
end
