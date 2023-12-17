# spec/controllers/lucky_numbers_controller_spec.rb

require 'rails_helper'

describe LuckyNumbersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #view' do
    context 'when user is logged in' do
      before do
        sign_in user
        get :view
      end

      it 'returns HTTP success' do
        expect(response).to have_http_status(:success)
      end
      
      it 'returns JSON for view with 2000' do
        expected_json = { "0": "000000", "1": "001001", "2": "001010", "3": "001100" }.to_json
        get :view, params: { numbers_count: '2000' }, format: :json
        expect(response).to have_http_status(:success)
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the sign-in page' do
        get :view
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
