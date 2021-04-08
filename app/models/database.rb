class Database
  class << self
    def save(stats)
      data = load
      data << stats
      File.open(File.expand_path(Constants::DB_PATH), 'w') { |file| file.write(data.to_yaml) }
    end

    def load
      return [] unless File.exist?(File.expand_path(Constants::DB_PATH))

      data = File.open(File.expand_path(Constants::DB_PATH)) { |file| YAML.safe_load(file, [Stats, Symbol], [], true) }
      return [] if data.nil?

      data
    end

    def sort_stats
      sorted_stats = load
      sorted_stats.sort! do |left_item, right_item|
        [left_item.attempts_used, left_item.hints_used] <=> [right_item.attempts_used, right_item.hints_used]
      end
      sorted_stats.sort_by! { |item| Constants::DIFFICULTY_ORDER.reverse.index item.difficulty }
      sorted_stats
    end
  end
end
