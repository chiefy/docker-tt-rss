# docker-tt-rss

This is a working orchestration of [tiny tiny RSS](https://git.tt-rss.org/fox/tt-rss) using Alpine Linux, PostgreSQL and PHP 7.x. Thanks to [clue/docker-ttrss](https://github.com/clue/docker-ttrss/) for the DB import snippets.

## Usage

  * starting:

```bash
$ make run && open http://localhost:8080
```

  * stopping:

```bash
$ make stop
```
