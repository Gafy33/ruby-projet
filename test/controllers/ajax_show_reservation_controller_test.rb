require "test_helper"

class AjaxShowReservationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ajax_show_reservation_index_url
    assert_response :success
  end
end
