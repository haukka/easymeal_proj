class DownloadsController < ApplicationController
  def documentation_utilisateur
    send_file(
      "#{Rails.root}/public/2015_UD4_FR_EasyMeal.pdf",
      filename: "2015_UD4_FR_EasyMeal.pdf",
      type: "application/pdf"
    )
  end
  
  def documentation_technique
    send_file(
      "#{Rails.root}/public/2015_TD4_FR_EasyMeal.pdf",
      filename: "2015_TD4_FR_EasyMeal.pdf",
      type: "application/pdf"
    )
  end
end