# aria2 - static build without limitation of connections per server

[![Build Status](https://travis-ci.com/machsix/aria2-static-build.svg?branch=master)](https://travis-ci.com/machsix/aria2-static-build)

## Disclaimer

This program comes with no warranty. You must use this program at your own risk.

## License

- **aria2**: [https://github.com/aria2/aria2/blob/master/COPYING](https://github.com/aria2/aria2/blob/master/COPYING)
- **patches**: [https://github.com/myfreeer/aria2-build-msys2/blob/master/LICENSE](https://github.com/myfreeer/aria2-build-msys2/blob/master/LICENSE)
- **other scripts**: [GNU General Public License](https://www.gnu.org/licenses/gpl.html) Version 3 or later.

## [Changes](https://github.com/myfreeer/aria2-build-msys2)

- option `max-connection-per-server`: change maximum value to `*`, default value to `16`
- option `min-split-size`: change minimum value to `1K`, default value to `1M`
- option `piece-length`: change minimum value to `1K`, default value to `1M`
- option `connect-timeout`: change default value to `30`
- option `split`: change default value to `128`
- option `continue`: change default value to `true`
- option `retry-wait`: change default value to `1`
- option `max-concurrent-downloads`: change default value to `16`
- option `netrc-path` `conf-path` `dht-file-path` `dht-file-path6`: change default value to sub-folder of current directory
- download: retry on slow speed and connection close
- download: add option `retry-on-400` to retry on http 400 bad request, which only effective if retry-wait > 0
- download: add option `retry-on-403` to retry on http 403 forbidden, which only effective if retry-wait > 0
- download: add option `retry-on-406` to retry on http 406 not acceptable, which only effective if retry-wait > 0

## How to build?

- Check .travis.yaml

## Credits

- https://github.com/aria2/aria2
- https://gist.github.com/zhangyubaka/fb56f6bf9be50dbd28e64809cdc659be
- https://github.com/jb-alvarado/media-autobuild_suite
- https://github.com/myfreeer/aria2-build-msys2
- travis-ci
