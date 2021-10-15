class UsersController < ApplicationController
  ALERT_VALID_FRIEND = "Friend not found"
  ALERT_EMPTY_SEARCH = "Please enter a name or email to search"

  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        js_response(nil)
      else
        js_response(ALERT_VALID_FRIEND)
      end
    else
      js_response(ALERT_EMPTY_SEARCH)
    end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  private

  def js_response (alert)
    flash.now[:alert] = alert unless alert.nil?
    respond_to do |format|
      format.js { render partial: 'users/friend_result' }
    end
  end

end
