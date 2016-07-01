require_relative "../test_helper"

class UserCanCreateARobotTest < FeatureTest

  def test_user_can_create_a_robot
    # as a user, when I visit the dashboard, and i click the link to
    # "new task", then i should be on the new task's page, and i fill in
    # the title field with "new task" and i fill in the description field with
    # "new description", and i click the submit button, then i should see the list
    # of tasks and an All Tasks header
    visit "/"
    click_link "New Task"

    assert_equal "/tasks/new", current_path

    fill_in "task[title]", with: "new task"
    fill_in "task[description]", with: "new description"
    click_button("Create New Task")

    assert_equal "/tasks", current_path
    assert page.has_css?("#title")
    assert page.has_content?("All Tasks")
  end
end
