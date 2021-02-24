Scenario: Create a user
Given I am on the main application page
When I click on a link with the text 'Sign up'
When I change context to an element with the attribute 'id'='signup-form' 
When I enter '<testUserName>@as-aws-dev.com' in a field with the name 'email'
When I click on an element with the attribute 'id'='signup-submit'
When I wait until the page has the title 'Sign up - Log in with Atlassian account'
When I change context to an element by the xpath '//form[@id='form-sign-up']'
When I enter '<testUserName>' in a field by the xpath '//input[@id='displayName']'
When I enter '<testUserPass>' in a field by the xpath '//input[@id='password']'
When I click on an element by the xpath '//*[text()='Sign up']'

Examples:
|testUserName               |testUserPass                            |
|#{generate(Name.firstName)}|#{generate(regexify '[a-z]{5}[1-9]{3}')}|
|#{generate(Name.firstName)}|#{generate(regexify '[a-z]{5}[1-9]{3}')}|