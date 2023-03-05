# frozen_string_literal: true

require 'rails_helper'

ATTRS = %w[id created_at updated_at].freeze

describe Admin::TracksController do
  def valid_attributes(overrides = {})
    FactoryBot.build(:track).attributes.except(*ATTRS).merge(overrides)
  end

  describe 'authorized' do
    before do
      sign_in_with_email 'test@example.com'
    end
    describe 'GET index' do
      it 'assigns all tracks as @tracks' do
        tracks = []
        tracks << Track.create!(valid_attributes(published: true))
        tracks << Track.create!(valid_attributes(published: false))
        get :index
        expect(assigns(:published)).to eq([tracks[0]])
        expect(assigns(:unpublished)).to eq([tracks[1]])
      end
    end

    describe 'GET show' do
      it 'assigns the requested track as @track' do
        track = Track.create! valid_attributes
        get :show, params: { id: track.to_param }
        expect(assigns(:track)).to eq(track)
      end
    end

    describe 'GET new' do
      it 'assigns a new track as @track' do
        get :new
        expect(assigns(:track)).to be_a_new(Track)
      end
    end

    describe 'GET clone' do
      it 'assigns the requested track as @track' do
        track = Track.create! valid_attributes
        get :clone, params: { id: track.to_param }
        cloned_track = assigns(:track)
        %i[title description author display_title].each do |fld|
          expect(cloned_track.send(fld)).to eql track.send(fld)
        end
        expect(cloned_track.published).to be_falsey
        expect(cloned_track.filename).to be_empty
      end
    end

    describe 'GET edit' do
      it 'assigns the requested track as @track' do
        track = Track.create! valid_attributes
        get :edit, params: { id: track.to_param }
        expect(assigns(:track)).to eq(track)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Track' do
          expect {
            post :create, params: { track: valid_attributes }
          }.to change(Track, :count).by(1)
        end

        it 'assigns a newly created track as @track' do
          post :create, params: { track: valid_attributes }
          expect(assigns(:track)).to be_a(Track)
          expect(assigns(:track)).to be_persisted
        end

        it 'redirects to the created track' do
          post :create, params: { track: valid_attributes }
          expect(response).to redirect_to(admin_track_path(Track.last))
        end

        it 'create handles recorded_on_day/time params' do
          hr = 8
          sfx = 'pm'
          clock_time = "#{hr}:00#{sfx}"
          put :create,
              params: {
                track: valid_attributes(title: 'rock and roll', recorded_on: nil),
                recorded_on_day: '01 Mar, 2013', recorded_on_time: clock_time
              }
          expect(Track.where(title: 'rock and roll').first.recorded_on).to be_present
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved track as @track' do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Track).to receive(:save).and_return(false)
          post :create, params: { track: { 'title' => 'invalid value' } }
          expect(assigns(:track)).to be_a_new(Track)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Track).to receive(:save).and_return(false)
          post :create, params: { track: { 'title' => 'invalid value' } }
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT update' do
      describe 'with valid params' do
        it 'updates the requested track' do
          track = Track.create! valid_attributes
          # Assuming there are no other tracks in the database, this
          # specifies that the Track created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          put :update, params: { id: track.to_param, track: { 'title' => 'thingy' } }
          expect(track.reload.title).to eql 'thingy'
        end

        it 'assigns the requested track as @track' do
          track = Track.create! valid_attributes
          put :update, params: { id: track.to_param, track: valid_attributes }
          expect(assigns(:track)).to eq(track)
        end

        it 'redirects to the track' do
          track = Track.create! valid_attributes
          put :update, params: { id: track.to_param, track: valid_attributes }
          expect(response).to redirect_to(admin_track_path(Track.last))
        end

        it 'properly updates tags' do
          track = Track.create! valid_attributes
          put :update, params: { id: track.to_param, track: { tag_list: 'tag1,tag2' } }
          expect(Track.find(track.id).tag_list).to match_array %w[tag2 tag1]
        end

        it 'properly updates tags' do
          track = Track.create! valid_attributes(tag_list: %w[this that])
          expect(Track.find(track.id).tag_list).to match_array %w[that this]
          put :update, params: { id: track.to_param, track: { tag_list: 'this' } }
          expect(Track.find(track.id).tag_list).to match_array ['this']
        end

        12.times do |hr|
          hr += 7
          sfx = 'pm'
          sfx = 'am' if hr < 12
          clock_time = "#{hr}:00#{sfx}"
          it "computes the proper time given recorded on date and time (given #{clock_time})" do
            track = Track.create! valid_attributes
            put :update, params: { id: track.to_param, track: { title: track.title },
              recorded_on_day: '01 Mar, 2013', recorded_on_time: clock_time }
            r = Track.find(track.id).recorded_on
            expect(r.month).to eql 3
            expect(r.day).to eql 1
            expect(r.year).to eql 2013
            expect(r.hour).to eql hr
          end
        end
      end

      describe 'with invalid params' do
        it 'assigns the track as @track' do
          track = Track.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Track).to receive(:save).and_return(false)
          put :update, params: { id: track.to_param, track: { 'title' => 'invalid value' } }
          expect(assigns(:track)).to eq(track)
        end

        it "re-renders the 'edit' template" do
          track = Track.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Track).to receive(:save).and_return(false)
          put :update, params: { id: track.to_param, track: { 'title' => 'invalid value' } }
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      before do
        @track = Track.create! valid_attributes
      end
      it 'destroys the requested track' do
        expect {
          delete :destroy, params: { id: @track.to_param }
        }.to change(Track, :count).by(-1)
      end

      it 'redirects to the tracks list' do
        delete :destroy, params: { id: @track.to_param }
        expect(response).to redirect_to(admin_tracks_url)
      end
    end
  end
end
