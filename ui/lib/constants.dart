import 'package:flutter/material.dart';
import 'package:ui/screens/Meal%20Plan/model/recipe.dart';

// This constant is for the login background gradient color
const kBackgroundBlueGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff01CDFA), Colors.white],
);

// This constant is for the text field decoration
const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: '',
//  prefixIcon: Icon(Icons.done),
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff01CDFA), width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff01CDFA), width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);

// This constant is for the Text style for the
const kTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Regular',
);

const SKIN_CANCER_PROGNOSIS_QUESTIONS_MALE = [
  "Age",
  "Complexion",
  "Blistering sunburn (one or more)",
  "Number of moles larger than 5mm in diameter on patient's back",
  "Number of moles less than or equal to 5mm in diameter on patient's back",
  "How extensive is the freckling on the patient's back and shoulders?",
  "Does the patient have severe solar damage on the shoulders?"
];

const SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_MALE = [
  ["Light", "Medium", "Dark"],
  ["Yes", "No"],
  ["Less than 2", "2 or more"],
  ["Less than 7", "7 to 16", "17 or more"],
  ["Absent", "Mild Freckling", "Moderate Freckling", "Severe Freckling"],
  ["Yes", "No"],
];
const SKIN_CANCER_PROGNOSIS_QUESTIONS_FEMALE = [
  "Age",
  "Complexion",
  "Skin result of repeated and prolonged exposure to sunlight",
  "Number of moles less than or equal to 5mm in diameter on patient's back",
  "How extensive is the freckling on the patient's back and shoulders?"
];
const SKIN_CANCER_PROGNOSIS_ANSWER_OPTIONS_FEMALE = [
  ["Light", "Medium", "Dark"],
  [
    "Very brown and deeply tanned",
    "Moderately tanned",
    "Lightly tanned",
    "No tan at all"
  ],
  ["Less than 5", "5 to 11", "12 or more"],
  ["Absent", "Mild Freckling", "Moderate Freckling", "Severe Freckling"],
];

const LUNG_CANCER_PROGNOSIS_QUESTIONS = [
  "Age",
  "Gender",
  "Air Pollution",
  "Alcohol use",
  "Dust Allergy",
  "Occupational Hazards",
  "Genetic Risk",
  "Chronic Lung Disease",
  "Balanced Diet",
  "Obesity",
  "Smoking",
  "Passive Smoker",
  "Chest Pain",
  "Coughing of Blood",
  "Fatigue",
  "Weight Loss",
  'Shortness of Breath',
  "Wheezing",
  "Swallowing Difficulty",
  "Clubbing of Finger Nails",
  "Frequent Cold",
  "Dry Cough",
  "Snoring",
];

const BREAST_CANCER_PROGNOSIS_QUESTIONS = [
  "Radius Mean",
  "Radius SE",
  "Texture Mean",
  "Texture SE",
  "Perimeter Mean",
  "Perimeter_se",
  "Compactness Mean",
  "Compactness SE",
  "Compactness Worst",
  "Concavity Mean",
  "Concavity SE",
  "Concavity Worst",
  "Points Mean",
  "Points Worst",
  "Concave",
  "Concave Points SE",
  "Fractal Dimension Mean",
  "Fractal Dimension SE",
  "Fractal Dimension Worst",
  "Symmetry SE",
  "Symmetry Worst",
  "Tumor Size",
  "Positive Axillary Lymph Node"
];

