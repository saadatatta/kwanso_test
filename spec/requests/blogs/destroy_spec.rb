require 'rails_helper'

RSpec.describe "Blog", type: :request do
  before(:each) do
    @user = create :user_with_blogs
    @login_params = {
      email: @user.email,
      password: @user.password
    }
    @blog = @user.blogs.first
  end

  describe "Destroy Blog" do
    describe "/api/blogs/:id" do
      context "when blog is valid" do
        before(:each) do
          @auth_tokens = auth_tokens_for_user(@login_params)
          delete "/api/blogs/#{@blog.id}", headers: @auth_tokens
        end

        it "returns status of 200" do
          expect(response).to have_http_status(200)
        end

        it "returns message of 'Blog deleted successfully'" do
          expect(JSON.parse(response.body)["message"]).to eql "Blog deleted successfully"
        end
      end

      context "when blog is not valid" do
        before(:each) do
          @auth_tokens = auth_tokens_for_user(@login_params)
          delete "/api/blogs/543432", headers: @auth_tokens
        end

        it "returns status of 422" do
          expect(response).to have_http_status(422)
        end
      end

      context "when user is not authenticated" do
        before(:each) do
          delete "/api/blogs/#{@blog.id}"
        end

        it "returns status of 401" do
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end