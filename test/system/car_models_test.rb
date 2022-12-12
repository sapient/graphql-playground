require "application_system_test_case"

class CarModelsTest < ApplicationSystemTestCase
  setup do
    @car_model = car_models(:one)
  end

  test "visiting the index" do
    visit car_models_url
    assert_selector "h1", text: "Car models"
  end

  test "should create car model" do
    visit car_models_url
    click_on "New car model"

    fill_in "Manufacturer", with: @car_model.manufacturer_id
    fill_in "Name", with: @car_model.name
    click_on "Create Car model"

    assert_text "Car model was successfully created"
    click_on "Back"
  end

  test "should update Car model" do
    visit car_model_url(@car_model)
    click_on "Edit this car model", match: :first

    fill_in "Manufacturer", with: @car_model.manufacturer_id
    fill_in "Name", with: @car_model.name
    click_on "Update Car model"

    assert_text "Car model was successfully updated"
    click_on "Back"
  end

  test "should destroy Car model" do
    visit car_model_url(@car_model)
    click_on "Destroy this car model", match: :first

    assert_text "Car model was successfully destroyed"
  end
end
