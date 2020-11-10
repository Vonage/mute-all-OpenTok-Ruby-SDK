require "opentok/opentok"
require "opentok/version"
require "opentok/force_mute"
require "spec_helper"

describe OpenTok::ForceMute do
  before(:each) do
    now = Time.parse("2017-04-18 20:17:40 +1000")
    allow(Time).to receive(:now) { now }
  end

  let(:api_key) { "123456" }
  let(:api_secret) { "1234567890abcdef1234567890abcdef1234567890" }
  let(:session_id) { "SESSIONID" }
  let(:stream_id) { "STREAMID" }
  let(:excluded_steam_ids) { ["1","2"] }
  let(:opentok) { OpenTok::OpenTok.new api_key, api_secret }
  let(:force_mute) { opentok.force_mute }

  subject { force_mute }


  it 'raise an error on nil session_id forceMute' do
    expect {
      force_mute.forceMute(nil,stream_id)
    }.to raise_error(ArgumentError)
  end

  it 'raise an error on nil session_id forceMuteAll' do
    expect {
      force_mute.forceMuteAll(nil,excluded_steam_ids)
    }.to raise_error(ArgumentError)
  end

  it 'raise an error on nil stream_id' do
    expect {
      force_mute.forceMute(session_id,nil)
    }.to raise_error(ArgumentError)
  end

  it "forces a mute stream Id", :vcr => { :erb => { :version => OpenTok::VERSION + "-Ruby-Version-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"} } do
    response = force_mute.forceMute(session_id, stream_id)
    expect(response).not_to be_nil
  end

  it "forces a mute all but excluded streams", :vcr => { :erb => { :version => OpenTok::VERSION + "-Ruby-Version-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"} } do
    response = force_mute.forceMuteAll(session_id, excluded_steam_ids)
    expect(response).not_to be_nil
  end

  it "forces a mute all", :vcr => { :erb => { :version => OpenTok::VERSION + "-Ruby-Version-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"} } do
    response = force_mute.forceMuteAll(session_id, nil)
    expect(response).not_to be_nil
  end
end