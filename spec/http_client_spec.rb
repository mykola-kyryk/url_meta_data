require 'spec_helper'

RSpec.describe UrlMetaData::HTTPClient do
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

  subject { described_class.get(url) }

  example do
    expect { subject }.not_to raise_error
  end

  context '#get' do
    it 'returns HTTP response' do
      expect(subject.body).to eq response_body
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
          expect(subject.body).to eq redirect_response_body
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
          expect {
            subject
          }.to raise_error UrlMetaData::HTTPClient::TooManyRedirects
        end
      end
    end
  end
end
