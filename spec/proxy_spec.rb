require File.dirname(__FILE__) + '/spec_helper'

describe "Warden::Reliefwatch::Oauth::Proxy" do
  before(:all) do
    sha = Digest::SHA1.hexdigest(Time.now.to_s)
    @proxy =  Warden::Reliefwatch::Oauth::Proxy.new(sha[0..19], sha[0..39],
                                               'public',
                                               'http://localhost:3000',
                                               'http://example.org/auth/github/callback')
  end

  it "returns an authorize url" do
    uri = Addressable::URI.parse(@proxy.authorize_url)

    uri.scheme.should eql('http')
    uri.host.should eql('localhost')

    params = uri.query_values
    params['response_type'].should eql('code')
    params['scope'].should eql('public')
    params['client_id'].should match(/\w{20}/)
    params['redirect_uri'].should eql('http://example.org/auth/github/callback')
  end

  it "has a client object" do
    @proxy.client.should_not be_nil
  end

  # it "returns access tokens" do
  #  lambda { @proxy.access_token_for(/\w{20}/.gen) }.should_not raise_error  
  # end
end
