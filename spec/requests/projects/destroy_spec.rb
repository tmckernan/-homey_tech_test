# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /projects/:id' do
  include Devise::Test::IntegrationHelpers

  subject(:delete_project) do
    delete project_path(project)
  end

  let(:project) { create(:project) }

  context 'when user not logged in' do
    it 'redirects user back to login page' do
      expect(delete_project).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged in' do
    before do
      sign_in(project.user)
    end

    it 'redirects user back to projects page' do
      delete_project
      expect(response).to redirect_to(projects_path)
    end

    it 'project record is deleted' do
      expect do
        delete_project
      end.to change(Project, :count).by(-1)
    end
  end
end
