require 'rails_helper'

RSpec.describe 'Conversations API', type: :request do
  let(:dimas) { create(:user, name: "dimas") }
  let(:dimas_headers) { valid_headers(dimas.id) }

  let(:samid) { create(:user, name: "samid") }
  let(:samid_headers) { valid_headers(samid.id) }

  describe 'GET /conversations' do
    context 'when user have no conversation' do
      # make HTTP get request before each example
      before { get '/conversations', params: {}, headers: dimas_headers }

      it 'returns empty data with 200 code' do
        expect_response(
          :ok,
          data: []
        )
      end
    end

    context 'when user have conversations' do
      # TODOS: Populate database with conversation of current user
      before :each do
        dimas.conversations = create_list(:conversation, 5) do |conversation, i|
          conversation.users << create(:user)
          conversation.save!
        end
      end

      before { get '/conversations', params: {}, headers: dimas_headers }

      it 'returns list conversations of current user' do
        # Note `response_data` is a custom helper
        # to get data from parsed JSON responses in spec/support/request_spec_helper.rb

        expect(response_data).not_to be_empty
        expect(response_data.size).to eq(5)
      end

      it 'returns status code 200 with correct response' do
        expect_response(
          :ok,
          data: [
            {
              id: Integer,
              with_user: {
                id: Integer,
                name: String,
                photo_url: String
              },
              last_message: {
                id: Integer,
                sender: {
                  id: Integer,
                  name: String
                },
                sent_at: String
              },
              unread_count: Integer
            }
          ]
        )
      end
    end
  end

  describe 'GET /conversations/:id' do
    let(:convo) { create(:conversation) }
    let(:agus) { create(:user, name: "agus") }

    context 'when the record exists' do
      # TODO: create conversation of dimas
      before :each do
        convo.users << dimas
        convo.users << agus
      end

      before { get "/conversations/#{convo.id}", params: {}, headers: dimas_headers }

      it 'returns conversation detail' do
        expect_response(
          :ok,
          data: {
            id: Integer,
            with_user: {
              id: Integer,
              name: String,
              photo_url: String
            }
          }
        )
      end
    end

    context 'when current user access other user conversation' do
      before { get "/conversations/#{convo.id}", params: {}, headers: samid_headers }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when the record does not exist' do
      before { get "/conversations/-11", params: {}, headers: dimas_headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
