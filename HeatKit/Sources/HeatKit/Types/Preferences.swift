import Foundation
import GenKit

public struct Preferences: Codable {
    
    public var services: [Service]
    public var instructions: String?
    public var defaultAgentID: String?
    public var shouldStream: Bool
    public var debug: Bool
    
    public var preferredChatServiceID: Service.ServiceID?
    public var preferredImageServiceID: Service.ServiceID?
    public var preferredEmbeddingServiceID: Service.ServiceID?
    public var preferredTranscriptionServiceID: Service.ServiceID?
    public var preferredToolServiceID: Service.ServiceID?
    public var preferredVisionServiceID: Service.ServiceID?
    public var preferredSpeechServiceID: Service.ServiceID?
    public var preferredSummarizationServiceID: Service.ServiceID?
    
    public init() {
        self.services = []
        self.instructions = nil
        self.defaultAgentID = nil
        self.shouldStream = true
        self.debug = false

        self.preferredChatServiceID = Constants.defaultChatServiceID
        self.preferredImageServiceID = Constants.defaultImageServiceID
        self.preferredEmbeddingServiceID = Constants.defaultTranscriptionServiceID
        self.preferredTranscriptionServiceID = Constants.defaultTranscriptionServiceID
        self.preferredToolServiceID = Constants.defaultToolServiceID
        self.preferredVisionServiceID = Constants.defaultVisionServiceID
        self.preferredSpeechServiceID = Constants.defaultSpeechServiceID
        self.preferredSummarizationServiceID = Constants.defaultSummarizationServiceID
        
        self.services = Constants.defaultServices
    }
}

actor PreferencesData {
    private var preferences: Preferences = .init()
    
    func save(_ preferences: Preferences) throws {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        
        let data = try encoder.encode(preferences)
        try data.write(to: self.dataURL, options: [.atomic])
        self.preferences = preferences
    }
    
    func load() throws -> Preferences {
        let data = try Data(contentsOf: dataURL)
        let decoder = PropertyListDecoder()
        preferences = try decoder.decode(Preferences.self, from: data)
        return preferences
    }
    
    private var dataURL: URL {
        get throws {
            try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    .appendingPathComponent("PreferencesData.plist")
        }
    }
}
