class CreateCarsRecommendation < ActiveRecord::Migration[6.1]
  def change
    create_table :cars_recommendations do |t|
      t.references :user
      t.references :car
      t.decimal :rank_score
      t.timestamps
    end
  end
end
