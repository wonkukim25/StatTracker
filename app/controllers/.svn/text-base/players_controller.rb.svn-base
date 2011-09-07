class PlayersController < ApplicationController
autocomplete :player, :name, :full => true
  def index
    #@players = Player.all
  end

  def show
    @player = Player.find(params[:id])
	@position = FieldingStat.where("player_id = ?", @player.id).sort_by{|s| s.games}.last.position
	if @player.final_game.nil?
    @google_image = GoogleImage.all(@player.name+" rotoworld headshot", 0).first
	else
    query = "\"#{@player.name}\" baseball player portait"
    #throw query
	@google_image = GoogleImage.all(query, 0).first
  puts query
	end
    @batting_stats=BattingStat.find(:all, :conditions => ['player_id = ?', params[:id]])
    @chart = GoogleVisualr::Table.new
		@chart.add_column('string' , 'Year')
		@chart.add_column('string' , 'Age')
		@chart.add_column('string' , 'Team')
		@chart.add_column('number' , 'G')
		@chart.add_column('number' , 'PA')
    @chart.add_column('number' , 'AB')
    @chart.add_column('number' , 'R')
    @chart.add_column('number' , 'H')
    @chart.add_column('number' , '2B')
    @chart.add_column('number' , '3B')
    @chart.add_column('number' , 'HR')
    @chart.add_column('number' , 'RBI')
    @chart.add_column('number' , 'TB')
	@chart.add_column('number' , 'SB')
    @chart.add_column('number' , 'CS')
    @chart.add_column('number' , 'BB')
    @chart.add_column('number' , 'K')
    @chart.add_column('string' , 'BA')
    @chart.add_column('string' , 'SLG')
    @chart.add_column('string' , 'OBP')
    @chart.add_column('string' , 'OPS')
	 count = 0
	@batting_stats.each { |b|
		if b.games_batting == 0
		else
			count+=1
		end
	}
    @chart.add_rows(count+1)
    i=0
	  games="\"Games\""
		runs="\"Runs\""
		bats="\"At Bats\""
		plates="\"Plate Appearances\""
		hits="\"Hits\""
		doubles="\"Doubles\""
		triples="\"Triples\""
		home="\"Home Runs\""
		rbi="\"RBI\""
		stolen="\"Stolen Bases\""
		caught="\"Caught Stealing\""
		walks="\"Walks\""
		strikes="\"Strikeouts\""
		bases="\"Total Bases\""
		totalgames="\"Total Games\""
		totalruns="\"Total Runs\""
		totalbats="\"Total At Bats\""
		totalplates="\"Total Plate Appearances\""
		totalhits="\"Total Hits\""
		totaldoubles="\"Total Doubles\""
		totaltriples="\"Total Triples\""
		totalhome="\"Total Home Runs\""
		totalrbi="\"Total RBI\""
		totalstolen="\"Total Stolen Bases\""
		totalcaught="\"Total Caught Stealing\""
		totalwalks="\"Total Walks\""
		totalstrikes="\"Total Strikeouts\""
    @batting_stats.each { |b|
		
	if b.games_batting == 0
	
	else
		@chart.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
		@chart.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
		@chart.set_cell(i, 2, "<span title='Team'><a href='/teams/#{b.team.id}'>#{b.team.name}</a></span>")
		@chart.set_cell(i, 3, b.games, "<span title=#{games}>#{b.games.to_s}</span>")
		@chart.set_cell(i, 4, b.plate_appearances, "<span title=#{plates}>#{b.plate_appearances.to_s}</span>")
		  @chart.set_cell(i, 5, b.at_bats, "<span title=#{bats}>#{b.at_bats.to_s}</span>")
		  @chart.set_cell(i, 6, b.runs, "<span title=#{runs}>#{b.runs.to_s}</span>")
		  @chart.set_cell(i, 7, b.hits, "<span title=#{hits}>#{b.hits.to_s}</span>")
		@chart.set_cell(i, 8, b.doubles, "<span title=#{doubles}>#{b.doubles.to_s}</span>")
		@chart.set_cell(i, 9, b.triples, "<span title=#{triples}>#{b.triples.to_s}</span>")
		@chart.set_cell(i, 10, b.home_runs, "<span title=#{home}>#{b.home_runs.to_s}</span>")
		@chart.set_cell(i, 11, b.rbi, "<span title=#{rbi}>#{b.rbi.to_s}</span>")
		@chart.set_cell(i, 12, b.total_bases, "<span title=#{bases}>#{b.total_bases.to_s}</span>")
		@chart.set_cell(i, 13, b.stolen_bases, "<span title=#{stolen}>#{b.stolen_bases.to_s}</span>")
		@chart.set_cell(i, 14, b.caught_stealing, "<span title=#{caught}>#{b.caught_stealing.to_s}</span>")
		@chart.set_cell(i, 15, b.walks, "<span title=#{walks}>#{b.walks.to_s}</span>")
		@chart.set_cell(i, 16, b.strikeouts, "<span title=#{strikes}>#{b.strikeouts.to_s}</span>")
		@chart.set_cell(i, 17, "<span title='Batting Average'>#{b.batting_average.to_s}</span>")
		@chart.set_cell(i, 18, "<span title='Slugging Percentage'>#{b.slugging_percentage.to_s}</span>")
		@chart.set_cell(i, 19, "<span title='On Base Percentage'>#{b.on_base_percentage.to_s}</span>")
		@chart.set_cell(i, 20, "<span title='On Base+Slugging'>#{b.on_base_plus_slugging.to_s}</span>")
		i += 1
	end
	}
    numbergames=BattingStat.get_stat_total(params[:id], :games)
    numberruns=BattingStat.get_stat_total(params[:id], :runs)
    numberdoubles=BattingStat.get_stat_total(params[:id], :doubles)
    numbertriples=BattingStat.get_stat_total(params[:id], :triples)
    numberrbi=BattingStat.get_stat_total(params[:id], :rbi)
		 @chart.set_cell(i, 0, "Totals")
		 @chart.set_cell(i, 3, numbergames.to_i, "<span title=#{totalgames}>#{numbergames}</span>")
		 @chart.set_cell(i, 4, @player.career_plate_appearances, "<span title=#{totalplates}>#{@player.career_plate_appearances}</span>")
		   @chart.set_cell(i, 5, @player.career_at_bats, "<span title=#{totalbats}>#{@player.career_at_bats}</span>")
		   @chart.set_cell(i, 6, numberruns.to_i, "<span title=#{totalruns}>#{numberruns}</span>")
		   @chart.set_cell(i, 7, @player.career_hits, "<span title=#{totalhits}>#{@player.career_hits}</span>")
		 @chart.set_cell(i, 8, numberdoubles.to_i, "<span title=#{totaldoubles}>#{numberdoubles}</span>")
		 @chart.set_cell(i, 9, numbertriples.to_i, "<span title=#{totaltriples}>#{numbertriples}</span>")
		 @chart.set_cell(i, 10, @player.career_home_runs, "<span title=#{totalhome}>#{@player.career_home_runs}</span>")
		 @chart.set_cell(i, 11, numberrbi.to_i, "<span title=#{totalrbi}>#{numberrbi}</span>")
		 @chart.set_cell(i, 12,  @player.career_total_bases.to_i, "<span title=#{bases}>#{@player.career_total_bases}</span>")
		 @chart.set_cell(i, 13, @player.career_stolen_bases, "<span title=#{totalstolen}>#{@player.career_stolen_bases}</span>")
		 @chart.set_cell(i, 14, @player.career_caught_stealing, "<span title=#{totalcaught}>#{@player.career_caught_stealing}</span>")
		 @chart.set_cell(i, 15, @player.career_walks, "<span title=#{totalwalks}>#{@player.career_walks}</span>")
		 @chart.set_cell(i, 16, @player.career_strikeouts, "<span title=#{totalstrikes}>#{@player.career_strikeouts}</span>")
		 @chart.set_cell(i, 17, "<span title='Batting Average'>#{@player.career_batting_average}</span>")
		 @chart.set_cell(i, 18, "<span title='Slugging Percentage'>#{@player.career_slugging_percentage}</span>")
		 @chart.set_cell(i, 19,  "<span title='On Base Percentage'>#{@player.career_on_base_percentage}</span>")
		 @chart.set_cell(i, 20,  "<span title='On Base Plus Slugging'>#{@player.career_on_base_plus_slugging}</span>")
		options = { :width => '100%', :allowHtml =>true}
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
   @batting_stats_post=BattingPostStat.find(:all, :conditions => ['player_id = ?', params[:id]])
    @chart2 = GoogleVisualr::Table.new
		@chart2.add_column('string' , 'Year')
		@chart2.add_column('string' , 'Age')
		@chart2.add_column('string' , 'Team')
    @chart2.add_column('string' , 'Round')
		@chart2.add_column('number' , 'G')
		@chart2.add_column('number' , 'PA')
    @chart2.add_column('number' , 'AB')
    @chart2.add_column('number' , 'R')
    @chart2.add_column('number' , 'H')
    @chart2.add_column('number' , '2B')
    @chart2.add_column('number' , '3B')
    @chart2.add_column('number' , 'HR')
    @chart2.add_column('number' , 'RBI')
    @chart2.add_column('number' , 'TB')
	@chart2.add_column('number' , 'SB')
    @chart2.add_column('number' , 'CS')
    @chart2.add_column('number' , 'BB')
    @chart2.add_column('number' , 'K')
    @chart2.add_column('string' , 'BA')
    @chart2.add_column('string' , 'SLG')
    @chart2.add_column('string' , 'OBP')
    @chart2.add_column('string' , 'OPS')
    @chart2.add_rows(@batting_stats_post.size+1)
    i=0
    @batting_stats_post.each { |b|
		i = @batting_stats_post.index(b)
		@chart2.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
		@chart2.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
		@chart2.set_cell(i, 2, "<span title='Team'><a href='/teams/#{b.team.id}'>#{b.team.name}</a></span>")
		@chart2.set_cell(i, 3, "<span title='Round'>#{b.round.to_s[0,4]}</span>")
		@chart2.set_cell(i, 4, b.games, "<span title=#{games}>#{b.games.to_s}</span>")
		@chart2.set_cell(i, 5, b.plate_appearances, "<span title=#{plates}>#{b.plate_appearances.to_s}</span>")
		@chart2.set_cell(i, 6, b.at_bats, "<span title=#{bats}>#{b.at_bats.to_s}</span>")
		@chart2.set_cell(i, 7, b.runs, "<span title=#{runs}>#{b.runs.to_s}</span>")
		@chart2.set_cell(i, 8, b.hits, "<span title=#{hits}>#{b.hits.to_s}</span>")
		@chart2.set_cell(i, 9, b.doubles, "<span title=#{doubles}>#{b.doubles.to_s}</span>")
		@chart2.set_cell(i, 10, b.triples, "<span title=#{triples}>#{b.triples.to_s}</span>")
		@chart2.set_cell(i, 11, b.home_runs, "<span title=#{home}>#{b.home_runs.to_s}</span>")
		@chart2.set_cell(i, 12, b.rbi, "<span title=#{rbi}>#{b.rbi.to_s}</span>")
		@chart2.set_cell(i, 13, b.total_bases, "<span title=#{bases}>#{b.total_bases.to_s}</span>")
		@chart2.set_cell(i, 14, b.stolen_bases, "<span title=#{stolen}>#{b.stolen_bases.to_s}</span>")
		@chart2.set_cell(i, 15, b.caught_stealing, "<span title=#{caught}>#{b.caught_stealing.to_s}</span>")
		@chart2.set_cell(i, 16, b.walks, "<span title=#{walks}>#{b.walks.to_s}</span>")
		@chart2.set_cell(i, 17, b.strikeouts, "<span title=#{strikes}>#{b.strikeouts.to_s}</span>")
		@chart2.set_cell(i, 18, "<span title='Batting Average'>#{b.batting_average.to_s}</span>")
		@chart2.set_cell(i, 19, "<span title='Slugging Percentage'>#{b.slugging_percentage.to_s}</span>")
		@chart2.set_cell(i, 20, "<span title='On Base Percentage'>#{b.on_base_percentage.to_s}</span>")
		@chart2.set_cell(i, 21, "<span title='On Base+Slugging'>#{b.on_base_plus_slugging.to_s}</span>")
		}
		i += 1
    numbergames=BattingPostStat.get_stat_total(params[:id], :games)
    numberruns=BattingPostStat.get_stat_total(params[:id], :runs)
    numberdoubles=BattingPostStat.get_stat_total(params[:id], :doubles)
    numbertriples=BattingPostStat.get_stat_total(params[:id], :triples)
    numberrbi=BattingPostStat.get_stat_total(params[:id], :rbi)
    @chart2.set_cell(i, 0, "Totals")
    @chart2.set_cell(i, 4, numbergames.to_i, "<span title=#{totalgames}>#{numbergames}</span>")
		 @chart2.set_cell(i, 5, @player.career_plate_appearances_post, "<span title=#{totalplates}>#{@player.career_plate_appearances_post}</span>")
		 @chart2.set_cell(i, 6, @player.career_at_bats_post, "<span title=#{totalbats}>#{@player.career_at_bats_post}</span>")
		 @chart2.set_cell(i, 7, numberruns.to_i, "<span title=#{totalruns}>#{numberruns}</span>")
		 @chart2.set_cell(i, 8, @player.career_hits_post, "<span title=#{totalhits}>#{@player.career_hits_post}</span>")
		 @chart2.set_cell(i, 9, numberdoubles.to_i, "<span title=#{totaldoubles}>#{numberdoubles}</span>")
		 @chart2.set_cell(i, 10, numbertriples.to_i, "<span title=#{totaltriples}>#{numbertriples}</span>")
		 @chart2.set_cell(i, 11, @player.career_home_runs_post, "<span title=#{totalhome}>#{@player.career_home_runs_post}</span>")
		 @chart2.set_cell(i, 12, numberrbi.to_i, "<span title=#{totalrbi}>#{numberrbi}</span>")
		 @chart2.set_cell(i, 13,  @player.career_total_bases_post, "<span title=#{bases}>#{@player.career_total_bases_post}</span>")
		 @chart2.set_cell(i, 14, @player.career_stolen_bases_post, "<span title=#{totalstolen}>#{@player.career_stolen_bases_post}</span>")
		 @chart2.set_cell(i, 15, @player.career_caught_stealing_post, "<span title=#{totalcaught}>#{@player.career_caught_stealing_post}</span>")
		 @chart2.set_cell(i, 16, @player.career_walks_post, "<span title=#{totalwalks}>#{@player.career_walks_post}</span>")
		 @chart2.set_cell(i, 17, @player.career_strikeouts_post, "<span title=#{totalstrikes}>#{@player.career_strikeouts_post}</span>")
		 @chart2.set_cell(i, 18, "<span title='Batting Average'>#{@player.career_post_batting_average}</span>")
		 @chart2.set_cell(i, 19, "<span title='Slugging Percentage'>#{@player.career_post_slugging_percentage}</span>") 
		 @chart2.set_cell(i, 20,  "<span title='On Base Percentage'>#{@player.career_post_on_base_percentage}</span>")
		 @chart2.set_cell(i, 21,  "<span title='On Base Plus Slugging'>#{@player.career_post_on_base_plus_slugging}</span>")
  options = { :width => '100%', :allowHtml =>true }
  options.each_pair do | key, value |
    @chart2.send "#{key}=", value
  end
