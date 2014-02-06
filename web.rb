require 'sinatra'


get '/' do
  erb :index
end


post '/calc' do
  slices = [1..160, 161..300, 301..500, 501..600, 601..750, 751..1000, 1001..2000]
  fls    = [0.033,  0.072,    0.086,    0.114,    0.152,    0.181,     0.235]


  from = params[:from].to_i
  to = params[:to].to_i

  read = to - from

  diff = read
  cost = 0

  slices.each_with_index do |slice, index|
    prev_diff = diff
    diff -= (slice.last - slice.first)

    if diff > 0
      cost += fls[index] * (slice.last - slice.first)
    else
      cost += fls[index] * prev_diff
    end

    break if diff <= 0
  end


  total = cost + (read / 200).to_i * 0.05 + 1 + 1.7

  "Your consuming: #{read} KW<br />
  Your cost: #{'%.2f' % cost} JD<br />
  TV tax: 1 JD<br />
  Cleaning tax: 1.7 JD<br />
  0.05 JD each 200 KW: #{(read / 200).to_i * 0.05} JD<br />
  Total: <b>#{'%.2f' % total} JD</b>"
end

