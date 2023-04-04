# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /projects/:id' do
  include Devise::Test::IntegrationHelpers

  subject(:put_update) do
    put project_path(project), params:
  end

  let(:project) { create(:project, status: 'in_progress') }
  let(:status) { 'on_hold' }

  let(:params) do
    {
      status: status
    }
  end

  context 'when user not logged in' do
    it 'redirects user back to login page' do
      expect(put_update).to redirect_to(new_user_session_path)
    end
  end

  context 'when user is logged in and is authorized to create a project' do
    before do
      sign_in(project.user)
    end

    context 'with valid params' do
      it 'updates record' do
        put_update
        expect(project.reload).to have_attributes(status: status)
      end

      it 'creates a new comment record' do
        expect do
          put_update
        end.to change(Comment, :count).by(1)
      end

      it 'redirects user back to project page' do
        put_update
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'with invalid params' do
      let(:status) { '' }

      it 'redirects user back to project page' do
        put_update
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'record is not updated' do
        put_update
        expect(project.reload).not_to have_attributes(status: status)
      end

      it 'new comment record is not created' do
        expect do
          put_update
        end.not_to change(Comment, :count)
      end
    end
  end
end
