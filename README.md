## About The Project

This is a small app listing SpaceX past launches using Swift and GraphQL, made in 2 days.

Api documentation can be found [here](https://spacex.land)

![SpaceXLaunchesRecord](https://user-images.githubusercontent.com/11751183/145189848-5431739a-ca48-4b9c-87eb-7507dfa55326.gif)

## Notes

This project was a training to learn to use [UITableViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uitableviewdiffabledatasource) and to implement a [modern UICollectionView](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views).

It was also to test the use of a GraphQL api using the [Apollo client](https://www.apollographql.com/) and to check the ease of integration of the [Swift Package Manager](https://www.swift.org/package-manager/) (and it's easy!).

A deeplink system to access a specific launch with an id is implemented, if you want to try it using a simulator you can run this command in your favorite terminal:
```bash
xcrun simctl openurl booted com.spacexlaunches://rocket?id=MY_ID
```
