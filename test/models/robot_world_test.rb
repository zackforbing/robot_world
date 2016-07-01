require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def current_robot_id
    robot_world.all.first.id
  end

  def test_create_robot_functions
    assert_equal 0, robot_world.all.count

    robot_world.create(title: "eat dinner", description: "PHO!")

    assert_equal 1, robot_world.all.count

    robot = robot_world.find(current_robot_id)

    assert_equal "eat dinner", robot.title
    assert_equal "PHO!", robot.description
    assert_equal current_robot_id, robot.id
  end

  def test_all_returns_all_robots
    robot_world.create(title: "go to gym", description: "Do you even lift bro?")
    robot_world.create(title: "eat dinner", description: "PHO!")
    robot_world.create(title: "code your face off", description: "DO IT")

    assert_equal 3, robot_world.all.count
    assert_instance_of Task, robot_world.all[0]
  end

  def test_find_a_robot
    robot_world.create(title: "go to gym", description: "Do you even lift bro?")
    robot_world.create(title: "eat dinner", description: "PHO!")
    robot_world.create(title: "code your face off", description: "DO IT")
    robot1 = robot_world.find(current_robot_id)
    robot2 = robot_world.find(current_robot_id + 1)
    robot3 = robot_world.find(current_robot_id + 2)

    assert_equal "go to gym", robot1.title
    assert_equal "eat dinner", robot2.title
    assert_equal "code your face off", robot3.title
  end

  def test_update_a_robot
    robot_world.create(title: "go to gym", description: "Do you even lift bro?")
    updated_robot = {title: "don't go to gym", description: "eat ice cream instead"}
    robot = robot_world.find(current_robot_id)

    assert_equal "go to gym", robot.title

    robot_world.update(current_robot_id, updated_robot)
    robot = robot_world.find(current_robot_id)

    assert_equal "don't go to gym", robot.title
    assert_equal current_robot_id, robot.id
  end

  def test_destroy_a_robot
    assert_equal 0, robot_world.all.count

    robot_world.create(title: "eat dinner", description: "PHO!")
    robot_world.create(title: "drink", description: "turing hurts my soul")

    assert_equal 2, robot_world.all.count

    robot = robot_world.find(current_robot_id)
    robot_world.destroy(robot.id)

    assert_equal 1, robot_world.all.count
  end
end
