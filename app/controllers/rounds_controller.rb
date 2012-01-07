class RoundsController < ApplicationController
  def destroy
    @round = Round.find(params[:id])
    @round.points.each {|p| p.destroy }
    @round.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { head :ok }
    end
  end
end
