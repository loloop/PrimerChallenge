# Primer iOS Take Home Challenge

## Explain your design decisions. What are you proud of? 🙂

This project is built with an MVC style architecture with Coordinating view controllers, where instead of keeping tabs of everything that's instantiated, we pass that responsibility to iOS' own navigation system by doing view controller containment, similar to the way UINavigationControllers, UITabBarControllers, etc are built. This is a way that feels natural to the system's APIs and avoids many pitfalls such as massive view controllers. The app has a user search and suggestions view and a debug settings view, both done with SwiftUI for simplicity, and the repositories' list was done with UIKit, since it has reusability needs which aren't met by SwiftUI's implementation for iOS 13. A good reference for this architecture is [Gui Rambo's dot Swift Talk](https://www.youtube.com/watch?v=ZShE3toDPIk).

For the Repositories list itself I chose to do a different take on UICollectionDiffableDataSources, by separating each section in their own class instead of enums with associated values, improving testability and reusability of each part of the app, as well as reducing the probability of massive view controllers and data sources emerging during the app's development. This can also be seen as a way to add functionality from iOS 14 (NSDiffableDataSourceSectionSnapshot!) into iOS 13.

For networking, I picked an approach that encapsulates the stack in a chain of responsability that allows us to easily add and change parts of the way a request is done easily. The loader chain can alter headers of a request before it is sent, cache requests, automatically retry requests when they fail, keep data between requests, all of that easily testable as each member of the chain only does the thing it should do and then passes the request along, and because of that modularity, the complete chain can be tested as well.

The app also contains a ChallengeFoundation framework as a starting point for code modularization, which would us to implement App Clips or App Extensions such as a Watch app more easily in the future.

The only external dependency I brought in was Kingfisher for image downloading and caching, and it is isolated enough from the code that swapping it out for another library or our own implementation should be easy enough.

## What would you improve if you had more time to production-ize this?

Having done what I consider the minimum functionality to deliver the app, the next steps I would take with this project are:

* Implement unit tests and snapshot tests
* Add user search in a way that shows suggestions based on what the user is typing
* Add a way to favorite users' profiles
* Add sorting options to the repo list
* Replace the loading indicator for a shimmering-style loading view
* Show more about a user than just their repos such as their full name, avatar, following/follower counts, stars, etc
* Identify which repos are forks and which repos were created by the user
* Replace the current error state with an error state that better communicates the issue
* Find a more modular way to add stuff in the DebugSettings View
* Create a Network Loader that automatically decodes requests
* Localization
* Write documentation
* Separate features into their own frameworks to reduce build times and make features like App Clips easier to introduce
* Support other Apple platforms such as Apple Watch, macOS via Catalyst and tvOS

## What are some potential issues with your implementation?

The current implementation of the Diffable Data Source could lead to some difficulties during development when not all expected Types are not provided to the data source, and because of the way it is done, error messages aren't as descriptive as they could be. The way the developer can mitigate this is by trying out each section separately, since they are each their own unit, as a way to find the issue quickly.

Another problem with the current implementation is that the current diffable snapshot implementation recreates the full snapshot each time any section needs to update. Thankfully, the diffable API is performant enough that this isn't a problem for this project, but is something that the developer should measure the performance of when doing new sections with large amounts of data, and implement a way to modify snapshot items within a section without literally creating new snapshots over and over again.

The last issue I see with this implementation is that DebugSettings are not easily modifiable in runtime, so if a developer adds the wrong API and that goes through review or a tester wants to try out the app with an API that is running locally in their computer, the app wouldn't work properly.