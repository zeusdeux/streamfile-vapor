import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("index")
}

drop.get("tail") { req in

}

drop.resource("posts", PostController())

drop.run()
