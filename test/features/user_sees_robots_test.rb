require_relative '../test_helper'

class UserSeesRobotsTest < FeatureTest
  include TestHelpers

  def current_robot_id
    robot_world.all.last.id
  end

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

    visit "robots/#{current_robot_id - 1}"

    assert page.has_content?("Caligula")
    assert page.has_content?("city: Fallujah")
    assert page.has_content?("state: Haram")
    assert page.has_content?("birthdate: June 11, 1945")
    assert page.has_content?("date hired: yesterday")
    assert page.has_content?("department: Grocery Bagger")

    visit "/robots"
    visit "robots/#{current_robot_id}"

    assert page.has_content?("George Marshall")
    assert page.has_content?("city: New New York")
    assert page.has_content?("state: Earth")
    assert page.has_content?("birthdate: June 11, 1967")
    assert page.has_content?("date hired: yesterday")
    assert page.has_content?("department: Florist")
  end
end
