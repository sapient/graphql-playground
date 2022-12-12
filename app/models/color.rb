class Color < ApplicationRecord
  has_many :stocks

  def full_name
    if metallic?
      'Metallic ' + name
    else
      name
    end
  end
end
