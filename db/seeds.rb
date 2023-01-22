# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# outcome
categories = [
  { name: 'Food', desc: 'Food prices and spending.', flow: Category.oucome_code,
    faker: 'Faker::Food.ingredient', operations: 58 },
  {  name: 'Devices', desc: 'Tech stuff', flow: Category.oucome_code,
     faker: 'Faker::Device.model_name', operations: 1 },
  {  name: 'House', desc: 'Appliance and other houshold expenses.', flow: Category.oucome_code,
     faker: 'Faker::House.furniture', operations: 5 },
  {  name: 'Stuff', desc: 'The monthly cost of using rental property.', flow: Category.oucome_code,
     faker: 'Faker::Marketing.buzzwords', operations: 10 },
  {  name: 'Hobby', desc: 'Some expenses for hobby.', flow: Category.oucome_code,
     faker: 'Faker::Hobby.activity', operations: 8 }
]

categories.each do |c|
  category = Category.create(name: c[:name], description: c[:desc], money_flow: c[:flow])
  (1..c[:operations]).each do |_|
    price = Faker::Commerce.price
    date = Faker::Time.between(from: DateTime.now - 60.days, to: DateTime.now)
    faker, faker_method = c[:faker].split('.')
    desc = faker.constantize.send(faker_method)
    category.operations.build(amount: price, odate: date, description: desc).save
  end
end

# income
sal = Category.create(name: 'Salary', description: 'Main income', money_flow: Category.income_code)
sp = Category.create(name: 'Side projects', description: 'Side projects income',
                     money_flow: Category.income_code)
sal.operations.build(amount: 55_000, odate: DateTime.now - 60.days, description: 'Salary').save
sal.operations.build(amount: 55_000, odate: DateTime.now - 30.days, description: 'Salary').save
sp.operations.build(amount: 15_000, odate: DateTime.now - 40.days, description: 'Salary').save
sp.operations.build(amount: 10_000, odate: DateTime.now - 15.days, description: 'Salary').save
