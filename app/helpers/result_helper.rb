# -*- encoding : utf-8 -*-
module ResultHelper

    def recalculate_all_results
    ActiveRecord::Base.transaction do
      RES_LOG.info "Clearing old results"
      results.destroy_all
      games.reload

      @progress_helper = {}

      games.each do |game|
        white_result = Result.find_or_create_by(tournament_id: id, player_id: game.white_player.id)
        black_result = Result.find_or_create_by(tournament_id: id, player_id: game.black_player.id)
        update_results(white_result, black_result, game.result)
      end

      @bucholtz_helper = {}

      games.each do |game|
        white_result = Result.find_or_create_by(tournament_id: id, player_id: game.white_player.id)
        black_result = Result.find_or_create_by(tournament_id: id, player_id: game.black_player.id)
        @bucholtz_helper[white_result.id.to_s.to_sym] = {} unless @bucholtz_helper[white_result.id.to_s.to_sym]
        @bucholtz_helper[black_result.id.to_s.to_sym] = {} unless @bucholtz_helper[black_result.id.to_s.to_sym]
        update_bucholtz(white_result, black_result)
        update_berger(white_result, black_result, game.result)
      end

      results.each do |result|
        res_sym = result.id.to_s.to_sym
        RES_LOG.info result.player.name
        RES_LOG.info @bucholtz_helper[res_sym]
        result.mini_bucholtz = result.bucholtz
        result.mini_bucholtz -= @bucholtz_helper[res_sym][:min_bucholtz] if @bucholtz_helper[res_sym][:min_bucholtz]
        result.mini_bucholtz -= @bucholtz_helper[res_sym][:max_bucholtz] if @bucholtz_helper[res_sym][:max_bucholtz]
        result.mini_bucholtz = 0 if result.mini_bucholtz < 0
        result.progress = @progress_helper[res_sym]
        result.save
      end
    end
  end

  def update_results(white_result, black_result, game_result)
    RES_LOG.info "Upgrading results: #{white_result.inspect} #{black_result.inspect} #{game_result}"
    if game_result == 1 ## 1-0
      RES_LOG.info "White has won the game"
      update_player_result(white_result, 1)
      update_player_result(black_result, 0)
    elsif game_result == 3 ## 0-1
      RES_LOG.info "Black has won the game"
      update_player_result(white_result, 0)
      update_player_result(black_result, 1)
    elsif game_result == 2 ## 1/2
      RES_LOG.info "Draw achieved"
      update_player_result(white_result, 0.5)
      update_player_result(black_result, 0.5)
    elsif game_result == 4 ## still in play
      RES_LOG.info "Game still played"
    end
  end

  def update_bucholtz(white_result, black_result)
    update_bucholtz_result(white_result, black_result.points)
    update_bucholtz_result(black_result, white_result.points)
  end

  def update_berger(white_result, black_result, game_result)
    if game_result == 1 ## 1-0
      RES_LOG.info "White has won the game"
      update_berger_result(white_result, black_result.points)
    elsif game_result == 3 ## 0-1
      RES_LOG.info "Black has won the game"
      update_berger_result(black_result, white_result.points)
    elsif game_result == 2 ## 1/2
      RES_LOG.info "Draw achieved"
      update_berger_result(white_result, (black_result.points/2.0))
      update_berger_result(black_result, (white_result.points/2.0))
    end
  end

  def update_player_result(result, points)
    @progress_helper[result.id.to_s.to_sym] = @progress_helper[result.id.to_s.to_sym].to_f + result.points + points
    result.games_count += 1
    result.points += points
    result.save
    RES_LOG.info "Player with id: #{result.player_id} has #{result.points} points"
  end

  def update_bucholtz_result(result, points)
    result_sym = result.id.to_s.to_sym

    RES_LOG.info "Old: #{@bucholtz_helper[result_sym][:min_bucholtz]}, new: #{points}"
    RES_LOG.info "Old maz: #{@bucholtz_helper[result_sym][:max_bucholtz]}, new: #{points}"
    if @bucholtz_helper[result_sym][:min_bucholtz].nil?
      @bucholtz_helper[result_sym][:min_bucholtz] = points
    else
      @bucholtz_helper[result_sym][:min_bucholtz] = [@bucholtz_helper[result_sym][:min_bucholtz], points].min
    end

    if @bucholtz_helper[result_sym][:max_bucholtz].nil?
      @bucholtz_helper[result_sym][:max_bucholtz] = points
    else
      @bucholtz_helper[result_sym][:max_bucholtz] = [@bucholtz_helper[result_sym][:max_bucholtz], points].max
    end

    result.bucholtz += points
    result.save
  end

  def update_berger_result(result, points)
    RES_LOG.info "BERGER"
    result.berger += points
    result.save
  end

end
