import Foundation
import FirebaseCore
import FirebaseAnalytics

public class AnalyticsKitFirebaseProvider: NSObject, AnalyticsKitProvider
{

    private static var eventCharacterSet: CharacterSet = {
        var cs = CharacterSet.alphanumerics
        cs.insert("_")
        return cs.inverted
    }()

    public override init()
    {
        super.init()
        FirebaseApp.configure()
    }

    // Lifecycle
    public func applicationWillEnterForeground()
    { }

    public func applicationDidEnterBackground()
    { }

    public func applicationWillTerminate()
    { }

    public func uncaughtException(_ exception: NSException)
    { }

    // Logging
    public func logScreen(_ screenName: String)
    {
        logEvent("Screen - \(screenName)")
    }

    public func logScreen(_ screenName: String, withProperties properties: [String: Any])
    {
        logEvent("Screen - \(screenName)", withProperties: properties)
    }

    public func logEvent(_ event: String)
    {
        logFbEvent(event, parameters: nil)
    }

    public func logEvent(_ event: String, withProperty key: String, andValue value: String)
    {
        logFbEvent(event, parameters: [key: value])
    }

    public func logEvent(_ event: String, withProperties properties: [String: Any])
    {
        logFbEvent(event, parameters: properties)
    }

    public func logEvent(_ event: String, timed: Bool)
    {
        logFbEvent(event, parameters: nil)
    }

    public func logEvent(_ event: String, withProperties dict: [String: Any], timed: Bool)
    {
        logFbEvent(event, parameters: dict)
    }

    public func endTimedEvent(_ event: String, withProperties dict: [String: Any])
    {
        // Firebase doesn't support timed events
    }

    public func logError(_ name: String, message: String?, exception: NSException?)
    {
        logFbEvent("Exception Logged", parameters: [
            "name": name,
            "message": String(describing: message).prefix(100),
            "exception": String(describing: exception).prefix(100)
        ])
    }

    public func logError(_ name: String, message: String?, error: Error?)
    {
        logFbEvent("Error Logged", parameters: [ // error is a reserved word in firebase so we can't call the event "Error"
            "name": name,
            "message": String(describing: message).prefix(100),
            "error": String(describing: error).prefix(100)
        ])
    }

    fileprivate func logFbEvent(_ event: String, parameters: [String: Any]?)
    {
        // Firebase event names must be snake cased and since AK is designed for multi-provider we
        // have to convert to be safe.
        var snakeCaseEvent = event.replacingOccurrences(of: "-", with: " ")
        snakeCaseEvent = snakeCaseEvent.replacingOccurrences(of: "_", with: " ")
        snakeCaseEvent = snakeCaseEvent.replacingOccurrences(of: " +", with: "_", options: .regularExpression, range: nil)
        snakeCaseEvent = snakeCaseEvent.lowercased()
        snakeCaseEvent = snakeCaseEvent.components(separatedBy: AnalyticsKitFirebaseProvider.eventCharacterSet).joined()
        Analytics.logEvent(snakeCaseEvent, parameters: parameters)
    }

}
