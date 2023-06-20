# ACME Project

The objective of the project is to re-engineer the ACME application adopting the approach of a decentralized/distributed system.

This project was developed for evaluation in the Systems Integration course of the Master in Informatics Engineering - Software Engineering at Instituto Superior de Engenharia do Porto - ISEP/IPP

# :arrow_down: Starting services locally with docker-compose
This tutorial will guide you through the installation and execution of the services required to start your application locally with docker-compose.

<br>

## Prerequisites
- [Docker Engine](https://www.docker.com/products/docker-desktop/) installed.
- Sufficient hardware and software resources to support the execution of all applications simultaneously without causing performance or stability issues.
    - Applications:
        * discovery-system
        * load-balancer
        * axonserver
        * product-command
        * product-command-bootstrapper
        * product-query
        * product-query-bootstrapper
        * review-command
        * review-command-bootstrapper
        * review-query
        * review-query-bootstrapper
        * vote-command
        * vote-command-bootstrapper
        * vote-query
        * vote-query-bootstrapper

<br>

## Step-by-step
1. Open and run the Docker desktop application.

2. Download the [docker-compose.yml](https://github.com/INSIS-s-Projects-ISEP/.github/blob/main/profile/acme/docker-compose.yml) file required to start the services locally.

3. Open a terminal and navigate to the directory where the [docker-compose.yml](https://github.com/INSIS-s-Projects-ISEP/.github/blob/main/profile/acme/docker-compose.yml) file is saved. Then, execute the following command to start the services in the background: 
```
docker-compose up -d
```

4. Wait for all services to start. You can check the status of the services using the `docker-compose ps` command. To view the applications running on Docker, click on the "Containers/Apps" section of the dashboard. This will display a list of all the containers that are currently running.

5. To access the services, use the following links:

- Discovery System (Eureka Server): http://localhost:8761
- Message Broker: http://localhost:15672 (Username: admin | Password: 123456)
- Axon Server (Event Sourcing): http://localhost:8024

<br>

## How to launch a new instance of a service on Docker

If you want to create 5 new instances of the "product-command" service after starting it, use the command `docker-compose scale product-command=5`. It is possible to change the name of the service and the number of instances as needed, but it is important to consider that the maximum number of instances is limited by the processing power and resources available on the machine.

<br>

## Performing a test with HTTP requests using [Postman](https://www.postman.com/)

<br>

1. Create a POST request to http://localhost:8080/products, with the JSON {"sku": "123456789123", "designation": "Laptop", "description": "Black"} in the request body.

2. Create a POST request to http://localhost:8080/products/123456789123/reviews, with the JSON in the request body.
```
{"user": "John Doe", "reviewText": "This product is great!", "rating": 4.5} 
```

3. Create a PATCH request to localhost:8080/reviews/{id_review}/acceptreject/APPROVED, where {id_review} is the ID of the review you want to accept.

4. Create a POST request to localhost:8080/votes, with the JSON in the request body.
```
{"user": "Jane Doe", "reviewId": "{id_review}", "voteType": "UP_VOTE"}
```

5. Create a POST request to http://localhost:8080/products, with the JSON in the request body.
```
{"sku": "123456789156", "designation": "Mouse", "description": "Black"} 
```

6. Create a POST request to localhost:8080/votes/for-non-existing-review, with the JSON in the request body.
```
{"user": "Jonas", "voteType": "UP_VOTE", "review": {"sku": "123456789156", "user": "Maria", "reviewText": "Great!", "rating": 4.0}}

```
In all requests, select the content type "JSON (application/json)" and click "Send" to send the request.

<br>

### **Test with GET requests**

1. Open Postman and create a new request.
2. Select the HTTP method "GET" and insert the URL "http://localhost:8080/products".
3. Click "Send" to send the request.
4. A list of all registered products will be displayed.

**To get information about a specific product:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/products/{sku}".
2. Replace "{sku}" with the SKU of the product you want to query.
3. Click "Send" to send the request.
4. The information of the selected product will be displayed.

**To get reviews of a specific product:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/products/{sku}/reviews".
2. Replace "{sku}" with the SKU of the product you want to query.
4. Click "Send" to send the request.
5. The reviews of the selected product will be displayed.

**To get information about all reviews:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/reviews".
2. Click "Send" to send the request.
3. All review will be displayed.

**To get information about of products reviews by status:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/products/{sku}/reviews/{approvalStatus}".
2. Replace "{sku}" with the sku of the product you want to query.
3. Replace "{approvalStatus}" with one of the status (PENDING, ACCEPTED, REJECTED) to get the reviews with the desired status.
4. Click "Send" to send the request.
5. The information of the selected review will be displayed.

**To get information about reviews of a specific user:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/reviews/{user}".
2. Replace "{user}" with the name of the user you want to query.
3. Click "Send" to send the request.
4. The reviews of the selected user will be displayed.

**To get the pending reviews:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/reviews/pending".
2. Click "Send" to send the request.
5. The reviews with pending status will be displayed.

**To get the accepted or rejected reviews:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/reviews/{reviewId}/acceptreject/{approvalStatus}".
2. Replace "{id_review}" with the ID of the review you want to desired status.
3. Replace "{approvalStatus}" with "ACCEPTED" or "REJECTED" to get the reviews with the desired status.
4. Click "Send" to send the request.
5. The reviews with the selected status will be displayed.

**To get information about all votes of a specific review:**

1. Select the HTTP method "GET" and insert the URL "http://localhost:8080/reviews/{id_review}/votes".
2. Replace "{id_review}" with the ID of the review you want to query.
3. Click "Send" to send the request.
4. The votes of the selected review will be displayed.

<br>

## Stopping the services
You can stop the services at any time by using the `docker-compose down` command in the directory where the `docker-compose.yml` file is saved.

<br>

## Conclusion
Now you can use the services locally with docker-compose. Make sure the services are stopped before running the application in another environment. If you have problems during installation or execution, make sure you followed the steps described in this tutorial correctly and that all prerequisites were met.

<br>

# :pushpin: Understanding the ACME application

#### Two dimensions of decentralization/distribution are addressed:
- Business Domain Segregation: The monolithic application was segregated into three distinct but collaborative applications:
    - Products
    - Reviews
    - Votes

- Cloning: Multiple instances of each of the above applications are deployed in containers.

## Requirements

**Non-functional requirements**
- Deployment must be automated through CI/CD.
- Adoption of service component test pattern.
- Adoption of end-to-end test pattern.
- Two or more frameworks/programming languages must be adopted in implementing the services.
- AMQP Message Broker (e.g. RabbitMQ) must be adopted for communication between services.

<br>

**Functional requirements**
- Endpoint in service Votes that allows creating a vote for a non-existing review. The review must be created for the specified product, and the vote is eventually associated with the review.

- Develop a bootstrap process for the starting services. I.e. at any time, a new service can start and its data must be bootstrapped.

<br>

*The following patterns must be adopted:*
- Strangler fig
- Command-Query Responsibility Segregation (CQRS)
- Database-per-Service
- Polyglot persistence
- Messaging
- The Domain Events
- Event Sourcing
- Saga
- CI (Continuous Integration)

<br>

## Features

- Load Balance
- Discovery System
- Message Broker
- Event Sourcing
- Bootstrapper
- Applications: Product, Review e Vote (Command/Query)

<br>

## Technologies used for Software Development

- Java (JDK 17)
- Node.js
- Git/GitHub
- GitHub Actions (CI)
- Docker
- RabbitMQ (AMQP)
- Axon Server (Event Sourcing)
- Netflix Eureka
- H2 Database
- MongoDB

<br>

# :page_with_curl: Documentation
## Logic View
![logic view image](https://raw.githubusercontent.com/INSIS-s-Projects-ISEP/.github/main/profile/acme/ACME-logic-view.svg)

## Physical View
![physical view image](https://raw.githubusercontent.com/INSIS-s-Projects-ISEP/.github/main/profile/acme/ACME-physical%20view.svg)

## Sequence Diagrams
### POST Product
![case01-post-product](https://raw.githubusercontent.com/INSIS-s-Projects-ISEP/.github/main/profile/acme/ACME-Case%2001%20HttpClient%20POST%20Product%20Request.svg)

<br>

### POST Review
![case02-post-review](https://raw.githubusercontent.com/INSIS-s-Projects-ISEP/.github/main/profile/acme/ACME%20-Case%2002%20HttpClient%20POST%20Review%20Request.svg)

<br>

### POST Vote
![case03-post-vote](https://raw.githubusercontent.com/INSIS-s-Projects-ISEP/.github/main/profile/acme/ACME-Case%2003%20HttpClient%20POST%20Vote%20Request.svg)

<br>

### SAGA
![case04-saga](https://raw.githubusercontent.com/INSIS-s-Projects-ISEP/.github/main/profile/acme/ACME-Case%2004(SAGA).svg)

<br>

# :computer: Development

## Refactoring
**1. Layered architecture restructuring**<br>

We performed significant refactoring of the application by adopting the typical layered architecture of software development. This architecture includes the layers of controller, model, repository, and service, each with its well-defined responsibility.

- The controller is responsible for presentation logic;
- The model represents the entities and data of the application;
- The repository provides access to the system's data;
- The service performs the business logic of the application.

We isolated the innermost layers from the outer ones to ensure that the business logic remains separate from the presentation logic and data access. This resulted in greater security and scalability of the application, as well as enabling more organized development, facilitating maintenance and evolution of the application.

***Before:***

```
acme-monolithic-project/src/main/java/com/isep/acme/
.
├── bootstrapper
├── controllers
├── model
├── property
├── repositories
├── services
.

```
***After:***

```
acme-product-command/src/main/java/com/isep/acme/
.
├── bootstrapper
├── api
│   └── controllers
├── config
├── domain
│   ├── model
│   ├── repository
│   └── service
├── dto
│   ├── mapper
│   ├── message
│   ├── request
│   └── response
├── exception
│   ├── model
│   ├── repository
│   └── service
├── messaging
.

```
<br>

**2. Changes in application logic**

In addition to adopting the layered architecture, we made other significant improvements to optimize the application logic:

- We used an Enum for `ApprovalStatus`, replacing the list of strings with the three status types. This change reduced code complexity and made the implementation more efficient.

- We transformed the `class Rating` into a `Double rate` attribute in the `class Review`, reducing code complexity and simplifying the application logic.

- We removed the `AggregatedRating` class to simplify the application logic and avoid data redundancy.

- We changed the logic in `review-command` so that the `class Review` now has a `Set<>` with all the votes, positive and negative. This change reduced the complexity of the `addVote()` method in the `class Review` and allowed the application to obtain the number of votes and count positive and negative votes with just one database query, making the operation more efficient and scalable.

<br>

**3. Changes in application code**

- We used the Lombok library to reduce the amount of boilerplate code in the application, eliminating the need to write getters, setters, constructors, and other common methods in Java classes.

- We switched from `CrudRepository` to `JPA` to simplify database access. This change resulted in faster and simplified development, as well as allowing the application to be easily integrated with other technologies and systems.

- We adopted `UUID` as the standard for the ids of each entity. This change brought a series of benefits, such as the guarantee of id uniqueness and the difficulty of predicting the ids, making the application more secure.

<br>

*These changes were implemented with the aim of optimizing the application by reducing code complexity and improving the efficiency and scalability of the application logic.*

<br>

## Technologies Used in Application Development

<br>

**1. Discovery System**<br>

We implemented a Discovery System to simplify the deployment and scalability of microservices. It allows services to find and communicate with each other without requiring coded service locations.

<br>

**2. Load Balancer**<br>

We used a Load Balancer to distribute HTTP requests coming from clients among multiple server instances. This was done to optimize resource usage, maximize throughput, minimize response time, and ensure high availability and scalability of the application.

<br>

**3. Message Broker**<br>

We used RabbitMQ to facilitate asynchronous communication between microservices via the AMQP protocol. It allows services to communicate in a decoupled and scalable manner.

<br>

**4. Bootstrapper**<br>

We implemented a Bootstrapper to manage the initialization of microservices. It ensures that each service is started in the correct order and with the correct configuration, minimizing the risk of errors and reducing deployment time. It also sends events to the event sourcing.

<br>

**5. Event Sourcing**<br>

 We used Axon Server to maintain a complete audit trail of all changes to the application state. This allows events to be easily replayed and the application to be recovered from failures.

<br>

**6. Command-Query Responsibility Segregation (CQRS)**<br>

We implemented the CQRS pattern to separate write and read operations into different services. This allows each service to be independently scaled and handle read and write operations separately. The Product, Review, and Vote services are examples of this approach.

<br>

**7. GitHub Action**<br>

We use the Docker Image CI GitHub Action to implement continuous integration of our Docker images. This action automatically builds the Docker image and tags it with a specific version whenever we push changes to the main branch or create a pull request. The Docker Image CI Action also logs in to Docker Hub using secure credentials and pushes the image to the registry.

Using this GitHub Action ensures that our Docker images are always up-to-date and tested, reducing the risk of errors and inconsistencies during deployment. Additionally, it simplifies our deployment process by enabling easy deployment of Docker images to different environments.

<br>

<br>

## Students
| <img alt="@DavidGomesh" src="https://avatars.githubusercontent.com/DavidGomesh?size=64"> | <img alt="@RegianaBarbosa" src="https://avatars.githubusercontent.com/RegianaBarbosa?size=64"> | <img alt="@NaironCarneiro" src="https://avatars.githubusercontent.com/NaironCarneiro?size=64"> |
| :-: | :-: | :-: |
| *David Gomes* | *Regiana Cruz* | *Nairon Carneiro* |

## Professor
| <img alt="@NunoSilva" src="https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/557058:6fcae13e-78be-47ae-b86f-32c59404c8a3/de6bf548-8908-4c59-bdac-2813d38f37a0/64"> |
| :-: |
| *Nuno Silva* |
