import UIKit

public typealias NKNetworkSerializerResponse = (serializedData: AnyObject?, serializerError: NSError?)

public typealias NKNetworkSerializerBlock = (
    (request: NSURLRequest, response: NSHTTPURLResponse?, data: NSData?) -> NKNetworkSerializerResponse
)

public typealias NKNetworkResponseBlock = (
    (request: NSURLRequest, response: NSHTTPURLResponse?, dataObject: AnyObject?, error: NSError?) -> (Void)
)

public typealias NKNetworkSessionBecameInvalidBlock = (
    (NSURLSession!, NSError?) -> (Void)
)
public typealias NKNetworkSessionFinishedBackgroundEventsBlock = (
    (NSURLSession!) -> (Void)
)
public typealias NKNetworkSessionReceivedChallengeBlock = (
    (NSURLSession!, NSURLAuthenticationChallenge) -> (NSURLSessionAuthChallengeDisposition, NSURLCredential!)
)

public typealias NKNetworkTaskWillPerformRedirectBlock = (
    (NSURLSession!, NSURLSessionTask!, NSHTTPURLResponse!, NSURLRequest!) -> (NSURLRequest!)
)
public typealias NKNetworkTaskReceivedChallengeBlock = (
    (NSURLSession!, NSURLSessionTask!, NSURLAuthenticationChallenge) ->
    (NSURLSessionAuthChallengeDisposition, NSURLCredential?)
)
public typealias NKNetworkTaskSentBodyDataBlock = (
    (NSURLSession!, NSURLSessionTask!, Int64, Int64, Int64) -> (Void)
)
public typealias NKNetworkTaskNeedsBodyStreamBlock = (
    (NSURLSession!, NSURLSessionTask!) -> (NSInputStream!)
)

public typealias NKNetworkDataTaskReceivedResponseBlock = (
    (NSURLSession!, NSURLSessionDataTask!, NSURLResponse!) -> (NSURLSessionResponseDisposition)
)
public typealias NKNetworkDataTaskBecameDownloadTaskBlock = (
    (NSURLSession!, NSURLSessionDataTask!) -> (Void)
)
public typealias NKNetworkDataTaskReceivedDataBlock = (
    (NSURLSession!, NSURLSessionDataTask!, NSData!) -> (Void)
)
public typealias NKNetworkDataTaskWillCacheResponseBlock = (
    (NSURLSession!, NSURLSessionDataTask!, NSCachedURLResponse!) -> (NSCachedURLResponse)
)
public typealias NKNetworkDataTaskProgressedBlock = (
    (Int64, Int64, Int64) -> (Void)
)

public typealias NKNetworkDownloadTaskFinishedBlock = (
    (NSURLSession!, NSURLSessionDownloadTask!, NSURL) -> (NSURL)
)
public typealias NKNetworkDownloadTaskWroteDataBlock = (
    (NSURLSession!, NSURLSessionDownloadTask!, Int64, Int64, Int64) -> (Void)
)
public typealias NKNetworkDownloadTaskDidResumeBlock = (
    (NSURLSession!, NSURLSessionDownloadTask!, Int64, Int64) -> (Void)
)
