// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LaunchListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LaunchList($limit: Int, $offset: Int) {
      launchesPast(limit: $limit, offset: $offset) {
        __typename
        id
        launch_date_utc
        mission_name
        rocket {
          __typename
          rocket_name
          rocket_type
        }
        links {
          __typename
          mission_patch_small
        }
      }
    }
    """

  public let operationName: String = "LaunchList"

  public var limit: Int?
  public var offset: Int?

  public init(limit: Int? = nil, offset: Int? = nil) {
    self.limit = limit
    self.offset = offset
  }

  public var variables: GraphQLMap? {
    return ["limit": limit, "offset": offset]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("launchesPast", arguments: ["limit": GraphQLVariable("limit"), "offset": GraphQLVariable("offset")], type: .list(.object(LaunchesPast.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(launchesPast: [LaunchesPast?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "launchesPast": launchesPast.flatMap { (value: [LaunchesPast?]) -> [ResultMap?] in value.map { (value: LaunchesPast?) -> ResultMap? in value.flatMap { (value: LaunchesPast) -> ResultMap in value.resultMap } } }])
    }

    public var launchesPast: [LaunchesPast?]? {
      get {
        return (resultMap["launchesPast"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [LaunchesPast?] in value.map { (value: ResultMap?) -> LaunchesPast? in value.flatMap { (value: ResultMap) -> LaunchesPast in LaunchesPast(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [LaunchesPast?]) -> [ResultMap?] in value.map { (value: LaunchesPast?) -> ResultMap? in value.flatMap { (value: LaunchesPast) -> ResultMap in value.resultMap } } }, forKey: "launchesPast")
      }
    }

    public struct LaunchesPast: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Launch"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(GraphQLID.self)),
          GraphQLField("launch_date_utc", type: .scalar(String.self)),
          GraphQLField("mission_name", type: .scalar(String.self)),
          GraphQLField("rocket", type: .object(Rocket.selections)),
          GraphQLField("links", type: .object(Link.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, launchDateUtc: String? = nil, missionName: String? = nil, rocket: Rocket? = nil, links: Link? = nil) {
        self.init(unsafeResultMap: ["__typename": "Launch", "id": id, "launch_date_utc": launchDateUtc, "mission_name": missionName, "rocket": rocket.flatMap { (value: Rocket) -> ResultMap in value.resultMap }, "links": links.flatMap { (value: Link) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return resultMap["id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var launchDateUtc: String? {
        get {
          return resultMap["launch_date_utc"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "launch_date_utc")
        }
      }

      public var missionName: String? {
        get {
          return resultMap["mission_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "mission_name")
        }
      }

      public var rocket: Rocket? {
        get {
          return (resultMap["rocket"] as? ResultMap).flatMap { Rocket(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "rocket")
        }
      }

      public var links: Link? {
        get {
          return (resultMap["links"] as? ResultMap).flatMap { Link(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "links")
        }
      }

      public struct Rocket: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LaunchRocket"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("rocket_name", type: .scalar(String.self)),
            GraphQLField("rocket_type", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(rocketName: String? = nil, rocketType: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LaunchRocket", "rocket_name": rocketName, "rocket_type": rocketType])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var rocketName: String? {
          get {
            return resultMap["rocket_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "rocket_name")
          }
        }

        public var rocketType: String? {
          get {
            return resultMap["rocket_type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "rocket_type")
          }
        }
      }

      public struct Link: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LaunchLinks"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("mission_patch_small", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(missionPatchSmall: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LaunchLinks", "mission_patch_small": missionPatchSmall])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var missionPatchSmall: String? {
          get {
            return resultMap["mission_patch_small"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mission_patch_small")
          }
        }
      }
    }
  }
}

public final class LaunchQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Launch($id: ID!) {
      launch(id: $id) {
        __typename
        details
        launch_site {
          __typename
          site_name_long
        }
        launch_date_utc
        mission_name
        links {
          __typename
          flickr_images
          mission_patch
        }
        rocket {
          __typename
          rocket_name
          rocket_type
          rocket {
            __typename
            height {
              __typename
              meters
            }
            mass {
              __typename
              kg
            }
            diameter {
              __typename
              meters
            }
            cost_per_launch
            success_rate_pct
            engines {
              __typename
              number
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Launch"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("launch", arguments: ["id": GraphQLVariable("id")], type: .object(Launch.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(launch: Launch? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "launch": launch.flatMap { (value: Launch) -> ResultMap in value.resultMap }])
    }

    public var launch: Launch? {
      get {
        return (resultMap["launch"] as? ResultMap).flatMap { Launch(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "launch")
      }
    }

    public struct Launch: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Launch"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("details", type: .scalar(String.self)),
          GraphQLField("launch_site", type: .object(LaunchSite.selections)),
          GraphQLField("launch_date_utc", type: .scalar(String.self)),
          GraphQLField("mission_name", type: .scalar(String.self)),
          GraphQLField("links", type: .object(Link.selections)),
          GraphQLField("rocket", type: .object(Rocket.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(details: String? = nil, launchSite: LaunchSite? = nil, launchDateUtc: String? = nil, missionName: String? = nil, links: Link? = nil, rocket: Rocket? = nil) {
        self.init(unsafeResultMap: ["__typename": "Launch", "details": details, "launch_site": launchSite.flatMap { (value: LaunchSite) -> ResultMap in value.resultMap }, "launch_date_utc": launchDateUtc, "mission_name": missionName, "links": links.flatMap { (value: Link) -> ResultMap in value.resultMap }, "rocket": rocket.flatMap { (value: Rocket) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var details: String? {
        get {
          return resultMap["details"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "details")
        }
      }

      public var launchSite: LaunchSite? {
        get {
          return (resultMap["launch_site"] as? ResultMap).flatMap { LaunchSite(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "launch_site")
        }
      }

      public var launchDateUtc: String? {
        get {
          return resultMap["launch_date_utc"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "launch_date_utc")
        }
      }

      public var missionName: String? {
        get {
          return resultMap["mission_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "mission_name")
        }
      }

      public var links: Link? {
        get {
          return (resultMap["links"] as? ResultMap).flatMap { Link(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "links")
        }
      }

      public var rocket: Rocket? {
        get {
          return (resultMap["rocket"] as? ResultMap).flatMap { Rocket(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "rocket")
        }
      }

      public struct LaunchSite: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LaunchSite"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("site_name_long", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(siteNameLong: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LaunchSite", "site_name_long": siteNameLong])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var siteNameLong: String? {
          get {
            return resultMap["site_name_long"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "site_name_long")
          }
        }
      }

      public struct Link: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LaunchLinks"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("flickr_images", type: .list(.scalar(String.self))),
            GraphQLField("mission_patch", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(flickrImages: [String?]? = nil, missionPatch: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LaunchLinks", "flickr_images": flickrImages, "mission_patch": missionPatch])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var flickrImages: [String?]? {
          get {
            return resultMap["flickr_images"] as? [String?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "flickr_images")
          }
        }

        public var missionPatch: String? {
          get {
            return resultMap["mission_patch"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mission_patch")
          }
        }
      }

      public struct Rocket: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["LaunchRocket"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("rocket_name", type: .scalar(String.self)),
            GraphQLField("rocket_type", type: .scalar(String.self)),
            GraphQLField("rocket", type: .object(Rocket.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(rocketName: String? = nil, rocketType: String? = nil, rocket: Rocket? = nil) {
          self.init(unsafeResultMap: ["__typename": "LaunchRocket", "rocket_name": rocketName, "rocket_type": rocketType, "rocket": rocket.flatMap { (value: Rocket) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var rocketName: String? {
          get {
            return resultMap["rocket_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "rocket_name")
          }
        }

        public var rocketType: String? {
          get {
            return resultMap["rocket_type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "rocket_type")
          }
        }

        public var rocket: Rocket? {
          get {
            return (resultMap["rocket"] as? ResultMap).flatMap { Rocket(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "rocket")
          }
        }

        public struct Rocket: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Rocket"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("height", type: .object(Height.selections)),
              GraphQLField("mass", type: .object(Mass.selections)),
              GraphQLField("diameter", type: .object(Diameter.selections)),
              GraphQLField("cost_per_launch", type: .scalar(Int.self)),
              GraphQLField("success_rate_pct", type: .scalar(Int.self)),
              GraphQLField("engines", type: .object(Engine.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(height: Height? = nil, mass: Mass? = nil, diameter: Diameter? = nil, costPerLaunch: Int? = nil, successRatePct: Int? = nil, engines: Engine? = nil) {
            self.init(unsafeResultMap: ["__typename": "Rocket", "height": height.flatMap { (value: Height) -> ResultMap in value.resultMap }, "mass": mass.flatMap { (value: Mass) -> ResultMap in value.resultMap }, "diameter": diameter.flatMap { (value: Diameter) -> ResultMap in value.resultMap }, "cost_per_launch": costPerLaunch, "success_rate_pct": successRatePct, "engines": engines.flatMap { (value: Engine) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var height: Height? {
            get {
              return (resultMap["height"] as? ResultMap).flatMap { Height(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "height")
            }
          }

          public var mass: Mass? {
            get {
              return (resultMap["mass"] as? ResultMap).flatMap { Mass(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "mass")
            }
          }

          public var diameter: Diameter? {
            get {
              return (resultMap["diameter"] as? ResultMap).flatMap { Diameter(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "diameter")
            }
          }

          public var costPerLaunch: Int? {
            get {
              return resultMap["cost_per_launch"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "cost_per_launch")
            }
          }

          public var successRatePct: Int? {
            get {
              return resultMap["success_rate_pct"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "success_rate_pct")
            }
          }

          public var engines: Engine? {
            get {
              return (resultMap["engines"] as? ResultMap).flatMap { Engine(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "engines")
            }
          }

          public struct Height: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Distance"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("meters", type: .scalar(Double.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(meters: Double? = nil) {
              self.init(unsafeResultMap: ["__typename": "Distance", "meters": meters])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var meters: Double? {
              get {
                return resultMap["meters"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "meters")
              }
            }
          }

          public struct Mass: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Mass"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("kg", type: .scalar(Int.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(kg: Int? = nil) {
              self.init(unsafeResultMap: ["__typename": "Mass", "kg": kg])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var kg: Int? {
              get {
                return resultMap["kg"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "kg")
              }
            }
          }

          public struct Diameter: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Distance"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("meters", type: .scalar(Double.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(meters: Double? = nil) {
              self.init(unsafeResultMap: ["__typename": "Distance", "meters": meters])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var meters: Double? {
              get {
                return resultMap["meters"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "meters")
              }
            }
          }

          public struct Engine: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["RocketEngines"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("number", type: .scalar(Int.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(number: Int? = nil) {
              self.init(unsafeResultMap: ["__typename": "RocketEngines", "number": number])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var number: Int? {
              get {
                return resultMap["number"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "number")
              }
            }
          }
        }
      }
    }
  }
}
