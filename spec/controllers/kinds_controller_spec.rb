require 'rails_helper'

RSpec.describe KindsController, type: :controller do

  let(:kind) { FactoryGirl.create(:kind)}

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new Kind object and sets it to @kind" do
      get :new
      expect(assigns(:kind)).to be_a_new(Kind)
    end
  end

  describe "#create" do
    context "with valid attributes" do
        it "creates a record in the database" do
          count_before = Kind.count
          post :create, kind: FactoryGirl.attributes_for(:kind)
          count_after = Kind.count
          expect(count_after - count_before).to eq(1)
        end

        it "redirects to the show page" do
          post :create, kind: FactoryGirl.attributes_for(:kind)
          expect(response).to redirect_to(Kind.last)
        end

        it "sets a flash notice message" do
          post :create, kind: FactoryGirl.attributes_for(:kind)
          expect(flash[:notice]).to be
        end
    end
    context "with invalid attributes" do
      def invalid_request
        post :create, kind: FactoryGirl.attributes_for(:kind, name: "")
      end

      it "doesn't create a record in the database" do
        count_before = Kind.count
        invalid_request
        count_after = Kind.count
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
      kind
      get :show, id: kind.id
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "finds the object by its id and sets to to @kind variable" do
      expect(assigns(:kind)).to eq(kind)
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

    it "fetches all records and assigns them to @kinds" do
      k = FactoryGirl.create(:kind)
      k1 = FactoryGirl.create(:kind)
      get :index
      expect(assigns(:kinds)).to eq([k, k1])
    end
  end

  describe "#edit" do

    it "renders the edit template" do
      get :edit, id: kind
      expect(response).to render_template(:edit)
    end

    it "finds the kind by id and sets it to @kind instance variable" do
      get :edit, id: kind
      expect(assigns(:kind)).to eq(kind)
    end
 end

  describe "#update" do
    context "with valid attributes" do
      before do
        patch :update, id: kind.id, kind: {name: "new valid name"}
      end
      it "updates the records with new parameter(s)" do
        expect(kind.reload.name).to eq("new valid name")
      end
      it "redirects to the kind show page" do
        expect(response).to redirect_to(kind_path(kind))
      end
      it "sets a flash notice message" do
        expect(flash[:notice]).to be
      end
    end
    context "with invalid attributes" do
      it "doesn't update the record" do
        name_before = kind.name
        patch :update, id: kind.id, kind: {name: ""}
        expect(kind.reload.name).to eq(name_before)
      end
      it "renders the edit template" do
        patch :update, id: kind.id, kind: {name: ""}
        expect(response).to render_template(:edit)
      end
      it "sets a flash alert message" do
        patch :update, id: kind.id, kind: {name: ""}
        expect(flash[:alert]).to be
      end
    end
  end

end
