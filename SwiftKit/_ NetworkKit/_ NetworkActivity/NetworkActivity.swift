import UIKit

public class NetworkActivity {
    private struct Extension {
        static var instance: NetworkActivity?
    }

    static var sharedInstance: NetworkActivity? {
        return self.sharedActivity()
    }

    static func sharedActivity() -> NetworkActivity? {
        return Extension.instance
    }

    let application: UIApplication

    var activityCount: Int
    
    var mainQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }

    var isNetworkIndicatorVisible: Bool {
        return (self.activityCount != 0)
    }

    var setNetworkActivityIndicator: (Void)->(Void) {
        return {
            self.application.networkActivityIndicatorVisible = self.isNetworkIndicatorVisible
        }
    }

    public required init(application: UIApplication) {
        self.application = application
        self.activityCount = 0

        Extension.instance = self
        NSURLSessionTask.swizzleSessionTasks()
    }

    func requestDidBegin() {
        self.setActivityCount(newCount: self.activityCount + 1)
    }

    func requestDidEnd() {
        self.setActivityCount(newCount: self.activityCount - 1)
    }

    func setActivityCount(#newCount: Int) {
        NSOperationQueue.synced(self) {
            self.activityCount = max(0, newCount)
        }
        self.mainQueue.dispatch {
            if self.isNetworkIndicatorVisible == false {
                self.mainQueue.dispatchAfterDelay(0.17, self.setNetworkActivityIndicator)
            }
            else {
                self.mainQueue.dispatch(self.setNetworkActivityIndicator)
            }
        }
    }
}