@pitching_stats=PitchingStat.find(:all, :conditions => ['player_id = ?', params[:id]])
    @chart3 = GoogleVisualr::Table.new
    @chart3.add_column('string' , 'Year')
	@chart3.add_column('string' , 'Age')
	@chart3.add_column('string' , 'Team')
	@chart3.add_column('number' , 'W')
	@chart3.add_column('number' , 'L')
	@chart3.add_column('string' , 'WL%')
    @chart3.add_column('string' , 'ERA')
	@chart3.add_column('number' , 'G')
	@chart3.add_column('number' , 'GS')
    @chart3.add_column('string' , 'GF')
    @chart3.add_column('number' , 'CG')
    @chart3.add_column('number' , 'SHO')
    @chart3.add_column('number' , 'SV')
    @chart3.add_column('string' , 'IP')
    @chart3.add_column('number' , 'H')
    @chart3.add_column('number' , 'R')
    @chart3.add_column('number' , 'ER')
    @chart3.add_column('number' , 'HR')
    @chart3.add_column('number', 'BB')
    @chart3.add_column('number' , 'IBB')
    @chart3.add_column('number' , 'K')
    @chart3.add_column('number' , 'HBP')
    @chart3.add_column('number' , 'BK')
    @chart3.add_column('number' , 'WP')
    @chart3.add_column('number' , 'BF')
    @chart3.add_column('string' , 'WHIP')
    @chart3.add_column('string' , 'H/9')
    @chart3.add_column('string' , 'HR/9')
    @chart3.add_column('string' , 'BB/9')
    @chart3.add_column('string' , 'K/9')
    @chart3.add_column('string' , 'K/BB')
    @chart3.add_rows(@pitching_stats.size+1)
	    wins="\"Wins \""
      losses="\"Losses\""
      games="\"Games\""
	    started="\"Games Started\""
      finished="\"Games Finished\""
      complete="\"Complete Games\""
      shutouts="\"Shutouts\""
      saves="\"Saves\""
      hits="\"Hits Allowed\""
      runs="\"Runs Alowed\""
	    earned="\"Earned Runs\""
      home="\"Home Runs Allowed\""
      walks="\"Walks\""
      intentional="\"Intentional Walks\""
      strikes="\"Strikeouts\""
      hitbypitch="\"Hit by Pitch\""
	    balks="\"Balks\""
      wild="\"Wild Pitches\""
      batters="\"Batters Faced\""
      totalwins="\"Total Wins\""
      totallosses="\"Total Losses\""
      totalgames="\"Total Games\""
	    totalstarted="\"Total Games Started\""
      totalfinished="\"Total Games Finished\""
      totalcomplete="\"Total Complete Games\""
      totalshutouts="\"Total Shutouts\""
      totalsaves="\"Total Saves\""
      totalhits="\"Total Hits Allowed\""
      totalruns="\"Total Runs Allowed\""
	    totalearned="\"Total Earned Runs\""
      totalhome="\"Total Home Runs Allowed\""
      totalwalks="\"Total Walks\""
      totalintentional="\"Total Intentional Walks\""
      totalstrikes="\"Total Strikeouts\""
      totalhitbypitch="\"Total Hit by Pitch\""
	    totalbalks="\"Total Balks\""
      totalwild="\"Total Wild Pitches\""
      totalbatters="\"Total Batters Faced\""
