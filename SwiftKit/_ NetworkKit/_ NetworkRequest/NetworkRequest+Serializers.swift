import Foundation

public extension NetworkRequest {
    public static func responseSerializerData() -> NetworkSerializerBlock {
        return {(request, response, data) -> NetworkSerializerResponse in
            return (data, nil)
        }
    }

    public func responseData(completionHandler: NetworkResponseBlock) -> Self {
        return self.response(
            serializer: NetworkRequest.responseSerializerData(),
            completionHandler: completionHandler
        )
    }
}

public extension NetworkRequest {
    public static func responseSerializerString(encoding: NSStringEncoding=NSUTF8StringEncoding) -> NetworkSerializerBlock {
        return {(_, _, data) -> NetworkSerializerResponse in
            let response: (serializedData: AnyObject?, serializerError: NSError?)
            if let stringData = data {
                response = (NSString(data: stringData, encoding: encoding), nil)
            }
            else {
                response = (nil, nil)
            }
            return response
        }
    }

    public func responseString(
        encoding: NSStringEncoding=NSUTF8StringEncoding,
        completionHandler: (NSURLRequest, NSHTTPURLResponse?, String?, NSError?) -> (Void)
    ) -> Self {
        return self.response(
            serializer: NetworkRequest.responseSerializerString(encoding: encoding),
            completionHandler: {(request, response, string, error) -> (Void) in
                completionHandler(request, response, string as? String, error)
        })
    }
}

public extension NetworkRequest {
    public static func responseSerializerJSON(
        options: NSJSONReadingOptions=NSJSONReadingOptions.AllowFragments
    ) -> NetworkSerializerBlock {
        return {(request, response, data) -> NetworkSerializerResponse in
            var json: AnyObject?
            var serializationError: NSError?
            if let jsonData = data {
                json = NSJSONSerialization.JSONObjectWithData(jsonData, options: options, error: &serializationError)
            }
            return (json, serializationError)
        }
    }

    public func responseJSON(
        options: NSJSONReadingOptions=NSJSONReadingOptions.AllowFragments,
        completionHandler: NetworkResponseBlock
    ) -> Self {
        return self.response(
            serializer: NetworkRequest.responseSerializerJSON(options: options),
            completionHandler: completionHandler
        )
    }

    public func responseJSON(options: NSJSONReadingOptions=NSJSONReadingOptions.AllowFragments) -> (AnyObject?, NSError?) {
        let networkOperation = NetworkOperation()
            .set(request: self)
            .set(serializer: NetworkRequest.responseSerializerJSON(options: options))
        networkOperation.start()
        networkOperation.waitUntilFinished()
        return networkOperation.networkResponse()
//            .runOperation()
//            .completeOperation()
//            .networkResponse()
    }
}
