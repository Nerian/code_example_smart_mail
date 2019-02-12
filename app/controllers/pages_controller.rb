class PagesController < ApplicationController

  def index
    @currencies        = params[:currencies].split(',')
    @origin            = params[:origin]
    @target_currencies = (@currencies - [@origin])

    @data = []

    @target_currencies.each do |currency|
      @data << { name: currency, data: get_data(currency) }
    end
  end

  private

  def get_data(currency)
    data = {}

    (600.days.ago.to_date..1.days.ago.to_date).each do |date|
      begin
        data[date]       = Money.default_bank.exchange(100, @origin, currency, date).to_s
        @last_valid_rate = data[date]
      rescue Money::Bank::UnknownRate
        # eu_bank does not publish exchange rates on weekends. So we infer the value.
        data[date] = @last_valid_rate
      end
    end

    data
  end
end
