class PitchingPostStatsController < ApplicationController
  def index
    @pitching_post_stats = PitchingPostStat.all
  end

  def show
    @pitching_post_stat = PitchingPostStat.find(params[:id])
  end
  
    def single_season
		@pitching_post_stats = PitchingPostStat.single_season_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , 'Team')
		@table.add_column('string' , 'Year')
		if params[:stat] == 'era'
			@table.add_column('string' , params[:stat].upcase)
		else @table.add_column('string' , params[:stat].titleize)
		end
		@table.add_rows(50)
		@pitching_post_stats.each { |b|
			
			i = @pitching_post_stats.index(b)
			@table.set_cell(i, 0, "<a href='/players/#{b.player.id}'>#{b.player.name}</a>")
			if !b.player.throws.nil?
				@table.set_cell(i, 1, b.player.throws)
			else @table.set_cell(i, 1, 'N/A')
			end
			@table.set_cell(i, 2, "<a href='/teams/#{b.team.id}'>#{b.team.name}</a>")
			@table.set_cell(i, 3, "#{b.year}")
			@table.set_cell(i, 4, "#{b.send(params[:stat])}")
		}
		
		options = { :width => 600, :showRowNumber => true, :allowHtml=>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end	
	end
  
    def career
		@pitching_post_stats = PitchingPostStat.career_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		if params[:stat] == 'era'
			@table.add_column('string' , params[:stat].upcase)
		else @table.add_column('string' , params[:stat].titleize)
		end
		@table.add_rows(50)
		i = 0
			if PitchingPostStat.accessible_attributes.include?(params[:stat])
				@pitching_post_stats.each { |k, v|
					@table.set_cell(i, 0, "<a href='/players/#{k.id}'>#{k.name}</a>")
					if !k.throws.nil?
						@table.set_cell(i, 1, k.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{v}")
					i += 1
				}
			else 
				@pitching_post_stats.each { |b|
					@table.set_cell(i, 0, "<a href='/players/#{b.id}'>#{b.name}</a>")
					if !b.bats.nil?
						@table.set_cell(i, 1, b.bats)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{b.send("career_post_" + params[:stat])}")
					i += 1
				}
			end
			
		options = { :width => 600, :showRowNumber => true, :allowHtml=>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end
	
	def active
		@pitching_post_stats = PitchingPostStat.active_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		if params[:stat] == 'era'
			@table.add_column('string' , params[:stat].upcase)
		else @table.add_column('string' , params[:stat].titleize)
		end
		@table.add_rows(50)
		i = 0
			if PitchingPostStat.accessible_attributes.include?(params[:stat])
				@pitching_post_stats.each { |k, v|
					@table.set_cell(i, 0, "<a href='/players/#{k.id}'>#{k.name}</a>")
					if !k.throws.nil?
						@table.set_cell(i, 1, k.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{v}")
					i += 1
				}
			else 
				@pitching_post_stats.each { |b|
					@table.set_cell(i, 0, "<a href='/players/#{b.id}'>#{b.name}</a>")
					if !b.bats.nil?
						@table.set_cell(i, 1, b.bats)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{b.send("career_post_" + params[:stat])}")
					i += 1
				}
			end	
		options = { :width => 600, :showRowNumber => true, :allowHtml=>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end

  def season_finder

  end

  def find_seasons
    number = params[:fields][:count].to_i
    @stats = []
    operations = []
    (1..number).each do |i|
      stat = params["#{i}"][:stat]
      next if stat.blank?
      operator = params["#{i}"][:operator]
      number = params["#{i}"][:number]
      string = stat + " " + operator + " " + number
      @stats.push(stat)
      operations.push(string)
    end
    @batting_stats = PitchingPostStat.where(operations.join(" AND "))

  end
	
end
