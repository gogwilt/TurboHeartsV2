class PagesController < ApplicationController
  def home
    @do_not_show_banner = true
    if current_user
      redirect_to dashboard_path
    end
  end

  def learn_turbohearts
  end

end
