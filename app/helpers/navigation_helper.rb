module NavigationHelper
  def navi_menus
    [
      {
        link_text: Event.model_name.human,
        active_on: [:dashboards, :events],
        icon: :event,
        path: dashboard_path
      },
      {
        link_text: Member.model_name.human,
        active_on: [:members],
        icon: :tag_faces,
        path: members_path
      },
      {
        link_text: Account.model_name.human,
        active_on: [:accounts],
        icon: :supervisor_account,
        path: accounts_path
      }
    ]
  end

  def navi_options_for(menu)
    if menu[:active_on].collect(&:to_s).include? controller_name
      {class: 'active'}
    end
  end
end