const List<Recipe> RECIPES = [
  Recipe(
      title: 'Spring Salad',
      imageUrl:
          'https://www.twopeasandtheirpod.com/wp-content/uploads/2018/04/Spring-Cobb-Salad-3.jpg',
      duration: 'Breast Cancer',
      ingredients: '- 1 block (14 oz.) firm tof\n'
          '- 1 Tbsp. sesame oil\n'
          '- 1 Tbsp. low-sodium soy sauce\n'
          '- 1 Tbsp. cornstarch\n'
          '- 1 tsp. ground ginger\n'
          '- 1 tsp. garlic powder\n'
          '- pre-washed salad greens (about 5 oz.)\n'
          '- 2 cups snow pea pods, trimmed and sliced on diagonal into 3/4-inch pieces\n'
          '- 1 cup frozen shelled edamame, cooked according to package directions\n'
          '- 1 English cucumber (4 in.), sliced in half lengthwise and cut into thin half-moons\n'
          '- 1/4 cup loosely packed mint leaves, roughly chopped, or more to taste\n'
          '- 1/4 cup sesame ginger salad dressing, or more to taste\n',
      steps:
          '1. Preheat oven to 400 degrees F. Line a large, rimmed baking sheet with parchment paper and set aside.\n'
          '\n'
          '2. Place tofu in a colander and drain water. Wrap tofu in a few layers of paper towels and transfer to a cutting board. Press block under a baking sheet to squeeze out excess water. Stack something heavy on top such as a few cans of beans or a kettle filled with water. Let drain, about 20 minutes.\n'
          '\n'
          '3. Remove paper towels. Cut tofu into forty-eight 3/4-inch cubes.\n'
          '\n'
          '4. Meanwhile, in large bowl, whisk together sesame oil, soy sauce, cornstarch, ginger and garlic powder. Add tofu cubes and toss gently until well coated.\n'
          '\n'
          '5. Transfer tofu to prepared baking sheet. Bake until golden, about 20 minutes. Turn cubes halfway through to ensure even baking.\n'
          '\n'
          '6. Set out 4 dinner-size salad bowls. Fill each with salad greens, snow peas, edamame, cucumber, mint, dressing and tofu croutons.\n'),
  Recipe(
    title: 'Pistachio Crumble Tacos',
    imageUrl:
        'https://www.brandnewvegan.com/wp-content/uploads/2016/08/cauliflower-tacos.jpg',
    duration: 'Lung Cancer',
    ingredients: '- 3/4 cup shelled unsalted pistachios, divided\n'
        '- 1 Tbsp. extra-virgin olive oil\n'
        '- 1 small red bell pepper, cut into ½-inch dice\n'
        '- 4 ounces button mushrooms, roughly chopped (1¼ cups)\n'
        '- 1/2 cup onion, finely diced\n'
        '- 1 garlic clove, minced\n'
        '- 1 tsp. ground cumin\n'
        '- 1/2 tsp. dried oregano\n'
        '- 1/2 tsp. chili powder\n'
        '- 1/4 tsp. chipotle powder\n'
        '- kosher salt, to taste\n'
        '- 8 corn tortillas, warmed\n',
    steps: '1. 1/2 ripe avocado, peeled and pitted\n'
        '\n'
        '2. 2 Tbsp. plain reduced-fat Greek yogurt\n'
        '\n'
        '3. Juice of half a lime, about 2 Tbsp.\n'
        '\n'
        '4. 2 Tbsp. chopped pistachio\n'
        '\n'
        '5. 2 Tbsp. fresh cilantro leaves, roughly chopped\n'
        '\n'
        '6. 2 Tbsp. fresh mint leaves, roughly chopped\n'
        '\n'
        '7. 1/8 tsp. kosher salt\n'
        '\n'
        '8. A few pinches chipotle powder\n',
  ),
  Recipe(
    title: 'Banana Bread',
    imageUrl:
        'https://natashaskitchen.com/wp-content/uploads/2018/12/Chocolote-Banana-Bread-2.jpg',
    duration: 'Skin Cancer',
    ingredients: '- 3 ripe medium bananas, peeled, mashed\n'
        '- 1/2 cup milk or soy milk, plain, unsweetened\n'
        '- 1/4 cup vegetable oil\n'
        '- 2 Tbsp. chia seeds\n'
        '- 1 tsp. vanilla\n'
        '- 1/4 cup brown sugar\n'
        '- 1 1/4 cups whole-wheat flour\n'
        '- 1 tsp. baking soda\n'
        '- 1/2 tsp. baking powder\n'
        '- 1/2 tsp. cinnamon\n'
        '- Pinch salt (optional)\n'
        '- 2 Tbsp. sunflower seeds\n'
        '- 2 Tbsp. coconut, unsweetened, shredded\n'
        '- 2 Tbsp. sliced almonds\n'
        '- 3 Tbsp, pistachio nuts\n'
        '- 3 Tbsp. chopped walnuts\n'
        '- Nonstick cooking spray\n',
    steps: '1. Preheat oven to 350 degrees F.\n'
        '\n'
        '2. In mixing bowl, whip together bananas, soy milk, vegetable oil, chia seeds, vanilla and sugar for two minutes. For best results, use an electric mixer.\n'
        '\n'
        '3. Stir in remaining ingredients, mixing only until well combined.\n'
        '\n'
        '4. Spray loaf pan with nonstick cooking spray.\n'
        '\n'
        '5. Pour batter into loaf pan and bake for about 65 minutes, until fork inserted in center comes out clean.\n'
        '\n'
        '6. Remove, cool slightly before slicing.\n',
  ),
  Recipe(
    title: 'Summer Lasagna',
    imageUrl:
        'https://www.aicr.org/wp-content/uploads/2020/02/summer-lasagna.jpg',
    duration: 'Lung Cancer',
    ingredients: '- 2 eggplants (about 3 lbs.), quartered lengthwise\n'
        '- 6 medium zucchini (about 3 lbs.)\n'
        '- Canola oil cooking spray\n'
        '- 15 oz. low-fat ricotta or low-fat cottage cheese (or a combination of both)\n'
        '- 2 eggs\n'
        '- 1/2 cup grated Parmesan cheese\n'
        '- 1/2 tsp. ground nutmeg\n'
        '- 1/2 tsp. garlic powder\n'
        '- 4 cups low-sodium tomato sauce\n'
        '- 1 lb. whole-wheat, no-boil lasagna noodles\n'
        '- 3 cups part-skim mozzarella cheese\n',
    steps:
        '1. Preheat oven to 450 degrees F. Grease a 13 x 9 x 2-inch baking pan, set aside.\n'
        '\n'
        '2. Slice the eggplant and zucchini in ½ -inch slices. Layer on two baking sheets and coat both sides of the vegetables with cooking spray. Roast for about 40 minutes.\n'
        '\n'
        '3. Reduce the oven temperature to 375 degrees F.\n'
        '\n'
        '4. Meanwhile, in a medium bowl, mix together the ricotta and/or cottage cheeses, eggs, Parmesan, nutmeg and garlic powder.\n'
        '\n'
        '5. To assemble: spread a thin layer of sauce over the bottom of the prepared pan. Cover with a layer of pasta. Spread ⅓ of the ricotta mixture on top of pasta. Sprinkle ¼ of the mozzarella over the ricotta. Spoon ⅓ of the roasted vegetables on top. Top with ½ cup of tomato sauce and continue the assembly as directed until you have 4 layers of pasta and 3 layers of filling. Spread the remaining sauce on top and sprinkle with the remaining mozzarella cheese.\n'
        '\n'
        '6. Cover the pan with aluminum foil and bake for 30 minutes. Uncover and continue to bake until golden and bubbly, about 15 minutes more. Let stand for 15 minutes before serving.\n',
  ),
  Recipe(
    title: 'Quinoa Risotto Primavera',
    imageUrl: 'https://under500calories.com/photos/10057.jpg',
    duration: 'Skin Cancer',
    ingredients:
        '- 2.5 cups cauliflower florets cut into 1-inch pieces, stems well-trimmed\n'
        '- 1 1/2 tbsp extra virgin olive oil\n'
        '- 1/2 cup finely chopped onion\n'
        '- 2 Tbsp. finely chopped shallot\n'
        '- 2/3 cup quinoa, rinsed and drained\n'
        '- 3 1/2 cups fat-free, reduced sodium chicken broth, divided\n'
        '- 1/3 cup thinly sliced baby carrots\n'
        '- 1/2 cup frozen peas\n'
        '- 1/4 cup grated Parmesan cheese\n'
        '- salt and freshly ground black pepper\n'
        '- 1/3 cup chopped flat leaf parsley\n',
    steps:
        '1. Place cauliflower in food processor. Pulse until cauliflower resembles crumbled feta, about 15-20 pulses; there should be 2 cups chopped cauliflower to set aside. Add leftovers to soup or salad.\n'
        '\n'
        '2. In heavy, wide, large saucepan, heat oil over medium-high heat. Add onion and cook, stirring often, for 3 minutes. Add shallots and cook until golden, about 3 minutes, stirring occasionally. Add quinoa and cook, stirring constantly, until grain makes constant crackling, popping sound, about 5 minutes. Carefully add 2 cups broth, standing back as it will spatter. Cover, reduce heat and simmer quinoa for 10 minutes.\n'
        '\n'
        '3. Add cauliflower, carrots and 1/2 cup hot broth and simmer, uncovered, for 5 minutes, stirring often. Add peas and enough broth to keep risotto soupy, about 1/4 cup. Cook 8-10 minutes, or until quinoa is al dente or to your taste and vegetables are tender-crisp, adding broth 1/4 cup at a time, as needed. Risotto is done when liquid is mostly absorbed and mixture is slightly wet, but not soupy. Off heat, stir in cheese and season to taste with salt and pepper. Garnish with parsley and serve. Leftover risotto keeps for 3 days, covered in refrigerator, and can be served at room temperature as a whole-grain salad.\n',
  ),
  Recipe(
    title: 'Citrus Quinoa Avocado Salad',
    imageUrl:
        'https://www.onceuponapumpkinrd.com/wp-content/uploads/2020/01/citrus-salad-with-avocado-683x1024.jpg',
    duration: 'Breast Cancer',
    ingredients: '- 1/2 cup cucumber, diced\n'
        '- 1 cup cherry tomatoes, cut in half\n'
        '- 2 small cloves garlic, minced\n'
        '- 1/4 cup red onion, chopped\n'
        '- 1 bunch cilantro\n'
        '- 2 cups spinach, thinly sliced\n'
        '- 1 15.5 oz can no salt added garbanzo beans (drained and rinsed)\n'
        '- 1 cup cooked and cooled quinoa\n'
        '- 2 medium avocados, diced\n'
        '- Juice of 2 lemons\n'
        '- Zest of 1 lemon\n'
        '- 2 tsp. Dijon mustard\n'
        '- 1 Tbsp. olive oil\n'
        '- 1 tsp. honey\n'
        '- 1/2 tsp. ground cumin\n'
        '- Dash of cayenne pepper\n'
        '- Salt and pepper, to taste',
    steps: '1. Place all salad ingredients in a bowl.\n'
        '\n'
        '2. Whisk all dressing ingredients together in a separate bowl.\n'
        '\n'
        '3. Drizzle dressing over salad mixture and gently toss ingredients together until dressing is incorporated throughout.\n',
  ),
  Recipe(
    title: 'Mango Carrot Ginger Smoothie',
    imageUrl:
        'https://sharonpalmer.com/wp-content/uploads/2017/06/mango-carrot-1.jpg',
    duration: 'Skin Cancer',
    ingredients: '- 1 mango, peeled, sliced into chunks\n'
        '- 1/2 orange, peeled, quartered\n'
        '- 1 large carrot, sliced into large chunks\n'
        '- 1 1/2 cups soy milk, plain\n'
        '- 1 (1-inch) piece, peeled fresh ginger\n'
        '- 6 ice cubes',
    steps: '1. Place all ingredients in a blender and process until smooth.\n'
        '\n'
        '2. Pour into 2 glasses.\n',
  ),
  Recipe(
    title: 'Stuffed Portobellos',
    imageUrl:
        'https://i.pinimg.com/736x/9a/28/4f/9a284fe682c66879f563d20ccba7f3e8.jpg',
    duration: 'Breast Cancer',
    ingredients: '- 4 large portobello mushroom caps\n'
        '- 2 Tbsp. olive oil, divided\n'
        '- 3 small shallots, chopped\n'
        '- 3 cloves garlic, chopped\n'
        '- 6 oil-packed sun-dried tomatoes, drained and chopped\n'
        '- 5 cups raw baby spinach\n'
        '- 1/4 tsp. black pepper\n'
        '- 1 cup cherry tomatoes, quartered\n'
        '- 1/4 cup grated Parmesan cheese, divided\n'
        '- 4 oz. goat cheese sliced\n'
        '- 1 Tbsp. balsamic vinegar, divided\n'
        '- 8 basil leaves, thinly sliced',
    steps: '1. Preheat oven to 400°F.\n'
        '\n'
        '2. Using damp paper towel or cloth, gently wipe any dirt from portobello caps. Use small knife to slice off each stem at base of caps and discard.\n'
        '\n'
        '3. Coat mushroom caps on each side using 1 Tbsp. olive oil. Place mushrooms gill-side up on a baking sheet and roast until they start to soften, about 10 minutes. While mushrooms are roasting, make the filling.\n'
        '\n'
        '4. Heat large skillet over medium heat and add 1 Tbsp. olive oil until it begins to shimmer. Add shallots and garlic and sauté 1-2 minutes, until translucent.\n'
        '\n'
        '5. Add sun-dried tomatoes and stir.\n'
        '\n'
        '6. Add spinach and stir gently until spinach begins to wilt, about 1 minute. Add pepper.\n'
        '\n'
        '7. Add cherry tomatoes and sauté for another minute. Remove pan from heat and set aside.\n'
        '\n'
        '8. Remove mushrooms from oven and divide spinach mixture evenly among each portobello cap.\n'
        '\n'
        '9. Top each cap with 1 Tbsp. Parmesan cheese and 1 oz. goat cheese. Broil mushroom caps an additional 1-2 minutes until cheese starts to melt.\n'
        '\n'
        '10. Serve each cap topped with a drizzle of balsamic vinegar and basil.\n',
  ),
  Recipe(
    title: 'Tex-Mex Sorghum Chili',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYO6J3I5VqKs0cutWG0C-_HCRBJH81X75Ilg&usqp=CAU',
    duration: 'Skin Cancer',
    ingredients: '- 2 cups dried black beans\n'
        '- 1 1/2 cups dried whole grain sorghum\n'
        '- 4 cups water\n'
        '- 4 cups vegetable broth\n'
        '- 3 stalks celery, diced\n'
        '- 1 large onion, diced\n'
        '- 3 cloves garlic, minced\n'
        '- 1 green bell pepper, diced\n'
        '- 1 cup yellow corn, frozen or canned, drained\n'
        '- 1 14.5-ounce can fire-roasted, crushed tomatoes with juice\n'
        '- 2 Tbsp. tomato paste\n'
        '- 3 Tbsp. Mexican seasoning blend\n'
        '- Salt to taste (optional)',
    steps:
        '1. Place beans in a large pot, cover with water and soak overnight.\n'
        '\n'
        '2. The next day, discard the water, and add 4 cups fresh water and 4 cups vegetable broth. Add dried sorghum, stir well, cover and simmer over medium-low heat for 45 minutes, stirring occasionally.\n'
        '\n'
        '3. Add celery, onion, garlic, pepper, corn, tomatoes, tomato paste, and Mexican seasoning blend*. Stir well to combine. Cover and simmer for an additional 45 minutes, stirring occasionally, until beans, sorghum, and vegetables are tender. May need to add additional water lost to evaporation. Should make a thick stew-like texture.\n'
        '\n'
        '4. Serve in bowls and garnish as desired with tortilla chips, fresh avocado slices, green onion slices, chopped fresh cilantro, and chopped fresh tomatoes.\n',
  ),
  Recipe(
    title: 'Lasagna Noodles',
    imageUrl:
        'https://sharonpalmer.com/wp-content/uploads/2020/03/IMG_6027-683x1024.jpg',
    duration: 'Lung Cancer',
    ingredients: '- 4 small zucchini squash\n'
        '- 1 Tbsp. extra-virgin olive oil\n'
        '- 1 medium onion, finely diced\n'
        '- 3 cloves garlic, minced\n'
        '- 2 stalks celery, finely chopped\n'
        '- 5 ounces (about 2 cups) mushrooms, thinly sliced\n'
        '- 1 32-ounce jar marinara sauce\n'
        '- 2 Tbsp. tomato paste\n'
        '- 1 Tbsp. soy sauce\n'
        '- 1/2 cup red wine*\n'
        '- 1 Tbsp. Italian seasoning blend\n'
        '- 1/2 tsp. black pepper\n'
        '- 1/4 tsp. salt (optional)\n'
        '- 1 1/2 cups ground walnuts, divided\n'
        '- Nonstick cooking spray\n'
        '- 1 cup shredded plant-based cheese*\n'
        '- 2 Tbsp. chopped Italian parsley',
    steps:
        '1. Slice zucchini horizontally into long, thin slices (about 5 horizontal slices per squash). Place on paper towels and set aside (to soak up extra moisture).\n'
        '\n'
        '2. Place a Dutch oven or large saucepan on medium heat and add olive oil.\n'
        '\n'
        '3. Add onion, garlic and celery, and sauté for 3 minutes, stirring frequently.\n'
        '\n'
        '4. Add mushrooms and sauté for an additional 2 minutes.\n'
        '\n'
        '5. Add marinara sauce, tomato paste, soy sauce, red wine, Italian seasoning, black pepper and salt (if using). Stir well and cover. Simmer over medium heat for 10-15 minutes, stirring occasionally, until thickened and vegetables are tender.\n'
        '\n'
        '6. Measure out 1 1/4 cups ground walnuts (may chop in a food processor or high-powered blender; should resemble consistency of course grains of sand, but should not be overly processed to a flour texture), reserving remaining ¼ cup ground walnuts for topping. Add the 1 1/4 cups ground walnuts to the sauce, and heat for 2 minutes.\n'
        '\n'
        '7. Preheat oven to 350 degrees F.\n'
        '\n'
        '8. Spray a 13x9-inch baking dish with nonstick cooking spray. Place one-third (6-7 slices) of the zucchini slices on the bottom of the dish. Layer with one-third of the walnut tomato sauce. Sprinkle with 1/3 cup of the shredded cheese. Repeat layers two more times, for a total of three layers of zucchini, walnut tomato sauce and cheese.\n'
        '\n'
        '9. Place baking dish in the oven uncovered and bake for 40 minutes.\n'
        '\n'
        '10. Sprinkle remaining 1/4 cup ground walnuts over top of lasagna and set oven to broiler setting. Broil for 2 minutes, until golden brown.\n'
        '\n'
        '11. Remove from oven, garnish with fresh chopped parsley, slice into squares and serve immediately.\n',
  ),
  Recipe(
    title: 'Blueberry Blast Smoothie',
    imageUrl:
        'https://www.pumpkinnspice.com/wp-content/uploads/2015/03/blueberry-blast-smoothie6.jpg',
    duration: 'Breast Cancer',
    ingredients: '- 2 cups frozen unsweetened blueberries (do not thaw)\n'
        '- 1/2 cup orange juice (calcium-fortified preferred)\n'
        '- 3/4 cup low-fat or nonfat vanilla yogurt\n'
        '- 1/2 medium frozen banana\n'
        '- 1/2 tsp. pure vanila extract',
    steps:
        '1. Place blueberries, orange juice, yogurt, banana and vanilla into blender.\n'
        '\n'
        '2. Cover securely and blend for 30 to 35 seconds or until thick and smooth. For thinner smoothies, add more juice; for thicker smoothies, add more frozen fruit.\n'
        '\n'
        '3. Pour into 2 glasses and serve immediately.\n',
  ),
  Recipe(
    title: 'Strawberry Chia Smoothie',
    imageUrl:
        'https://static01.nyt.com/images/2013/05/21/science/24recipehealth/24recipehealth-articleLarge.jpg',
    duration: 'Skin Cancer',
    ingredients: '- 3/4 cup skim milk\n'
        '- 4 tsp. chia seeds\n'
        '- 1 cup fresh strawberries\n'
        '- 1 Tbsp. strawberry fruit spread, or to taste\n'
        '- 2 tsp. orange zest\n'
        '- 1/2 tsp. chopped fresh ginger\n'
        '- 1/2 tsp. vanilla extract',
    steps:
        '1. Place milk and chia seeds in a blender and let sit while measuring remaining ingredients.\n'
        '\n'
        '2. Add strawberries, preserves, orange zest, ginger and vanilla to blender. Whirl on high speed until smoothie is blended and creamy, about 1 minute.\n'
        '\n'
        '3. Pour into a tall glass and serve immediately.\n',
  ),
  Recipe(
    title: 'Power Mocha Smoothie',
    imageUrl: 'https://leaf.nutrisystem.com/wp-content/uploads/2019/11/2-1.jpg',
    duration: 'Breast Cancer',
    ingredients: '- 1 vanilla bean\n'
        '- 1 frozen banana\n'
        '- 1 cup brewed Purity Coffee, chilled\n'
        '- 2 Tbsp. hulled hemp seeds\n'
        '- 1 Tbsp. unsweetened cocoa powder\n'
        '- 1 Tbsp. nut butter (e.g. peanut butter, almond butter, cashew butter)\n'
        '- 1 tsp. fresh turmeric root, minced\n'
        '- Pinch of black pepper',
    steps:
        '1. Combine all ingredients in a high-power blender or food processor and blend until smooth. Drink immediately.\n',
  ),
  Recipe(
    title: 'Salmon and Veggie Egg Muffins',
    imageUrl:
        'https://recipetineats.com/wp-content/uploads/2018/02/Healthy-Egg-Muffins_8.jpg',
    duration: 'Lung Cancer',
    ingredients: '- Nonstick cooking spray\n'
        '- 2 tsp. extra-virgin olive oil\n'
        '- 1/2 red bell pepper, cut into 1/2-inch dice\n'
        '- 2 cups baby spinach, roughly chopped and packed\n'
        '- 2 green onions, trimmed, sliced and chopped\n'
        '- 5 large eggs\n'
        '- One 2.6-ounce pouch wild-caught pink salmon in extra-virgin olive oil, flaked*\n'
        '- 1/2 cup shredded reduced-fat Cheddar cheese\n'
        '- 1/4 cup fresh basil, finely chopped\n'
        '- Kosher salt and black pepper, to taste\n'
        '- 100% whole-grain bread, toasted\n'
        '- Optional spreads for toast: Smashed avocado, olive oil, nut butter, hummus, butter substitute',
    steps:
        '1. Preheat oven to 350°F. Lightly coat 6-cup muffin pan with nonstick cooking spray and set aside.\n'
        '\n'
        '2. Heat oil in nonstick skillet over medium-high heat. Add peppers and cook, stirring frequently, until tender, 5 minutes. (Adjust heat to medium if peppers begin to burn.) Add spinach and onions and cook, stirring frequently, until wilted, 2 minutes. Set aside to cool slightly.\n'
        '\n'
        '3. Crack eggs into large bowl. Whisk until well combined. Stir in salmon, cheese, basil, cooked vegetables and salt and pepper until combined. Use a 1/3 measuring cup to divide mixture evenly into prepared muffin cups. Bake until eggs are set, about 18 minutes.\n'
        '\n'
        '4. Serve with 1 slice toast with topping of your choice and fruit or vegetable salad on the side.\n',
  ),
];
