require 'rails_helper'

describe CurrencyReporter do

  before(:each) do
    @origin = 'BRL'
    @targets = ['EUR', 'USD', 'AUD']
  end

  let(:report) do
    CurrencyReporter.new(origin: @origin, targets: @targets).report
  end

  it 'have all target currencies' do
    expect(report[0][:name]).to eq('EUR')
    expect(report[1][:name]).to eq('USD')
    expect(report[2][:name]).to eq('AUD')
  end

  it 'have 600 time points' do
    expect(report[0][:data].size).to eq(600)
    expect(report[1][:data].size).to eq(600)
    expect(report[2][:data].size).to eq(600)
  end

  it 'tupla is [date, rate]' do
    expect(report[0][:data].first[0].class).to eq(Date)
    expect(report[0][:data].first[1].class).to eq(String)
  end

  it 'There are no null dates' do
    expect(report[0][:data].map { |c| c[0] }.include?(nil)).not_to be
    expect(report[1][:data].map { |c| c[0] }.include?(nil)).not_to be
    expect(report[2][:data].map { |c| c[0] }.include?(nil)).not_to be
  end

  it 'There are no null rates' do
    expect(report[0][:data].map { |c| c[1] }.include?(nil)).not_to be
    expect(report[1][:data].map { |c| c[1] }.include?(nil)).not_to be
    expect(report[2][:data].map { |c| c[1] }.include?(nil)).not_to be
  end
end