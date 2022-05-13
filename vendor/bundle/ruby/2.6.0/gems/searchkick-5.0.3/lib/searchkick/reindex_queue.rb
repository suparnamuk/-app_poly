module Searchkick
  class ReindexQueue
    attr_reader :name

    def initialize(name)
      @name = name

      raise Error, "Searchkick.redis not set" unless Searchkick.redis
    end

    # supports single and multiple ids
    def push(record_ids)
      Searchkick.with_redis { |r| r.lpush(redis_key, record_ids) }
    end

    def push_records(records)
      record_ids =
        records.map do |record|
          # always pass routing in case record is deleted
          # before the queue job runs
          if record.respond_to?(:search_routing)
            routing = record.search_routing
          end

          # escape pipe with double pipe
          value = escape(record.id.to_s)
          value = "#{value}|#{escape(routing)}" if routing
          value
        end

      push(record_ids)
    end

    # TODO use reliable queuing
    def reserve(limit: 1000)
      if supports_rpop_with_count?
        Searchkick.with_redis { |r| r.call("rpop", redis_key, limit) }.to_a
      else
        record_ids = []
        Searchkick.with_redis do |r|
          while record_ids.size < limit && (record_id = r.rpop(redis_key))
            record_ids << record_id
          end
        end
        record_ids
      end
    end

    def clear
      Searchkick.with_redis { |r| r.del(redis_key) }
    end

    def length
      Searchkick.with_redis { |r| r.llen(redis_key) }
    end

    private

    def redis_key
      "searchkick:reindex_queue:#{name}"
    end

    def supports_rpop_with_count?
      redis_version >= Gem::Version.new("6.2")
    end

    def redis_version
      @redis_version ||= Searchkick.with_redis { |r| Gem::Version.new(r.info["redis_version"]) }
    end

    def escape(value)
      value.gsub("|", "||")
    end
  end
end
