export type MessageSource = "Chat" | "ChatCommand" | "API" | "ClientCommandBar" | "ClientPreviewRun" | "ClientRun" | "ClientCommand" | "Other" | "Unknown"

export type Target = Player | number -- a Player instance, or a userId

export type ActionScope = "perm" | "server" | "expire"

return {}
