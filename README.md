# 📱 **Fantazy – Sports App**

MVP • Clean Architecture • Swift • Alamofire • CoreData

Fantazy is an iOS application built following **MVP + Clean Architecture**, allowing users to browse sports, explore leagues, view teams, check events, and manage their favorite leagues.
All data is fetched from **AllSportsAPI** and the project follows the guidelines provided in the course brief.

---

## 👥 **Team Members & Tasks**

### **1. Mohamed Amir**
### **2. Ahmed Elsayyad**

---

## 🧱 **Architecture**

This project follows **MVP + Clean Architecture**:

```
Data Layer
    ↳ DTOs, Mappers, Network, Local Services (CoreData)

Domain Layer
    ↳ Use Cases, Repositories, Models

Presentation Layer
    ↳ MVP (Views, Presenters)
```

Benefits:

* Clear separation of concerns
* Testability (Unit Tests added)
* Scalable and maintainable structure

---

## 🚀 **App Features**

* Browse sports list
* Explore leagues by sport
* View league details including:

  * Upcoming events
  * Latest events
  * Teams
* View team details
* Add/remove favorite leagues (CoreData)
* Offline protection (alerts for no internet)
* Onboarding screens
* Dark/Light mode

---

## 🔌 **Technologies Used**

* **Swift 5**
* **UIKit**
* **Alamofire** (Networking)
* **CoreData** (Favorites)
* **MVP + Clean Architecture**
* **XCTest** (Unit Testing)
* **SDWebImage** (Image loading)

---

## 📂 **Repository Structure (Highlights)**

```
Fantazy/
 ├── Data/
 │   ├── Network/
 │   ├── Mapper/
 │   ├── DTO/
 │   ├── Database/
 │   └── Repository/
 ├── Domain/
 │   ├── Model/
 │   └── Repository/
 └── Presentation/
     ├── Home
     ├── Leagues
     ├── LeagueDetails
     ├── TeamDetails
     ├── Favorite
     ├── Settings
     ├── Onboarding
     └── SplashScreen
```

---

## 🛠 **API Keys (via .xcconfig)**

```
TEAM_API_KEY=xxxxxxx
SPORTS_API_KEY=xxxxxxx
```
