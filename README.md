# SwagLabs Automation Suite

This repository contains a comprehensive suite of automation scripts written in Robot Framework for [Swag Labs](https://www.saucedemo.com/) demo site



## 📌 Libraries and Resources Used

- **SeleniumLibrary**: To interact with web browsers.
- **AxeLibrary**: Provides keywords for accessibility testing using the axe-core engine

## Structure

```
└───Resources
│   │
│   └───Custom
|   |   |  WriteMultiFailureResult.py
│   │
│   └───POM
|   |   |  _Main.robot
|   |   |  AddressFormPage.robot
|   |   |  LoginPage.robot
|   |   |  OrderCompletePage.robot
|   |   |  OverviewBasketPage.robot
|   |   |  OverviewCheckoutPage.robot
|   |   |  OverviewCommonPage.robot
|   |   |  ProductDetailsPage.robot
|   |   |  ProductListingPage.robot
│   │
│   └───StepDefinitions
|   |   |  _Main.robot
|   |   |  AddressFormSteps.robot
|   |   |  LoginSteps.robot
|   |   |  OrderCompleteSteps.robot
|   |   |  OverviewBasketSteps.robot
|   |   |  OverviewCheckoutSteps.robot
|   |   |  OverviewCommonSteps.robot
|   |   |  ProductListingSteps.robot
│   │
│   └───Variables
|   |   |  CheckoutInfo.robot
|   |   |  LoginErrors.robot
|   |   |  LoginSteps.robot
|   |   |  Products.robot
|   |   |  SortOptions.robot
|   |   |  Urls.robot
|   |   |  OverviewCommonSteps.robot
|   |   |  Users.robot
|   |   Setup.robot
└───Tests
|   |  __init__.robot
|   |  Basket.robot
|   |  Checkout.robot
|   |  Inventory.robot
|   |  Login.robot
```

## 🛍 Features Automated

### 1. **Login Functionality** (`Login.robot`):

- User authentication.
- Alert handling and error messages.

### 2. **Basket Operations** (`Basket.robot`):

- Seeing current product count in the basket.
- Handling empty baskets.
- Viewing summaries with single, multiple, or all products.
- Adding/removing products from basket details.
- Retaining products after session timeouts.
- Reflecting basket updates across browser tabs.

### 3. **Product Sorting and Management** (`Inventory.robot`):

- Product sorting by name and price.
- Viewing product details.
- Managing products in basket directly from the listing.

### 4. **Checkout Interactions** (`Checkout.robot`):

- Confirming that a user cannot proceed to checkout without any products in the basket.
- Checkout Cancelation: Ensuring that a user retains basket content after canceling the checkout process.
- Shipping and Payment Details: Confirming that shipping and card details displayed are correct during the checkout process.
- Order Confirmation: Displaying a message to the user upon successful order completion and ensuring products are removed from the basket.
- Navigation After Checkout: Allowing users to navigate back to the home page post-checkout.
- Value Calculations: During the checkout process, validating calculated values.

## 🔧 How To Use

1. **Setup**:
   - Install Robot Framework and necessary libraries. (requirements.txt)
   - Set up browser drivers (like chromedriver for Chrome) in the PATH.

2. **Executing Tests**:
   - Navigate to the directory of the Robot scripts.
   - Use the command: `robot <script_name>.robot`.

3. **Reports**:
   - Robot Framework will produce logs and reports post-execution. To view test results, open `report.html` in a web browser.

## 🚀 Future Enhancements

- Enhanced coverage for swaglabs functionalities.
- CI/CD pipeline integration.
- Cross-browser testing.

## 📝 Note

The automation suite is modular, allowing reuse across different application parts. Best practices are employed for maintainability.