class FieldingPostStatsController < ApplicationController
  def index
    @fielding_post_stats = FieldingPostStat.all
  end

  def show
    @fielding_post_stat = FieldingPostStat.find(params[:id])
  end
  
	def single_season
		@fielding_post_stats = FieldingPostStat.single_season_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , 'Team')
		@table.add_column('string' , 'Year')
		@table.add_column('string' , params[:stat].titleize)
		@table.add_rows(50)
		@fielding_post_stats.each { |b|
			i = @fielding_post_stats.index(b)
			@table.set_cell(i, 0, "<a href='/players/#{b.player.id}'>#{b.player.name}</a>")
			if !b.player.throws.nil?
				@table.set_cell(i, 1, b.player.throws)
			else @table.set_cell(i, 1, 'N/A')
			end
			@table.set_cell(i, 2,  "<a href='/teams/#{b.team.id}'>#{b.team.name}</a>")
			@table.set_cell(i, 3, "#{b.year}")
			@table.set_cell(i, 4, "#{b.send(params[:stat])}")
		}
		
		options = { :width => 600, :showRowNumber => true, :allowHtml =>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end	
	end
  
	def career
		@fielding_post_stats = FieldingPostStat.career_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , params[:stat].titleize)
		@table.add_rows(50)
		i = 0
		if FieldingPostStat.accessible_attributes.include?(params[:stat])
			@fielding_post_stats.each { |k, v|
				@table.set_cell(i, 0, "<a href='/players/#{k.id}'>#{k.name}</a>")
				if !k.throws.nil?
						@table.set_cell(i, 1, k.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
				@table.set_cell(i, 2, "#{v}")
				i += 1
			}
		else 
				@fielding_post_stats.each { |b|
					@table.set_cell(i, 0, "<a href='/players/#{b.id}'>#{b.name}</a>")
					if !b.throws.nil?
						@table.set_cell(i, 1, b.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{b.send("career_" + params[:stat])}")
					i += 1
				}
		end

		options = { :width => 600, :showRowNumber => true, :allowHtml =>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end
  
	def active
		@fielding_post_stats = FieldingPostStat.active_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , params[:stat].titleize)
		@table.add_rows(50)
		i = 0
		if FieldingPostStat.accessible_attributes.include?(params[:stat])
			@fielding_post_stats.each { |k, v|
				@table.set_cell(i, 0, "<a href='/players/#{k.id}'>#{k.name}</a>")
				if !k.throws.nil?
						@table.set_cell(i, 1, k.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
				@table.set_cell(i, 2, "#{v}")
				i += 1
			}
		else 
				@fielding_post_stats.each { |b|
					@table.set_cell(i, 0, "<a href='/players/#{b.id}'>#{b.name}</a>")
					if !b.throws.nil?
						@table.set_cell(i, 1, b.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{b.send("career_" + params[:stat])}")
					i += 1
				}
		end

		options = { :width => 600, :showRowNumber => true, :allowHtml => true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end
	
end
