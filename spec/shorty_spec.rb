require 'spec_helper'
require 'zlib'
require 'shorty'

RSpec.describe Shorty do
  subject(:app)       { Shorty.new }
  let(:test_url)      { "http://bestgifs.com/ever" }
  let(:shortened_url) { Zlib.adler32(test_url).to_s(26) }

  context 'POST' do
    before do
      post '/', url: test_url
    end

    it "stores a url and responds with 201" do
      expect(last_response).to be_created
    end

    it "returns the shortened url" do
      expect(last_response.body).to include(shortened_url)
    end
  end

  context 'GET' do
    before do
      post '/', url: test_url
    end

    it "redirects to a previously shortened url" do
      get "/#{shortened_url}"
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eq(test_url)
    end

    it "unknown urls get 404" do
      get "/dragons"
      expect(last_response).to be_not_found
    end
  end
end
