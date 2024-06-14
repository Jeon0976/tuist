import ArgumentParser
import Foundation
import Path

struct CloudOrganizationRemoveCommand: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "remove",
            _superCommandName: "organization",
            abstract: "A set of commands to remove members or cancel pending invitations.",
            subcommands: [
                CloudOrganizationRemoveInviteCommand.self,
                CloudOrganizationRemoveMemberCommand.self,
                CloudOrganizationRemoveSSOCommand.self,
            ]
        )
    }
}
