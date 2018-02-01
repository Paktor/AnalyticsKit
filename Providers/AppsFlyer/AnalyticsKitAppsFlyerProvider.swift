import Foundation
import AppsFlyerLib

public class AnalyticsKitAppsFlyerProvider: NSObject, AnalyticsKitProvider, AppsFlyerTrackerDelegate
{
    private var privacyProperties: [String]!

    public init(apiKey: String,
                appleId: String,
                useUninstallSandbox: Bool = true,
                privacyProperties: [String] = [])
    {
        super.init()
        AppsFlyerTracker.shared().appsFlyerDevKey = apiKey
        AppsFlyerTracker.shared().appleAppID = appleId
        AppsFlyerTracker.shared().useUninstallSandbox = useUninstallSandbox
        AppsFlyerTracker.shared().delegate = self
        self.privacyProperties = privacyProperties
    }

    public func applicationWillEnterForeground()
    {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    
    public func applicationDidEnterBackground() {}
    public func applicationWillTerminate() {}
    public func uncaughtException(_ exception: NSException) {}
    
    public func logEvent(_ event: String)
    {
        AppsFlyerTracker.shared().trackEvent(event, withValues: [:])
    }
    
    public func logEvent(_ event: String, withProperties properties: [String : Any])
    {
        AppsFlyerTracker.shared().trackEvent(event, withValues: self.filteredProperties(params: properties))
    }
    
    public func logEvent(_ event: String, withProperty key: String, andValue value: String)
    {
        AppsFlyerTracker.shared().trackEvent(event, withValues: self.filteredProperties(params: [key: value]))
    }
    
    public func logEvent(_ event: String, timed: Bool)
    {
        AppsFlyerTracker.shared().trackEvent(event, withValues: [:])
    }
    
    public func logEvent(_ event: String, withProperties properties: [String: Any], timed: Bool)
    {
        AppsFlyerTracker.shared().trackEvent(event, withValues: [:])
    }
    
    public func logScreen(_ screenName: String) {}
    public func logScreen(_ screenName: String, withProperties properties: [String: Any]) {}
    public func endTimedEvent(_ event: String, withProperties properties: [String: Any]) {}
    public func logError(_ name: String, message: String?, exception: NSException?) {}
    public func logError(_ name: String, message: String?, error: Error?) {}

    public var ignoredProperties: [String]
    {
        return self.privacyProperties
    }

}
