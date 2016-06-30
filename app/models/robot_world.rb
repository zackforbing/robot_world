require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {
        "id" => database['total'],
        "name" => robot[:name],
        "city" => robot[:city],
        "state" => robot[:state],
        "avatar" => robot[:avatar],
        "birthdate" => robot[:birthdate],
        "date hired" => robot[:date_hired],
        "department" => robot[:department],
      }
    end
  end

  def create_avatar(name)
    '<img src="https://robohash.org/<%= @robot.name %>">'
  end

  def all_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    all_robots.map { |data| Robot.new(data) }
  end

  def find_robot_named(name)
  all_robots.find { |robot| robot["name"] == name }
  end

  def find(name)
    Robot.new(find_robot_named(name))
  end

  def update(robot_data)
    database.transaction do
      target_robot = database['robots'].find { |data| data["name"] == robot_data[:name] }
      target_robot["name"] = robot_data[:name]
      target_robot["city"] = robot_data[:city]
      target_robot["state"] = robot_data[:state]
      target_robot["birthdate"] = robot_data[:birthdate]
      target_robot["date hired"] = robot_data[:date_hired]
      target_robot["department"] = robot_data[:department]
    end
  end

  def destroy(robot)
    database.transaction do
      database["robots"].delete_if { |robot| robot["name"] == robot }
    end
  end
end
