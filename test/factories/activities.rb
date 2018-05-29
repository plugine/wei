FactoryGirl.define do
  factory :activity do
    name "MyString"
    desc "MyText"
    consts "MyText"
    template "@_do_nothing = 1"
  end

end
