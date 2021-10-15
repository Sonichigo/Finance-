class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  validates :ticker, uniqueness: true
  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable_access_key],
      secret_token: Rails.application.credentials.iex[:secret_access_key],
      endpoint: Rails.application.credentials.iex[:endpoint]
    )
    begin
      new(ticker: ticker_symbol, 
          name: client.company(ticker_symbol).company_name, 
          last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
