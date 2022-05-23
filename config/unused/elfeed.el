;;; -*- lexical-binding: t -*-

(use-package elfeed
  :config
  (setq elfeed-use-curl t
        elfeed-enclosure-default-dir "~/Downloads/"
        elfeed-db-directory "~/.emacs.d/.elfeed/"
        elfeed-search-feed-face ":foreground #fff :weight bold"
        elfeed-feeds
        '("https://news.ycombinator.com/rss"
          "https://grumpygamer.com/rss"
          "https://lobste.rs/rss"
          "https://blog.acolyer.org/feed/"
          "https://www.retronator.com/rss"
          "http://feeds.feedburner.com/stevelosh?format=xml"
          ("https://www.reddit.com/r/linux.rss" reddit linux)
          ("https://www.reddit.com/r/commandline.rss" reddit commandline)
          ("https://www.reddit.com/r/distrotube.rss" reddit distrotube)
          ("https://www.reddit.com/r/emacs.rss" reddit emacs)
          ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
          ("https://hackaday.com/blog/feed/" hackaday linux)
          ("https://opensource.com/feed" opensource linux)
          ("https://linux.softpedia.com/backend.xml" softpedia linux)
          ("https://itsfoss.com/feed/" itsfoss linux)
          ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
          ("https://www.phoronix.com/rss.php" phoronix linux)
          ("http://feeds.feedburner.com/d0od" omgubuntu linux)
          ("https://www.computerworld.com/index.rss" computerworld linux)
          ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
          ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
          ("https://betanews.com/feed" betanews linux)
          ("http://lxer.com/module/newswire/headlines.rss" lxer linux))))

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))
