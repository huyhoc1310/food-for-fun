User.create!(name: "user1",
             email: "admin@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 2,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "user2",
             email: "manager@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 1,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "user3",
             email: "user@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 0,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

Restaurant.create!(name: "Restaurant A",
             description: "this is the great restaurant.",
             address: "146 xuan thuy, cau giay, ha noi",
             phone_number: "02548352",
             user_id: 2)

Restaurant.create!(name: "Restaurant B",
             description: "this is the great restaurant.",
             address: "xuan thuy, cau giay, ha noi",
             phone_number: "02548352",
             user_id: 1)

5.times do |n|
  name = "category-#{n+1}"
  Category.create!(name:  name,
                   restaurant_id: 1)
end
