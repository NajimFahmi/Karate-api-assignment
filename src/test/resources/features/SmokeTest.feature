@smoke
Feature: Authentication Smoke Test

Scenario: Generate token with valid username and password

Given url "https://tek-insurance-api.azurewebsites.net/"
And path "/api/token"
And request 
"""
{
  "username": "supervisor",
  "password": "tek_supervisor"
}
"""
When method post
Then status 200 
Then print response
* def generatedToken = response.token

Given path "/api/accounts/add-primary-account"

* def datagenerator = Java.type('us.karate.fakedataGenerator.FakeDataGenerator')
* def email = datagenerator.getEmail()
* def firstName = datagenerator.getFirstName()
* def lastName = datagenerator.getLastName()
* def phoneNumber = datagenerator.getPhoneNumber 
* def DateofBirth = datagenerator.getDOB()

 And request
 """
 {
  "email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Employed",
  "dateOfBirth": "#(DateofBirth)",
  "new": true
  }
  """
And header Authorization = "Bearer " + generatedToken
When method post 
Then status 201
Then print response 

Scenario: Generate token with invalid username and password 

Given url "https://tek-insurance-api.azurewebsites.net/"
And path "/api/token"
And request 
"""
{
  "username": "supervisor1",
  "password": "tek_supervisor1"
}
"""
When method post
Then status 404 
Then print response
* def generatedToken = response.token

Given path "/api/accounts/add-primary-account"

* def datagenerator = Java.type('us.karate.fakedataGenerator.FakeDataGenerator')
* def email = datagenerator.getEmail()
* def firstName = datagenerator.getFirstName()
* def lastName = datagenerator.getLastName()
* def phoneNumber = datagenerator.getPhoneNumber 
* def DateofBirth = datagenerator.getDOB()

 And request
 """
 {
  "email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Employed",
  "dateOfBirth": "#(DateofBirth)",
  "new": true
  }
  """
And header Authorization = "Bearer " + generatedToken
When method post 
Then status 403
Then print response 
