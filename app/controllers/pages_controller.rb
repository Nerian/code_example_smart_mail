class PagesController < ApplicationController

  def index
    @mock_data = [
      { name: "BRL", data: { 1.days.ago => 100, 2.days.ago => 110, 3.days.ago => 120 } },
      { name: "EUR", data: { 1.days.ago => 200, 2.days.ago => 210, 3.days.ago => 220 } },
      { name: "AUD", data: { 1.days.ago => 340, 2.days.ago => 360, 3.days.ago => 390 } },
    ]
  end
end
