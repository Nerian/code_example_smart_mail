class PagesController < ApplicationController

  def index
    @currencies        = params[:currencies].split(',')
    @origin            = params[:origin]
    @target_currencies = (@currencies - [@origin])

    @data = CurrencyReporter.new(origin: @origin, targets: @target_currencies).report
  end
end
