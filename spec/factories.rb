# By using the symbol ':user', we get Factory Girl to simulate the User model.
# Factories do bypass attr_acessible, so it's possible to write all attributes
Factory.define :user do |user|
  user.name                  "Sandro Factory"
  user.email                 "sandro@factory.foo"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar lorem ipsum"
  micropost.association :user
end