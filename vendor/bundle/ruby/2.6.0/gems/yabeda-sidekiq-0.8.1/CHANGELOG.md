# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

## 0.8.1 - 2021-08-24

### Fixed

 - Compatibility with Sidekiq 6.2.2+ due to renamings in Sidekiq's undocumented API that yabeda-sidekiq uses. See [mperham/sidekiq#4971](https://github.com/mperham/sidekiq/discussions/4971). [@Envek]

## 0.8.0 - 2021-05-12

### Added

 - `sidekiq_running_job_runtime` metric that tracks maximum runtime of currently running jobs. It may be useful for detection of hung jobs. See [#17](https://github.com/yabeda-rb/yabeda-sidekiq/pull/17). [@dsalahutdinov], [@Envek]

 - Setting `collect_cluster_metrics` allowing to force enable or disable collection of global (whole Sidekiq installaction-wide) metrics. See [#20](https://github.com/yabeda-rb/yabeda-sidekiq/pull/20). [@mrexox]

    By default all sidekiq worker processes (servers) collects global metrics about whole Sidekiq installation.
    Client processes (everything else that is not Sidekiq worker) by default doesn't.

    With this config you can override this behavior:
    - force disable if you don't want multiple Sidekiq workers to report the same numbers (that causes excess load to both Redis and monitoring)
    - force enable if you want non-Sidekiq process to collect them (like dedicated metric exporter process)

## 0.7.0 - 2020-07-15

### Changed

 - Tags from `yabeda_tags` method are applied to all metrics collected inside a job, not only sidekiq-specific. See [#14](https://github.com/yabeda-rb/yabeda-sidekiq/issues/14). @Envek

## 0.6.0 - 2020-07-15

### Added

 - Ability to override or add tags for every job via `yabeda_tags` method. @Envek

## 0.5.0 - 2020-02-20

### Added

 - New `sidekiq_job_latency` histogram to track latency statistics of different job classes. [#9](https://github.com/yabeda-rb/yabeda-sidekiq/pull/9) by [@asusikov]

### Changed

 - **BREAKING CHANGE!** Renamed `sidekiq_jobs_latency` gauge to `sidekiq_queue_latency` to better describe its purpose and differentiate with the new histogram. [#9](https://github.com/yabeda-rb/yabeda-sidekiq/pull/9) by [@asusikov]

## 0.2.0 - 2020-01-14

### Changed

 - Added `tags` option to metric declarations for compatibility with yabeda and yabeda-prometheus 0.2. @Envek

## 0.1.4 - 2019-10-07

### Added

 - Require of core yabeda gem [#4](https://github.com/yabeda-rb/yabeda-sidekiq/pull/4). [@dsalahutdinov]

## 0.1.3 - 2018-10-25

### Fixed

 - Require of core yabeda gem [#1](https://github.com/yabeda-rb/yabeda-sidekiq/issues/1). @Envek

## 0.1.2 - 2018-10-17

### Changed

 - Renamed evil-metrics-sidekiq gem to yabeda-sidekiq. @Envek

## 0.1.1 - 2018-10-05

### Changed

 - Automatic add client and server middlewares to Sidekiq. @Envek

## 0.1.0 - 2018-10-03

 - Initial release of evil-metrics-sidekiq gem. @Envek

[@Envek]: https://github.com/Envek "Andrey Novikov"
[@dsalahutdinov]: https://github.com/dsalahutdinov "Salahutdinov Dmitry"
[@asusikov]: https://github.com/asusikov "Alexander Susikov"
[@mrexox]: https://github.com/mrexox "Valentine Kiselev"
