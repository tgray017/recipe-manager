tom = User.create(:username => "tgray017", :email => "tom@gmail.com", :password => "password")
chicken_tikka = Recipe.create(:name => "Chicken Tikka")
chicken_tikka.ingredients.create(:name => "Rice")
chicken_tikka.ingredients.create(:name => "Chicken breast")
chicken_tikka.ingredients.create(:name => "Masala")
chicken_tikka.creator = tom

