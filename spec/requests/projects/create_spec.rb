# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /projects' do
  include Devise::Test::IntegrationHelpers

  subject(:post_create) do
    post projects_path, params:
  end

  let(:user) { create(:user) }
  let(:name) { 'project name' }
  let(:description) { 'project name' }
  let(:status) { 'in_progress' }

  let(:params) do
    {
      project: {
        name:,
        description:,
        status:
      }
    }
  end

  context 'when user not logged in' do
    it 'redirects user back to login page' do
      expect(post_create).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged in and is authorized to create a project' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      it 'creates a new record' do
        expect do
          post_create
        end.to change(Project, :count).by(1)
      end

      it 'redirects user back to project page' do
        post_create
        expect(response).to redirect_to(project_path(Project.last))
      end
    end

    context 'with invalid params' do
      let(:name) { '' }

      it 'a new record is not created' do
        expect do
          post_create
        end.not_to change(Project, :count)
      end

      it 'redirects user back to project page' do
        post_create
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
