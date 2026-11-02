local Workspace = game:GetService("Workspace")
local Lobby = workspace:WaitForChild("Lobby")
local ServerStatus = Lobby:WaitForChild("ServerStatus")

local VersionText = ServerStatus.Screen.SurfaceGui.Frame:WaitForChild("VersionText")
VersionText.Text = ("ver. %s"):format(game.PlaceVersion)

