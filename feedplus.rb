#!/usr/bin/env ruby

#    Copyright (C) 2013 Andrea Scarpino <me@andreascarpino.it>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'net/http'
require 'json'
require 'optparse'
require 'ostruct'
require 'rss'

$options = OpenStruct.new
$options.id = ""
$options.hashtags = []
$options.limit = 20
$options.feedTitle = "Your feed title"
$options.feedUrl = "http://your.domain.com/"

def getPosts(pageToken = "nextPageToken")
  uri = URI("https://www.googleapis.com/plus/v1/people/#{$options.id}/activities/public")
  params = { :fields => 'items(actor/displayName,object(actor/displayName,attachments(content,displayName,fullImage/url),content),title,published,updated,url),nextPageToken',
             :key => 'AIzaSyDjcCZGSGTIaMA3VXmEjATkTlX4iRAoPiM',
             :maxResults => 100,
             :pageToken => pageToken }
  uri.query = URI.encode_www_form(params)

  res = Net::HTTP.get_response(uri)
  if res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)
  else
    puts "Something went wrong :-("
    exit
  end
end

def parse(args)
  opt_parser = OptionParser.new do |opts|
    opts.banner = "Usage: feedplus.rb [options]"
    opts.separator ""
    opts.separator "Specific options:"

    opts.on("--id <id>", "--user <id>", "Google+ user ID") do |id|
      $options.id = id
    end

    opts.on("-f", "--filter tag1, tag2, ...", Array, "Only posts that have these hashtags") do |tags|
      $options.hashtags = tags.map{|t| t.downcase}
    end

    opts.on("-l", "--limit <n>", "Max N entries for feed. (Default to 20)") do |limit|
      $options.limit = limit
    end

    opts.on("-t", "--title <title>", "Feed title") do |title|
      $options.feedTitle = title
    end
  
    opts.on("-u", "--url <url>", "Feed url") do |url|
      $options.feedUrl = url
    end

    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
    end
  end

  opt_parser.parse!(args)
end

def makeRSS
  rss = RSS::Maker.make("2.0") do |maker|
    channel = maker.channel
    channel.title = $options.feedTitle
    channel.description = channel.title
    channel.link = $options.feedUrl

    items = getPosts
    counter = 0

    catch :done do
      while counter < $options.limit
        items.fetch("items").each do |post|
          catch :none do
            $options.hashtags.each do |tag|
              throw :none unless post.fetch("object").fetch("content").downcase.include?("##{tag}")
            end

            addPost(maker, post)

            counter += 1
            throw :done if counter >= $options.limit
          end
        end

        if items.has_key?("nextPageToken")
          items = getPosts(items.fetch("nextPageToken"))
        else
          break
        end
      end
    end
  end

  rss
end

def addPost(maker, post)
  maker.items.new_item do |item|
    item.title = post.fetch("title")

    # Elide title when text is very long
    if item.title.length >= 40
      item.title = item.title[0, 37]
      item.title += '...'
    end

    item.link = post.fetch("url")
    item.description = post.fetch("object").fetch("content")
    item.pubDate = post.fetch("published")
    item.author = post.fetch("actor").fetch("displayName")

    if post.fetch("object").has_key?("attachments")
      item.description += "<br /><br />"

      attachments = post.fetch("object").fetch("attachments")
      if attachments.first.has_key?("fullImage")
        url = attachments.first.fetch("fullImage").fetch("url")
        item.description += "<a href='#{url}'><img src='#{url}'></a>"
      end
    end
  end
end

parse(ARGV)

if $options.id.empty?
  puts "Please, specify an user id (see --help)."
  exit
end

rss = makeRSS

puts rss unless rss.nil?
