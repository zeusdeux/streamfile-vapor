import Vapor
import HTTP

final class TailController: ResourceRepresentable {
    func index(_ req: Request) throws -> ResponseRepresentable {
        guard let filename = req.data["filename"]?.string else {
            throw Abort.badRequest
        }
        return "Filename is \(filename)"
    }

    func makeResource() -> Resource<Int> {
        return Resource(
          index: index
        )
    }
}
