# E-Store Platform 

A  Java-based backend  modern architectural patterns for authentication, distributed state management, and performance optimization.

---

## System Architecture

The system is designed with a layered architecture to ensure separation of concerns and scalability:

* **Presentation Layer:** JSP and Servlets for handling HTTP requests and dynamic content rendering.
* **Security Layer (Middleware):** A custom `AuthFilter` that intercepts all incoming requests to validate authentication state.
* **Service Layer:** Centralized business logic, integrating caching mechanisms and rate limiting.
* **Data Access Layer (DAO):** Decoupled MySQL interaction logic to manage persistent storage efficiently.
* **Redis Layer:** Used as a distributed session store for shared session data, cached information, and rate-limiting counters.

---

## Authentication & Logic Flow

### Request Filtering
Every request is handled by a custom security filter before reaching the main application logic. This filter is responsible for:
* Blocking or allowing protected endpoints.
* Reading JWT tokens from cookies and validating integrity.
* Verifying active user sessions within **Redis**.
* Enforcing global security policies.

### Login & Signup Flow
* **Login:** Credentials are verified against **MySQL**. Upon success,
 a **JWT** is signed and a session entry is created in **Redis**.
 This hybrid approach allows for stateless identity with server-side session control (forced logout/invalidation).
* **Signup:** Validates input data, hashes passwords securely using **BCrypt**, and persists the new record in the database.

---

## Database Schema
The relational schema is optimized for an e-store workflow:
* **Users:** Manages credentials (hashed), identities, and roles (`ADMIN` or `USER`).
* **Product Cards:** Stores inventory details, pricing, and metadata.
* **Reviews:** Handles user feedback with relational integrity to specific products.

---

## Technical Stack



 - **Core Backend**  Java (Jakarta EE / Servlets & JSP)
 - **Web Server**  Apache Tomcat 11.0 
 - **Authentication**  Hybrid JWT + Redis Session Management 
 - **Security**  BCrypt Password Hashing 
 - **RDBMS**  MySQL via JDBC 
 - **In-Memory Store**  Redis (Sessions, Caching, Rate Limiting) 
 - **Virtualization**  Docker 
 - **Data Format**  GSON (JSON Serialization) 

---

##  Running the Project

### 1. Infrastructure Setup (Redis)
Run Redis via Docker to handle sessions and caching:
```bash
docker run --name ecommerce-redis -p 6379:6379 -d redis
```
### 2. Database Configuration (MySQL)
1.  **Start MySQL:** Ensure **MySQL** is running via **XAMPP**.
2.  **Create Database:** Create a new database named `products`.
3.  **Initialize Schema:** Execute the provided SQL scripts to create and seed the following tables:
    * `users`
    * `product_cards`
    * `reviews`
4.  **Verify Connection:** check your database credentials (username/password) in the `DBConnection.java` file.



### 3. Accessing the Application
Once the Tomcat server  and Redis service are running, you can access the platform at:

Login Page: http://localhost:8080/e-commerce/login.jsp


---