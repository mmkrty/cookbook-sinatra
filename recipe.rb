class Recipe
  attr_reader :name, :description, :rating, :prep_time, :done

  def initialize(name, description, rating, prep_time)
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
    @done = false
  end

  def done!
    @done = true
  end

  def done?
    @done
  end
end
