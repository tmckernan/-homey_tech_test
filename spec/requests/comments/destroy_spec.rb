# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE //comments/:id' do
  include Devise::Test::IntegrationHelpers

  subject(:delete_comment) do
    delete comment_path(comment)
  end

  let(:project) { create(:project) }

  let(:comment) { create(:comment, project_id: project.id) }

  context 'when user not logged in' do
    it 'redirects user back to login page' do
      expect(delete_comment).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged in' do
    before do
      sign_in(project.user)
      delete_comment
    end

    it 'redirects user back to project page' do
      expect(response).to redirect_to(project_path(project))
    end

    it 'Comment record is deleted' do
      expect(Comment.count).to eq(0)
    end
  end
end
