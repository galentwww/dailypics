import Cocoa
import FlutterMacOS
import Photos

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let controller = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = controller
        self.setFrame(windowFrame, display: true)
        
        let channel = FlutterMethodChannel(name: "ml.cerasus.pics", binaryMessenger: controller.engine.binaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "share":
                let arguments = call.arguments as! Dictionary<String, String>;
                self.share(file: arguments["file"]!, result: result)
            case "useAsWallpaper":
                self.useAsWallpaper(file: call.arguments as! String, result: result)
            case "requestReview":
                self.requestReview(inApp: call.arguments as! Bool, result: result)
            case "isAlbumAuthorized":
                self.isAlbumAuthorized(result: result)
            case "openAppSettings":
                self.openAppSettings(result: result)
            case "syncAlbum":
                let arguments = call.arguments as! Dictionary<String, String>;
                self.syncAlbum(file: arguments["file"]!, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        RegisterGeneratedPlugins(registry: controller)
        super.awakeFromNib()
    }

    private func share(file: String, result: FlutterResult) {
        // TODO: implement method
        result(nil)
    }

    private func useAsWallpaper(file: String, result: FlutterResult) {
        /*let task = Process()
        task.launchPath = "osascript"
        task.arguments = ["-e", "tell application \"Finder\" to set desktop picture to POSIX file \"\(file)\""]
        task.launch()*/
        result(FlutterMethodNotImplemented)
    }

    private func requestReview(inApp: Bool, result: FlutterResult) {
        let url = "itms-apps://itunes.apple.com/app/id1457009047?action=write-review"
        result(NSWorkspace.shared.open(URL.init(string: url)!))
    }

    private func isAlbumAuthorized(result: FlutterResult) {
        let fileManager = FileManager.default
        let url: URL = fileManager.urls(for: .picturesDirectory, in: .userDomainMask)[0]
        result(fileManager.isWritableFile(atPath: url.path))
    }

    private func openAppSettings(result: FlutterResult) {
        result(FlutterMethodNotImplemented)
    }

    private func syncAlbum(file: String, result: FlutterResult) {
        let fileManager = FileManager.default
        let path: URL = fileManager.urls(for: .picturesDirectory, in: .userDomainMask)[0]
        let srcUrl = URL.init(fileURLWithPath: file)
        let dstUrl = path.appendingPathComponent(srcUrl.lastPathComponent)
        do {
            try fileManager.moveItem(at: srcUrl, to: dstUrl)
            result(nil)
        } catch let error {
            result(FlutterError(code: "0", message: error.localizedDescription, details: nil))
        }
    }
}
