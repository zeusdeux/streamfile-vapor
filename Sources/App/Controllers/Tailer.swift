import Foundation
import Vapor
import HTTP

final class TailController: ResourceRepresentable {
    func index(_ req: Request) throws -> ResponseRepresentable {
        guard let filename = req.data["filename"]?.string else {
            throw Abort.badRequest
        }

        let task = Process()

        task.launchPath = "/usr/bin/tail"
        task.arguments = ["-n 10", filename]

        let pipe = Pipe()
        task.standardOutput = pipe

        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)

        return "Filename is \(output!)"
    }

    func makeResource() -> Resource<Int> {
        return Resource(
          index: index
        )
    }
}
