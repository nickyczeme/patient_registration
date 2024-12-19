require "test_helper"

class Api::V1::PatientsControllerTest < ActionDispatch::IntegrationTest
  def json_response
    JSON.parse(response.body)
  end

  test "should create patient with valid form attributes" do
    assert_difference('Patient.count', 1) do
      post api_v1_patients_url, params: {
        name: "John Smith",
        email: "smith@gmail.com",
        phone: "1122334455"
      }
    end
    assert_response :created
    assert_equal "John Smith", json_response['name']
    assert_equal "smith@gmail.com", json_response['email']
    assert_equal "1122334455", json_response['phone']
  end

  test "should not create patient with invalid attributes" do
    assert_no_difference("Patient.count") do
      post api_v1_patients_url, params: {
        name: "John"
      }
    end

    assert_response :unprocessable_entity
    assert_includes json_response["errors"], "Email can't be blank"
    assert_includes json_response["errors"], "Phone can't be blank"
  end
end