@pitching_stats.each { |b|
			i = @pitching_stats.index(b)
			@chart3.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
      @chart3.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
      @chart3.set_cell(i, 2, "<span title='Team'>#{"<a href='/teams/#{b.team.id}'>#{b.team.name}</a>"}</span>")
			@chart3.set_cell(i, 3, b.wins, "<span title=#{wins}>#{b.wins.to_s}</span>")
      @chart3.set_cell(i, 4, b.losses, "<span title=#{losses}>#{b.losses.to_s}</span>")
      @chart3.set_cell(i, 5, "<span title='Win Loss Percentage'>#{b.win_loss_percentage.to_s}</span>" )
      @chart3.set_cell(i, 6, "<span title='ERA'>#{b.era.to_s}</span>" )
      @chart3.set_cell(i, 7, b.games, "<span title=#{games}>#{b.games.to_s}</span>" )
      @chart3.set_cell(i, 8, b.games_started, "<span title=#{started}>#{b.games_started.to_s}</span>" )
      @chart3.set_cell(i, 9,  "<span title=#{finished}'>#{b.games_finished.to_s}</span>" )
      @chart3.set_cell(i, 10, b.complete_games, "<span title=#{complete}>#{b.complete_games.to_s}</span>" )
      @chart3.set_cell(i, 11, b.shutouts, "<span title=#{shutouts}>#{b.shutouts.to_s}</span>")
      @chart3.set_cell(i, 12, b.saves, "<span title=#{saves}>#{b.saves.to_s}</span>" )
      @chart3.set_cell(i, 13, "<span title='Innings Pitched'>#{b.innings_pitched_display.to_s}</span>" )
      @chart3.set_cell(i, 14, b.hits, "<span title=#{hits}>#{b.hits.to_s}</span>" )
      @chart3.set_cell(i, 15, b.runs, "<span title=#{runs}>#{b.runs.to_s}</span>" )
      @chart3.set_cell(i, 16, b.earned_runs, "<span title=#{earned}>#{b.earned_runs.to_s}</span>")
      @chart3.set_cell(i, 17, b.home_runs, "<span title=#{home}>#{b.home_runs.to_s}</span>")
      @chart3.set_cell(i, 18, b.walks, "<span title=#{walks}>#{b.walks.to_s}</span>")
      @chart3.set_cell(i, 19, b.intentional_walks, "<span title=#{intentional}>#{b.intentional_walks.to_s}</span>" )
      @chart3.set_cell(i, 20, b.strikeouts, "<span title=#{strikes}>#{b.strikeouts.to_s}</span>")
      @chart3.set_cell(i, 21, b.hit_by_pitch, "<span title=#{hitbypitch}>#{b.hit_by_pitch.to_s}</span>" )
      @chart3.set_cell(i, 22, b.balks, "<span title=#{balks}>#{b.balks.to_s}</span>" )
      @chart3.set_cell(i, 23, b.wild_pitches, "<span title=#{wild}>#{b.wild_pitches.to_s}</span>")
      @chart3.set_cell(i, 24, b.batters_faced,"<span title=#{batters}>#{b.batters_faced.to_s}</span>" )
      @chart3.set_cell(i, 25, "<span title='Walks and Hits per Innings Pitched'>#{b.walks_and_hits_innings_pitched.to_s}</span>" )
      @chart3.set_cell(i, 26, "<span title='Hits per 9 Innings'>#{b.hits_per_9_innings.to_s}</span>" )
      @chart3.set_cell(i, 27, "<span title='Home Runs per 9 Innings'>#{b.home_runs_per_9_innings.to_s}</span>" )
      @chart3.set_cell(i, 28, "<span title='Walks per 9 Innings'>#{b.walks_per_9_innings.to_s}</span>" )
      @chart3.set_cell(i, 29, "<span title='Strikeouts per 9 Innings'>#{b.strikeouts_per_9_innings.to_s}</span>" )
      @chart3.set_cell(i, 30, "<span title='Strikeouts per Walk'>#{b.strikeouts_per_walk.to_s}</span>" )
		}
    i+=1
     numbergames=PitchingStat.get_stat_total(params[:id], :games)
     numberstarted= PitchingStat.get_stat_total(params[:id], :games_started)
     numberfinished=PitchingStat.get_stat_total(params[:id], :games_finished)
     numbercomplete=PitchingStat.get_stat_total(params[:id], :complete_games)
     numbersaves=PitchingStat.get_stat_total(params[:id], :saves)
     numbershutouts=PitchingStat.get_stat_total(params[:id], :shutouts)
     numberintentional=PitchingStat.get_stat_total(params[:id], :intentional_walks)
     numberbalks=PitchingStat.get_stat_total(params[:id], :balks)
     numberwild=PitchingStat.get_stat_total(params[:id], :wild_pitches)
    @chart3.set_cell(i, 0, "Totals")
    @chart3.set_cell(i, 3,  @player.career_wins, "<span title=#{totalwins}>#{@player.career_wins}</span>")
    @chart3.set_cell(i, 4,  @player.career_losses, "<span title=#{totallosses}>#{@player.career_losses}</span>")
    @chart3.set_cell(i, 5, "<span title='Win Loss Percentage'>#{@player.career_win_loss_percentage}</span>")
    @chart3.set_cell(i, 6, "<span title='ERA'>#{@player.career_era}</span>")
    @chart3.set_cell(i, 7, numbergames.to_i, "<span title=#{totalgames}>#{numbergames}</span>")
    @chart3.set_cell(i, 8, numberstarted.to_i, "<span title=#{totalstarted}>#{numberstarted}</span>")
    @chart3.set_cell(i, 9, "<span title=#{totalfinished}>#{numberfinished}</span>")
    @chart3.set_cell(i, 10, numbercomplete.to_i, "<span title=#{totalcomplete}>#{numbercomplete}</span>")
    @chart3.set_cell(i, 11, numbershutouts.to_i, "<span title=#{totalshutouts}>#{numbershutouts}</span>")
    @chart3.set_cell(i, 12, numbersaves.to_i, "<span title=#{totalsaves}>#{numbersaves}</span>")
    @chart3.set_cell(i, 13, "<span title='Total Innings Pitched'>#{@player.career_innings_pitched_display}</span>")
    @chart3.set_cell(i, 14, @player.career_hits_allowed, "<span title=#{totalhits}>#{@player.career_hits_allowed}</span>")
    @chart3.set_cell(i, 15, @player.career_runs_allowed, "<span title=#{totalruns}>#{@player.career_runs_allowed}</span>")
    @chart3.set_cell(i, 16, @player.career_earned_runs, "<span title=#{totalearned}>#{@player.career_earned_runs}</span>")
    @chart3.set_cell(i, 17, @player.career_home_runs_allowed, "<span title=#{totalhome}>#{@player.career_home_runs_allowed}</span>")
    @chart3.set_cell(i, 18, @player.career_walks_allowed, "<span title=#{totalwalks}>#{@player.career_walks_allowed}</span>")
    @chart3.set_cell(i, 19, numberintentional.to_i, "<span title=#{totalintentional}>#{numberintentional}</span>")
    @chart3.set_cell(i, 20, @player.career_strikeouts_allowed, "<span title=#{totalstrikes}>#{@player.career_strikeouts_allowed}</span>")
    @chart3.set_cell(i, 21, @player.career_hit_by_pitches_allowed, "<span title=#{totalhitbypitch}>#{@player.career_hit_by_pitches_allowed}</span>")
    @chart3.set_cell(i, 22, numberbalks.to_i, "<span title=#{totalbalks}>#{numberbalks}</span>")
    @chart3.set_cell(i, 23, numberwild.to_i, "<span title=#{totalwild}>#{numberwild}</span>")
    @chart3.set_cell(i, 24, @player.career_batters_faced, "<span title=#{totalbatters}>#{@player.career_batters_faced}</span>")
	   @chart3.set_cell(i, 25, "<span title='Walks and Hits per Innings Pitched'>#{@player.career_walks_and_hits_innings_pitched}</span>" )
    @chart3.set_cell(i, 26, "<span title='Hits per 9 Innings'>#{@player.career_hits_per_9_innings}</span>" )
    @chart3.set_cell(i, 27, "<span title='Home Runs per 9 Innings'>#{@player.career_home_runs_per_9_innings}</span>" )
    @chart3.set_cell(i, 28, "<span title='Walks per 9 Innings'>#{@player.career_walks_per_9_innings}</span>" )
    @chart3.set_cell(i, 29, "<span title='Strikeouts per 9 Innings'>#{@player.career_strikeouts_per_9_innings}</span>" )
    @chart3.set_cell(i, 30, "<span title='Strikeouts per Walk'>#{@player.career_strikeouts_per_walk}</span>" )
  options = { :width => '100%', :allowHtml =>true }
  options.each_pair do | key, value |
    @chart3.send "#{key}=", value
  end
  @pitching_stats_post=PitchingPostStat.find(:all, :conditions => ['player_id = ?', params[:id]])
    @chart4 = GoogleVisualr::Table.new
    @chart4.add_column('string' , 'Year')
	@chart4.add_column('string' , 'Age')
	@chart4.add_column('string' , 'Team')
    @chart4.add_column('string' , 'Round')
	@chart4.add_column('number' , 'W')
	@chart4.add_column('number' , 'L')
	@chart4.add_column('string' , 'WL%')
    @chart4.add_column('string' , 'ERA')
	@chart4.add_column('number' , 'G')
	@chart4.add_column('number' , 'GS')
    @chart4.add_column('string' , 'GF')
    @chart4.add_column('number' , 'CG')
    @chart4.add_column('number' , 'SHO')
    @chart4.add_column('number' , 'SV')
    @chart4.add_column('string' , 'IP')
    @chart4.add_column('number' , 'H')
    @chart4.add_column('number' , 'R')
    @chart4.add_column('number' , 'ER')
    @chart4.add_column('number' , 'HR')
    @chart4.add_column('number', 'BB')
    @chart4.add_column('number' , 'IBB')
    @chart4.add_column('number' , 'K')
    @chart4.add_column('number' , 'HBP')
    @chart4.add_column('number' , 'BK')
    @chart4.add_column('number' , 'WP')
    @chart4.add_column('number' , 'BF')
    @chart4.add_column('string' , 'WHIP')
    @chart4.add_column('string' , 'H/9')
    @chart4.add_column('string' , 'HR/9')
    @chart4.add_column('string' , 'BB/9')
    @chart4.add_column('string' , 'K/9')
    @chart4.add_column('string' , 'K/BB')
    @chart4.add_rows(@pitching_stats_post.size+1)
    @pitching_stats_post.each { |b|
			i = @pitching_stats_post.index(b)
			@chart4.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
      @chart4.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
      @chart4.set_cell(i, 2, "<span title='Team'>#{"<a href='/teams/#{b.team.id}'>#{b.team.name}</a>"}</span>")
      @chart4.set_cell(i, 3, "<span title='Round'>#{b.round.to_s[0,4]}</span>")
	  @chart4.set_cell(i, 4, b.wins, "<span title=#{wins}>#{b.wins.to_s}</span>")
      @chart4.set_cell(i, 5, b.losses, "<span title=#{losses}>#{b.losses.to_s}</span>")
      @chart4.set_cell(i, 6, "<span title='Win Loss Percentage'>#{b.win_loss_percentage.to_s}</span>" )
      @chart4.set_cell(i, 7, "<span title='ERA'>#{b.era.to_s}</span>" )
      @chart4.set_cell(i, 8, b.games, "<span title=#{games}>#{b.games.to_s}</span>" )
      @chart4.set_cell(i, 9, b.games_started, "<span title=#{started}>#{b.games_started.to_s}</span>" )
      @chart4.set_cell(i, 10,  "<span title=#{finished}'>#{b.games_finished.to_s}</span>" )
      @chart4.set_cell(i, 11, b.complete_games, "<span title=#{complete}>#{b.complete_games.to_s}</span>" )
      @chart4.set_cell(i, 12, b.shutouts, "<span title=#{shutouts}>#{b.shutouts.to_s}</span>")
      @chart4.set_cell(i, 13, b.saves, "<span title=#{saves}>#{b.saves.to_s}</span>" )
      @chart4.set_cell(i, 14, "<span title='Innings Pitched'>#{b.innings_pitched_display.to_s}</span>" )
      @chart4.set_cell(i, 15, b.hits, "<span title=#{hits}>#{b.hits.to_s}</span>" )
      @chart4.set_cell(i, 16, b.runs, "<span title=#{runs}>#{b.runs.to_s}</span>" )
      @chart4.set_cell(i, 17, b.earned_runs, "<span title=#{earned}>#{b.earned_runs.to_s}</span>")
      @chart4.set_cell(i, 18, b.home_runs, "<span title=#{home}>#{b.home_runs.to_s}</span>")
      @chart4.set_cell(i, 19, b.walks, "<span title=#{walks}>#{b.walks.to_s}</span>")
      @chart4.set_cell(i, 20, b.intentional_walks, "<span title=#{intentional}>#{b.intentional_walks.to_s}</span>" )
      @chart4.set_cell(i, 21, b.strikeouts, "<span title=#{strikes}>#{b.strikeouts.to_s}</span>")
      @chart4.set_cell(i, 22, b.hit_by_pitch, "<span title=#{hitbypitch}>#{b.hit_by_pitch.to_s}</span>" )
      @chart4.set_cell(i, 23, b.balks, "<span title=#{balks}>#{b.balks.to_s}</span>" )
      @chart4.set_cell(i, 24, b.wild_pitches, "<span title=#{wild}>#{b.wild_pitches.to_s}</span>")
      @chart4.set_cell(i, 25, b.batters_faced,"<span title=#{batters}>#{b.batters_faced.to_s}</span>" )
      @chart4.set_cell(i, 26, "<span title='Walks and Hits per Innings Pitched'>#{b.walks_and_hits_innings_pitched.to_s}</span>" )
      @chart4.set_cell(i, 27, "<span title='Hits per 9 Innings'>#{b.hits_per_9_innings.to_s}</span>" )
      @chart4.set_cell(i, 28, "<span title='Home Runs per 9 Innings'>#{b.home_runs_per_9_innings.to_s}</span>" )
      @chart4.set_cell(i, 29, "<span title='Walks per 9 Innings'>#{b.walks_per_9_innings.to_s}</span>" )
      @chart4.set_cell(i, 30, "<span title='Strikeouts per 9 Innings'>#{b.strikeouts_per_9_innings.to_s}</span>" )
      @chart4.set_cell(i, 31, "<span title='Strikeouts per Walk'>#{b.strikeouts_per_walk.to_s}</span>" )
		}
    i+=1
     numbergames=PitchingPostStat.get_stat_total(params[:id], :games)
     numberstarted= PitchingPostStat.get_stat_total(params[:id], :games_started)
     numberfinished=PitchingPostStat.get_stat_total(params[:id], :games_finished)
     numbercomplete=PitchingPostStat.get_stat_total(params[:id], :complete_games)
     numbersaves=PitchingPostStat.get_stat_total(params[:id], :saves)
     numbershutouts=PitchingPostStat.get_stat_total(params[:id], :shutouts)
     numberintentional=PitchingPostStat.get_stat_total(params[:id], :intentional_walks)
     numberbalks=PitchingPostStat.get_stat_total(params[:id], :balks)
     numberwild=PitchingPostStat.get_stat_total(params[:id], :wild_pitches)
    @chart4.set_cell(i, 0, "Totals")
    @chart4.set_cell(i, 4,  @player.career_wins_post, "<span title=#{totalwins}>#{@player.career_wins_post}</span>")
    @chart4.set_cell(i, 5,  @player.career_losses_post, "<span title=#{totallosses}>#{@player.career_losses_post}</span>")
    @chart4.set_cell(i, 6, "<span title='Win Loss Percentage'>#{@player.career_post_win_loss_percentage}</span>")
    @chart4.set_cell(i, 7, "<span title='ERA'>#{@player.career_post_era}</span>")
    @chart4.set_cell(i, 8, numbergames.to_i, "<span title=#{totalgames}>#{numbergames}</span>")
    @chart4.set_cell(i, 9, numberstarted.to_i, "<span title=#{totalstarted}>#{numberstarted}</span>")
    @chart4.set_cell(i, 10, "<span title=#{totalfinished}>#{numberfinished}</span>")
    @chart4.set_cell(i, 11, numbercomplete.to_i, "<span title=#{totalcomplete}>#{numbercomplete}</span>")
    @chart4.set_cell(i, 12, numbershutouts.to_i, "<span title=#{totalshutouts}>#{numbershutouts}</span>")
    @chart4.set_cell(i, 13, numbersaves.to_i, "<span title=#{totalsaves}>#{numbersaves}</span>")
    @chart4.set_cell(i, 14, "<span title='Total Innings Pitched'>#{@player.career_post_innings_pitched_display}</span>")
    @chart4.set_cell(i, 15, @player.career_hits_allowed_post, "<span title=#{totalhits}>#{@player.career_hits_allowed_post}</span>")
    @chart4.set_cell(i, 16, @player.career_runs_allowed_post, "<span title=#{totalruns}>#{@player.career_runs_allowed_post}</span>")
    @chart4.set_cell(i, 17, @player.career_earned_runs_post, "<span title=#{totalearned}>#{@player.career_earned_runs_post}</span>")
    @chart4.set_cell(i, 18, @player.career_home_runs_allowed_post, "<span title=#{totalhome}>#{@player.career_home_runs_allowed_post}</span>")
    @chart4.set_cell(i, 19, @player.career_walks_allowed_post, "<span title=#{totalwalks}>#{@player.career_walks_allowed_post}</span>")
    @chart4.set_cell(i, 20, numberintentional.to_i, "<span title=#{totalintentional}>#{numberintentional}</span>")
    @chart4.set_cell(i, 21, @player.career_strikeouts_allowed_post, "<span title=#{totalstrikes}>#{@player.career_strikeouts_allowed_post}</span>")
    @chart4.set_cell(i, 22, @player.career_hit_by_pitches_allowed_post, "<span title=#{totalhitbypitch}>#{@player.career_hit_by_pitches_allowed_post}</span>")
    @chart4.set_cell(i, 23, numberbalks.to_i, "<span title=#{totalbalks}>#{numberbalks}</span>")
    @chart4.set_cell(i, 24, numberwild.to_i, "<span title=#{totalwild}>#{numberwild}</span>")
    @chart4.set_cell(i, 25, @player.career_batters_faced_post, "<span title=#{totalbatters}>#{@player.career_batters_faced_post}</span>")
	   @chart4.set_cell(i, 26, "<span title='Walks and Hits per Innings Pitched'>#{@player.career_post_walks_and_hits_innings_pitched}</span>" )
    @chart4.set_cell(i, 27, "<span title='Hits per 9 Innings'>#{@player.career_post_hits_per_9_innings}</span>" )
    @chart4.set_cell(i, 28, "<span title='Home Runs per 9 Innings'>#{@player.career_post_home_runs_per_9_innings}</span>" )
    @chart4.set_cell(i, 29, "<span title='Walks per 9 Innings'>#{@player.career_post_walks_per_9_innings}</span>" )
    @chart4.set_cell(i, 30, "<span title='Strikeouts per 9 Innings'>#{@player.career_post_strikeouts_per_9_innings}</span>" )
    @chart4.set_cell(i, 31, "<span title='Strikeouts per Walk'>#{@player.career_post_strikeouts_per_walk}</span>" )
  options = { :width => '100%', :allowHtml=>true }
  options.each_pair do | key, value |
    @chart4.send "#{key}=", value
  end
  
	@chart5 = GoogleVisualr::Table.new
	@chart5.add_column('string' , 'Year')
	@chart5.add_column('string' , 'Age')
	@chart5.add_column('string' , 'Team')
    @chart5.add_column('number' , 'AB')
    @chart5.add_column('number' , 'R')
    @chart5.add_column('number' , 'H')
    @chart5.add_column('number' , 'HR')
    @chart5.add_column('number' , 'RBI')
    @chart5.add_column('number' , 'SB')
    @chart5.add_column('string' , 'BA')
	 count = 0
	@batting_stats.each { |b|
		if b.games_batting == 0
		else
			count+=1
		end
	}
    @chart5.add_rows(count+1)
		i=0
		runs="\"Runs\""
		bats="\"At Bats\""
		hits="\"Hits\""
		home="\"Home Runs\""
		rbi="\"RBI\""
		stolen="\"Stolen Bases\""
		totalruns="\"Total Runs\""
		totalbats="\"Total At Bats\""
		totalhits="\"Total Hits\""
		totalhome="\"Total Home Runs\""
		totalrbi="\"Total RBI\""
		totalstolen="\"Total Stolen Bases\""
    @batting_stats.each { |b|
		
	if b.games_batting == 0
	
	else
		@chart5.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
		@chart5.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
		@chart5.set_cell(i, 2, "<span title='Team'><a href='/teams/#{b.team.id}'>#{b.team.name}</a></span>")
		  @chart5.set_cell(i, 3, b.at_bats, "<span title=#{bats}>#{b.at_bats.to_s}</span>")
		  @chart5.set_cell(i, 4, b.runs, "<span title=#{runs}>#{b.runs.to_s}</span>")
		  @chart5.set_cell(i, 5, b.hits, "<span title=#{hits}>#{b.hits.to_s}</span>")
		@chart5.set_cell(i, 6, b.home_runs, "<span title=#{home}>#{b.home_runs.to_s}</span>")
		@chart5.set_cell(i, 7, b.rbi, "<span title=#{rbi}>#{b.rbi.to_s}</span>")
		@chart5.set_cell(i, 8, b.stolen_bases, "<span title=#{stolen}>#{b.stolen_bases.to_s}</span>")
		@chart5.set_cell(i, 9, "<span title='Batting Average'>#{b.batting_average.to_s}</span>")
		i += 1
	end
	}
    numberruns=BattingStat.get_stat_total(params[:id], :runs)
    numberrbi=BattingStat.get_stat_total(params[:id], :rbi)
		 @chart5.set_cell(i, 0, "Totals")
		   @chart5.set_cell(i, 3, @player.career_at_bats, "<span title=#{totalbats}>#{@player.career_at_bats}</span>")
		   @chart5.set_cell(i, 4, numberruns.to_i, "<span title=#{totalruns}>#{numberruns}</span>")
		   @chart5.set_cell(i, 5, @player.career_hits, "<span title=#{totalhits}>#{@player.career_hits}</span>")
		 @chart5.set_cell(i, 6, @player.career_home_runs, "<span title=#{totalhome}>#{@player.career_home_runs}</span>")
		 @chart5.set_cell(i, 7, numberrbi.to_i, "<span title=#{totalrbi}>#{numberrbi}</span>")
		 @chart5.set_cell(i, 8, @player.career_stolen_bases, "<span title=#{totalstolen}>#{@player.career_stolen_bases}</span>")
		 @chart5.set_cell(i, 9, "<span title='Batting Average'>#{@player.career_batting_average}</span>")
		options = { :width => '100%', :allowHtml =>true}
		options.each_pair do | key, value |
			@chart5.send "#{key}=", value
		end
		
	@chart6 = GoogleVisualr::Table.new
	@chart6.add_column('string' , 'Year')
	@chart6.add_column('string' , 'Age')
	@chart6.add_column('string' , 'Team')
	@chart6.add_column('string' , 'Round')
    @chart6.add_column('number' , 'AB')
    @chart6.add_column('number' , 'R')
    @chart6.add_column('number' , 'H')
    @chart6.add_column('number' , 'HR')
    @chart6.add_column('number' , 'RBI')
    @chart6.add_column('number' , 'SB')
    @chart6.add_column('string' , 'BA')
    @chart6.add_rows(@batting_stats_post.size+1)
		i=0
		runs="\"Runs\""
		bats="\"At Bats\""
		hits="\"Hits\""
		home="\"Home Runs\""
		rbi="\"RBI\""
		stolen="\"Stolen Bases\""
		totalruns="\"Total Runs\""
		totalbats="\"Total At Bats\""
		totalhits="\"Total Hits\""
		totalhome="\"Total Home Runs\""
		totalrbi="\"Total RBI\""
		totalstolen="\"Total Stolen Bases\""
    @batting_stats_post.each { |b|
		@chart6.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
		@chart6.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
		@chart6.set_cell(i, 2, "<span title='Team'><a href='/teams/#{b.team.id}'>#{b.team.name}</a></span>")
		@chart6.set_cell(i, 3, "<span title='Round'>#{b.round.to_s[0,4]}</span>")
		  @chart6.set_cell(i, 4, b.at_bats, "<span title=#{bats}>#{b.at_bats.to_s}</span>")
		  @chart6.set_cell(i, 5, b.runs, "<span title=#{runs}>#{b.runs.to_s}</span>")
		  @chart6.set_cell(i, 6, b.hits, "<span title=#{hits}>#{b.hits.to_s}</span>")
		@chart6.set_cell(i, 7, b.home_runs, "<span title=#{home}>#{b.home_runs.to_s}</span>")
		@chart6.set_cell(i, 8, b.rbi, "<span title=#{rbi}>#{b.rbi.to_s}</span>")
		@chart6.set_cell(i, 9, b.stolen_bases, "<span title=#{stolen}>#{b.stolen_bases.to_s}</span>")
		@chart6.set_cell(i, 10, "<span title='Batting Average'>#{b.batting_average.to_s}</span>")
		i += 1
	}
    numberruns=BattingPostStat.get_stat_total(params[:id], :runs)
    numberrbi=BattingPostStat.get_stat_total(params[:id], :rbi)
		 @chart6.set_cell(i, 0, "Totals")
		   @chart6.set_cell(i, 4, @player.career_at_bats_post, "<span title=#{totalbats}>#{@player.career_at_bats_post}</span>")
		   @chart6.set_cell(i, 5, numberruns.to_i, "<span title=#{totalruns}>#{numberruns}</span>")
		   @chart6.set_cell(i, 6, @player.career_hits_post, "<span title=#{totalhits}>#{@player.career_hits_post}</span>")
		 @chart6.set_cell(i, 7, @player.career_home_runs_post, "<span title=#{totalhome}>#{@player.career_home_runs_post}</span>")
		 @chart6.set_cell(i, 8, numberrbi.to_i, "<span title=#{totalrbi}>#{numberrbi}</span>")
		 @chart6.set_cell(i, 9, @player.career_stolen_bases_post, "<span title=#{totalstolen}>#{@player.career_stolen_bases_post}</span>")
		 @chart6.set_cell(i, 10, "<span title='Batting Average'>#{@player.career_post_batting_average}</span>")
		options = { :width => '100%', :allowHtml =>true}
		options.each_pair do | key, value |
			@chart6.send "#{key}=", value
		end
		
	@chart7 = GoogleVisualr::Table.new
    @chart7.add_column('string' , 'Year')
	@chart7.add_column('string' , 'Age')
	@chart7.add_column('string' , 'Team')
	@chart7.add_column('number' , 'W')
	@chart7.add_column('number' , 'L')
	@chart7.add_column('string' , 'ERA')
	@chart7.add_column('number' , 'SV')
    @chart7.add_column('string' , 'IP')
    @chart7.add_column('number' , 'K')
    @chart7.add_column('string' , 'WHIP')
    @chart7.add_rows(@pitching_stats.size+1)
	wins="\"Wins \""
    losses="\"Losses\""
    saves="\"Saves\""
    strikes="\"Strikeouts\""
    totalwins="\"Total Wins\""
    totallosses="\"Total Losses\""
    totalsaves="\"Total Saves\""
    totalstrikes="\"Total Strikeouts\""
	@pitching_stats.each { |b|
		i = @pitching_stats.index(b)
		@chart7.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
		@chart7.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
		@chart7.set_cell(i, 2, "<span title='Team'>#{"<a href='/teams/#{b.team.id}'>#{b.team.name}</a>"}</span>")
		@chart7.set_cell(i, 3, b.wins, "<span title=#{wins}>#{b.wins.to_s}</span>")
		@chart7.set_cell(i, 4, b.losses, "<span title=#{losses}>#{b.losses.to_s}</span>")
		@chart7.set_cell(i, 5, "<span title='ERA'>#{b.era.to_s}</span>" )
		@chart7.set_cell(i, 6, b.saves, "<span title=#{saves}>#{b.saves.to_s}</span>" )
		@chart7.set_cell(i, 7, "<span title='Innings Pitched'>#{b.innings_pitched_display.to_s}</span>" )
		@chart7.set_cell(i, 8, b.strikeouts, "<span title=#{strikes}>#{b.strikeouts.to_s}</span>")
		@chart7.set_cell(i, 9, "<span title='Walks and Hits per Innings Pitched'>#{b.walks_and_hits_innings_pitched.to_s}</span>" )
	}
    i+=1
    numbersaves=PitchingStat.get_stat_total(params[:id], :saves)
    @chart7.set_cell(i, 0, "Totals")
    @chart7.set_cell(i, 3,  @player.career_wins, "<span title=#{totalwins}>#{@player.career_wins}</span>")
    @chart7.set_cell(i, 4,  @player.career_losses, "<span title=#{totallosses}>#{@player.career_losses}</span>")
    @chart7.set_cell(i, 5, "<span title='ERA'>#{@player.career_era}</span>")
    @chart7.set_cell(i, 6, numbersaves.to_i, "<span title=#{totalsaves}>#{numbersaves}</span>")
    @chart7.set_cell(i, 7, "<span title='Total Innings Pitched'>#{@player.career_innings_pitched_display}</span>")
    @chart7.set_cell(i, 8, @player.career_strikeouts_allowed, "<span title=#{totalstrikes}>#{@player.career_strikeouts_allowed}</span>")
	@chart7.set_cell(i, 9, "<span title='Walks and Hits per Innings Pitched'>#{@player.career_walks_and_hits_innings_pitched}</span>" )
	options = { :width => '100%', :allowHtml =>true }
	options.each_pair do | key, value |
		@chart7.send "#{key}=", value
	end
    @chart8 = GoogleVisualr::Table.new
    @chart8.add_column('string' , 'Year')
	@chart8.add_column('string' , 'Age')
	@chart8.add_column('string' , 'Team')
    @chart8.add_column('string' , 'Round')
	@chart8.add_column('number' , 'W')
	@chart8.add_column('number' , 'L')
    @chart8.add_column('string' , 'ERA')
    @chart8.add_column('number' , 'SV')
    @chart8.add_column('string' , 'IP')
    @chart8.add_column('number' , 'K')
    @chart8.add_column('string' , 'WHIP')
    @chart8.add_rows(@pitching_stats_post.size+1)
    @pitching_stats_post.each { |b|
		i = @pitching_stats_post.index(b)
		@chart8.set_cell(i, 0, "<span title='Year'>#{b.team.year.to_s}</span>")
		@chart8.set_cell(i, 1, "<span title='Age'>#{b.player.age(b.team.year).to_s}</span>")
		@chart8.set_cell(i, 2, "<span title='Team'>#{"<a href='/teams/#{b.team.id}'>#{b.team.name}</a>"}</span>")
		@chart8.set_cell(i, 3, "<span title='Round'>#{b.round.to_s[0,4]}</span>")
		@chart8.set_cell(i, 4, b.wins, "<span title=#{wins}>#{b.wins.to_s}</span>")
		@chart8.set_cell(i, 5, b.losses, "<span title=#{losses}>#{b.losses.to_s}</span>")
		@chart8.set_cell(i, 6, "<span title='ERA'>#{b.era.to_s}</span>" )
		@chart8.set_cell(i, 7, b.saves, "<span title=#{saves}>#{b.saves.to_s}</span>" )
		@chart8.set_cell(i, 8, "<span title='Innings Pitched'>#{b.innings_pitched_display.to_s}</span>" )
		@chart8.set_cell(i, 9, b.strikeouts, "<span title=#{strikes}>#{b.strikeouts.to_s}</span>")
		@chart8.set_cell(i, 10, "<span title='Walks and Hits per Innings Pitched'>#{b.walks_and_hits_innings_pitched.to_s}</span>" )
		}
    i+=1
    numbersaves=PitchingPostStat.get_stat_total(params[:id], :saves)
    @chart8.set_cell(i, 0, "Totals")
    @chart8.set_cell(i, 4,  @player.career_wins_post, "<span title=#{totalwins}>#{@player.career_wins_post}</span>")
    @chart8.set_cell(i, 5,  @player.career_losses_post, "<span title=#{totallosses}>#{@player.career_losses_post}</span>")
    @chart8.set_cell(i, 6, "<span title='ERA'>#{@player.career_post_era}</span>")
    @chart8.set_cell(i, 7, numbersaves.to_i, "<span title=#{totalsaves}>#{numbersaves}</span>")
    @chart8.set_cell(i, 8, "<span title='Total Innings Pitched'>#{@player.career_post_innings_pitched_display}</span>")
    @chart8.set_cell(i, 9, @player.career_strikeouts_allowed_post, "<span title=#{totalstrikes}>#{@player.career_strikeouts_allowed_post}</span>")
	@chart8.set_cell(i, 10, "<span title='Walks and Hits per Innings Pitched'>#{@player.career_post_walks_and_hits_innings_pitched}</span>" )
	options = { :width => '100%', :allowHtml=>true }
		options.each_pair do | key, value |
		@chart8.send "#{key}=", value
	end
  
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(params[:player])
    if @player.save
      flash[:notice] = "Successfully created player."
      redirect_to @player
    else
      render :action => 'new'
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:notice] = "Successfully updated player."
      redirect_to player_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    flash[:notice] = "Successfully destroyed player."
    redirect_to players_url
  end

  def by_letter
    redirect_to players_letter_path(params[:letter])
  end

  def letter
    letter = params[:letter].downcase + '%'
    @players = Player.find(:all, :conditions => ["lower(last_name) like ?", letter]).paginate :page => params[:page], :per_page => 20
  end

  def by_position
    redirect_to players_position_path(params[:position])
  end

  def position
    @players = FieldingStat.find(:all, :conditions => ['position like ?', params[:position]]).map{|p| p.player}.paginate :page => params[:page], :per_page => 20
  end

  def player_search

    @query = params[:query]
    if !@query.blank? && @query.length < 3
      #throw "a"
      redirect_to :back
      flash[:notice] = 'Please be more specific with your search.'
      @players = Array.new
    elsif @query.blank? && params[:letter].blank? && params[:position].blank?
      redirect_to :back
			flash[:notice] = 'Please fill in one of the fields.'
      @players = Array.new
    else
      name = '%' + params[:query].downcase + '%'
      letter = params[:letter].downcase + '%'
      position = params[:position] + '%'
      @players = Player.find(:all, :conditions => ["(lower(first_name) like ? OR lower(last_name) like ? OR lower(name) like ?) AND lower(last_name) like ? AND position like ?", name, name, name, letter, position], :order => "(final_game IS NOT NULL), last_name ASC, first_name ASC", :joins => [:fielding_stats]).uniq
    end

    if @players.size == 1
      redirect_to @players.first
    end
    
    @players = @players.paginate :page => params[:page], :per_page => 20
    @arr = Array.new
    @arr << "Name: " + @query unless @query.blank?
    @arr << "Position: " + params[:position] unless params[:position].blank?
    @arr << "Last Name Begins With: " + params[:letter] unless params[:letter].blank?
  end
end
