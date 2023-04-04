# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /project/:organisation_id/comment' do
  include Devise::Test::IntegrationHelpers

  subject(:post_create) do
    post project_comments_path(project), params:
  end

  let(:project) { create(:project) }
  let(:content) { 'valid comment.' }

  let(:params) do
    {
      comment: {
        content:
      }
    }
  end

  context 'when user not logged in' do
    it 'redirects user back to login page' do
      expect(post_create).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged in and is authorized to create comment for a project' do
    before do
      sign_in(project.user)
    end

    context 'with valid params' do
      it 'creates a new record' do
        expect do
          post_create
        end.to change(Comment, :count).by(1)
      end

      it 'redirects user back to project page' do
        post_create
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'with invalid params' do
      let(:content) { '' }

      it 'a new record is not created' do
        expect do
          post_create
        end.not_to change(Comment, :count)
      end

      it 'redirects user back to project page' do
        post_create

        expect(response).to redirect_to(project_path(project))
        expect(flash[:alert]).to be_present
      end
    end
  end
end
