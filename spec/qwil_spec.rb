require 'spec_helper'
require 'support/vcr_setup'
require 'qwil'

RSpec.describe PaymentProcessor::Qwil do

  subject { PaymentProcessor::Qwil }

  context 'success authenticate with qwil', vcr: { cassette_name: 'qwil/success_authenticating' } do

    before do
      subject.authenticate
    end

    describe 'authenticate' do

      it 'sets api_token' do
        expect(subject.api_token).to be_a(String)
      end

      it 'sets api_platform_uri' do
        expect(subject.api_platform_uri).to match(/platforms\/\d+/)
      end

    end

  end

  context 'success with creating a request object via faraday' do

    describe 'call request' do
      it 'returns faraday object' do
        expect(subject.request.class.to_s).to eq('Faraday::Connection')
      end
    end
  end
end
