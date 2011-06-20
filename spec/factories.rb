# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name "Michael Hartl"
  user.email "mhartl@example.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

# now we can do @user = Factory(:user) for tests


Factory.sequence :email do |n|
  "person-#{n}@example.com"

end
