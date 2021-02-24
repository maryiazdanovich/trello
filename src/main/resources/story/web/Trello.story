GivenStories: story/Precondition.story


Scenario: Login as an existing user 
Given I am on the main application page
When I log in as an existing user
When I wait until the page title contains the text 'Boards'
When I change context to an element by the xpath '//nav[@class="home-left-sidebar-container"]'
When I COMPARE_AGAINST baseline with `mainPage`


Scenario: Verify profile
When I change context to an element by the xpath '//div[@class="TMI28E0KnYSK9p"]'
When I click on an element by the xpath '//button[@data-test-id="header-member-menu-button"]'
When I find >= '1' elements by By.xpath(//section[@data-test-id="header-member-menu-popover"]) and for each element do
|step|
|When I COMPARE_AGAINST baseline with `menuPopUp`|
|When I change context to an element by the xpath '//section[@data-test-id="header-member-menu-popover"]'|
|When I click on an element with the text 'Profile and Visibility'|
Then the page title is 'Profile | Trello'
When I change context to the page
Then an element with the attribute 'value' containing '${UserName}' exists
When I click on an element by the xpath '//a[text()='Settings']'
When I click on an element by the xpath '//span[contains(text(),'Notification Email')]'
Then an element by the xpath '//div[@class='no-back']' exists
When I change context to an element by the xpath '//div[@class='no-back']'
When I COMPARE_AGAINST baseline with `NotificationSettings`


Scenario: Creating a Trello board using API
Given request body: <requestBody>
When I set request headers:
|name             |value                     |
|Content-Type     |application/json          |
And I issue a HTTP POST request for a resource with the URL 'https://api.trello.com/1/boards/?key=<key>&token=<token>'
Then the response code is equal to '200'
When I save a JSON element from response by JSON path '$.name' to STORY variable 'BoardName'
Examples:
|key      |token      |requestBody                                          |
|${APIkey}|${APItoken}|{"name": "#{generate(regexify '[A-Z]{1}[a-z]{6}')}"} |



Scenario: Verify created boards
Given I am on the main application page
When I find >= '1' elements by By.xpath(//div[@title='${BoardName}']) and for each element do
|step|
|When I click on an element by the xpath '//div[@title='${BoardName}']'|
|When I change context to an element by the xpath '//div[@class='board-main-content']'|
|Then an element by the xpath '//textarea[text()="To Do"]' exists|
|Then an element by the xpath '//textarea[text()="Doing"]' exists| 
|Then an element by the xpath '//textarea[text()="Done"]' exists| 
When I COMPARE_AGAINST baseline with `BoardsView` ignoring:
|ELEMENT                                                               |
|By.xpath(//div[@class='board-header u-clearfix js-board-header'])|


Scenario: Verify Templates page
When I navigate to home page
When I click on an element by the xpath '//span[text()='Templates']'
When I wait until the page has the title 'Templates | Trello'
When I wait until an element with the xpath '//div[@class='_2pQ0QspMOl1pri']' appears
When I change context to an element by the xpath '//div[@class='_2pQ0QspMOl1pri']'
When I COMPARE_AGAINST baseline with `TemplatesPage`
Then the number of elements found by the xpath '//*[@class='_38hwhHBlt6nX5e']' is equal to '9'

