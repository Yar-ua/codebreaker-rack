require 'spec_helper'

describe CodebreakerRack do
  include Rack::Test::Methods

  let(:app) { Rack::Builder.parse_file('config.ru').first }
  let(:urls) { Router::URLS }

  describe 'when user unauthorised' do
    describe 'root page' do
      before { get(urls[:root]) }

      it { expect(last_response.status).to eq(200) }
      it { expect(last_response.body).to include I18n.t('MENU.name') }
      it { expect(last_response.body).to include I18n.t('MENU.choose_level') }
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

      it { expect(last_response.body).to include I18n.t('GAME.hello', name: user_name) }
      it { expect(last_response.body).to include difficulty }
    end

    describe 'hint' do
      it 'take hint' do
        hints = last_request.session[:web_game].hints
        get urls[:hint]
        expect(last_request.session[:web_game].hints.count - hints.count).to eq(1)
      end
    end

    describe 'win game' do
      before do
        get urls[:submit_answer], guess: last_request.session[:web_game].game.code
      end

      it 'redirect path' do
        expect(last_response.header['Location']).to eq(:win.to_s)
      end
      
      it '***' do
        get urls[:statistics]
        expect(last_response.body).to include user_name
      end
    end

    describe 'win page delete session' do
      before { get urls[:win] }

      it { expect(last_response.body).to include I18n.t('congratulation', name: user_name) }
      it { expect(last_request.session[:web_game]).to eq(nil) }
    end

    describe 'lose game' do
      before do
        5.times { get urls[:submit_answer], guess: '1111' }
      end

      it 'redirect path' do
        expect(last_response.header['Location']).to eq(:lose.to_s)
      end
    end

    describe 'lose page delete session' do
      before { get urls[:lose] }

      it { expect(last_response.body).to include I18n.t('LOSE.lose', name: user_name) }
      it { expect(last_request.session[:web_game]).to eq(nil) }
    end
  end

  describe '404 when wrong path' do
    it { expect(get('/wrong_path').status).to eq(404) }
    it { expect(get('/wrong_path').body).to include I18n.t('not_found') }
  end
end
