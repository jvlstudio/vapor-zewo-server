import Vapor

public class Provider: Vapor.Provider {

	public class func boot(application: Application) {
		application.server = ZewoServer()
	}

}