require 'redmine'
require 'query_patch_like'

Redmine::Plugin.register :redmine_favourites do
  name 'Favourites plugin'
  author 'Milan Stastny of ALVILA SYSTEMS, Stefan Moises of shoptimax GmbH'
  description 'Bookmarking favourite tasks by Like button with Query inclusion'
  version '0.1.0'
  author_url 'http://www.alvila.com'
  settings :default => {
      :like_filterid => '0'
  }, :partial => 'settings/like/general'
  menu :top_menu, :redmine_favourites, {:controller => 'issues', :action => 'index', :params => {'query_id' => 0}  },
       :caption => :heading_ticket_likes, :last => true, :if => Proc.new { Setting.plugin_redmine_favourites['like_filterid']}
end

# hook to replace the menu link for ticket favourites
# runs on rendering
class MenuListener < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context)
    if Setting.plugin_redmine_favourites['like_filterid'] != nil
      menu = Redmine::MenuManager.map(:top_menu).find(:redmine_favourites)
      menu.url[:params] = { :query_id => Setting.plugin_redmine_favourites['like_filterid'] }
    end
    return ''
  end
end

RedmineApp::Application.config.after_initialize do
#  Query.send( :include, RedmineLike::RedmineExt::QueryPatch)
end
