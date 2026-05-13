@login @ui
Feature: Login Functionality
  As a user
  I want to be able to log in to the system
  So that I can access the application features

  Background:
    Given the user is on the login page
    And the login form is displayed

  @smoke @positive
  Scenario: Successful login with valid credentials
    When the user enters valid username "testuser"
    And the user enters valid password "Test@123"
    And the user clicks the login button
    Then the user should be redirected to the dashboard
    And the user should see the welcome message

  @negative @validation
  Scenario: Login attempt with invalid username
    When the user enters invalid username "invaliduser"
    And the user enters password "Test@123"
    And the user clicks the login button
    Then the user should see the error message "Invalid username or password"
    And the user should remain on the login page

  @negative @validation
  Scenario: Login attempt with invalid password
    When the user enters username "testuser"
    And the user enters invalid password "WrongPassword"
    And the user clicks the login button
    Then the user should see the error message "Invalid username or password"
    And the user should remain on the login page

  @validation @accessibility
  Scenario: Login attempt with empty username
    When the user leaves the username field empty
    And the user enters password "Test@123"
    And the user clicks the login button
    Then the user should see the validation error "Username is required"
    And the login button should be disabled

  @validation @accessibility
  Scenario: Login attempt with empty password
    When the user enters username "testuser"
    And the user leaves the password field empty
    And the user clicks the login button
    Then the user should see the validation error "Password is required"
    And the login button should be disabled

  @validation @accessibility
  Scenario: Login attempt with all empty fields
    When the user leaves the username field empty
    And the user leaves the password field empty
    And the user clicks the login button
    Then the user should see the validation error "Username is required"
    And the user should see the validation error "Password is required"
    And the login button should be disabled

  @security @negative
  Scenario: Account lockout after multiple failed login attempts
    When the user attempts login with invalid credentials 5 times
    And each attempt uses password "WrongPassword"
    Then the user should see the error message "Account locked due to multiple failed attempts"
    And the user should see the message "Please try again later"
    And the login form should be disabled

  @logout @positive
  Scenario: Successful logout
    Given the user is logged in with username "testuser"
    When the user clicks the logout button
    Then the user should be redirected to the login page
    And the session should be cleared
    And the user should not have access to dashboard

  @accessibility @positive
  Scenario: Password field should be masked
    When the user enters password "Test@123"
    Then the password characters should be displayed as dots or asterisks
    And the password should not be visible in plain text

  @positive @accessibility
  Scenario: Remember me functionality
    When the user enters username "testuser"
    And the user enters password "Test@123"
    And the user checks the "Remember me" checkbox
    And the user clicks the login button
    Then the user should be redirected to the dashboard
    And the username should be remembered on next visit to login page