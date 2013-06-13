feedplus
========

An RSS feed generator for the public posts on Google+ of any account.

# Options
        --id, --user <id>            Google+ user ID
    -f, --filter [tag1, tag2,...]    Only posts that have these hashtags
    -t, --title <title>              Feed title
    -u, --url <url>                  Feed url
    -h, --help                       Show this message

# Example usage
    ruby feedplus.rb --id 104652450278570828775 -f kde, qt -t "Scarpino's posts on G+" -u "http://www.andreascarpino.it/feed.xml"
