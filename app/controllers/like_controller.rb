class LikeController < ApplicationController
  unloadable

  def like
    if User.current.pref[:others][:issue_like] == nil then 
	User.current.pref[:others][:issue_like]=Array.new
	User.current.pref.save
    end
    if (!User.current.pref[:others][:issue_like].include?(params[:id].to_i)) then
	User.current.pref[:others][:issue_like]+=[params[:issue_id].to_i]
	User.current.pref.save
    end
    @issue_id = params[:issue_id]
    redirect_to_referer_or {render :text => 'Issue liked', :layout => true}
  end

  def unlike
    if User.current.pref[:others][:issue_like] == nil then 
	User.current.pref[:others][:issue_like]=Array.new
	User.current.pref.save
    end
	User.current.pref[:others][:issue_like]-=[params[:issue_id].to_i]
	User.current.pref.save
    @issue_id = params[:issue_id]
    redirect_to_referer_or {render :text => 'Issue unliked', :layout => true}
  end
  
  def like?
    return User.current.pref[:others][:issue_like].include?(params[:issue_id])
  end
end
