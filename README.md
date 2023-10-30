# Internal Wallet Transactional System (API)

This project aims to develop an internal wallet transactional system API that facilitates money transfers and withdrawals between entities such as Users, Teams, Stocks, and other models. The system ensures data integrity and follows ACID standards for transaction processing.

## Requirements

1. **Entity-specific Wallets:**
   - Each entity (e.g., User, Team, Stock) should have its own defined "wallet" for handling money transfers and withdrawals.

2. **Database Records:**
   - Every credit or debit request (deposit or withdrawal) must be based on records in the database for the relevant model.

3. **Transaction Validations:**
   - Each transaction should have proper validations against required fields and their source and target wallets. For example, credits should have a source wallet set to `nil`, while debits should have a target wallet set to `nil`.
> I believe we can avoid DB Transaction using one row for both credit and debit transactions, especially when the balance should be calculated by summing all records. As a result, we don't require a transaction on this.

4. **Database Transactions:**
   - Every transaction should create a record in the database to ensure compliance with ACID standards.

5. **Balance Calculation:**
   - The balance for a given entity (User, Team, Stock) should be calculated by summing the relevant records in the database.

## Tasks

### 1. Architect a Generic Wallet Solution
- Design a generic wallet system for handling money manipulation between different entities (User, Stock, Team, etc.).

### 2. Model Relationships and Validations
- Create model relationships and implement validations to ensure accurate calculations of wallet balances and transactions.

### 3. Use Design Patterns (e.g., STI)
- Apply suitable design patterns (such as Single Table Inheritance - STI) for efficient money manipulation within the system.
> We use Concern from Active Record because it is a standard Ruby on Rails feature.

### 4. Custom Sign-In Solution
- Implement a custom sign-in solution, allowing users to start new sessions without relying on external gems or libraries.

### 5. LatestStockPrice Library
- Develop a "LatestStockPrice" library and place it in the "lib" folder in a gem-like structure. This library should provide endpoints for accessing stock prices, including "price," "prices," and "price_all." The endpoints can be accessed via the following URL: [LatestStockPrice API](https://rapidapi.com/suneetk92/api/latest-stock-price).

## Getting Started

To set up and run the internal wallet transactional system API, follow these steps:

1. **Installation:**
   - Clone this repository to your local environment.
   - Install the required dependencies.

2. **Configuration:**
   - Configure the database settings as per your environment.

3. **Migrations:**
   - Run database migrations to create the necessary tables.

4. **API Endpoints:**
   - Access the API endpoints to perform wallet transactions and retrieve stock prices.

5. **Custom Sign-In:**
   - Utilize the custom sign-in solution to create and manage user sessions.

6. **Documentation:**
   - For detailed API documentation and usage examples, refer to the project documentation.

## Documentation

For comprehensive documentation on using the internal wallet transactional system API, including endpoint details and examples, please refer to the project documentation.

For testing Latest Stock Price gem

```
$ rails lsp:price
Retrieve the price of Indices
NIFTY 50
# api output

$ rails lsp:prices
$ rails lsp:price_all
```

## Credits

- LatestStockPrice library developed by [Suneet K](https://rapidapi.com/suneetk92).

## License

This project is licensed under the [MIT License](LICENSE).
