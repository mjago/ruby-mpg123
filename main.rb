require_relative 'ruby-mpg123'

def print_status mpg
  puts "state: #{mpg.state}, frame: #{mpg.frame}, frames_remaining: #{mpg.frames_remaining}"
  puts "time: #{mpg.time}, time_remaining: #{mpg.time_remaining}"
  puts "info: #{mpg.info}, "
end

p 'here'
mpg = Mpg123.new
sleep 0.2
puts "state: #{mpg.state}, version: #{mpg.version}"
mpg.load('wave.mp3')
loop do
  sleep 1
  mpg.poll
  print_status mpg
  break if mpg.error
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
