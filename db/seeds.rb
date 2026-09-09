# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.delete_all

product = Product.create(title: 'Courage Is Calling: Fortune Favors the Brave',
  description:
    %(<p>
      <em>Ryan Holiday's bestselling trilogy--The Obstacle Is the Way, Ego is the Enemy, and Stillness is the Key--captivated professional athletes,
      CEOs, politicians, and entrepreneurs and helped bring Stoicism to millions of readers. Now, in the first book of an exciting new series on the
      cardinal virtues of ancient philosophy, Holiday explores the most foundational virtue of all: Courage.</em>
      Almost every religion, spiritual practice, philosophy and person grapples with fear. The most repeated phrase in the Bible is 'Be not afraid.'
      The ancient Greeks spoke of phobos, panic and terror. It is natural to feel fear, the Stoics believed, but it cannot rule you. Courage, then,
      is the ability to rise above fear, to do what's right, to do what's needed, to do what is true. And so it rests at the heart of the works of
      Marcus Aurelius, Aristotle, and CS Lewis, alongside temperance, justice, and wisdom.
    </p>),
    price: 19.25)


product.image.attach(io: File.open(Rails.root.join('db', 'images', 'did.jpeg')), filename: 'did.jpeg')

product.save!
