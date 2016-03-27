require 'spec_helper'

RSpec.describe UrlMetaData::Fetcher do
  let(:url) { url = 'http://www.google.com' }
  subject(:fetcher) { described_class.fetch(url) }

  example do
    expect { subject }.not_to raise_error
    expect { described_class.new(url) }.to raise_error NoMethodError
  end
end
