class StocksController < ApplicationController
  ALERT_CHAR_COUNT = "Stock symbols must be five or fewer characters"
  ALERT_VALID_SYMBOL = "Please enter a valid symbol to search"
  ALERT_EMPTY_SEARCH = "Please enter a symbol to search"

  def search
    if params[:stock].present? && params[:stock].length < 6
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        js_response(nil)
      else
        js_response(ALERT_VALID_SYMBOL)
      end
    elsif params[:stock].present? && params[:stock].length > 5
      js_response(ALERT_CHAR_COUNT)
    else
      js_response(ALERT_EMPTY_SEARCH)
    end
  end

  private

  def js_response (alert)
    flash.now[:alert] = alert unless alert.nil?
    respond_to do |format|
      format.js { render partial: 'users/stock_result' }
    end
  end
end