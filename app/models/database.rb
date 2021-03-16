class Database
  PATH = './db/top_users.yml'.freeze
  DIFFICULTY_ORDER = %w[hell medium easy].freeze

  class << self
    def save(stats)
      data = load
      data << stats
      File.open(File.expand_path(PATH), 'w') { |file| file.write(data.to_yaml) }
    end

    def load
      return [] unless File.exist?(File.expand_path(PATH))

      File.open(File.expand_path(PATH)) { |file| YAML.safe_load(file, [Stats, Symbol], [], true) }
    end

    def sort_stats
      sorted_stats = load
      sorted_stats.sort! do |left_item, right_item|
        [left_item.attempts_used, left_item.hints_used] <=> [right_item.attempts_used, right_item.hints_used]
      end
      sorted_stats.sort_by! { |item| DIFFICULTY_ORDER.index item.difficulty }
      sorted_stats
    end
  end
end
