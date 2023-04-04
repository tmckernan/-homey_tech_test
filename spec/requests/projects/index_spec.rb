# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /projects' do
  include Devise::Test::IntegrationHelpers

  subject(:get_projects) do
    get projects_path
  end

  let!(:project) { create(:project) }

  context 'when user not logged in' do
    it 'redirects user back to login page' do
      expect(get_projects).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged in' do
    before do
      sign_in(project.user)
      get_projects
    end

    it 'returns an "Ok" status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
