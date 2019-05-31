tom = User.create(:username => "tgray017", :email => "tom@gmail.com", :password => "password")
chicken_tikka = Recipe.create(:name => "Chicken Tikka", :directions => "Season the chicken with salt and pepper, oil up the pan, put the chicken in, cook till finished, boil the rice, put in bowl, add the masala", :total_prep_time => "45 min")
chicken_tikka.ingredients.create(:name => "Rice")
chicken_tikka.ingredients.create(:name => "Chicken breast")
chicken_tikka.ingredients.create(:name => "Masala")
chicken_tikka.creator = tom

