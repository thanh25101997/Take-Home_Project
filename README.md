# Take-Home Project

A modular iOS project built with **XcodeGen**, using **MVVM + Clean Architecture**, written in **Swift**.  
👉 GitHub repo: [Take-Home_Project](https://github.com/thanh25101997/Take-Home_Project)

---

## 🔧 1. XcodeGen Setup

This project uses [`XcodeGen`](https://github.com/yonaskolb/XcodeGen) to generate the `.xcodeproj` from a `project.yml` file.

### 👉 How to setup & generate project

```bash
brew install xcodegen
xcodegen generate
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

- Clearly separate the responsibilities of each specific class
- Easy to test (mock repositories or use cases)
- Scalable and clean

---

## 📦 3. Dependency Management

- **Swift Package Manager (SPM)** used via `project.yml` with packages:
  - [Alamofire](https://github.com/Alamofire/Alamofire)
  - [RxSwift](https://github.com/ReactiveX/RxSwift)
  - [Kingfisher](https://github.com/onevcat/Kingfisher)
---

## 🧪 4. Unit Testing

- Test targets: `Take-HomeTests`
- Experimental demo of ViewModel and Interactor
- Use case and repository layers are mockable

---

## 🚀 5. Getting Started

1. Clone the repo

```bash
git clone https://github.com/thanh25101997/Take-Home_Project.git
cd Take-Home_Project
```

2. Generate Xcode project

```bash
xcodegen generate
```

3. Open in Xcode

```bash
open Take-Home.xcodeproj
```

4. Build and run

---

