class Bravado::RecommendedCarsService
  include HTTParty
  base_uri 'https://bravado-images-production.s3.amazonaws.com'

  def initialize(user_id)
    @user_id = user_id
  end

  def by_user_id
    self.class.get("/recomended_cars.json?user_id=#{@user_id}")
  end
end