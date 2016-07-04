require_relative "../test_helper"

class UserCanCreateARobotTest < FeatureTest

  def test_user_can_create_a_robot
    visit "/"
    click_link "New Robot"

    assert_equal "/robots/new", current_path

    fill_in "robot[name]", with: "ferberzher"
    fill_in "robot[city]", with: "new description"
    click_button("Create New Robot")

    assert_equal "/robots", current_path
    assert page.has_css?("#robot_list")
    assert page.has_content?("All Robots")
    assert page.has_content?("ferberzher")
  end
end
