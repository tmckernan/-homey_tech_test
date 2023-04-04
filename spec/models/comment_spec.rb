# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  subject(:comment) { build(:comment) }

  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to belong_to(:user).class_name('User') }
  it { is_expected.to belong_to(:project).class_name('Project') }
end
