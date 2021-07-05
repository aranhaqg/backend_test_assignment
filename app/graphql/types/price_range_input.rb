class Types::DateRangeInput < Types::BaseInputObject
  description "Range of price"
  argument :min, Types::Integer, "Minimum value of the range", required: true
  argument :max, Types::Integer, "Maximum value of the range", required: true

  def prepare
    min..max
  end
end