eu_bank = EuCentralBank.new
Money.default_bank = eu_bank

eu_bank.update_historical_rates(nil, true)