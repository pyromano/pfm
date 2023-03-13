# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

class MoneyFaker
  class << self
    def price
      Faker::Commerce.price
    end

    def salary
      22_000
    end

    def side_project
      Faker::Number.between(from: 1_000, to: 15_000)
    end

    def saving
      5_000
    end

    def investment
      2_000
    end
  end
end

class DescriptionFaker
  class << self
    def saving
      'Save money'
    end

    def side_project
      'Earning money from my side project'
    end

    def salary
      'Salary income'
    end
  end
end

CategoryFaker = Struct.new(:name, :desc, :flow, :faker, :amount, :operations)

fake_categories = [
  CategoryFaker.new(
    name: 'Food', desc: 'Food prices and spending.', flow: MoneyFlow.expenses,
    faker: 'Faker::Food.ingredient', amount: 'price', operations: 58
  ),
  CategoryFaker.new(
    name: 'Devices', desc: 'Tech stuff', flow: MoneyFlow.expenses,
    faker: 'Faker::Device.model_name', amount: 'price', operations: 2
  ),
  CategoryFaker.new(
    name: 'House', desc: 'Appliance and other houshold spending.', flow: MoneyFlow.expenses,
    faker: 'Faker::House.furniture', amount: 'price', operations: 10
  ),
  CategoryFaker.new(
    name: 'Stuff', desc: 'The monthly cost of using rental property.', flow: MoneyFlow.expenses,
    faker: 'Faker::Marketing.buzzwords', amount: 'price', operations: 20
  ),
  CategoryFaker.new(
    name: 'Hobby', desc: 'Some spending for hobby.', flow: MoneyFlow.expenses,
    faker: 'Faker::Hobby.activity', amount: 'price', operations: 18
  ),
  CategoryFaker.new(
    name: 'Stocks investment', desc: 'Buy some stocks', flow: MoneyFlow.investment,
    faker: 'Faker::Finance.ticker', amount: 'investment', operations: 40
  ),
  CategoryFaker.new(
    name: 'Save money', desc: 'Growing deposit account', flow: MoneyFlow.saving,
    faker: 'DescriptionFaker.saving', amount: 'saving', operations: 20
  ),
  CategoryFaker.new(
    name: 'Side project', desc: 'Side project income', flow: MoneyFlow.income,
    faker: 'DescriptionFaker.side_project', amount: 'side_project', operations: 10
  ),
  CategoryFaker.new(
    name: 'Salary', desc: 'Salary income', flow: MoneyFlow.income,
    faker: 'DescriptionFaker.salary', amount: 'salary', operations: 4
  )
]

# demo user
user = User.create(
  email: 'demo@example.com',
  password: '123456'
)
fake_categories.each do |fake_category|
  category = user.categories.create(name: fake_category.name, description: fake_category.desc,
                                    money_flow: fake_category.flow)
  (1..fake_category.operations).each do |_|
    amount = MoneyFaker.send(fake_category.amount)
    date = Faker::Time.between(from: DateTime.now - 90.days, to: DateTime.now.end_of_month)

    faker, faker_method = fake_category.faker.split('.')
    desc = faker.constantize.send(faker_method)

    category.operations.build(amount:, odate: date, description: desc, user_id: user.id).save
  end
end
