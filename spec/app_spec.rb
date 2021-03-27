RSpec.describe CodebreakerRack do
  include Rack::Test::Methods

  let(:app) { Rack::Builder.parse_file('config.ru').first }
  let(:urls) { Router::URLS }

  describe 'when user unauthorised' do
    describe 'root page' do
      before { get(urls[:root]) }

      it { expect(last_response.status).to eq(200) }
      it { expect(last_response.body).to include I18n.t('menu.name') }
      it { expect(last_response.body).to include I18n.t('menu.choose_level') }
    end

    describe 'rules page' do
      before { get(urls[:rules]) }

      it { expect(last_response.status).to eq(200) }
      it { expect(last_response.body).to include I18n.t('rules') }
      it { expect(last_response.body).to include I18n.t('home') }
    end

    describe 'statistice page' do
      before { get(urls[:statistics]) }

      it { expect(last_response.status).to eq(200) }
      it { expect(last_response.body).to include I18n.t(:top_players) }
    end

    describe 'if protected path then redirect' do
      it { expect(get(urls[:game])).to be_redirect }
      it { expect(get(urls[:submit_answer])).to be_redirect }
      it { expect(get(urls[:hint])).to be_redirect }
      it { expect(get(urls[:win])).to be_redirect }
    end
  end

  describe 'when auth user' do
    let(:user_name) { 'Benny' }
    let(:difficulty) { 'hell' }

    before do
      post urls[:new_game], user_name: user_name, difficulty: difficulty
    end

    describe 'game created' do
      it { expect(last_response.status).to eq(302) }
      it { expect(last_response.header['Location']).to eq(:game.to_s) }
      it { expect(last_response).to be_redirect }
    end

    describe 'game saved to session' do
      it { expect(last_request.session[:web_game].status).to eq(:in_process) }
      it { expect(last_request.session[:web_game].game.user.name).to eq(user_name) }
    end

    describe 'game page have' do
      before do
        get urls[:game]
      end

      it { expect(last_response.body).to include I18n.t('game.hello', name: user_name) }
      it { expect(last_response.body).to include difficulty }
    end

    describe 'submit_answer' do
      before { post urls[:submit_answer], guess: '1234' }

      it '111' do
        follow_redirect!
        expect(last_response.body).to include NOPE || Codebreaker::Game::PLUS || Codebreaker::Game::MINUS
      end
    end

    describe 'hint' do
      it 'take hint' do
        expect { get(urls[:hint]) }.to change { last_request.session[:web_game].game.hints }.from(1).to(0)
      end
    end

    describe 'win game' do
      before do
        get urls[:submit_answer], guess: last_request.session[:web_game].game.code
      end

      it { expect(last_response.header['Location']).to eq(:win.to_s) }

      it 'redirect win page' do
        follow_redirect!
        expect(last_response.body).to include I18n.t('congratulation', name: user_name)
      end

      it 'statistics' do
        get urls[:statistics]
        expect(last_response.body).to include user_name
      end
    end

    describe 'lose game' do
      before do
        5.times { get urls[:submit_answer], guess: '1111' }
      end

      it { expect(last_response.header['Location']).to eq(:lose.to_s) }

      it 'redirect lose page' do
        follow_redirect!
        expect(last_response.body).to include I18n.t('lose.lose', name: user_name)
      end
    end

    describe 'win page not available' do
      it { expect(get(urls[:win])).to be_redirect }
    end

    describe 'lose page not available' do
      it { expect(get(urls[:lose])).to be_redirect }
    end
  end

  describe '404 when wrong path' do
    it { expect(get('/wrong_path').status).to eq(404) }
    it { expect(get('/wrong_path').body).to include I18n.t('not_found') }
  end
end
