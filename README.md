# Clean-Swift
![Swift-Version](https://img.shields.io/badge/Swift-3.1-Purple.svg)

Real-Life Chat Application including server.

# Getting Started

## Project

```bash
$ bundle install
```

Which will install the currently used versions of our gems like [fastlane](https://github.com/fastlane/fastlane)
or [cocoapods](https://cocoapods.org/).

So if you want to use any of these gems listed in `Gemfile` you have to call `bundle exec <command>`.

```bash
$ bundle exec pod install
$ bundle exec fastlane
```

To update any of these gems just use

```bash
$ bundle update <gem>
```

## Server

I am using [json-server](https://github.com/typicode/json-server) to fake my awesome chat api. Before you can start you
just have to install it easily locally using

 ```bash
$ npm install -g json-server
 ```

Once installed you just can start it using

```bash
$ json-server server/db.json
```

`db.json` just contains our complete data. It has a set of initial data provided, so just have a look and feel free to
add some more data. For further information just have a look at the official [documentation](https://github.com/typicode/json-server) on github.

You are now able to make REST-Calls (GET, PUT, POST, DELETE) to following resources

```
  http://localhost:3000/contacts
  http://localhost:3000/chats
  http://localhost:3000/messages
```

## Technology Stack

* [RxSwift](https://github.com/ReactiveX/RxSwift) awesome reactive framework
* [Alamofire](https://github.com/Alamofire/Alamofire) for network communication
* [RealmSwift](https://realm.io/docs/swift/latest/) as database layer
* [Swinject](https://github.com/Swinject/Swinject) as dependency injection framework
* [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) as logging framework
* [R.swift](https://github.com/mac-cain13/R.swift) strong typed, autocompleted resources

## Clean-Architecture

### UseCase

Some theory and current interpretation about repositories in this project.

### Repositories

Some theory and current interpretation about repositories in this project.

## Project Structure

### Modules

#### 1. Clean-Swift
* Bootstrapping
* UI/Scenes

#### 2. Domain
* Logic of the app. **What** can the app do.
* Independent of any framework (except RxSwift)
* Contains Entities
* Business Logic

#### 3. Data
* Implementation Detail
* Networking (like Alamofire)
* Persistence (like Realm/CoreData)
* Repository implementation

## Terminology

* Repository
* DataSource
* Manager
* Service
* API
* Entity
* Model
* ViewModel

## Contribute


## Sources

Here are some really great blog articles from [five.agency](http://five.agency/)
* [Android Architecture: Part 1](http://five.agency/android-architecture-part-1-every-new-beginning-is-hard/)
* [Android Architecture: Part 2](http://five.agency/android-architecture-part-2-clean-architecture/)
* [Android Architecture: Part 3](http://five.agency/android-architecture-part-3-applying-clean-architecture-android/)

Inspirations from
* [CleanArchitectureRxSwift](https://github.com/sergdort/CleanArchitectureRxSwift)

* [Code for Data Synchronization in Mobile Apps](https://de.slideshare.net/nikonelissen/appsyncorg-opensource-patterns-and-code-for-data-synchronization-in-mobile-apps)
