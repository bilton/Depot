require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4			# assert_select() has many uses. checks 'a href' links in #columns #side
    assert_select '#main .entry', 3							# looks for 3 entry classes
    assert_select 'h3', 'Programming Ruby 1.9'				# checks that h3 text is ...
    assert_select '.price', /\$[,\d]+\.\d\d/ 				# checks price class in the correct format
  end

end
