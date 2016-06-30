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

  def find_robot_named(id)
  all_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(find_robot_named(id.to_i))
  end

  def update(id, robot)
    database.transaction do
      target_robot = database['robots'].find { |data| data["id"] == id }
      target_robot["name"] = robot[:name]
      target_robot["city"] = robot[:city]
      target_robot["state"] = robot[:state]
      target_robot["birthdate"] = robot[:birthdate]
      target_robot["date hired"] = robot[:date_hired]
      target_robot["department"] = robot[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database["robots"].delete_if { |robot| robot["id"] == id.to_i }
    end
  end
end
