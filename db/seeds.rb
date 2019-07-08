tom = User.create(:username => "tgray017", :email => "tom@gmail.com", :password => "password")
chicken_tikka = Recipe.create(:name => "Chicken Tikka", :directions => "Season the chicken with salt and pepper, oil up the pan, put the chicken in, cook till finished, boil the rice, put in bowl, add the masala", :total_prep_time => "45 min")
chicken_tikka.ingredients.create(:name => "Rice", :quantity => 2, :unit => "cups")
chicken_tikka.ingredients.create(:name => "Chicken breast", :quantity => 3)
chicken_tikka.ingredients.create(:name => "Masala", :quantity => 3, :unit => "quarts")
chicken_tikka.creator = tom
chicken_tikka.save

hamburger = Recipe.create(:name => "Cheeseburger", :directions => "Throw patty on the grill, flip every 5 min until cooked, place cheese on patty and wait until melted, assemble ingredients on bun", :total_prep_time => "15 min")
hamburger.ingredients.create(:name => "Beef patty", :quantity => 1)
hamburger.ingredients.create(:name => "Hamburger bun", :quantity => 1)
hamburger.ingredients.create(:name => "Lettuce leaf", :quantity => 3)
hamburger.ingredients.create(:name => "Ketchup", :quantity => 2, :unit => "tbsp")
hamburger.ingredients.create(:name => "Cheese", :quantity => 2, :unit => "slices")
hamburger.creator = tom
hamburger.save

victoria = User.create(:username => "vgbegg", :email => "victoria@gmail.com", :password => "wilson")
bbq_chicken = Recipe.create(:name => "BBQ Chicken", :directions => "Season the chicken with salt and pepper, oil up the pan, put the chicken in, lather with BBQ sauce, cook till finished, boil the corn", :total_prep_time => "30 min")
bbq_chicken.ingredients.create(:name => "BBQ sauce", :quantity => 4, :unit => "cups")
bbq_chicken.ingredients.create(:name => "Corn", :quantity => 15, :unit => "oz")
bbq_chicken.ingredients.create(:name => "Chicken breast", :quantity => 2)
bbq_chicken.creator = victoria
bbq_chicken.save


