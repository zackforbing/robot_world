require_relative '../test_helper'

class RobotTest < Minitest::Test

  def test_assigns_attributes_correctly
    robot = Robot.new({"id" => 11,
                       "name" => "xevious",
                       "city" => "salem",
                       "state" => "AZ",
                       "birthdate" => "the summer of '69",
                       "date_hired" => "tomorrow",
                       "department" => "filing"})

    assert_equal 11, robot.id
    assert_equal "xevious", robot.name
    assert_equal "salem", robot.city
    assert_equal "AZ", robot.state
    assert_equal "the summer of '69", robot.birthdate
    assert_equal "tomorrow", robot.date_hired
    assert_equal "filing", robot.department

  end
end
