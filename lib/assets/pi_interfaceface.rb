module PiInterface
  require 'pi_piper'
  include PiPiper

  class Log
    attr_accessor :archive

    def initialize()
      @archive = []
    end

    def last_item
      return @archive[@archive.length - 1]
    end

    def add_item(item)
      @archive.push(item)
    end
    
    def calculate_speed(time)
      last_time = self.last_item
      puts "time: #{time}, last_time: #{last_time}"
      elapsed = time - last_time
      puts "elapsed: #{elapsed}"
      circumference = 2 * (Math::PI) * 350
      speed = 0.001367017 / (elapsed / 3600 )
      puts speed
    end
  end

  history = Log.new

  PiPiper.watch :pin => 18, :pull => :up, :direction => :in do |pin|
    if(pin.value == 0) 
      if(history.archive.length > 2)
        history.calculate_speed(Time.now)
        history.add_item(Time.now)
      else
        history.add_item(Time.now)
      end
    end
  end

  PiPiper.wait
end
