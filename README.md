# Take-Home Project

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-15%2B-blue.svg)](https://developer.apple.com/xcode/)

A modular iOS project built with **XcodeGen**, using **MVVM + Clean Architecture**, written in **Swift**.  
👉 GitHub repo: [Take-Home_Project](https://github.com/thanh25101997/Take-Home_Project)

---

## 🔧 1. XcodeGen Setup

This project uses [`XcodeGen`](https://github.com/yonaskolb/XcodeGen) to generate the `.xcodeproj` from a `project.yml` file.

### 👉 How to generate project

```bash
brew install xcodegen
xcodegen generate
```

### 📁 Folder structure (auto-generated)

```
Take-Home_Project/
├── project.yml
├── Take-Home/
│   ├── Sources/
│   │   ├── AppDelegate.swift
│   │   ├── SceneDelegate.swift
│   │   ├── Modules/
│   │   │   ├── Home/
│   │   │   └── ...
│   └── Resources/
├── Take-HomeTests/
├── Take-HomeUITests/
```

---

## 🧱 2. Architecture: MVVM + Clean Architecture

The project is split into **layers** with clear boundaries:

### 💡 Layered Design

- **View**: `UIViewController`, `UIView`
- **ViewModel**: handles logic, transforms inputs → outputs
- **UseCase / Interactor**: contains business logic
- **Repository**: abstracted data access (remote/local)
- **Data Source**: implements data fetching (API, DB)
- **Models**: plain Swift structs (DTOs, Entities)

### 💥 Advantages

- Easy to test (mock repositories or use cases)
- Separation of concerns
- Scalable and clean

---

## 📦 3. Dependency Management

- **Swift Package Manager (SPM)** used via `project.yml` with packages:
  - [Alamofire](https://github.com/Alamofire/Alamofire)
  - [RxSwift](https://github.com/ReactiveX/RxSwift)
  - [Kingfisher](https://github.com/onevcat/Kingfisher)

To resolve:

```bash
xcodegen
open Take-Home.xcodeproj
// Let Xcode resolve SPM dependencies
```

---

## 🧪 4. Unit Testing

- Test targets: `Take-HomeTests`, `Take-HomeUITests`
- Follows MVVM test approach: test `ViewModel` in isolation
- Use case and repository layers are mockable

---

## 📲 5. API Info

Sample API: [GitHub Users](https://api.github.com/users)

- Pagination:
  - `since`: calculated by `page * per_page`
  - `per_page`: adjustable

---

## 🛠 6. Requirements

- Xcode 15+
- Swift 5.0+
- iOS 15.0+

---

## 🚀 7. Getting Started

1. Clone the repo

```bash
git clone https://github.com/thanh25101997/Take-Home_Project.git
cd Take-Home_Project
```

2. Generate Xcode project

```bash
xcodegen
```

3. Open in Xcode

```bash
open Take-Home.xcodeproj
```

4. Build and run

---

## 📎 8. To-Do / Roadmap

- [ ] Add CI integration (GitHub Actions)
- [ ] Improve error handling layer
- [ ] Add snapshot testing for UI
- [ ] Add Dark mode support

---

## 📄 License

MIT License

---

_Developed by [thanh25101997](https://github.com/thanh25101997)_
