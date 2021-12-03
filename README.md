## Notes

### Date
03 December 2021

### Instructions for how to build & run the app
You'll need XCode Version 13.1 to build the app.

In order to test the deeplink system, you can type this command (you'll need to have the simulator already running):
`xcrun simctl openurl booted com.spacexlaunches://rocket?id=MY_ID`

### Time spent
I spend almost 15 hours doing the test.

### Assumptions made
In the test statement, it is asked to show an image if there is one: as I had already downloaded the patch images from the list, I decided to download the images from FLicker if they were available.

### Assume your application will go into production...
1. What would be your approach to ensuring the application is ready for production(testing)?
I would start by creating unit and UI tests to avoid regression during the development process. I would also monitor crashes using XCode or a third-party SDK like Firebase Crashlytics.

2. How would you ensure a smooth user experience as 1000s of users start using your app simultaneously?
Tough question because as front-end developers, it's hard to deal with network congestion issues; however, if the server is down due to too many requests, I would create a pop-up stating that too many people are trying to log in and that they should try later. This is not an optimal solution, as it doesn't solve the problem, but it improves the user experience by explaining the problem and preventing them from hitting the refresh button and making the situation worse.

3. What key steps would you take to ensure application security?
In this application, there is no critical data, but I would use SSL certificate pinning to avoid man in the middle attacks. I would also store the API access point in an XCConfig file that will not be added to Github but retrieved from a secure server. I would the keychain to store critical data (tokens for example).

### Shortcuts/Compromises made
I made a mistake because of my use of GraphQL: I first used it when I was very junior, and when I had to use it in this test, I made some assumptions about models in my architecture. 
Specifically, I thought that since GraphQL has high granularity and allows me to modify data easily, I wouldn't need to create models (as structures) because I would lose the flexibility of GraphQL. For example, if I wanted a new field in a query, I would have to modify the query itself and the model, which would duplicate my work and not use all the advantages of GraphQL.
I realized after a few hours that I wasn't a good choice and should have created models structures, but due to the time limit of the test, I didn't; this is something I would do differently if I had the chance.

### Why did you choose the specific technology/patterns/libraries?
I used Swift because I'm more comfortable with it and I wanted to make a good application, and I also used Swift Package Manager to get the Apollo GraphQL client.
I used an MVVM-C model for my application, because I think it's the cleanest way to deal with most of the issues when developing an application: view routing, deep link management, controller separation from data, etc...
I just didn't add a template system because of my understanding of GraphQL, please read the "Shortcuts/Compromises made" to understand.

### Stretch goals attempted
I created the deeplink system; it's a very simple implementation to retrieve a specific rocket from an identifier. With the design pattern and router, it was easy to implement.

I didn't do a data persistence system, because of the time limitation: it was a deliberate choice that I don't like, but I didn't have enough time since I also work in my current company. Nevertheless, I did set up a cache for downloaded images, as requesting them can be cumbersome and time consuming.

I did not use Navigator 2.0 since I choose to do the test in Swift but I've tried to make a comprehensive router system.

### Other
It was a good test but I feel like I could have done better.

In the end, I'm not totally satisfied with the result: on the surface, it works well and I tried to make a clean architecture with clear responsibilities for each part of the project, but I regret not having models (except those generated by Apollo) and not having data persistence.

I also learned a few things in swift: for the tableview for example, I used for the first time diffable data sources, and a compositional layout for the collectionView. I could have used the "old way" of building table and collection views, but it seemed outdated and I like to try new things, even if I have to leave my comfort zone.

### Your feedback on this technical challenge
I think it's a good test because there are no specific pitfalls, but it can be difficult to cover all the requirements: uploading images, presenting data in an appropriate way...

A difficult part to do as a developer is to make the user interface: it is a challenge to create and design a series of screens.
