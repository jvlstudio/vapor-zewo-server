import HTTPServer
import Vapor

class ZewoServer: Vapor.ServerDriver {
    var delegate: Vapor.ServerDriverDelegate?
    var server: HTTPServer.Server!

    func boot(port port: Int) throws {
        self.server = try Server(port: port, responder: self)
        try server.start()
    }

    func halt() {

    }
}

extension ZewoServer: HTTP.ResponderType {

    func respond(request: HTTP.Request) throws -> HTTP.Response {
        //convert to Vapor request
        let path = request.uri.path ?? "/"
        let vaporRequest = Vapor.Request.init(method: .Get, path: path, address: nil, headers: [:], body: [])

        //convert to Zewo response
        if let vaporResponse = self.delegate?.serverDriverDidReceiveRequest(vaporRequest) {
            let data: Data = Data(vaporResponse.data)
            var response = Response(body: data)

            response.status = .OK

            for (key, value) in vaporResponse.headers {
                response.headers[CaseInsensitiveKey(key)] = value
            }

            return response
        } else {
            Log.warning("not found")    
            return Response()
        }

    }

}