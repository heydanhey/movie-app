require "application_system_test_case"

class TheatersTest < ApplicationSystemTestCase
  setup do
    @theater = theaters(:one)
  end

  test "visiting the index" do
    visit theaters_url
    assert_selector "h1", text: "Theaters"
  end

  test "creating a Theater" do
    visit theaters_url
    click_on "New Theater"

    fill_in "Capacity", with: @theater.capacity
    fill_in "Name", with: @theater.name
    click_on "Create Theater"

    assert_text "Theater was successfully created"
    click_on "Back"
  end

  test "updating a Theater" do
    visit theaters_url
    click_on "Edit", match: :first

    fill_in "Capacity", with: @theater.capacity
    fill_in "Name", with: @theater.name
    click_on "Update Theater"

    assert_text "Theater was successfully updated"
    click_on "Back"
  end

  test "destroying a Theater" do
    visit theaters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Theater was successfully destroyed"
  end
end
