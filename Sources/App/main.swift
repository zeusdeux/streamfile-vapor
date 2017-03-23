import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("index")
}

drop.resource("tail", Tailer())

drop.run()
