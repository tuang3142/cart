require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:order) { create(:order) }

  describe "received" do
    let(:mail) { OrderMailer.received(order) }

    it "renders the headers" do
      expect(mail.subject).to eq("Pragmatic Store Order Confirmation")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq(["depot@example.com"])
    end
  end

  describe "shipped" do
    let(:mail) { OrderMailer.shipped(order) }

    it "renders the headers" do
      expect(mail.subject).to eq("Pragmatic Store Order Shipped")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq(["depot@example.com"])
    end
  end
end
