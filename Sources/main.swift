import Vapor

let app = Application()

app.get("test") { request in
    return "123"
}

app.server = ZewoServer()

app.start(port: 8080)