##encoding: utf-8
require 'spec_helper'

describe "User pages" do

  subject { page }
  
  describe "signup" do
    let(:user) { FactoryGirl.create(:admin) }
    before do 
		sign_in user, no_capybara: true
		visit new_user_path
	end

    let(:submit) { "Crear cuenta" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user3@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
	
	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
		  it { should have_content("Actualiza tu perfil") }
		  
		  it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		describe "with invalid information" do
		
		  before { click_button "Save changes" }

		  it { should have_content('error') }
		end
		describe "with valid information" do
		  let(:new_name)  { "New Name" }
		  let(:new_email) { "new@example.com" }
		  before do
			fill_in "Name",             with: new_name
			fill_in "Email",            with: new_email
			fill_in "Password",         with: user.password
			fill_in "Confirm Password", with: user.password
			click_button "Save changes"
		  end

		  it { should have_title(new_name) }
		  it { should have_selector('div.alert.alert-success') }
		  it { should have_link('Cerrar Sesión', href: signout_path) }
		  specify { expect(user.reload.name).to  eq new_name }
		  specify { expect(user.reload.email).to eq new_email }
		end
	end
  end
end