require 'station'

describe Station do
let (:new_station) { Station.new('Station', 'Zone') }  

  it 'has variable name' do
    expect(new_station).to respond_to(:name)
  end

  it 'has variable zone' do
    expect(new_station).to respond_to(:zone)
  end
end