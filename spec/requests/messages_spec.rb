require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let(:agus) { create(:user, name: "agus") }
  let(:dimas) { create(:user, name: "dimas") }
  let(:dimas_headers) { valid_headers(dimas.id) }

  let(:samid) { create(:user, name: "samid") }
  let(:samid_headers) { valid_headers(samid.id) }

  # TODO: create conversation between Dimas and Agus, then set convo_id variable
  let(:convo) { create(:conversation, first: dimas, second: agus) }

  describe 'get list of messages' do
    context 'when user have conversation with other user' do
      before :each do
        create_list(:text, 5, user: dimas, conversation: convo)
        create_list(:text, 5, user: agus, conversation: convo)
      end

      before { get "/conversations/#{convo.id}/messages", params: {}, headers: dimas_headers }

      it 'returns list all messages in conversation' do
        expect(dimas.texts.length).to eq 5
        expect(agus.texts.length).to eq 5
        expect(convo.unreads.where("user_id = :user_id",{user_id: dimas.id}).length).to eq 5
        expect(convo.texts.length).to eq 10
        expect_response(
          :ok,
          texts_list_schema
        )
      end
    end

    context 'when user try to access conversation not belong to him' do
      # TODO: create conversation and set convo_id variable
      before :each do
        create_list(:text, 5, user: dimas, conversation: convo)
        create_list(:text, 5, user: agus, conversation: convo)
      end

      before { get "/conversations/#{convo.id}/messages", params: {}, headers: samid_headers }

      it 'returns error 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when user try to access invalid conversation' do
      # TODO: create conversation and set convo_id variable
      before :each do
        create_list(:text, 5, user: dimas, conversation: convo)
        create_list(:text, 5, user: agus, conversation: convo)
      end

      before { get "/conversations/-11/messages", params: {}, headers: samid_headers }

      it 'returns error 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'send message' do
    let(:valid_attributes) do
      { message: 'Hi there!', user_id: agus.id }
    end

    let(:invalid_attributes) do
      { message: '', user_id: agus.id }
    end

    context 'when request attributes are valid for dimas' do
      before { post "/messages", params: valid_attributes.to_json , headers: dimas_headers}

      it 'returns status code 201 (created) and create conversation automatically with agus' do
        expect_response(
          :created,
          text_created_schema
        )
      end
    end

    context 'when create message into existing conversation' do
      before { post "/messages", params: valid_attributes.to_json , headers: samid_headers}

      it 'returns status code 201 (created) and create conversation automatically' do
        expect_response(
          :created,
          text_created_schema
        )
      end
    end

    context 'when an invalid request' do
      before { post "/messages", params: invalid_attributes.to_json , headers: dimas_headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
