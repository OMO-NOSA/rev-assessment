# DJANGO HELLO API

## STACK
* language: Python3
* Framework: Django
* Database: Postgres
* Infrastructure: Docker and Docker Compose
* Cloud Deployment: AWS and Terraform

## SOLUTION APPROACH
### Code
Django framework is used to build this API. Tests are also done with the Framework's test suite. Used Django models in such a way that creates a Mongo DB(SQL lite table) collections. ```UserDetails``` to contains the relevant table fields like ```username```, ```date_of_birth``` the datastore is used to store the application database secrets and other application related secrets. 

### Infrastructure
To achieve the requirement of persistent data solutions, the API and Database are seperated from each other within the same network. The API and database containers use persistent storage volume so Data is intact should the containers restart for any reason. Containers connect to each other using container names.
Database secrets have been set variables gotten from environment variables in both the code and Docker compose files. This is to help us achieve some form of security and could be improved on in production environments. 

## TESTING
* In order to run the tests for the application locally run ```python3 manage.py test```. This is also included in the docker build step to ensure only code that passed tests is built.

## DEPLOY SOLUTION


### Using Docker Compose
* This solution is deployed using Docker compose. The Docker compose setup includes 2 separate containers which are Mongo DB container and the API container.
* To deploy solution run ```docker-compose up --build -d``` to start the application.
* To destroy solution run  ```docker-compose down```


### Running locally
To run the code locally (out of docker)
* Pull code base
* ```cd into root directory```
* Settup your postgres database or use the django default sqlite db and populate the .env using the sample in env.example
* Run ```pip3 install -r requirements.txt```
* Make Migrations ```python3 manage.py makemigrations```
* Migrate         ```python3 manage.py migrate```
* Test with       ```python3 manage.py test```
* Start API with  ```python3 manage.py runserver 0.0.0.0:8080```


### Deploy to AWS Using Terraform

==> Please see architectural diagram and terraform deployment code in ```api_terraform_deployment```

==> Please update the ```provider aws{}``` with the needed credentials 

* change directory into the deployment folder ```cd api_terraform_deployment``` && ```cd deployment/simple```
* Update the required Terraform variables
* Initialize the terraform state ```terraform init```
* Check planned deployment ```terraform plan```
* Apply/Build the terraform infrastructure ```terraform apply```
* destroy infrastructure using ```terraform destroy```

==> The docker container with the code base has been pre-built using SQLite as the DB and deployed to a public repository for easy pull and deployment.

## ACCESS API ENDPOINTS (LOCALLY)
To access the API, you can use PostMan or any other HTTP Client of your choice

* To create a user ```POST``` request to http://localhost:8080/createuser/

- sample request body:
```
{
    "username": "Job",
    "date_of_birth": "1995-03-17"
}
```
- sample output:
```
{
    "id": 2,
    "username": "Job",
    "date_of_birth": "1995-03-17"
}
```

* To Update a users username ```PUT``` to http://localhost:8080/hello/username/
- sample request body:
```
{
    "username": "Emma",
    "date_of_birth": "2000-11-12"
}
```
- sample output:
```
Returns 204 status code.
```
* To get a user by username ```GET``` to http://localhost:8080/hello/username
- sample request body:
```
{
    "username": "Emma",
    "date_of_birth": "2000-11-11"
}
```
- sample output:
```
{
    "message": "Hello, Emma! Your birthday is in 32 day(s)"
}
```
* For health checks ```GET``` to http://localhost:8080/api/health/

