Given /^I am (not?) at the home page$/ do |word|
  visit root_path
  if word.present?
    click_link 'about' 
    current_path.should_not == '/'
  else
    current_path.should == '/'
  end
end

When /^I visit the home page$/ do
  visit '/'
end

When(/^I observe the products field$/) do
  within(:css, '#product-container')
  @products = find(:css, '.product-title').collect { |title| title.value }
end

Then(/^I should see (new?) products displayed$/) do |word|
  within(:css, '#product-container')
  if word.present?
    @products.should_not =~ find(:css, '.product-title').collect { |title| title.value }
  else
    page.should have_content('#product-container')
  end
end
