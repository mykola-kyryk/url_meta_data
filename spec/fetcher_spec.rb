require 'spec_helper'

RSpec.describe UrlMetaData::Fetcher do
  before do
    stub_request(:get, url).
      to_return(
        body: response_body,
        status: response_code,
        headers: response_headers
      )
  end

  let(:url) { 'http://www.google.com' }
  let(:response_code) { 200 }
  let(:response_body) { 'Body' }
  let(:response_headers) { {} }

  subject { described_class.fetch(url) }

  example do
    expect { subject }.not_to raise_error
    expect { described_class.new(url) }.to raise_error NoMethodError
  end

  context '#fetch' do
    it 'returns body of response' do
      expect(subject).to eq response_body
    end

    context 'status 301-303' do
      let(:response_code) { %w(301 302 303).sample }

      context 'follow the redirect' do
        before do
          stub_request(:get, redirect_url).
            to_return(
              body: redirect_response_body,
              status: 200,
              headers: {}
            )
        end
        let(:response_headers) { { 'Location' => redirect_url } }
        let(:redirect_url) { 'https://github.com/status' }
        let(:redirect_response_body) { 'Redirected' }

        example do
          expect(subject).to eq redirect_response_body
        end
      end

      context 'raises if more than 5 redirects are encountered' do
        before do
          stub_request(:get, url).
            to_return(
              body: 'abc',
              status: response_code,
              headers: { 'Location' => url } # loop redirects
            )
        end

        example do
          expect(subject).to eq ''
        end
      end
    end
  end
end
