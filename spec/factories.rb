FactoryGirl.define do
  factory :player do
  end

  factory :piece do
    association :game
    association :player

    factory :pawn do
      type 'Pawn'
    end
  end


  factory :game do
    sequence :id do |n|
      n
    end
  end

  # Factories for Omniauth

  factory :auth_hash, class: OmniAuth::AuthHash do

    initialize_with do
      OmniAuth::AuthHash.new({
        provider: provider,
        uid: uid,
        info: {
          email: email
        }
        })
      end

      trait :facebook do
        provider "facebook"
        sequence(:uid)
        email "testuser@facebook.com"
      end

      trait :google do
        provider "google"
        sequence(:uid)
        email "testuser@gmail.com"
      end

      trait :twitter do
        provider "twitter"
        sequence(:uid)
        email "testuser@twitter.com"
      end

      trait :does_not_persist do
        email ""
      end

    end



  end

