# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    sequence(:password) { |i| "password#{i}" }
  end
end
