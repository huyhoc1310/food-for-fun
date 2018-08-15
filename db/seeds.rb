User.create!(name: "user1",
             email: "demo@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 2,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "user2",
             email: "demo1@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 1,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

5.times do |n|
  name = Faker::Name.name
  email = "demo-#{n+1}@gmail.com"
  address = "Ha Noi"
  phone_number = "016548522"
  password = "password"
  User.create!(name: name,
               email: email,
               address: address,
               phone_number: phone_number,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Restaurant.create!(name: "ahihi 1",
             description: "this is the great restaurant.",
             address: "146 xuan thuy, cau giay, ha noi",
             phone_number: "02548352",
             user_id: 2)

5.times do |n|
  name = "category-#{n+1}"
  Category.create!(name:  name)
end
