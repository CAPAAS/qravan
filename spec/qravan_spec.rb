# frozen_string_literal: true

RSpec.describe Qravan do
  it "has a version number" do
    expect(Qravan::VERSION).not_to be nil
  end

  it "testable" do
    expect(true).to eq(true)
  end
end
