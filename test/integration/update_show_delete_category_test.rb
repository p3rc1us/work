require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers
test "update_show_delete_category" do
  #sign in

  sign_in users(:one)

  #proceed to update

  get edit_category_path(categories(:one))
  assert_response :success

  patch category_path, params: {
     category: {
       name: "updating a category"
     }
   }
  assert :redirect
  follow_redirect!
  assert_response :success

  #proceed to show

  get category_path(categories(:one))
  assert_response :success

  assert_select "h1", text: "UPDATING A CATEGORY"

  #proceed to delete

  assert_difference("Category.count", -1) do
    delete category_path(categories(:one))
  end

  #proceed to sign out

  sign_out users(:one)

 end
end
