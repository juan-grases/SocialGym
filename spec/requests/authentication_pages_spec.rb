##encoding: utf-8
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Iniciar Sesión" }

    
      it { should have_selector('div.alert.alert-error', text: 'inválida') }
	  describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
	 describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

    
      it { should have_link('Perfil',     href: user_path(user)) }
      it { should have_link('Configuración',    href: edit_user_path(user)) }
      it { should have_link('Cerrar Sesión',    href: signout_path) }
      it { should_not have_link('Iniciar Sesión', href: signin_path) }
      
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_content('Iniciar Sesión') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
	  describe "as wrong user" do
		  let(:user) { FactoryGirl.create(:user) }
		  let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
		  before { sign_in user, no_capybara: true }

		  describe "visiting Users#edit page" do
			before { visit edit_user_path(wrong_user) }
			it { should_not have_title(full_title('Edit user')) }
		  end

		  describe "submitting a PATCH request to the Users#update action" do
			before { patch user_path(wrong_user) }
			specify { expect(response).to redirect_to(root_url) }
		  end
       end
	end
  end
end