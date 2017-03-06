# RxGithub

This is an example project to demonstrate [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) and [Swinject](https://github.com/Swinject/Swinject) in [MVVM (Model-View-ViewModel)](https://en.wikipedia.org/wiki/Model_View_ViewModel) architecture with [RxSwift](https://github.com/ReactiveX/RxSwift).

## Requirements

- Xcode 8.0 or later
- [GitHub](https://github.com/settings/tokens) personal access token

## Setup

1. Download the source code or clone the repository.
3. Get a free personal access token from [GitHub](https://github.com/settings/tokens).
4. Create a swift file named `Keys.swift` with the following content in `RxGithub` folder in the project. The string `"TOKEN"` should be replaced with your own personal access token.

**Keys.swift**
```
import Foundation

enum Keys {
    static let GitHubAccessToken = "TOKEN"
}
```

## Workshop sessions (Hebrew)

[![Part 1](http://img.youtube.com/vi/5zs8CXiBcA4/0.jpg)](http://www.youtube.com/watch?v=5zs8CXiBcA4)

[![Part 1](http://img.youtube.com/vi/9YH1sskeQhk/0.jpg)](http://www.youtube.com/watch?v=9YH1sskeQhk)
