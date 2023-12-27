# PizzaJeff

## Installation
Just execute `pod install` on the root folder to install the dependencies

## Description

First of all I wanted to make the app as simple as possible and focused on the code and not visuals. Visuals consume a lot of time and I thought that it was not worth to spend that much time on visuals instead of code.

I used MVVM + Coordinator pattern because it's really a small MVVM and it's what I'm more confortable with using. Also `Coordinator` helps you manage all the screen flows.
The app consists of 4 screens + 1 popup:

### LoginViewController
Login to the app using the user type specified: `Single` or `Married`. This controller initializes a `MainCoordinator` that will manage the logic between all the following screens.

### PizzaListViewController
This screen shows the prices of the pizza based on the Customer Satisfaction information using the `CSatManager`, as you can see on the `PizzaListCollectionViewCell`.

### PizzaDetailViewController
Shows the pizza detail with the price adjusted for customer satisfaction at the beginning. You can add the pizza to the current cart or checkout immediately.

### ConfirmationViewController
Its the Cart screen. Depends on the user type, will show an Upsell for a movie to add it to the cart.

#### *CSatManager*
(CustomerSatisfactionManager) This could perfectly be a library that makes calls to an API to get the data from the backend. So the prices that the user sees change dynamically based on user type.
```
CSatManager.shared.bestPriceForCurrentUser(pizza: pizza)
```

#### *UpsellPopupViewController + ActionButton*
These classes could be from an external module to be shared between all the apps/projects/etc. Maybe even the `Alerts` class also.

Also made these clases using code + SnapKit so its easier to work on with a bigger team. Not just use Storyboards/Xib files.



## Third Party
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
- [SwiftEntryKit](https://github.com/huri000/SwiftEntryKit)
- [SnapKit](https://github.com/SnapKit/SnapKit)