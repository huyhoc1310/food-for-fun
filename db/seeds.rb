User.create!(name: "admin",
             email: "admin-1@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 2,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "manager",
             email: "manager-1@gmail.com",
             address: "141 xuan thuy, cau giay, ha noi",
             phone_number: "02548652",
             role: 1,
             password: "123456",
             password_confirmation: "123456",
             activated: true,
             activated_at: Time.zone.now)

4.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  address = "Ha Noi"
  phone_number = "016548522"
  password = "123456"
  User.create!(name: name,
               email: email,
               address: address,
               phone_number: phone_number,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
