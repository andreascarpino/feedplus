Feed+
=====

An RSS feed generator based on Google+ posts.

At the moment Google+ API allows to fetch only public posts. Good news is that you can fetch anyone posts, not only yours.
Also, Feed+ allows to filter posts by hashtags.

## Options
        --id, --user <id>            Google+ user ID
    -f, --filter <tag1, tag2, ...>   Fetch only posts having these hashtags
    -l, --limit <n>                  Fetch at most N posts per feed (default: 20)
    -t, --title <title>              Feed title
    -u, --url <url>                  Feed URL
    -h, --help                       Show this help

## Example usage
    ruby feedplus.rb --id 104652450278570828775 -f kde, qt -t "Andrea Scarpino - KDE" -u "http://www.andreascarpino.it/kde.xml"

## Running
You need the bundler gem (`ruby`), then exec:

    $ git clone https://gitlab.com/ilpianista/FeedPlus.git
    $ cd FeedPlus
    $ gem install bundler
    $ bundle install
    $ ruby feedplus.rb -h

## Donate

Donations via [Liberapay](https://liberapay.com/ilpianista) or Bitcoin (1Ph3hFEoQaD4PK6MhL3kBNNh9FZFBfisEH) are always welcomed, _thank you_!

## License

MIT
