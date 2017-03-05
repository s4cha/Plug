# Plug 🔌

[Reason](#why) - [Example](#example-project) -  [Idea](#main-idea) - [Get Started](#get-started)

## Why
Because the **classic way** of building iOS Apps introduces **tight coupling**, often with the network layer. **Dependencies grow** and **code is harder to test.**

## How
By providing a **simple convention** on how to **cleanly plug implementations** in an iOS App. Developers spend **less time** architecting and more time **adding value for their users.**


## Benefits
- [x] Clean Architecture
- [x] Code 90% of the App without the Backend implementation
- [x] Faster build times
- [x] Less Dependencies (think Better Testability, & Faster tests)
- [x] Easier to Maintain (predictable system)


## Example Project
Download and launch the `Example Project` to see how a Typical `LikePhoto` use case would be implemented using this approach.


## Main Idea
This is based on **Robert-C Martin** (Uncle Bob) thoughts, the guy behind the **SOLID** principles.

You can watch one of his terrific talks here :
https://skillsmatter.com/skillscasts/2437-uncle-bob-web-architecture

His examples are often written in Java, and the swift examples I came across were often Java directly translated into swift.

This is an **alternative approach** aiming at the **same goal**, but **leveraging swift awesomeness**.

The **main idea** is that you want to **decouple your App from it's delivery mechanisms.**

Let me rephrases that for you in a classic iOS App context.
Your **ViewControllers should not know how an action is performed**. For instance when you like a photo, the controller should'nt know if it's going to send a web request, a database command, or even a local request.
The ONLY thing it should know is : "I want to like this photo"


## Get Started

### Action
The entire Approach is built on the concept of `Actions`.  
An `Action` has an `Input` and an `Output`.

Here is what it looks like in swift :
```swift
public protocol IsAction {
    associatedtype Input
    associatedtype Output
    func perform(_ input: Input) -> Output?
}
```

### Create Your Action

For instance in the case of liking a photo, the `LikePhoto` action has an input of `Photo` and an Output of `Promise<Void>`

A cool this is that Output can be **synchronous or asynchronous**, it's yours to choose \o/.  
Here is how our App defines the `LikePhoto` use-case :
```swift
class LikePhoto: Action<Photo,Promise<Void>> { }
```

### Call it
```swift
action(LikePhoto.self, Photo()).then {
  // photo liked !
}
```
*Note : This uses dependency injection behind the hood to provide the **concrete** `LikePhoto` implementation at runtime*.

### Add some Model sugar
This phase is optional. But software is built for humans and we want this to be as readable as possible !

```swift
extension Photo {
    func like() -> Promise<Void> {
      return action(LikePhoto.self, self)
    }
}
```
You can now like a photo like this:
```swift
photo.like.then {
  // Photo liked \o/
}
```

### Providing A Concrete implementation
```swift
class MyLikePhoto: LikePhoto {

    override func perform(_ input: Photo) -> Promise<Void> {
       return network.post("/photos/\(input.identifier)/like")
    }
}

```

### 🔌 Plug it !
We can now Inject this implementation in our App form the `AppDelegate` :
```swift        
Actions.plug(LikePhoto.self, to: MyLikePhoto())
```
Or if you prefer the short version :
```swift        
LikePhoto.self <~ MyLikePhoto()
```
All the `LikePhoto` actions of our App will now use our concrete Implementation preforming a network call :).

This is now super easy to provide a dummy `MockLikePhoto` for testing purposes!



## Sum Up
Using this approach we have:

- A `Type-Safe` way to decouple and inject actions in our App.
- A clean and readable way to call actions on models.
