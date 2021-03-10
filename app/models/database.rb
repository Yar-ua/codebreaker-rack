class Database
  PATH = './db/top_users.yml'.freeze

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
  end
end