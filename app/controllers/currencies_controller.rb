class CurrenciesController < ApplicationController

  # this would be an environment variable in production
  API_KEY = 'uKcDggCRc4LOF6J5lAfKBqBBUu8GQdRt'

  def currency_by_date
    # takes a date string, currency code string, and array of currency codes as strings
    # currency code (base) is required
    # array of currency codes is required (at least 1)

    if currency_params[:date] && currency_params[:base] && currency_params[:symbols]
      url = "https://api.apilayer.com/exchangerates_data/#{currency_params[:date]}?symbols=#{currency_params[:symbols]}&base=#{currency_params[:base]}"

      response = HTTParty.get(url, headers: {
        "Accept" => "application/json",
        "apikey" => API_KEY
      })

    end

    render json: response["rates"]

    # https://api.apilayer.com/exchangerates_data/2022-01-12?symbols=JPY,EUR&base=USD

  # }
  #   "rates": {
  #       "JPY": 114.677987,
  #       "EUR": 0.874105
  #   }
  # }
  end

  private

  def currency_params
    params.permit(:date, :base, :symbols)
  end
end
