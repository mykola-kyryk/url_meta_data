require 'spec_helper'

RSpec.describe UrlMetaData::Parser do
  let(:html_document) do
    [
      '<html><head>',
      document_title_tag,
      meta_keywords_tag,
      meta_description_tag,
      '</head><body></body></html>',
    ].join
  end
  let(:document_title_content) { 'Test title' }
  let(:document_title_tag) { "<title>#{document_title_content}</title>" }
  let(:meta_keywords_content) { 'keyword1, keyword2' }
  let(:meta_keywords_tag) { "<meta name='keywords' content='#{meta_keywords_content}' />" }
  let(:meta_description_content) { 'Test meta description' }
  let(:meta_description_tag) { "<meta name='description' content='#{meta_description_content}' />" }

  subject { described_class.parse(html_document) }

  example do
    expect { subject }.not_to raise_error
  end

  it 'parses page meta data' do
    expect(subject[:title]).to eq document_title_content
    expect(subject[:keywords]).to eq meta_keywords_content
    expect(subject[:description]).to eq meta_description_content
  end

  context 'source attributes are not set' do
    let(:document_title_tag) { '' }
    let(:meta_keywords_tag) { '' }
    let(:meta_description_tag) { '' }

    it 'returns nil for all result attributes' do
      expect(subject[:title]).to be_nil
      expect(subject[:keywords]).to be_nil
      expect(subject[:description]).to be_nil
    end
  end

  context 'document is empty' do
    let(:html_document) { '' }

    it 'returns nil for all result attributes' do
      expect(subject[:title]).to be_nil
      expect(subject[:keywords]).to be_nil
      expect(subject[:description]).to be_nil
    end
  end
end
