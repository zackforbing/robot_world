require 'sqlite3'

database = SQLite3::Database.new("db/robot_world_development.db")
database.execute("DELETE FROM robots;")

database.execute(
                "INSERT INTO robots
                (name, city, state, birthdate, date_hired, department)
              VALUES
                ('killian', 'bork', 'fleep', 'the first of tha month', 'in 5 minutes', 'flower delivery'),
                ('helvetica', 'salt lick', 'blech', 'tuesday', 'last week', 'cat brushing'),
                ('macintosh', 'silicon valley', 'nowhere', '1976', 'forever ago', 'paperweight'),
                ('agent orange', 'flavor', 'kansas', 'the ides of march', 'febtember 3', 'shoe scrubbing')"
)
puts database.execute("SELECT * FROM robots;")
