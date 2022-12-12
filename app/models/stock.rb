class Stock < ApplicationRecord
  belongs_to :car_model
  belongs_to :color
end
