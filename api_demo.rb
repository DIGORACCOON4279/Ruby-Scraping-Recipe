require "json"
require "open-uri"

# TODO - Let's fetch name and bio from a given GitHub username
url = "https://api.github.com/users/ssaunier"


# user = URI.open(url).read

# p user


user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)

# p user

puts "#{user["name"]} - #{user["bio"]} - #{user["location"]} - #{user["followers"]} followers"
