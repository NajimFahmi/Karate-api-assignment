Feature: api assignment feature 
@End2End
Scenario: Generate Token 

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
* def primaryPersonID = response.id

Given path "/api/accounts/add-account-address"
When param primaryPersonId = primaryPersonID
And request
"""
{
 
  "addressType": "home",
  "addressLine1": "123 abc street",
  "city": "Kabul",
  "state": "CA",
  "postalCode": "15221",
  "countryCode": "1",
  "current": true
} 
"""
And header Authorization = "Bearer " + generatedToken
When method post 
Then status 201

Given path "/api/accounts/add-account-phone"
When param primaryPersonId = primaryPersonID
And request
"""
{
  "phoneNumber": "4100002895",
  "phoneExtension": "412",
  "phoneTime": "morning",
  "phoneType": "cell"
}
"""
And header Authorization = "Bearer " + generatedToken
When method post
And status 201
Then print response

Given path "/api/accounts/add-account-car"
When param primaryPersonId = primaryPersonID
And request
"""
{
  "make": "Toyota",
  "model": "corolla",
  "year": "2020",
  "licensePlate": "abc 124"
}
"""
And header Authorization = "Bearer " + generatedToken
When method post 
And status 201
Then print response 









