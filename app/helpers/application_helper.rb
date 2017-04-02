module ApplicationHelper
  def admin_view?(params)
    !( params =~ /admin\// ).nil?
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
