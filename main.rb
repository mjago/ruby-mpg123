require_relative 'ruby-mpg123'

def get_state state
  case state
  when 0 then 'STATE_STOPPED'
  when 1 then 'STATE_PAUSED'
  when 2 then 'STATE_PLAYING'
  else
    puts "Error: Invalid State"
    exit 1
  end
end

def print_status mpg
  puts "state: #{get_state(mpg.state)}, frame: #{mpg.frame}, frames_remaining: #{mpg.frames_remaining}"
  puts "time: #{mpg.time}, time_remaining: #{mpg.time_remaining}"
  puts "info: #{mpg.info}, "
end

p 'here'
mpg = Mpg123.new
sleep 0.2
puts "state: #{get_state(mpg.state)}, version: #{mpg.version}"
mpg.load('wave.mp3')
loop do
  sleep 1
  mpg.poll
  print_status mpg
  break if mpg.error
  break unless mpg.playing?
end
puts "Stopping..."
puts "state: #{get_state(mpg.state)}"
mpg.stop
loop do
  sleep 1
  puts "state: #{get_state(mpg.state)}"
  break if mpg.stopped?
end
mpg = nil
