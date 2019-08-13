10.times do
  Restaurant.create!({
    name: Faker::Name.first_name,
    stars: (1..5).to_a.sample,
    review: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam, perferendis."
  })
end
