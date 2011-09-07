class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @franchise =Franchise.find(@team.franchise_id)
    @google_image = GoogleImage.all(@team.name+" logo wiki", 0).first
    @chart2 = GoogleVisualr::Table.new
    @chart2.add_column('string' , 'R')
    @chart2.add_column('string' , 'PA')
    @chart2.add_column('string' , 'AB')
    @chart2.add_column('string' , 'H')
    @chart2.add_column('string' , '2B')
    @chart2.add_column('string' , '3B')
    @chart2.add_column('string' , 'HR')
    @chart2.add_column('string' , 'TB')
    @chart2.add_column('string' , 'XBH')
    @chart2.add_column('string' , 'PA')
    @chart2.add_column('string' , 'BB')
    @chart2.add_column('string' , 'K')
    @chart2.add_column('string' , 'SB')
    @chart2.add_column('string' , 'CS')
    @chart2.add_column('string' , 'HBP')
    @chart2.add_column('string' , 'SF')
    @chart2.add_column('string' , 'BPF')
    @chart3 = GoogleVisualr::Table.new
    @chart3.add_column('string' , 'RA')
    @chart3.add_column('string' , 'ER')
    @chart3.add_column('string' , 'CG')
    @chart3.add_column('string' , 'SHO')
    @chart3.add_column('string' , 'SV')
    @chart3.add_column('string' , 'IPO')
    @chart3.add_column('string' , 'H')
    @chart3.add_column('string' , 'HR')
    @chart3.add_column('string' , 'BB')
    @chart3.add_column('string' , 'K')
    @chart3.add_column('string' , 'PPF')
    @chart3.add_column('string' , 'E')
    @chart3.add_column('string' , 'DP')
    @chart3.add_column('string' , 'FPCT')

    @chart2.add_rows(1);
    @chart3.add_rows(1);

    @chart2.set_cell(0, 0, "<span title='Year'>#{@team.runs.to_s}</span>")
    @chart2.set_cell(0, 1, "<span title='Plate Appearances'>#{@team.plate_appearances.to_s}</span>")
    @chart2.set_cell(0, 2, "<span title='At Bats'>#{@team.at_bats.to_s}</span>")
    @chart2.set_cell(0, 3, "<span title='Hits'>#{@team.hits.to_s}</span>")
    @chart2.set_cell(0, 4, "<span title='Doubles'>#{@team.doubles.to_s}</span>")
    @chart2.set_cell(0, 5, "<span title='Triples'>#{@team.triples.to_s}</span>")
	  @chart2.set_cell(0, 6, "<span title='Home Runs'>#{@team.home_runs.to_s}</span>")
	  @chart2.set_cell(0, 7, "<span title='Total Bases'>#{@team.total_bases.to_s}</span>")
	  @chart2.set_cell(0, 8, "<span title='Extra Base Hits'>#{@team.extra_base_hits.to_s}</span>")
    @chart2.set_cell(0, 9, "<span title='Plate Appearances'>#{@team.plate_appearances.to_s}</span>")
    @chart2.set_cell(0, 10, "<span title='Walks'>#{@team.walks.to_s}</span>")
    @chart2.set_cell(0, 11, "<span title='Strikeouts'>#{@team.strikeouts.to_s}</span>")
    @chart2.set_cell(0, 12, "<span title='Stolen Bases'>#{@team.stolen_bases.to_s}</span>")
    @chart2.set_cell(0, 13, "<span title='Caught Stealing'>#{@team.caught_stealing.to_s}</span>")
	  @chart2.set_cell(0, 14, "<span title='Hit by Pitch'>#{@team.hit_by_pitch.to_s}</span>")
	  @chart2.set_cell(0, 15, "<span title='Sacrifice Flies'>#{@team.sacrifice_flies.to_s}</span>")
    @chart2.set_cell(0, 16, "<span title='Batters Park Factor'>#{@team.batters_park_factor.to_s}</span>")

    @chart3.set_cell(0, 0, "<span title='Runs Allowed'>#{@team.runs_allowed.to_s}</span>")
    @chart3.set_cell(0, 1, "<span title='Earned Runs'>#{@team.earned_runs.to_s}</span>")
    @chart3.set_cell(0, 2, "<span title='Complete Games'>#{@team.complete_games.to_s}</span>")
    @chart3.set_cell(0, 3, "<span title='Shutouts'>#{@team.shutouts.to_s}</span>")
    @chart3.set_cell(0, 4, "<span title='Saves'>#{@team.saves.to_s}</span>")
    @chart3.set_cell(0, 5, "<span title='Innings Pitched'>#{@team.innings_pitched_outs.to_s}</span>")
	  @chart3.set_cell(0, 6, "<span title='Hits Allowed'>#{@team.hits_allowed.to_s}</span>")
	  @chart3.set_cell(0, 7, "<span title='Home Runs Allowed'>#{@team.home_runs_allowed.to_s}</span>")
	  @chart3.set_cell(0, 8, "<span title='Walks Allowed'>#{@team.walks_allowed.to_s}</span>")
    @chart3.set_cell(0, 9, "<span title='Strikeouts Allowed'>#{@team.strikeouts_allowed.to_s}</span>")
    @chart3.set_cell(0, 10, "<span title='Pitchers Park Factor'>#{@team.pitchers_park_factor.to_s}</span>")
    @chart3.set_cell(0, 11, "<span title='Errors'>#{@team.errors_made.to_s}</span>")
    @chart3.set_cell(0, 12, "<span title='Double Plays'>#{@team.double_plays.to_s}</span>")
    @chart3.set_cell(0, 13, "<span title='Fielding Percentage'>#{@team.fielding_percentage.to_s}</span>")
    options = { :width => '100%', :allowHtml => true}
		options.each_pair do | key, value |
      @chart2.send "#{key}=", value
      @chart3.send "#{key}=", value
		end

    @roster = @team.batting_stats.map{|s| s.player} + @team.pitching_stats.map{|s| s.player} + @team.fielding_stats.map{|s| s.player}
    @roster.uniq!
    @chart4=GoogleVisualr::Table.new
    @chart4.add_column('string' , 'Name')
    @chart4.add_column('string' , 'Age')
    @chart4.add_column('string' , 'Position')
    @chart4.add_rows(@roster.size)
     @roster.each { |b|
			i = @roster.index(b)
       @chart4.set_cell(i, 0, "<span title='Name'><a href=/players/#{b.id}>#{b.name}</a></span>")
       @chart4.set_cell(i, 1, "<span title='Age'>#{b.age(@team.year)}</span>")
      stats = b.fielding_stats.where("team_id = ?", @team.id).sort_by{|s| s.games}
      position = (stats.size > 0)? stats.last.position : "N/A"
      @chart4.set_cell(i, 2, "<span title='Position'>#{position}</span>")
      }
      options = { :width => '50%', :allowHtml => true}
      options.each_pair do | key, value |
			@chart4.send "#{key}=", value
		end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = "Successfully created team."
      redirect_to @team
    else
      render :action => 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = "Successfully updated team."
      redirect_to team_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:notice] = "Successfully destroyed team."
    redirect_to teams_url
  end

	def season_compare
		@teams = Team.season_compare(params[:comp])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Franchise')
		@table.add_column('string' , 'Year')
		@table.add_column('string' , 'League')
		@table.add_column('string' , 'W')
		@table.add_column('string' , 'L')
		@table.add_column('string' , 'WL%')
		@table.add_column('string' , 'R')
		@table.add_column('string' , 'PA')
		@table.add_column('string' , 'AB')
		@table.add_column('string' , 'H')
		@table.add_column('string' , '2B')
		@table.add_column('string' , '3B')
		@table.add_column('string' , 'HR')
		@table.add_column('string' , 'TB')
		@table.add_column('string' , 'XBH')
		@table.add_column('string' , 'BB')
		@table.add_column('string' , 'K')
		@table.add_column('string', 'SB')
		@table.add_column('string' , 'CS')
		@table.add_column('string' , 'HBP')
		@table.add_column('string' , 'SF')
		@table.add_column('string' , 'RA')
		@table.add_column('string' , 'ER')
		@table.add_column('string' , 'CG')
		@table.add_column('string' , 'SHO')
		@table.add_column('string' , 'SV')
		@table.add_column('string' , 'HA')
		@table.add_column('string' , 'HRA')
		@table.add_column('string' , 'BBA')
		@table.add_column('string' , 'KA')
		@table.add_column('string' , 'E')
		@table.add_rows(@teams.size)
		i = 0
		@teams.each {|b|
			@table.set_cell(i, 0, "<a href='/teams/#{b[0].id}'>#{b[0].name}</a>")
			@table.set_cell(i, 1, "<a href='/franchises/#{b[0].franchise.id}'>#{b[0].franchise.name}</a>")
			@table.set_cell(i, 2, b[0].year.to_s)
			@table.set_cell(i, 3, b[0].division.league.abbrev.to_s)
			@table.set_cell(i, 4,"<span title='Wins'>#{b[0].wins.to_s}</span>")
			@table.set_cell(i, 5, "<span title='Losses'>#{b[0].losses.to_s}</span>")
			@table.set_cell(i, 6, "<span title='Win Loss Percentage'>#{b[0].pct.to_s}</span>")
			@table.set_cell(i, 7, "<span title='Runs'>#{b[0].runs.to_s}</span>")
			@table.set_cell(i, 8, "<span title='Plate Appearances'>#{b[0].plate_appearances.to_s}</span>")
			@table.set_cell(i, 9, "<span title='At Bats'>#{b[0].at_bats.to_s}</span>")
			@table.set_cell(i, 10, "<span title='Hits'>#{b[0].hits.to_s}</span>")
			@table.set_cell(i, 11, "<span title='Doubles'>#{b[0].doubles.to_s}</span>")
			@table.set_cell(i, 12, "<span title='Triples'>#{b[0].triples.to_s}</span>")
			@table.set_cell(i, 13, "<span title='Home Runs'>#{b[0].home_runs.to_s}</span>")
			@table.set_cell(i, 14, "<span title='Total Bases'>#{b[0].total_bases.to_s}</span>")
			@table.set_cell(i, 15, "<span title='Extra Base Hits'>#{b[0].extra_base_hits.to_s}</span>")
			@table.set_cell(i, 16, "<span title='Walks'>#{b[0].walks.to_s}</span>")
			@table.set_cell(i, 17, "<span title='Strikeouts'>#{b[0].strikeouts.to_s}</span>")
			@table.set_cell(i, 18, "<span title='Stolen Bases'>#{b[0].stolen_bases.to_s}</span>")
			@table.set_cell(i, 19, "<span title='Caught Stealing'>#{b[0].caught_stealing.to_s}</span>")
			@table.set_cell(i, 20, "<span title='Hit by Pitch'>#{b[0].hit_by_pitch.to_s}</span>")
			@table.set_cell(i, 21, "<span title='Sacrifice Flies'>#{b[0].sacrifice_flies.to_s}</span>")
			@table.set_cell(i, 22, "<span title='Runs Allowed'>#{b[0].runs_allowed.to_s}</span>")
			@table.set_cell(i, 23, "<span title='Earned Runs'>#{b[0].earned_runs.to_s}</span>")
			@table.set_cell(i, 24, "<span title='Complete Games'>#{b[0].complete_games.to_s}</span>")
			@table.set_cell(i, 25, "<span title='Shutouts'>#{b[0].shutouts.to_s}</span>")
			@table.set_cell(i, 26, "<span title='Saves'>#{b[0].saves.to_s}</span>")
			@table.set_cell(i, 27, "<span title='Hits Allowed'>#{b[0].hits_allowed.to_s}</span>")
			@table.set_cell(i, 28, "<span title='Home Runs Allowed'>#{b[0].home_runs_allowed.to_s}</span>")
			@table.set_cell(i, 29, "<span title='Walks Allowed'>#{b[0].walks_allowed.to_s}</span>")
			@table.set_cell(i, 30, "<span title='Strikeouts Allowed'>#{b[0].strikeouts_allowed.to_s}</span>")
			@table.set_cell(i, 31, "<span title='Errors'>#{b[0].errors_made.to_s}</span>")
			i += 1
		}
		
		options = { :width => '100%', :allowHtml=>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
		
		@chart = GoogleVisualr::Table.new
		@chart.add_column('string' , 'Name')
		@chart.add_column('string' , 'Franchise')
		@chart.add_column('string' , 'Year')
		@chart.add_column('string' , 'League')
		@chart.add_column('string' , 'W')
		@chart.add_column('string' , 'L')
		@chart.add_column('string' , 'R')
		@chart.add_column('string' , 'H')
		@chart.add_column('string' , 'HR')
		@chart.add_column('string' , 'RA')
		@chart.add_column('string' , 'KA')
		@chart.add_column('string' , 'E')
		@chart.add_rows(@teams.size)
		i = 0
		@teams.each {|b|
			@chart.set_cell(i, 0, "<a href='/teams/#{b[0].id}'>#{b[0].name}</a>")
			@chart.set_cell(i, 1, "<a href='/franchises/#{b[0].franchise.id}'>#{b[0].franchise.name}</a>")
			@chart.set_cell(i, 2, b[0].year.to_s)
			@chart.set_cell(i, 3, b[0].division.league.abbrev.to_s)
			@chart.set_cell(i, 4,"<span title='Wins'>#{b[0].wins.to_s}</span>")
			@chart.set_cell(i, 5, "<span title='Losses'>#{b[0].losses.to_s}</span>")
			@chart.set_cell(i, 6, "<span title='Runs'>#{b[0].runs.to_s}</span>")
			@chart.set_cell(i, 7, "<span title='Hits'>#{b[0].hits.to_s}</span>")
			@chart.set_cell(i, 8, "<span title='Home Runs'>#{b[0].home_runs.to_s}</span>")
			@chart.set_cell(i, 9, "<span title='Runs Allowed'>#{b[0].runs_allowed.to_s}</span>")
			@chart.set_cell(i, 10, "<span title='Strikeouts Allowed'>#{b[0].strikeouts_allowed.to_s}</span>")
			@chart.set_cell(i, 11, "<span title='Errors'>#{b[0].errors_made.to_s}</span>")
			i += 1
		}
		
		options = { :width => '100%', :allowHtml=>true }
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
	end
  
	def career_compare
		@teams = Team.career_compare(params[:comp])
		@franchise = []
		@franchises = []
		@teams.each_value {|value|
			if @franchise.include?(value)
			else @franchise.push(value)
			end
		}
		@max = []
		@franchise.each {|f|
			@franchises.push(Franchise.find(f.to_i))
			@max.push(Team.find(:all, :select => [:id], :conditions => ['franchise_id =?', f]).size)
		}
		@chart = GoogleVisualr::LineChart.new
		@chart.add_column('string', 'Year')
		@franchises.each { |f|
			@chart.add_column('number', f.name)
		}	
		@chart.add_rows(@max.max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		stats = Team.get_all_stats(f.id, :wins)
			stats.each {|s|
				@chart.set_value(x, 0, year.to_s)
				@chart.set_value(x, y, s.wins)
				x += 1
				year += 1
			}
			y += 1
		}
		options = { :width => '100%', :height => 300, :legend => 'bottom', :title => "Wins Each Year", :titleX => "Year for Team", :titleY => "Number of Wins"}
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
		
		@chart2 = GoogleVisualr::LineChart.new
		@chart2.add_column('string', 'Year')
		@franchises.each { |f|
			@chart2.add_column('number', f.name)
		}	
		@chart2.add_rows(@max.max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		stats = Team.get_all_stats(f.id, :wins)
		total = 0
			stats.each {|s|
				total += s.wins
				@chart2.set_value(x, 0, year.to_s)
				@chart2.set_value(x, y, total)
				x += 1
				year += 1
			}
			y += 1
		}
		options2 = { :width => '100%', :height => 300, :legend => 'bottom', :title => "Cumulative Wins", :titleX => "Year for Team", :titleY => "Number of Wins"}
		options2.each_pair do | key, value |
			@chart2.send "#{key}=", value
		end

		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Wins')
		@table.add_column('string' , 'Losses')
		@table.add_column('string' , 'Runs Scored')
		@table.add_column('string' , 'Runs Allowed')
		@table.add_column('string' , 'Errors')
		
		@table.add_rows(@franchises.size)
		i = 0
			@franchises.each { |f|
				@table.set_cell(i, 0, "<a href='/franchises/#{f.id}'>#{f.name}</a>")
				@table.set_cell(i, 1, Team.get_stat_total(f, :wins))
				@table.set_cell(i, 2, Team.get_stat_total(f, :losses))
				@table.set_cell(i, 3, Team.get_stat_total(f, :runs))
				@table.set_cell(i, 4, Team.get_stat_total(f, :runs_allowed))
				@table.set_cell(i, 5, Team.get_stat_total(f, :errors_made))
				i += 1
			}

		options = { :width => '100%', :allowHtml => true}
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end
	
	def change_career_chart
		stat = params[:chart_type].downcase.gsub(" ", "_")
		@franchise= params[:franchises]
		@franchises = []
		@max = []
		@franchise.each {|f|
			@franchises.push(Franchise.find(f.to_i))
			@max.push(Team.find(:all, :select => [:id], :conditions => ['franchise_id =?', f]).size)
		}
		@chart = GoogleVisualr::LineChart.new
		@chart.add_column('string', 'Year')
		@franchises.each { |f|
			@chart.add_column('number', f.name)
		}	
		@chart.add_rows(@max.max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		stats = Team.get_all_stats(f.id, stat.to_sym)
			stats.each {|s|
				@chart.set_value(x, 0, year.to_s)
				@chart.set_value(x, y, s.send(stat))
				x += 1
				year += 1
			}
			y += 1
		}
		options = { :width => '100%', :height => 300, :legend => 'bottom', :title => stat.titleize + " Each Year", :titleX => "Year for Team", :titleY => "Number of " + stat.titleize}
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
		
		@chart2 = GoogleVisualr::LineChart.new
		@chart2.add_column('string', 'Year')
		@franchises.each { |f|
			@chart2.add_column('number', f.name)
		}	
		@chart2.add_rows(@max.max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		stats = Team.get_all_stats(f.id, stat.to_sym)
		total = 0
			stats.each {|s|
				total += s.send(stat)
				@chart2.set_value(x, 0, year.to_s)
				@chart2.set_value(x, y, total)
				x += 1
				year += 1
			}
			y += 1
		}
		options2 = { :width => '100%', :height => 300, :legend => 'bottom', :title => "Cumulative " + stat.titleize, :titleX => "Year for Team", :titleY => "Number of " + stat.titleize}
		options2.each_pair do | key, value |
			@chart2.send "#{key}=", value
		end
		
		render :partial => "chart"
    end
	
	def change_career_table
		stats = params[:stat]
		@franchise = params[:franchises]
		@franchises = []
		@franchise.each {|f|
			@franchises.push(Franchise.find(f.to_i))
		}
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		stats.each {|s|
			@table.add_column('string' , s.titleize)
		}
		@table.add_rows(@franchises.size)
		i = 0
		
			@franchises.each { |f|
				@table.set_cell(i, 0, "<a href='/franchises/#{f.id}'>#{f.name}</a>")
				j = 1
				stats.each { |s|
					@table.set_cell(i, j, Team.get_stat_total(f, s.to_sym))
					j += 1
				}
				i += 1
			}

		options = { :width => '100%', :allowHtml => true}
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
		
		render :partial => "table"
	end
	
	def multi_compare
		@comp = params[:comp]
		@teams, @max, @years = Team.multi_compare(@comp)
		@franchise = []
		@franchises = []
		@teams.each_value {|value|
			if @franchise.include?(value)
				else @franchise.push(value)
			end
		}
		@franchise.each {|f|
			@franchises.push(Franchise.find(f.to_i))
		}
		@strings = []
		l = 0
		@franchises.each { |p|
			@strings.push(p.name + " from " + @years[l])
			l += 1
		}
		@chart = GoogleVisualr::LineChart.new
		@chart.add_column('string', 'Year')
		i = 0
		@franchises.each { |f|
			@chart.add_column('number', f.name + ', ' + @years[i])
			i += 1
		}	
		@chart.add_rows(@max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		@stats = Team.get_multi_stats(f.id, @teams, :wins)
			@stats.each {|s|
				@chart.set_value(x, 0, year.to_s)
				@chart.set_value(x, y, s)
				x += 1
				year += 1
			}
			y += 1
		}
		options = { :width => '100%', :height => 300, :legend => 'bottom', :title => "Wins Each Year", :titleX => "Year for Team", :titleY => "Number of Wins"}
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
		
		@chart2 = GoogleVisualr::LineChart.new
		@chart2.add_column('string', 'Year')
		i = 0
		@franchises.each { |f|
			@chart2.add_column('number', f.name + ', ' + @years[i])
			i += 1
		}	
		@chart2.add_rows(@max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		stats = Team.get_multi_stats(f.id, @teams, :wins)
		total = 0
			stats.each {|s|
				total += s
				@chart2.set_value(x, 0, year.to_s)
				@chart2.set_value(x, y, total)
				x += 1
				year += 1
			}
			y += 1
		}
		options2 = { :width => '100%', :height => 300, :legend => 'bottom', :title => "Cumulative Wins", :titleX => "Year for Team", :titleY => "Number of Wins"}
		options2.each_pair do | key, value |
			@chart2.send "#{key}=", value
		end

		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Wins')
		@table.add_column('string' , 'Losses')
		@table.add_column('string' , 'Runs Scored')
		@table.add_column('string' , 'Runs Allowed')
		@table.add_column('string' , 'Errors')
		
		@table.add_rows(@franchises.size)
		i = 0
			@franchises.each { |f|
				@table.set_cell(i, 0, "<a href='/franchises/#{f.id}'>#{f.name}</a>")
				@table.set_cell(i, 1, Team.get_multi_stat_total(f.id, @teams, :wins))
				@table.set_cell(i, 2, Team.get_multi_stat_total(f.id, @teams, :losses))
				@table.set_cell(i, 3, Team.get_multi_stat_total(f.id, @teams, :runs))
				@table.set_cell(i, 4, Team.get_multi_stat_total(f.id, @teams, :runs_allowed))
				@table.set_cell(i, 5, Team.get_multi_stat_total(f.id, @teams, :errors_made))
				i += 1
			}

		options = { :width => '100%', :allowHtml => true}
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end
	
	def change_multi_chart
		stat = params[:chart_type].downcase.gsub(" ", "_")
		@franchise = params[:franchises]
		@team, @max = Team.multi_compare(params[:comp])
		@teams = @team.keys
		@years = params[:years]
		@franchises = []
		@franchise.each {|f|
			@franchises.push(Franchise.find(f.to_i))
		}
		@chart = GoogleVisualr::LineChart.new
		@chart.add_column('string', 'Year')
		i = 0
		@franchises.each { |f|
			@chart.add_column('number', f.name + ', ' + @years[i])
			i += 1
		}	
		@chart.add_rows(@max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		stats = Team.get_change_multi_stats(f.id, @teams, stat.to_sym)
			stats.each {|s|
				@chart.set_value(x, 0, year.to_s)
				@chart.set_value(x, y, s)
				x += 1
				year += 1
			}
			y += 1
		}
		options = { :width => '100%', :height => 300, :legend => 'bottom', :title => stat.titleize + " Each Year", :titleX => "Year for Team", :titleY => "Number of " + stat.titleize}
		options.each_pair do | key, value |
			@chart.send "#{key}=", value
		end
		
		@chart2 = GoogleVisualr::LineChart.new
		@chart2.add_column('string', 'Year')
		i = 0
		@franchises.each { |f|
			@chart2.add_column('number', f.name + ', ' + @years[i])
			i += 1
		}	
		@chart2.add_rows(@max)
		y = 1
		@franchises.each { |f|
		x = 0
		year = 1
		total = 0
		stats = Team.get_change_multi_stats(f.id, @teams, stat.to_sym)
			stats.each {|s|
				total += s
				@chart2.set_value(x, 0, year.to_s)
				@chart2.set_value(x, y, total)
				x += 1
				year += 1
			}
			y += 1
		}
		options2 = { :width => '100%', :height => 300, :legend => 'bottom', :title => "Cumulative " + stat.titleize, :titleX => "Year for Team", :titleY => "Number of " + stat.titleize}
		options2.each_pair do | key, value |
			@chart2.send "#{key}=", value
		end

		render :partial => "chart"
    end
	
	def change_multi_table
		stats = params[:stat]
		@franchise = params[:franchises]
		@team, @max = Team.multi_compare(params[:comp])
		@teams = @team.keys
		@franchises = []
		@franchise.each {|f|
			@franchises.push(Franchise.find(f.to_i))
		}
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		stats.each {|s|
			@table.add_column('string' , s.titleize)
		}
		@table.add_rows(@franchises.size)
		i = 0
		
			@franchises.each { |f|
				@table.set_cell(i, 0, "<a href='/franchises/#{f.id}'>#{f.name}</a>")
				j = 1
				stats.each { |s|
					@table.set_cell(i, j, Team.get_change_multi_stat_total(f.id, @teams, s.to_sym))
					j += 1
				}
				i += 1
			}

		options = { :width => '100%', :allowHtml => true}
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
		
		render :partial => "table"
	end
	
end
