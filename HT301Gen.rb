module HT301Gen

  require "curl"
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'
  require 'colorize'

  def HT301Gen.make(old , new)
    old_links = File::open(old, 'r')
    new_links = File::open(new, 'r')

    HT301Gen.validate("old.txt" , "new.txt")

    old_links.each_with_index do |line , index|
      begin
        oldlink = line
        newlink = new_links.readline
        uri = oldlink.to_s
        HT301Gen.cleanLines(uri)
        # TODO Here We Redirect 301 From Old Link to New Link
        puts "Redirect 301 #{uri.red} #{URI.decode(newlink).green}"
      rescue Exception => e
        puts e
      end
    end
  end

  def HT301Gen.validate (old_file , new_file)
    if File.zero?(old_file)
      puts "Cannot Use Empty File For Checks Kindly Provide Some Links in #{old_file} ".red
      exit
    end

    if File.zero?(new_file)
      puts "Cannot Use Empty File For Checks Kindly Provide Some Links in #{new_file}t ".red
      exit
    end

    old_line_count = `wc -l #{old_file}`.strip.split(' ')[0].to_i
    new_line_count = `wc -l #{new_file}`.strip.split(' ')[0].to_i
    if old_line_count != new_line_count
      puts "Please Make Sure That Both Files has The Equal Number of lines ".red
      exit
    end
  end


  def HT301Gen.cleanLines(string)
    if string.include? "%0A"
      string["%0A"] = ''
    end

    if string.include? "\n"
      string["\n"] = ''
    end
  end

end
