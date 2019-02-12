class PagesController < ApplicationController

  def index
    @eu_bank = EuCentralBank.new
    Money.default_bank = @eu_bank
    @eu_bank.update_historical_rates('/tmp/all.xml', true)

    @mock_data = [
      { name: "EUR", data: get_data('EUR') },
      { name: "USD", data: get_data('USD') },
      { name: "AUD", data: get_data('AUD') },
    ]
  end

  private

  def get_data(currency)
    data = {}

    (600.days.ago.to_date..1.days.ago.to_date).each do |date|
      begin
        data[date]       = @eu_bank.exchange(100, "BRL", currency, date).to_s
        @last_valid_rate = data[date]
      rescue Money::Bank::UnknownRate
        # eu_bank does not publish exchange rates on weekends. So we infer the value.
        data[date] = @last_valid_rate
      end
    end

    data
  end
end
