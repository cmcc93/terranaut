namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'populator'
    require 'faker'

    admin = User.create!(
      first_name: "Casey",
      last_name: "McCourt",
      username: "cmccourt",
      email: "cas.mcco@gmail.com",
      password: "7&gY6%n)9",
      password_confirmation: "7&gY6%n)9")
    admin.toggle!(:admin)

    # second user
    User.create(
      :first_name => "Gary",
      :last_name => "Busey",
      :username => "garybusey",
      :email => "gary@busey.com",
      :password => "7&gY6%n)9",
      :password_confirmation => "7&gY6%n)9",
      :admin => false)
    # third user
    User.create(
      :first_name => "Jack",
      :last_name => "Kerouac",
      :username => "jackkerouac",
      :email => "jack@kerouac.com",
      :password => "7&gY6%n)9",
      :password_confirmation => "7&gY6%n)9",
      :admin => false)
    # end user section

    20.times do |user|
      first_name  = Faker::Name.first_name
      last_name   = Faker::Name.last_name
      username    = Faker::Name.first_name
      email = Faker::Internet.email
      password = "password"
      User.create!(
        first_name: first_name,
        last_name: last_name,
        username: username,
        email:  email,
        password: password,
        password_confirmation: password)
    end

  end
end