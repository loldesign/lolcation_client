require "spec_helper"

RSpec.describe lolcation_client do
  it "has a version number" do
    expect(LolcationClient::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
