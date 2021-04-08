module Constants
  URLS = {
    root: '/',
    rules: '/rules',
    statistics: '/stats',
    new_game: '/new_game',
    game: '/game',
    submit_answer: '/submit_answer',
    win: '/win',
    lose: '/lose',
    hint: '/hint'
  }.freeze

  AUTH_URLS = ['/game', '/submit_answer', '/hint', '/win', '/lose'].freeze

  DB_PATH = './db/top_users.yml'.freeze
  DIFFICULTY_ORDER = %w[easy medium hell].freeze

  NOPE = 'x'.freeze
  BTN_SUCCESS = 'btn-success'.freeze
  BTN_PRIMARY = 'btn-primary'.freeze
  BTN_DANGER = 'btn-danger'.freeze

  ONE_MONTH = 2_592_000
  CODE_LENGTH = 4
  CODE_404 = 404
  CODE_200 = 200
end
