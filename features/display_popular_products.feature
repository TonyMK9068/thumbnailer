Feature: Display and update view with products from online retailers via ajax

Scenario: User visits home page
  Given I am not at the home page
  When I visit the home page
  Then I should see products displayed
  
Scenario: User remains at home page
  Given I am at the home page
  When I observe the products field
  Then I should see new products displayed