
# Modularisation
Modularisation is process of breaking down the application into smaller maintainable and reliable micro-services. Modularised architecture categorises use-cases of the application in to feature modules, thus, clearly defining the responsibility of each module inside a dynamic framework.

Below are some of the most useful features of modularised app:
 - [Build Parallelisation](https://shashikantjagtap.net/wwdc18-modern-tips-for-optimising-swift-build-time-in-xcode-10/) - If  you look at your dependency graph and you don't see complex nested dependencies, you can actually take advantage of your multi-core processors to speed up build time.
 - Code Reusability - Features/ UI components developed can be extracted and versioned for reuse in other applications.
 - Encapsulated Scope - Major issue in huge application is the maintainability and further scalability. When a bug comes up, most of the times developers have to go through a number of classes and deep inheritance hell to find the issue. Clearly defining the scope of a feature eliminates this and prevents the issue from affecting other features.
- Easier Testing - Scope is defined thus making testing is also bounded task.
- Team Collaboration - Unlike in a typical huge application where developers' working copies often conflict with one another, here,  developers can work in parallel on separate features without that worry since the scope is encapsulated.

Having discussed how this can help your development, there are also disadvantages developers should look into:
 - When dependency graph becomes a long list, checking out code becomes too tedious regardless which dependency manager you're using.
 - Huge binary size - Compared to a monolith app, the either the archive or iPa is comparably huge. One of major factors affecting the adoption rate of application version is its size. In iOS applications the 3G download, as of writing, is currently limited to 150MB. This shouldn't be a problem considering Apple continues to make improvements in their appstore.
 - Syncing Build Configuration -  By default, iOS applications has two build configurations -- Debug and Release. Most developers prefer to add another one, Adhoc, for their adhoc deployments. This extra build configuration should also exist in your subprojects to successfully do an archive, otherwise, you have to do extra work and modify the framework mapping of your application layer.

# Architecture
There are many ways to write a modular applications. Some of those are Uber's [RIBs](https://github.com/uber/RIBs), [VIPER](https://www.objc.io/issues/13-architecture/viper/) and [MVC+RS](https://medium.com/swift-programming/mvc-rs-8780e73e9ff4). This example uses the latter but a modified version MVVM+RS since the application is built on top of [RxSwift](https://github.com/ReactiveX/RxSwift). Below is an overview of the architecture:

![alt text](https://github.com/softwaresaiyajin/modular-app-demo-ios/blob/develop/readme_res/Screen%20Shot%202018-10-23%20at%202.31.43%20PM.png)

The application is built using Swift so it takes advantage of the flexibility of [Protocol-oriented programming](https://www.raywenderlich.com/814-introducing-protocol-oriented-programming-in-swift-3). But the architecture can still be achieved in an object-oriented language using [Adapter Pattern](https://stackify.com/design-patterns-explained-adapter-pattern-with-code-examples/).

As illustrated in the diagram, the application is divided into three components:

 - Feature layer - This contains the use-cases the application. In this example, each screen is considered a feature. Each feature has a repository abstraction which they use to access whatever they need outside their scope (e.g, concrete data, styles, configurations, routing service, etc.). Each feature is developed to be stand-alone so they have their own demo applications making them independent on other external dependencies such as the rate the backend service is being developed.
 - Router Layer - This uses [Navigator](https://github.com/softwaresaiyajin/navigator-ios) framework. Feature modules are decoupled from one another, thus, no references from one another. So when it comes to navigating to another screen, an entity should handle the registration of each screens to know which controller to present. Feature modules communicates to this layer through abstraction as well.
 - Data Layer - Uses [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) as it's HttpClient and may be integrated further with any ORM such as [Realm](https://github.com/realm/realm-cocoa). This handles the network requests, mapping of endpoints to their corresponding concrete data models and application persistency.

# When to modularise?
Modularisation is not for every project. This is incredibly useful for projects which have mid to high complexities and are expected to scale but will be considered a waste of time for small projects.
Developers must thoroughly evaluate the system they are about to develop by conducting feasibility study before proceeding with engineering decisions. 

# Dependency Management
One of the cornerstones of modular app is its dependency manager. Gone are the days when you have to download a Github source code and paste it into your application. Today, in mobile development, most developers are using Carthage, Cocoapods, and Gradle.

 - [Cocoapods](https://cocoapods.org/) - CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It converts your application into workspace and injects the source files of your dependencies.
 - [Carthage](https://github.com/Carthage/Carthage) - Carthage builds your dependencies and provides you with binary frameworks, but you retain full control over your project structure and setup. Carthage does not automatically modify your project files or your build settings.

Between the two dependency managers. I prefer Carthage because binary frameworks are fool-proof compared to source files. There will be time that you'll be working with a less experience developers so it's crucial to restrict certain parts of the app especially the core modules. In Carthage, they have no chance of modifying the dependencies because those are already compiled. In addition, unlike in Cocoapods, developers don't have to setup Podspecs and and pod repo for their frameworks. Every CocoaTouch dynamic frameworks can be consumed right away using Carthage as long as they have [shared schemes](https://developer.nevercode.io/docs/sharing-ios-project-schemes) and are buildable.

# Conventions
- [Git-flow](https://danielkummer.github.io/git-flow-cheatsheet/) - It is important to follow a standard in your branch modelling regardless if you're doing modular or monolithic application so team members know how to merge features properly. Git-flow is a set of git extensions to provide high-level repository operations
- [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide) - A team can be composed of developers whose skills vary from one another, but still, they should all be able to read one another's code and point out the lines of codes that don't follow the team's engineering standards. This can be achieved using a standardised coding style.

# CI/CD
With lots of features being developed and requested for merge to your base branch, it's a necessity to check the build integrity and to automate and deployment process. Prerequisites of CI tool is the source code should have written tests in it otherwise, the tool is not fully utilised. I prefer a cloud-based solution compared to a build a machine because I can schedule or deploy right away a build anywhere. 
Below is a cheaper, open-source CI/CD tool:

 - [Bitrise](https://www.bitrise.io) - Bitrise scans and configures your project for any mobile platform, be it native or hybrid, so you can start shipping your app immediately

# To Do's
Dependency Inversion principle is applied in above example but it is manual injection. Below is a better way to do DI.

 - [Swinject](https://github.com/Swinject/Swinject) - Dependency injection (DI) is a software design pattern that implements Inversion of Control (IoC) for resolving dependencies. In the pattern, Swinject helps your app split into loosely-coupled components, which can be developed, tested and maintained more easily
