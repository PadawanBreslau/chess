class CommentariesController < InheritedResources::Base
  load_and_authorize_resource param_method: :permitted_params
  actions :all, except: []
  FIELDS = [:comment, :type, :site_user_id, :chess_move_id]

  def create
    commentary = Commentary.create(permitted_params["commentary"])
    redirect_to commentary.chess_move.chess_game
  end

private

  def permitted_params
    params.permit(commentary: FIELDS)
  end

end
