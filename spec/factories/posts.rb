FactoryGirl.define do
  factory :post do
    title "Post title"
    description "Post description"

    before(:create) do |post|
      post.user = create(:user)
      post.save
    end
  end
end
