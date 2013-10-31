Fabricator(:video) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.word }
end