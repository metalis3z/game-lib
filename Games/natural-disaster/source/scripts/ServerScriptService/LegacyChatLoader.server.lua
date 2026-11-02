local Chat = game:GetService("Chat")
local StarterPlayer = game:GetService("StarterPlayer")
local ServerScriptService = game:GetService("ServerScriptService")

script.ChatScript.Parent = StarterPlayer.StarterPlayerScripts
script.ChatServiceRunner.Parent = ServerScriptService
script.Remotes.Parent = Chat
script.Shared.Parent = Chat