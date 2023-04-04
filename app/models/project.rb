# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  STATUSES = %w[
    in_progress
    completed
    on_hold
    cancelled
    pending
  ].freeze

  # Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  def self.statuses
    STATUSES.each_with_object({}) do |status, h|
      h[status] = status
    end
  end
end
