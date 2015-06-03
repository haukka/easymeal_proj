# -*- encoding : utf-8 -*-
module UserHelper
  
  def current_translations
    @translations ||= I18n.backend.send(:translations)
    @translations[I18n.locale].with_indifferent_access
  end
  
end
