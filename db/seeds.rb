# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
CustomerSubscription.destroy_all
Customer.destroy_all
TeaSubscription.destroy_all
Tea.destroy_all
Subscription.destroy_all

customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'JD@email.com', address: '123 Main St. Somewhere, CO 80000')
customer_2 = Customer.create!(first_name: 'Jim', last_name: 'Bob', email: 'JimmyBob@email.com', address: '456 Elm St. Cooltown, CO 80000')
customer_3 = Customer.create!(first_name: 'Susie', last_name: 'Q', email: 'SusieQ@CCR.com', address: '789 Oak St. Denver, CO 80000')
sub_1 = Subscription.create!(title: 'Monthly', price: 10.00, frequency: 1)
sub_2 = Subscription.create!(title: 'Weekly', price: 40.00, frequency: 4)
sub_3 = Subscription.create!(title: 'Bi-Weekly', price: 20.00, frequency: 2)
tea_1 = Tea.create!(title: 'Green Tea', description: 'Green Tea is a type of tea that is made from Camellia sinensis leaves and buds that have not undergone the same withering and oxidation process used to make oolong teas and black teas.')
tea_2 = Tea.create!(title: 'Black Tea', description: 'Black tea is a type of tea that is more oxidized than oolong, green, and white teas. Black tea is generally stronger in flavor than other teas.')
tea_3 = Tea.create!(title: 'Oolong Tea', description: 'Oolong tea is a traditional Chinese tea. It is made from the leaves of the Camellia sinensis plant, the same plant used to make green tea and black tea. The difference is in how the tea is processed.')
tea_sub_1 = TeaSubscription.create!(tea_id: tea_1.id, subscription_id: sub_1.id)
tea_sub_2 = TeaSubscription.create!(tea_id: tea_2.id, subscription_id: sub_1.id)
tea_sub_3 = TeaSubscription.create!(tea_id: tea_3.id, subscription_id: sub_1.id)
tea_sub_4 = TeaSubscription.create!(tea_id: tea_1.id, subscription_id: sub_2.id)
tea_sub_5 = TeaSubscription.create!(tea_id: tea_2.id, subscription_id: sub_2.id)
tea_sub_6 = TeaSubscription.create!(tea_id: tea_3.id, subscription_id: sub_2.id)
tea_sub_7 = TeaSubscription.create!(tea_id: tea_1.id, subscription_id: sub_3.id)
tea_sub_8 = TeaSubscription.create!(tea_id: tea_2.id, subscription_id: sub_3.id)
tea_sub_9 = TeaSubscription.create!(tea_id: tea_3.id, subscription_id: sub_3.id)
customer_sub_1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: sub_1.id, status: 0)
customer_sub_2 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: sub_2.id, status: 1)
customer_sub_3 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: sub_3.id, status: 1)
