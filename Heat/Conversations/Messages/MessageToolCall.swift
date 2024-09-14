import SwiftUI
import GenKit
import HeatKit

struct MessageToolCall: View {
    let message: Message
    
    var body: some View {
        if let toolCalls = message.toolCalls {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(toolCalls, id: \.id) { toolCall in
                    if let tool = Toolbox(name: toolCall.function.name) {
                        switch tool {
                        case .generateImages:
                            MessageToolCallContent(label: "Generating images...")
                        case .generateMemory:
                            MessageToolCallContent(label: "Remembering...")
                        case .generateSuggestions:
                            MessageToolCallContent(label: "Generating suggestions...")
                        case .generateTitle:
                            MessageToolCallContent(label: "Generating title...")
                        case .searchFiles:
                            MessageToolCallContent(label: "Searching files...")
                        case .searchCalendar:
                            MessageToolCallContent(label: "Searching calendar...")
                        case .searchWeb:
                            MessageToolCallContent(label: "Searching the web...")
                        case .browseWeb:
                            MessageToolCallContent(label: "Browsing the web...")
                        }
                    } else {
                        Text("Missing tool calls.")
                    }
                    Text(toolCall.function.arguments)
                        .font(.footnote)
                        .foregroundStyle(.secondary.opacity(0.5))
                }
            }
            .padding(.horizontal, 24)
        } else {
            Text("Missing tool calls.")
        }
    }
}

struct MessageToolCallContent: View {
    var label: String
    
    var body: some View {
        Text(label)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
}
