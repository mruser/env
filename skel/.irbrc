begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

module DynamicPrompt
  def self.apply!
    IRB.conf[:PROMPT][:INFORMATIVE] = {
      :PROMPT_I => ">>".tap {|s| def s.dup; gsub('>>', DynamicPrompt.normal); end },
      :PROMPT_S => "\e[0;35m%n\e[0m   ",
      :PROMPT_C => "\e[0;35m%n\e[0m>   ",
      :RETURN => "\e[1;35m=>\e[0m %.2048s\n"
    }
    IRB.conf[:PROMPT_MODE]  = :INFORMATIVE
  end

  def self.normal
    color1 = "\e[0;35m%n \e[35m[\e[1;35m"
    color2 = "\e[0;35m]::\e[1;34m"
    color3 = "\e[0;35m]\e[0m> "
    color1 + color2 + cwd + color3 
  end

private
  def self.cwd
    if Dir.pwd == '/'
      '/'
    elsif Dir.pwd == ENV['HOME']
      '~'
    else
      Dir.pwd.split('/').last
    end
  end

end

DynamicPrompt.apply!
