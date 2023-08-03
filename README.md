# Tea Service

## Summary 

This is a simple tea service application done as part of the take-home portion for Mod 4 of the Turing School of Software and Design Back-End course. The application is a back-end api allowing for the subscribing and unsubscribing of Tea Subscriptions as well as an endpoint to retrieve customer data regarding which subscriptions they have that are active or cancelled. You can read more about the prompt for this <a href='https://mod4.turing.edu/projects/take_home/take_home_be'> here </a>


## Setup Instructions

This application was built using Rails 7 and PostgresQL so please ensure you have already install these. 

### Step 1 - Clone Repo

Navigate to the "code" button on the repository's github page. Select "SSH" and copy the address with the copy button to the right. Now navigate within your terminal to location on computer where you would like to install the application. Once there enter 'git clone' and paste the address' 

### Step 2 - Database and Gem's

Once the repository has been downloaded to your computer in the terminal enter "bundle install" and "rails db:{drop,create,migrate,seed}". These commands will install any gems not already present as well as create the database and seed it with some data

### Step 3 - Spin Up

With these steps completed you should now be able to run there server locally to test out the endpoints. "rails s" will spin up the server locally and allow you to query the database using a tool like Postman or ThunderClient.

## Testing 

Testing was done in this application with RSpec and SimpleCov. In order to run the test suite simply enter "rspec" in the terminal. Current test coverage is at 100% 

![Screenshot 2023-08-03 at 10 29 14 AM](https://github.com/andrew-bingham1/tea_service/assets/119075417/f0057ad1-eb4b-4417-8bf0-53a9b95812f6)

## Database Schemea

![Screenshot 2023-08-03 at 10 30 40 AM](https://github.com/andrew-bingham1/tea_service/assets/119075417/0168e1a7-eb50-45f0-8f70-23e2f7f836f8)


## Endpoints 

### POST /api/v0/customer_subscriptions?customer_id=1&subscription_id=1

<details>
<summary>Response</summary>
  
Status: 201
```json
{
    "message": "New Subscription Created"
}
```

Status: 200 
```json
{
    "message": "Subscription Re-Activated"
}
```

Status: 400 
```json
{
    "error": "Subscription Already Active"
}
```

Status: 400
```json
{
    "error": "Customer must exist and Subscription must exist"
}
```

</details>

### DELETE /api/v0/customer_subscriptions?customer_id=1&subscription_id=1

<details>
<summary>Response</summary>

Status: 200 
```json
{
    "message": "Subscription Cancelled"
}
```

Status: 400 
```json
{
    "error": "Subscription Already Cancelled"
}
```

Status: 404
```json
{
    "error": "Subscription Not Found"
}
```
</details>

### GET /api/v0/customers?id=1

<details>
<summary>Response</summary>

Status: 200 
```json
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "id": 1,
            "first_name": "John",
            "last_name": "Doe",
            "email": "JD@email.com",
            "address": "123 Main St. Somewhere, CO 80000",
            "active_subscriptions": [
                {
                    "id": 1,
                    "title": "Monthly",
                    "price": 10.0,
                    "frequency": 1
                }
            ],
            "cancelled_subscriptions": [
                {
                    "id": 2,
                    "title": "Weekly",
                    "price": 40.0,
                    "frequency": 4
                },
                {
                    "id": 3,
                    "title": "Bi-Weekly",
                    "price": 20.0,
                    "frequency": 2
                }
            ]
        }
    }
}
```

Status: 404
```json
{
    "error": "Customer Not Found"
}
```
  
</details>

