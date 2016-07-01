require_relative 'robot' #necessary?

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.execute("INSERT INTO robots (name, city, state, birthdate, date_hired, department)
                      VALUES (?, ?, ?, ?, ?, ?);",
                      robot[:name], robot[:city], robot[:state],
                      robot[:birthdate], robot[:date_hired], robot[:department])
  end

  def all_robots
    database.execute("SELECT * FROM robots;")
  end

  def all
    all_robots.map { |data| Robot.new(data) }
  end

  def find_robot_named(id)
  database.execute("SELECT * FROM robots WHERE id=?;", id).first
  end

  def find(id)
    Robot.new(find_robot_named(id.to_i))
  end

  def update(id, robot)
    database.execute("UPDATE tasks SET name=?,
                      city=?,
                      state=?,
                      birthdate=?,
                      date_hired=?,
                      department=? WHERE id=?;",
                      robot[:name],
                      robot[:city],
                      robot[:state],
                      robot[:birthdate],
                      robot[:date_hired],
                      robot[:department],
                      id)
  end

  def destroy(id)
    database.execute("DELETE FROM robots WHERE id= ?;", id)
  end

  def delete_all
    database.execute("DELETE FROM robots;")
  end
end
