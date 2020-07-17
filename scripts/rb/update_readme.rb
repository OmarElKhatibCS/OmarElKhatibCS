# ./scripts/rb/update_readme.rb
require "json"
require "faraday"

# Get all posts
# Take a look how we obtain our secret key by using ENV[]
response = Faraday.get(
  "https://dev.to/api/articles/me/published",
  {},
  { "api-key": ENV["DEV_TO_API_KEY"] }
)

# Retrieve `title`, `url`, and `description` and
# wrap it to markdown syntax
posts = JSON.parse(response.body).map do |article|
  <<~EOF
  [#{article['title']}](#{article['url']})\n
  EOF
end

# Generate your own layout and paste posts in it
# Don't forget to change text and name =)
markdown = <<~EOF
# Welcome to my profile!
I'm a fullstack developer. Follow me on [Dev.to](https://dev.to/elkhatibomar)
My last publications:
#{posts.join}

Script is provided by https://github.com/pashagray
EOF

# Write you markdown to README.MD
File.write("./README.md", markdown)