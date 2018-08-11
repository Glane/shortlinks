require "application_system_test_case"

class ShortcutsTest < ApplicationSystemTestCase
  setup do
    @shortcut = shortcuts(:one)
  end

  test "visiting the index" do
    visit shortcuts_url
    assert_selector "h1", text: "Shortcuts"
  end

  test "creating a Shortcut" do
    visit shortcuts_url
    click_on "New Shortcut"

    click_on "Create Shortcut"

    assert_text "Shortcut was successfully created"
    click_on "Back"
  end

  test "updating a Shortcut" do
    visit shortcuts_url
    click_on "Edit", match: :first

    click_on "Update Shortcut"

    assert_text "Shortcut was successfully updated"
    click_on "Back"
  end

  test "destroying a Shortcut" do
    visit shortcuts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shortcut was successfully destroyed"
  end
end
