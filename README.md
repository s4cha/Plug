# Actions 🔌

[Reason](#why) - [Example](#rxample-project) -  [Idea](#main-idea) - [Get Started](#get-started)

## Why
Because **Classic MVC** pattern is **no longer suitable** for real world Apps. Partly because it was never meant to be. **We developers** spend a **huge** amount of time **trying our best to do things right**.


## How
By providing a **simple convention** on how to **cleanly handle actions** in an iOS App. Developers spend **less time** architechting and more time **adding value for their users.**


## Benefits
- [x] Clean Architecture
- [x] Code 90% of the App without the Backend implementation
- [x] Faster build times
- [x] Less Dependencies (think Better Testability, & Faster tests)
- [x] Easier to Maintain (predictable system)


## Example Project
Download and launch the `Example Project` to see how a Typical `LikePhoto` use case would be implemented using this approach.


## Main Idea
This is based on **Robert-C Martin** (Uncle Bob) thoughts, the guy behind the **SOLID** principles

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
public protocol Action {
    associatedtype Input
    associatedtype Output
    func perform(_ input: Input) -> Output
}
```

### Like Photo Abstraction

For instance in the case of liking a photo, the `LikePhoto` action has an input of `Photo` and an Output of `AsyncTask`

A cool this is that Output can be **synchronous or asynchronous**, it's yours to choose \o/.  
Here is how our App defines the `LikePhoto` use-case :
```swift
protocol LikePhoto: Action {
    func perform(_ input: Photo) -> Promise<Void>
}
```

### Like Photo Actions
Now we want to define a `_likePhoto` action that is of Type `LikePhoto`.
```swift
var _likePhoto: AnyAction<Photo, Promise<Void>>!
```

### Calling an action
```swift
action(_likePhoto, Photo()).then {
  // photo liked !
}
```

### Model sugar
This phase is optional. But software is built for humans and we want this to be as readable as possible !

```swift
extension Photo {
    func like() -> Promise<Void> {
        return action(_likePhoto, self)
    }
}
```
You can now write it like this:
```swift
photo.like.then {
  // Photo liked \o/
}
```

### Providing A Concrete implementation for our Action
```swift
import then
import ws

struct MyWebApiLikePhoto: LikePhoto {

    let ws = WS("https://jsonplaceholder.typicode.com")

    func perform(_ input: Photo) -> Promise<Void> {
        return ws.post("/photos/\(input.identifier)/like")
    }
}
```

We can now Inject this implementation in our App form the AppDelegate :
```swift        
_likePhoto = AnyAction(MyWebApiLikePhoto())
```
All the like photo actions of our App will now use our concrete Implementation preforming a network call :).

This is now super easy to provide a dummy `MockLikePhoto` for testing purposes!



## Sum Up
Using this approach We have
- A clean and readable way to call actions on models.
- Those actions are forwarded by Model extensions to the Action system.
- Actions can be provided as plugins in the app delegate.
