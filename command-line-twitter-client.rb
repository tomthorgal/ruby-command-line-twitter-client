#!/usr/bin/env ruby

# Source: git@github.com:tomthorgal/Ruby-command-line-twitter-client.git
# Website: https://github.com/tomthorgal/Ruby-command-line-twitter-client
# Author: Thomas Vollath (@tomthorgal)
# Version: 1.0

system("clear")

require 'rubygems'
require 'twitter_oauth'
require 'colored'

TWITTER_CONSUMER_KEY    = 'your-applications-consumer-key'
TWITTER_CONSUMER_SECRET = 'your-applications-consumer-secret'
TWITTER_ACCESS_TOKEN    = 'your-applications-access-token'
TWITTER_ACCESS_SECRET   = 'your-applications-access-secret'

client = TwitterOAuth::Client.new(
    :consumer_key => TWITTER_CONSUMER_KEY,
    :consumer_secret => TWITTER_CONSUMER_SECRET,
    :token => TWITTER_ACCESS_TOKEN,
    :secret => TWITTER_ACCESS_SECRET)

case ARGV[0]
when '-l'
    puts "fetching tweets ..."
    ARGV[1].nil? ? c = 5 : c = ARGV[1]
    r = client.home_timeline({"count" => c}).reverse
    puts "\nThe #{c} most recent tweets of your home timeline:\n\n"
    puts "--------------------------------------------------------------------"
    r.each{ |t|
        puts t['user']['name'] + " | " +'@'.green + t['user']['screen_name'].green + " | " + t['created_at']
        puts t['text'].bold
        puts "--------------------------------------------------------------------"
    }
when '-m'
    ARGV[1].nil? ? c = 5 : c = ARGV[1]
    puts "fetching tweets ..."
    r = client.mentions({"count" => c}).reverse
    puts "\nYour #{c} most recent mentions:\n\n"
    puts "--------------------------------------------------------------------"
    r.each{ |t|
        puts t['user']['name'] + " | " +'@'.green + t['user']['screen_name'].green + " | " + t['created_at']
        puts t['text'].bold
        puts "--------------------------------------------------------------------"
    }
when '-u'
    if ARGV[1].nil?
        puts "Please enter your status: "
        status = STDIN.readline.chomp
        client.update("#{status}")
    else
        client.update("#{ARGV[1]}")
    end
when '-s'
    if ARGV[1].nil?
        puts "Please enter your search string:"
        puts "(Please escape special characters like " + "\\#".green + " or " + "\\@".green + ")."
        q = STDIN.readline.chomp
        puts "How many tweets do you want to show? (1-100, default/blank = 5):"
        ic = Integer(STDIN.realine.chomp) rescue 0
    else
        q = ARGV[1]
        ic = Integer(ARGV[2]) rescue 0
    end
    ic < 1 || ic > 100 ? c = 5 : c = ic # twitters api is limited to 100 at a time
    r = client.search("#{q}", {"include_entities" => false, "rpp" => c})
    q = q.sub( "\\", "" )
    puts "\nThe #{c} most recent tweets containing [ #{q} ]:\n\n"
    puts "--------------------------------------------------------------------"
    r['results'].each{ |t|
        puts t['from_user_name'] + " | " +'@'.green + t['from_user'].green + " | " + t['created_at']
        puts t['text'].bold
        puts "--------------------------------------------------------------------"
    }
else
    system("clear")
    puts "--------------------------------------------------------------------"
    puts "Command-line twitter client - v1.0\n".red.bold
    puts "Usage: " + "twitter -[l|m] {count:int}".green
    puts "       " + "twitter -[u] {text:string}".green
    puts "       " + "twitter -[s] {text:string} {count:int}\n".green
    puts "Examples: " + "twitter -l".bold
    puts "            will list your 5 (default) most recent home timeline tweets"
    puts "          twitter -l 10".bold
    puts "            will list your 10 most recent home timeline tweets"
    puts "          twitter -m".bold
    puts "            will list your 5 (default) most recent mentions"
    puts "          twitter -m 10".bold
    puts "            will list your 10 most recent mentions"
    puts "          twitter -u".bold
    puts "            will prompt you for the update you want to tweet"
    puts "          twitter -u \"Your update text\"".bold
    puts "            will post a new tweet with the update text"
    puts "          twitter -s".bold
    puts "            will prompt you for a search parameter"
    puts "          twitter -s \\#elephant".bold
    puts "            will list the 5 (default) most recent tweets that contain #elephant"
    puts "          twitter -s \\#elephant 50".bold
    puts "            will list the 50 most recent tweets that contain #elephant"
    puts "          note for searches:".green
    puts "            if you search for more than one word please wrap them in \"...\" quotes"
    puts "            please escape special characters like \\# or \\@"
    puts "--------------------------------------------------------------------\n"
end

puts "\n"