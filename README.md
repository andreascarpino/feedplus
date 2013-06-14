Feed+
========

An RSS feed generator for the public posts on Google+ of any account.

## Options
        --id, --user <id>            Google+ user ID
    -f, --filter [tag1, tag2,...]    Only posts that have these hashtags
    -l, --limit n                    Max N entries for feed
    -t, --title <title>              Feed title
    -u, --url <url>                  Feed url
    -h, --help                       Show this message

## Example usage
    ruby feedplus.rb --id 104652450278570828775 -f kde, qt -t "Andrea Scarpino - KDE" -u "http://www.andreascarpino.it/kde.xml"
