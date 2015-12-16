Feed+
=====

An RSS feed generator based on Google+ posts.

At the moment Google+ API allows to fetch only public posts. Good news is that you can fetch anyone posts, not only yours.
Also, Feed+ allows to filter posts by hashtags.

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=ascarpino&url=https://gitlab.com/ilpianista/Feedplus&title=Feed+&language=&tags=ruby,google&category=software)

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

    $ git clone https://gitlab.com/ascarpino/Feedplus.git
    $ cd feedplus
    $ gem install bundler
    $ bundle install
    $ ruby feedplus.rb -h
