class FranchisesController < ApplicationController
autocomplete :franchise, :name, :full => true

  def index
    @franchises = Franchise.all
  end

  def show
    @franchise = Franchise.find(params[:id])
    @google_image = GoogleImage.all(@franchise.name+" current logo", 0).first
    @teams= Team.find(:all, :conditions => ['franchise_id = ?', params[:id]])
    @first_team=@teams.first
    if !@franchise.active
    @last_team=@teams.last
    end
    @teams.reverse!
    @chart = GoogleVisualr::Table.new
		@chart.add_column('string' , 'Team')
    @chart.add_column('number' , 'Year')
		@chart.add_column('string' , 'League')
		@chart.add_column('number' , 'Wins')
		@chart.add_column('number' , 'Losses')
    @chart.add_column('string' , 'W-L%')
    @chart.add_column('string' , 'Rank')
    @chart.add_rows(@teams.size)
    @teams.each { |b|
			i = @teams.index(b)
			@chart.set_cell(i, 0, "<a href='/teams/#{b.id}'>#{b.name}</a>")
			@chart.set_cell(i, 1, b.year)
      @chart.set_cell(i, 2, b.division.league.name)
      @chart.set_cell(i, 3, b.wins)
      @chart.set_cell(i, 4, b.losses)
      @chart.set_cell(i, 5, b.pct.to_s)
      @chart.set_cell(i, 6, b.rank.to_s)
    }
    options = { :width => 600, :allowHtml => true}
    options.each_pair do | key, value |
    @chart.send "#{key}=", value
  end
  end

    def team_search
    @query = params[:query]
    @franchises = Franchise.search(@query)
    @total_hits = @franchises.size
    if @total_hits == 1
      if @franchises.first != nil
        redirect_to @franchises.first
      end
    end
  end


end
