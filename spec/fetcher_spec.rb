require 'spec_helper'

RSpec.describe UrlMetaData::Fetcher do
  context '#fetch' do
    let(:url) { 'http://www.google.com' }
    subject { described_class.fetch(url) }

    context 'positive path' do
      before do
        stub_request(:get, url).
          to_return(
            body: html_document,
            status: 200 ,
            headers: {}
          )
      end

      let(:html_document) do
        [
          '<html><head>',
          "<title>#{document_title_content}</title>",
          "<meta name='keywords' content='#{meta_keywords_content}' />",
          "<meta name='description' content='#{meta_description_content}' />",
          '</head><body></body></html>',
        ].join
      end
      let(:document_title_content) { 'Test title' }
      let(:meta_keywords_content) { 'keyword1, keyword2' }
      let(:meta_description_content) { 'Test meta description' }

      let(:expected_page_attributes) do
        {
          title: document_title_content,
          keywords: meta_keywords_content,
          description: meta_description_content,
        }
      end

      example do
        expect { subject }.not_to raise_error
      end

      it 'returns attributes of the fetched page' do
        expect(subject).to eq expected_page_attributes
      end
    end

    context 'negative path' do
      let(:expected_page_attributes) do
        {
          title: nil,
          keywords: nil,
          description: nil,
        }
      end

      context 'connection timeout' do
        before do
          stub_request(:get, url).to_timeout
        end

        it 'does not raise errors and returns nils as default result' do
          expect { subject }.not_to raise_error
          expect(subject).to eq expected_page_attributes
        end
      end

      context 'unvalid URI' do
        before do
          stub_request(:get, url).to_raise(SocketError)
        end

        it 'does not raise errors and returns nils as default result' do
          expect { subject }.not_to raise_error
          expect(subject).to eq expected_page_attributes
        end
      end
    end
  end
end
