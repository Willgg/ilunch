module UsersHelper
  def t_select_option_genders
    User::GENDERS.map do |s|
      [t('activerecord.attributes.user.sexe_option.' + s.downcase), s, { 'class' => 'normal'}]
    end
  end
end
