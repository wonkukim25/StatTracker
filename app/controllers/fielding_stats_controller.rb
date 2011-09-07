class FieldingStatsController < ApplicationController
  def index
    @fielding_stats = FieldingStat.all
  end

  def show
    @fielding_stat = FieldingStat.find(params[:id])
  end
  
	def single_season
		@fielding_stats = FieldingStat.single_season_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , 'Team')
		@table.add_column('string' , 'Year')
		@table.add_column('string' , params[:stat].titleize)
		@table.add_rows(50)
		@fielding_stats.each { |b|
			i = @fielding_stats.index(b)
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
		@fielding_stats = FieldingStat.career_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , params[:stat].titleize)
		@table.add_rows(50)
		i = 0
		if FieldingStat.accessible_attributes.include?(params[:stat])
			@fielding_stats.each { |k, v|
				@table.set_cell(i, 0, "<a href='/players/#{k.id}'>#{k.name}</a>")
				if !k.throws.nil?
						@table.set_cell(i, 1, k.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
				@table.set_cell(i, 2, "#{v}")
				i += 1
			}
		else 
				@fielding_stats.each { |b|
					@table.set_cell(i, 0, "<a href='/players/#{b.id}'>#{b.name}</a>")
					if !b.throws.nil?
						@table.set_cell(i, 1, b.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{b.send("career_" + params[:stat])}")
					i += 1
				}
		end
		options = { :width => 600, :showRowNumber => true, :allowHtml=>true }
		options.each_pair do | key, value |
			@table.send "#{key}=", value
		end
	end
	
	def active
		@fielding_stats = FieldingStat.active_sort(params[:stat])
		@table = GoogleVisualr::Table.new
		@table.add_column('string' , 'Name')
		@table.add_column('string' , 'Throws')
		@table.add_column('string' , params[:stat].titleize)
		@table.add_rows(50)
		i = 0
		if FieldingStat.accessible_attributes.include?(params[:stat])
			@fielding_stats.each { |k, v|
				@table.set_cell(i, 0, "<a href='/players/#{k.id}'>#{k.name}</a>")
				if !k.throws.nil?
						@table.set_cell(i, 1, k.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
				@table.set_cell(i, 2, "#{v}")
				i += 1
			}
		else 
				@fielding_stats.each { |b|
					@table.set_cell(i, 0, "<a href='/players/#{b.id}'>#{b.name}</a>")
					if !b.throws.nil?
						@table.set_cell(i, 1, b.throws)
					else @table.set_cell(i, 1, 'N/A')
					end
					@table.set_cell(i, 2, "#{b.send("career_" + params[:stat])}")
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
      number = params["#{i}"][:number].to_i
	  if number.to_i < 0
		flash[:notice] = 'At least one of your values was invalid. Please try again.'
		redirect_to :back
	  end
      string = stat.downcase.gsub(" ", "_") + " " + operator + " " + number.to_s
      @stats.push(stat)
      operations.push(string)
    end
    order = @stats.map{|s| s.downcase.gsub(" ", "_") + " DESC"}.join(", ")
    if @stats.size == 0
      flash[:notice] = 'You must select at least one stat.'
      redirect_to :back
      @batting_stats = Array.new
    elsif params[:postseason].nil?
      @batting_stats = FieldingStat.find(:all, :conditions => [operations.join(" AND ")], :order => order)
    else
      @batting_stats = FieldingPostStat.find(:all, :conditions => [operations.join(" AND ")], :order => order)
    end
    number = 400
    if @batting_stats.size > number
      flash[:notice] = "Your search returned more than #{number} results. Try a more specific search."
      redirect_to :back
    else
      @chart2 = GoogleVisualr::Table.new
      @chart2.add_column('string' , 'Name')
      @chart2.add_column('string' , 'Bats')
      @chart2.add_column('string' , 'Team')
      @chart2.add_column('string' , 'Year')
      @stats.each do |i|
       @chart2.add_column('number' , i.titleize)
      end
      @chart2.add_rows(@batting_stats.size)
      @batting_stats.each { |b|
        i = @batting_stats.index(b)
        @chart2.set_cell(i, 0, "<a href='/players/#{b.player.id}'>#{b.player.name}</a>")
        @chart2.set_cell(i, 1, b.player.bats.to_s)
        @chart2.set_cell(i, 2, "<a href='/teams/#{b.team.id}'>#{b.team.name}</a>")
        @chart2.set_cell(i, 3, b.team.year.to_s)
        k=4
      @stats.each do |j|
       number= b.send(j.downcase.gsub(" ", "_"))
       @chart2.set_value(i, k, number)
       k+=1
      end
      }
      options = { :width => 600, :allowHtml=>true}
      options.each_pair do | key, value |
      @chart2.send "#{key}=", value
      @operations = operations
      end
    end
  end
  
end
