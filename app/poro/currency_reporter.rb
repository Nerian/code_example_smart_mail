class CurrencyReporter

  attr_accessor :origin, :targets, :data

  def initialize(origin:, targets:, days: 600)
    @origin  = origin
    @targets = targets
    @data    = []
    @days    = 600
  end

  def report
    @data = []

    @targets.each do |currency|
      @data << { name: currency, data: get_data(currency) }
    end

    @data
  end

  private

  def get_data(currency)
    currency_data = {}

    (@days.days.ago.to_date..1.days.ago.to_date).each do |date|
      begin
        currency_data[date] = Money.default_bank.exchange(100, @origin, currency, date).to_s
        @last_valid_rate    = currency_data[date]
      rescue Money::Bank::UnknownRate
        # eu_bank does not publish exchange rates on weekends. So we take the previous value.
        currency_data[date] = @last_valid_rate
      rescue Money::Currency::UnknownCurrency => e
        raise StandardError.new("#{e.message}. Supported currencies are: #{EuCentralBank::CURRENCIES.join(', ')}")
      end
    end

    currency_data
  end

end