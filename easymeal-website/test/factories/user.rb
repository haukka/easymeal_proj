# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    username  "superToto"
    firstname "Toto"
    lastname  "Blu"
    password  "superToto"
    gender    "male"
    birth     Date.new(1994,2,3)
    email      "toto@hotmail.fr"
    role      1
    lastConnexion Time.now.to_date
    loginAttempts 0
    lock          nil
    islock        false
    height      177
  end
end
