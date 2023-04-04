# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /Comments/:id' do
  include Devise::Test::IntegrationHelpers

  subject(:put_update) do
    put comment_path(comment), params:
  end

  let(:project) { create(:project) }

  let(:comment) { create(:comment, project_id: project.id) }
  let(:content) { 'updating comment' }

   let(:params) do
    {
      comment: {
        content: content
      }
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
        expect(comment.reload).to have_attributes(content: content)
      end

      it 'redirects user back to project page' do
        put_update
        expect(response).to redirect_to(project_path(project))
      end
    end


    context 'with invalid params' do
      let(:content) { '' }

      it 'redirects user back to project page' do
        put_update
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'record is not updated' do
        put_update
        expect(comment.reload).not_to have_attributes(content: content)
      end
    end
  end
end
