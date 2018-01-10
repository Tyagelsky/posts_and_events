FactoryGirl.define do
  factory :user do
    password "password"
    password_confirmation "password"
    name "Name"
    email { email_rand }
  end
end

def email_rand
  "user#{Random.new.rand(10000)}@test.com"
end
