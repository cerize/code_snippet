require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do

  let(:snippet) {FactoryGirl.create(:snippet)}
  #let(:snippet_2) {FactoryGirl.create(:snippet, {title: snippet.title})}

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new Snippet object and sets it to @snippet" do
      get :new
      expect(assigns(:snippet)).to be_a_new(Snippet)
    end
  end

  describe "#create" do
    context "with valid attributes" do
        it "creates a record in the database" do
          count_before = Snippet.count
          post :create, snippet: FactoryGirl.attributes_for(:snippet)
          count_after = Snippet.count
          expect(count_after - count_before).to eq(1)
        end

        it "redirects to the snippet show page" do
          post :create, snippet: FactoryGirl.attributes_for(:snippet)
          expect(response).to redirect_to(Snippet.last)
        end

        it "sets a flash notice message" do
          post :create, snippet: FactoryGirl.attributes_for(:snippet)
          expect(flash[:notice]).to be
        end
      end
    context "with invalid attributes" do
      def invalid_request
        post :create, snippet: FactoryGirl.attributes_for(:snippet, title: "")
      end

      it "doesn't create a record in the database" do
        count_before = Snippet.count
        invalid_request
        count_after = Snippet.count
        expect(count_after - count_before).to eq(0)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#show" do
    before do
      snippet
      get :show, id: snippet.id
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "finds the object by its id and sets to to @snippet variable" do
      expect(assigns(:snippet)).to eq(snippet)
    end
    it "raises an error if the id passed doesn't match a record in the DB" do
      expect { get :show, id: 2423424234324 }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "fetches all records and assigns them to @snippets" do
      s = FactoryGirl.create(:snippet)
      s1 = FactoryGirl.create(:snippet)
      get :index
      expect(assigns(:snippets)).to eq([s, s1])
    end
  end

  describe "#edit" do
    before do
      get :edit, id: snippet
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end

    it "finds the campaign by id and sets it to @snippet instance variable" do
      expect(assigns(:snippet)).to eq(snippet)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      before do
        patch :update, id: snippet.id, snippet: {title: "new valid name"}
      end
      it "updates the records with new parameter(s)" do
        expect(snippet.reload.title).to eq("new valid name")
      end
      it "redirects to the snippet show page" do
        expect(response).to redirect_to(snippet_path(snippet))
      end
      it "sets a flash notice message" do
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      it "doesn't update the record" do
        title_before = snippet.title
        patch :update, id: snippet.id, snippet: {title: ""}
        expect(snippet.reload.title).to eq(title_before)
      end

      it "renders the edit template" do
        patch :update, id: snippet.id, snippet: {title: ""}
        expect(response).to render_template(:edit)
      end

      it "sets a flash alert message" do
        patch :update, id: snippet.id, snippet: {title: ""}
        expect(flash[:alert]).to be
      end
    end
  end

  # describe "#destroy" do
  #   context "with no signed in user" do
  #     it "redirects to the sign in page" do
  #
  #     end
  #   end
  #   context "with signed in user" do
  #     before { signin(user) }
  #
  #     context "with signed in user as the owner of the snippet" do
  #       it "removes the snippet from the database" do
  #
  #       end
  #
  #       it "redirects to snippets page" do
  #
  #       end
  #     end
  #     context "with signed in user as not the owner of the snippet" do
  #       it "raises an error" do
  #
  #       end
  #     end
  #   end
  # end






end
