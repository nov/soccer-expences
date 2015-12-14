module NavigationHelper
  def navi_menus
    [
      {
        link_text: 'navi.event'.t,
        active_on: [:dashboards, :events],
        path: dashboard_path
      },
      {
        link_text: 'navi.member'.t,
        active_on: [:members],
        path: members_path
      }
    ]
  end

  def navi_options_for(menu)
    if menu[:active_on].collect(&:to_s).include? controller_name
      {class: 'active'}
    end
  end
end
