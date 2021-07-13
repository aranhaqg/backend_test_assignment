# Introduction

We want to build a car market platform and provide a personalized selection of cars to our users. There are few main models:

* `Brand(name)` - car brands like Mercedes-Benz, Toyota, Volkswagen, BMW.
* `Car(model_name, brand_id, price)` -  cars for sale.
* `User(email, preferred_price_range)` - our users who want to buy a car.
* `UserPreferredBrand(user_id, brand_id)` - relationship to connect the user and his preferred car brands.

We already prepared rails models and seeds data that you can use but feel free to make any changes here (including model relations, validations, database changes etc).

We also have an external recommendation service with modern AI algorithms. The service provides recommended cars for the user. There is the API endpoint `https://bravado-images-production.s3.amazonaws.com/recomended_cars.json?user_id=<USER_ID>` with the following response schema:

```
[
  {
    car_id: <car id>, # car id from seeds data
    rank_score: <number between 0..1> # the higher, then the car the more relevant to the user
  },
  ...
]
```

The response will contain only the top 10 recommended cars for the user. Like many modern AI algorithms, our service not always work well and sometimes can be unavailable or respond with errors. Also, it's not a real-time solution and has updated data only one time every day.

# Problem to be resolved


We need an API endpoint that will accept the following parameters:

```
{
  "user_id": <user id (required)>
  "query": <car brand name or part of car brand name to filter by (optional)>
  "price_min": <minimum price (optional)>
  "price_max": <maximum price (optional)>
  "page": <page number for pagination (optional, default 1, default page size is 20)>
}
```

The API endpoint should return paginated cars list filtered by params passed with the following rules:

1. On top it should be cars with `perfect_match` label. This cars have match with user preferred car brands ( `user.preferred_brands.include?(car.brand) == true`) and with preferred price (`user.preferred_price_range.include?(car.price) == true`).
2. Then we should have `good_match` offers. These offers have the only user preferred car brands (`user.preferred_brands.include?(car.brand) == true`).
3. Then goes top 5 cars suggested by external recommendation service API (they can also be matched as perfect and good matches).
4. Then goes all other cars sorted by price (ASC).

Schema of response:
```
[
  {
    "id": <car id>
    "brand": {
      id: <car brand id>,
      name: <car brand name>
    },
    "price": <car price>,
    "rank_score": <rank score>,
    "model": <car model>,
    "label": <perfect_match|good_match|nil>
  },
  ...
]
```

# Proposed solution

The chosen approach was to use a GraphQl API that accept POST requests with a payload containing the listed params in the last section and the pagination params (page and items). A gem called _pagy_ was used to enable pagination.
A Sidekiq worker will be used to update once a day the list of car recommendations.
Also, this project doesn't include auth and is all dockerized.

To run locally you'll need the docker and docker-compose dependencies installed and run this command on your shell inside the project directory:

```
docker-compose up
```

This is a collection at postman to test the GraphQl API locally: https://www.getpostman.com/collections/a9178be11479ab9a8fe6

Since this is an API-only project it wasn't viable to include the GraphiQL (Graphql Interface). This interface is a nice tool for debugging and could be a good next improvement.
