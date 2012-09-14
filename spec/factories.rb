FactoryGirl.define do
  
  factory :user do |f|
    first_name "Charles"
    last_name "Barrett"
    sequence(:email) {|n| "user#{n}@email.com"}
    password "password"
  end
  
  factory :resource do |f|
    sequence(:name) {|n| "Resource #{n}"}
  end
  
end