require_relative '../test_helper'

class UserSeesRobotsTest < FeatureTest

  def test_user_sees_robot
    robot_world.create({
      name: "Caligula",
      city: "Fallujah",
      state: "Haram",
      birthdate: "June 11, 1945",
      date_hired: "yesterday",
      department: "Grocery Bagger"
      })
    robot_world.create({
      name: "George Marshall",
      city: "New New York",
      state: "Earth",
      birthdate: "June 11, 1967",
      date_hired: "yesterday",
      department: "Florist"
      })
    visit "/robots"
    within("#robot_list") do
      assert page.has_content?("Caligula")
      assert page.has_content?("George Marshall")
    end
  end
end
