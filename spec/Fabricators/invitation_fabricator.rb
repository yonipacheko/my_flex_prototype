Fabricator(:invitation) do
  recipient_name { Faker::Name.name }
  recipient_email { Faker::Internet.name }
  message { Faker::Lorem.paragraph(1) }

end