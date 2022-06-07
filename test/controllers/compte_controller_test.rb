require "test_helper"

class CompteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get compte_index_url
    assert_response :success
  end
end
