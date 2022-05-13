# frozen_string_literal: true

module Yabeda
  # Base class for complex metric for measuring time values that allow to
  # calculate averages, percentiles, and so on.
  class Histogram < Metric
    option :buckets

    # rubocop: disable Metrics/MethodLength
    def measure(tags, value = nil)
      if value.nil? ^ block_given?
        raise ArgumentError, "You must provide either numeric value or block for Yabeda::Histogram#measure!"
      end

      if block_given?
        starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        yield
        value = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - starting)
      end

      all_tags = ::Yabeda::Tags.build(tags, group)
      values[all_tags] = value
      ::Yabeda.adapters.each do |_, adapter|
        adapter.perform_histogram_measure!(self, all_tags, value)
      end
      value
    end
    # rubocop: enable Metrics/MethodLength
  end
end
