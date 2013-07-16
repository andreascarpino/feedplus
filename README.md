Feed+
=====

An RSS feed generator based on your Google+ posts.

At the moment Google+ API allows to fetch only public posts. Good news is that you can fetch anyone posts, not only yours.
Also, Feed+ allows to filter posts by hashtags.

## Options
    -i, --user-id <id>               Google+ User ID
    -f, --filter <tag1, tag2, ...>   Fetch only posts having these hashtags
    -l, --limit <n>                  Fetch at most N posts per feed (default: 20)
    -t, --title <title>              Feed title
    -u, --url <url>                  Feed URL
    -h, --help                       Show this help

## Example usage
    ruby feedplus.rb -i 104652450278570828775 -f kde, qt -t "Andrea Scarpino - KDE" -u "http://www.andreascarpino.it/kde.xml"

## Running
You need ruby, then exec:

    $ git clone git://github.com/scarpin0/feedplus.git
    $ cd feedplus
    $ gem install bundler
    $ bundle install
    $ ruby feedplus.rb -h
