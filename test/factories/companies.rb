FactoryGirl.define do
  factory :company do
    name {(rand * 10000).to_i.to_s}

    enabled true
  end
end