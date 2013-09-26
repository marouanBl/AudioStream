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

      help(:time) if options[:playlist].nil?
      @filepath = "#{options[:playlist]}"
  
      if File.exists?(@filepath) then
	File.open(@filepath).each do |item|
	  @item=item.chomp

	  next if /^#EXT(M3U|INF:).*$/.match(@item)
	  puts "Reading #{@item}"

	  if File.exists?(@item) then
	    puts "#{@item}: #{playtime(@item)}"
	  else
            puts "Error: File #{@item} not found"
          end
        end
      else
  	puts "Playlist could not be loaded."
      end
    end

    private
  
    def playtime(path)
      Time.at(mp3(path).length).gmtime.strftime('%R:%S')
    end

    def mp3(path)
      return Mp3Info.new path
    end
  end
end
