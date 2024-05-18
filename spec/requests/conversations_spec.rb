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
          empty_schema
        )
      end
    end

    context 'when user have conversations' do
      # TODOS: Populate database with conversation of current user
      before :each do
        conversations = create_list(:user, 5) do |user, i|
          convo = create(:conversation, first: dimas, second: user)
          create(:text, user: dimas, conversation: convo)
        end
      end

      before { get '/conversations', params: {}, headers: dimas_headers }

      it 'returns list conversations of current user' do
        # Note `response_data` is a custom helper
        # to get data from parsed JSON responses in spec/support/request_spec_helper.rb

        expect(response_body).not_to be_empty
        expect(response_body.size).to eq(5)
      end

      it 'returns status code 200 with correct response' do
        expect_response(
          :ok,
          conversations_list_schema
        )
      end
    end
  end

  describe 'GET /conversations/:id' do
    let(:agus) { create(:user, name: "agus") }

    context 'when the record exists' do
      # TODO: create conversation of dimas
      before :each do
        @convo = create(:conversation, first: dimas, second: agus)
      end

      before { get "/conversations/#{@convo.id}", params: {}, headers: dimas_headers }

      it 'returns conversation detail' do
        expect_response(
          :ok,
          conversation_index_schema
        )
      end
    end

    context 'when current user access other user conversation' do
      before :each do
        @convo = Conversation.create(first: dimas, second: agus)
      end

      before { get "/conversations/#{@convo.id}", params: {}, headers: samid_headers }

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
