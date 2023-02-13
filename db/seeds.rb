# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# demo user
user = User.create(
  email: 'demo@example.com',
  password: '123456'
)
# outcome
categories = [
  { name: 'Food', desc: 'Food prices and spending.', flow: MoneyFlow.expenses,
    faker: 'Faker::Food.ingredient', operations: 58 },
  {  name: 'Devices', desc: 'Tech stuff', flow: MoneyFlow.expenses,
     faker: 'Faker::Device.model_name', operations: 1 },
  {  name: 'House', desc: 'Appliance and other houshold spending.', flow: MoneyFlow.expenses,
     faker: 'Faker::House.furniture', operations: 10 },
  {  name: 'Stuff', desc: 'The monthly cost of using rental property.', flow: MoneyFlow.expenses,
     faker: 'Faker::Marketing.buzzwords', operations: 20 },
  {  name: 'Hobby', desc: 'Some spending for hobby.', flow: MoneyFlow.expenses,
     faker: 'Faker::Hobby.activity', operations: 18 }
]

categories.each do |c|
  category = user.categories.create(name: c[:name], description: c[:desc], money_flow: c[:flow])
  (1..c[:operations]).each do |_|
    price = Faker::Commerce.price
    date = Faker::Time.between(from: DateTime.now - 90.days, to: DateTime.now)
    faker, faker_method = c[:faker].split('.')
    desc = faker.constantize.send(faker_method)
    category.operations.build(amount: price, odate: date, description: desc, user_id: user.id).save
  end
end

# income
sal = user.categories.create(name: 'Salary', description: 'Main income', money_flow: MoneyFlow.income)
sp = user.categories.create(name: 'Side projects', description: 'Side projects income',
                            money_flow: MoneyFlow.income)
user.operations.create(amount: 22_000, odate: DateTime.now - 90.days, description: 'Salary', category_id: sal.id)
user.operations.create(amount: 22_000, odate: DateTime.now - 60.days, description: 'Salary', category_id: sal.id)
user.operations.create(amount: 22_000, odate: DateTime.now - 30.days, description: 'Salary', category_id: sal.id)

user.operations.create(amount: 12_000, odate: DateTime.now - 10.days, description: 'Side projects', category_id: sp.id)
user.operations.create(amount: 1_000, odate: DateTime.now - 14.days, description: 'Side projects', category_id: sp.id)
user.operations.create(amount: 10_000, odate: DateTime.now - 26.days, description: 'Side projects', category_id: sp.id)
user.operations.create(amount: 2_000, odate: DateTime.now - 30.days, description: 'Side projects', category_id: sp.id)
user.operations.create(amount: 14_000, odate: DateTime.now - 41.days, description: 'Side projects', category_id: sp.id)
