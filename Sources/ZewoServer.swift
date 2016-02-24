import HTTPServer
import Vapor

public class ZewoServer: Vapor.ServerDriver {
    public var delegate: Vapor.ServerDriverDelegate?
    var server: HTTPServer.Server!

    public func boot(port port: Int) throws {
        self.server = try Server(port: port, responder: self)
        try server.start()
    }

    public func halt() {
        //implement me
    }
}

extension HTTP.Method {

    ///Converts an HTTP.Method to a Vaopr.Request.Method
    var vaporValue: Vapor.Request.Method {
        switch self {
            case .GET:
                return .Get
            case .POST:
                return .Post
            case .PUT:
                return .Put
            case .PATCH:
                return .Patch
            case .DELETE:
                return .Delete
            case .OPTIONS:
                return .Options
            default:
                return .Unknown
        }
    }

}

extension Vapor.Response {

    ///Converts an Vapor.Response.Status to an HTTP.Status
    var zewoStatus: HTTP.Status {
        return .Raw(statusCode: self.status.code, reasonPhrase: self.reasonPhrase)
    }

}

extension ZewoServer: HTTP.ResponderType {

    public func respond(request: HTTP.Request) throws -> HTTP.Response {
        //convert to Vapor request
        var path = request.uri.path ?? "/"

        //convert path params
        if request.query.count > 0 {
            path += "?"
            for (key, value) in request.query {
                path += "\(key)=\(value)"
            }
        }

        let method = request.method.vaporValue

        //transfer headers
        var headers: [String: String] = [:]
        for (key, header) in request.headers {
            headers["\(key)"] = header
        }

        //convert buffer to [UInt8] array
        let data: [UInt8]
        switch request.body {
            case .Buffer(let body):
                data = [UInt8](body)
            default:
                data = []
        }

        let vaporRequest = Vapor.Request.init(method: method, path: path, address: nil, headers: headers, body: data)

        //convert to Zewo response
        if let vaporResponse = self.delegate?.serverDriverDidReceiveRequest(vaporRequest) {
            let data: Data = Data(vaporResponse.data)
            var response = Response(body: data)

            response.status = vaporResponse.zewoStatus

            for (key, value) in vaporResponse.headers {
                response.headers[CaseInsensitiveKey(key)] = value
            }

            return response
        } else {
            Log.error("Request not handled")    
            return Response()
        }

    }

}