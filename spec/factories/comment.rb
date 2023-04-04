# frozen_string_literal: true

FactoryBot.define do
  factory :comment, class: 'Comment' do
    association :user, factory: :user
    association :project, factory: :project

    content { 'lllll' }
  end
end
