import Foundation
import AppsFlyerLib

public class AnalyticsKitAppsFlyerProvider: NSObject, AnalyticsKitProvider, AppsFlyerTrackerDelegate
{
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any])
    {
        guard let first_launch_flag = conversionInfo["is_first_launch"] as? Int else {
            return
        }
        
        guard let status = conversionInfo["af_status"] as? String else {
            return
        }
        
        if (first_launch_flag == 1) {
            if (status == "Non-organic") {
                if let media_source = conversionInfo["media_source"] , let campaign = conversionInfo["campaign"] {
                    print("This is a Non-Organic install. Media source: \(media_source) Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
        } else {
            print("Not First Launch")
        }
        
        trackerDelegate?.onConversionDataSuccess(conversionInfo)
    }
    
    public func onConversionDataFail(_ error: Error)
    {
        trackerDelegate?.onConversionDataFail(error)
    }
    
    public func onAppOpenAttribution(_ attributionData: [AnyHashable : Any])
    {
        trackerDelegate?.onAppOpenAttribution?(attributionData)
    }
    
    public func onAppOpenAttributionFailure(_ error: Error)
    {
        trackerDelegate?.onAppOpenAttributionFailure?(error)
    }
    
    public var trackerDelegate: AppsFlyerTrackerDelegate?
    
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
