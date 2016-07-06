require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def current_robot_id
    robot_world.all.first.id
  end

  def test_create_robot_functions
    assert_equal 0, robot_world.all.count

    robot_world.create(name: "Robosocrates")

    assert_equal 1, robot_world.all.count

    robot = robot_world.find(current_robot_id)

    assert_equal "Robosocrates", robot.name
    assert_equal nil, robot.city
    assert_equal current_robot_id, robot.id
  end

  def test_all_returns_all_robots
    robot_world.create(name: "Alexandrius", city: "Constantinople")
    robot_world.create(name: "Robosocrates", city: "Athens Prime")
    robot_world.create(name: "Stevenhawking.com", city: "New York 5")
    assert_equal 3, robot_world.all.count
    assert_instance_of Robot, robot_world.all[0]
  end

  def test_find_a_robot
    robot_world.create(name: "Alexandrius", city: "Constantinople")
    robot_world.create(name: "Robosocrates", city: "Athens Prime")
    robot_world.create(name: "Stevenhawking.com", city: "New York 5")
    robot1 = robot_world.find(current_robot_id)
    robot2 = robot_world.find(current_robot_id + 1)
    robot3 = robot_world.find(current_robot_id + 2)

    assert_equal "Alexandrius", robot1.name
    assert_equal "Robosocrates", robot2.name
    assert_equal "Stevenhawking.com", robot3.name
  end

  def test_update_a_robot
    robot_world.create(name: "Alexandrius", city: "Constantinople")
    updated_robot = {name: "Perdicas", city: "Babylon"}
    robot = robot_world.find(current_robot_id)

    assert_equal "Alexandrius", robot.name

    robot_world.update(current_robot_id, updated_robot)
    robot = robot_world.find(current_robot_id)

    assert_equal "Perdicas", robot.name
    assert_equal current_robot_id, robot.id
  end

  def test_destroy_a_robot
    assert_equal 0, robot_world.all.count

    robot_world.create(name: "Robosocrates", city: "Athens Prime")
    robot_world.create(name: "Eeyore Prime", city: "kill me")

    assert_equal 2, robot_world.all.count

    robot = robot_world.find(current_robot_id)
    robot_world.destroy(robot.id)

    assert_equal 1, robot_world.all.count
  end
end
