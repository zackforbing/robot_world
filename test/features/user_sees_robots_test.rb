require_relative '../test_helper'

class UserSeesRobotsTest < FeatureTest

  def test_user_sees_robo
    # As a user, when I visit the tasks index, then I should see a list of my tasks.
    task1 = task_manager.create({
      title: "Coding forever",
      description: "never stop"
      })
    task1 = task_manager.create({
      title: "Learn Capybara",
      description: "hot tub james brown"
      })
    visit "/tasks"
    within("#task_list") do
      assert page.has_content?("Coding forever")
      assert page.has_content?("Learn Capybara")
    end
  end
end
