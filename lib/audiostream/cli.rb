require 'thor'

module AudioStream
  class CLI < Thor
    include Thor::Actions

    default_task :banner

    desc "help", "Display the application help text."
    method_option :help, :aliases => "-h", :desc => "Help command"

    def banner
      puts <<-EOL
AudioStream (C)2013 CompuTEK Industries. All Rights Reserved.
Licenced for usage and distribution under a BSD version 2 Licence.

      EOL
      help
    end

    desc "time", "Display the play time of an audio file."
    method_option :playlist, :aliases => "-p", :desc => "m3u playlist to parse"

    def time
      @filepath = "#{options[:playlist]}"
  
      if File.exists?(@filepath) then
  	  read_m3u(@filepath) do
  	    @mp3 = Mp3Info.new(@filepath)
  	    puts Time.at(@mp3.length).gmtime.strftime('%R:%S')
        end
  	else
  	  help(:time)
  	end
    end
  
    private
  
    def read_m3u(path, &block)
      File.open(@filepath).each do |item|
        next if /^#EXT(M3U|INF:).*$/.match(item)
        next unless File.exists?(item)
  	
  	block.call
      end
    end
  end
end
