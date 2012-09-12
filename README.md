# Command-line Twitter client written in Ruby

**Version**: 1.0.2  
**Source**: `git@github.com:tomthorgal/Ruby-command-line-twitter-client.git`  
**Website**: `https://github.com/tomthorgal/Ruby-command-line-twitter-client`  
**Author**: Thomas Vollath (@tomthorgal)  
**Based on**: `http://www.noppanit.com/ruby-command-line-twitter-client-made-easy/`  
**Helpful docs**: `https://dev.twitter.com/docs/api`  
              `https://github.com/moomerman/twitter_oauth`  

## Install  
    gem install twitter_oauth
    gem install colored
    git clone git@github.com:tomthorgal/Ruby-command-line-twitter-client.git
* Get your twitter consumer and access keys from: https://dev.twitter.com/apps/
* Make sure that you give the application "*read*, *write*, and *direct messages*" access when you set it up
* Add the keys to your .bashrc (linux only) file:
    export TWITTER_CONSUMER_KEY=your-consumer-key  
    export TWITTER_CONSUMER_SECRET=your-conusmer-secret  
    export TWITTER_ACCESS_TOKEN=your-access-token  
    export TWITTER_ACCESS_SECRET=your-access-secret
* Edit your .bashrc file and add a new alias:  
    alias twitter='ruby /your/path/command-line-twitter-client.rb'  
* Reload your .profile:
    source ~/.profile

## Usage
`twitter` => to see usage options

    twitter -[l|m] {count:int}
    twitter -[u] {text:string}
    twitter -[s] {text:string} {count:int}

## Examples
    twitter -l
  will list your 5 (default) most recent home timeline tweets
    twitter -l 10
  will list your 10 most recent home timeline tweets
    twitter -m
  will list your 5 (default) most recent mentions
    twitter -m 10
  will list your 10 most recent mentions
    twitter -u
  will prompt you for the update you want to tweet
    twitter -u "Your update text"
  will post a new tweet with the update text
    twitter -s
  will prompt you for a search parameter
    twitter -s \#elephant
  will list the 5 (default) most recent tweets that contain #elephant
    twitter -s \#elephant 50
  will list the 50 most recent tweets that contain #elephant
### Note for searches
  If you search for more than one word please wrap them in **"..."** quotes
  please escape special characters like `\#` or `\@`

## Change log
* 1.0.2 - Changed the README.markdown to README.md and updated the content.
* 1.0.1 - Changed the way the keys are stored. Now moved in to .bashrc.
* 1.0 - Basic functionality

## Future plans
 - Add @user profile views
 - Add follow user function
 - Add unfollow user function
 - Add trend views
 - Add list views (also edit/delete/create and so on..)
 - Make users in tweets clickable (when clicked open @user profile view)
 - Make hashtags in tweets clickable
 - Make URL's clickable (when clicked copy URL to clipboard)
 - Figure out how to .reverse the client.search method return
   -- Right now the search results are returned and displayed from newest to oldest
   -- I would like the sort to be oldest to newest like all other tweet output (eg: home_timeline, mentions)
 - Allow for multiple account with a default when none specified
   -- Pretty much just need to add an attribute
   -- I would like it to be the second attribute and default to an account when it's not submitted
   -- New structure could be: $ twitter {account} -[l|m|u|s] {text:string} {count:int}
 - Go back and check for proper error traps and add where needed
