# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hot_keyword do
    company nil
    name "MyString"
    unuseful false
  end
end
