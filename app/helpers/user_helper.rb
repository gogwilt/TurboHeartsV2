module UserHelper
  def share_rounds_together?(player1, player2)
    not (player1.rounds.all & player2.rounds.all).empty?
  end
end
