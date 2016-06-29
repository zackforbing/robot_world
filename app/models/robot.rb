class Robot
  attr_reader :name,
              :city,
              :state,
              :birthdate,
              :date_hired,
              :department

  def initialize(data)
    @name       = data["name"]
    @city       = data["city"]
    @state      = data["state"]
    @birthdate  = data["birthdate"]
    @date_hired = data["date hired"]
    @department = data["department"]
  end

  # def avatar(name)
  #   figure out a way to use the img <img src="https://robohash.org/<%= name %>.png">
  # end
end
