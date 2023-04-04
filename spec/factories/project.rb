# frozen_string_literal: true

FactoryBot.define do
  factory :project, class: 'Project' do
    association :user, factory: :user

    name { Faker::Name.first_name }
    description { Faker::Internet.email }
    status { Project::STATUSES.sample }
  end
end
