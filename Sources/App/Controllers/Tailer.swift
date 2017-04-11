import Foundation
import Vapor
import HTTP

final class TailController: ResourceRepresentable {
    func index(_ req: Request) throws -> ResponseRepresentable {
        guard let filePath = req.data["filename"]?.string else {
            throw Abort.badRequest
        }

        let task = Process()

        task.launchPath = "/usr/bin/tail"
        task.arguments = ["-n 10", filePath]

        let pipe = Pipe()
        task.standardOutput = pipe

        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        let filename = filePath.components(separatedBy: "/").last!

        return "Filename is \(filename)\n\(output!)"
    }

    func makeResource() -> Resource<Int> {
        return Resource(
          index: index
        )
    }
}
