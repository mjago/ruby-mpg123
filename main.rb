require_relative 'ruby-mpg123'

mpg = Mpg123.new
sleep 0.2
puts "state: #{mpg.state}, version: #{mpg.version}"
mpg.load('wave.mp3')
loop do
  puts "state: #{mpg.state}, frame: #{mpg.frame}, time: #{mpg.time} secs"
  break if mpg.error
#  break if mpg.time > 10.0
  sleep 1
  break unless mpg.playing?
end
puts "Stopping..."
puts "state: #{mpg.state}"
mpg.stop
loop do
  sleep 1
  puts "state: #{mpg.state}"
  break if mpg.stopped?
end
mpg = nil
