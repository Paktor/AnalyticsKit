import Foundation
import AppsFlyerLib

public class AnalyticsKitAppsFlyerProvider: NSObject, AnalyticsKitProvider, AppsFlyerTrackerDelegate
{
    public init(apiKey: String, appleId: String, useUninstallSandbox: Bool = true)
    {
        super.init()
        AppsFlyerTracker.shared().appsFlyerDevKey = apiKey
        AppsFlyerTracker.shared().appleAppID = appleId
        AppsFlyerTracker.shared().useUninstallSandbox = useUninstallSandbox
        AppsFlyerTracker.shared().delegate = self
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
        AppsFlyerTracker.shared().trackEvent(event, withValues: properties)
    }
    
    public func logEvent(_ event: String, withProperty key: String, andValue value: String)
    {
        AppsFlyerTracker.shared().trackEvent(event, withValues: [key: value])
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

}
