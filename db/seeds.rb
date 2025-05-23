# Clear all data
Like.destroy_all
Comment.destroy_all
Photo.destroy_all
FollowRequest.destroy_all
User.destroy_all

# Create users
alice = User.create!(username: "alice", email: "alice@example.com", password: "password", private: false)
bob = User.create!(username: "bob", email: "bob@example.com", password: "password", private: false)
carol = User.create!(username: "carol", email: "carol@example.com", password: "password", private: false)

# Follow requests
FollowRequest.create!(sender: alice, recipient: bob, status: "accepted")
FollowRequest.create!(sender: alice, recipient: carol, status: "accepted")

# Photos
photo1 = Photo.create!(
  caption: "Sunset in Goa",
  image: "https://upload.wikimedia.org/wikipedia/commons/4/4c/Sunset_over_Arabian_Sea_Goa_India.jpg",
  owner: bob
)

photo2 = Photo.create!(
  caption: "Chicago skyline",
  image: "https://upload.wikimedia.org/wikipedia/commons/a/a1/Chicago_skyline%2C_viewed_from_John_Hancock_Center.jpg",
  owner: carol
)

photo3 = Photo.create!(
  caption: "Pizza time",
  image: "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg",
  owner: bob
)

# Comments
Comment.create!(body: "Love this view!", photo: photo1, author: alice)
Comment.create!(body: "Yummy 😍", photo: photo3, author: alice)

# Likes
Like.create!(photo: photo1, fan: alice)
Like.create!(photo: photo2, fan: alice)
Like.create!(photo: photo3, fan: alice)

puts "✅ Seed complete: users, photos, comments, likes"
