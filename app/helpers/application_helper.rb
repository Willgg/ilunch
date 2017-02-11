module ApplicationHelper
  def admin_view?(params)
    !( params =~ /admin\// ).nil?
  end
end
