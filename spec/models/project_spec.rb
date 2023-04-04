# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project do
  subject(:project) { build(:project) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_inclusion_of(:status).in_array(Project::STATUSES) }

  it { is_expected.to belong_to(:user).class_name('User') }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
end
