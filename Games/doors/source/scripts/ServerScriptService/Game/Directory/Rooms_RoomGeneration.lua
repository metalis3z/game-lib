local module = {}

repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Rooms_FirstRoom" then

else
	return
end

function module:CreateDoor(v)
	local door = game.ServerScriptService.Server.Assets.Rooms_Door:Clone()
	door.Parent = v
	door:PivotTo(v:FindFirstChild("RoomExit").CFrame)
	
	door.Sign.Stinker.Text = game.Workspace.CurrentRooms.RoomsNumber.Value
	door.Sign.Stinker.Highlight.Text = game.Workspace.CurrentRooms.RoomsNumber.Value
	door.Sign.Stinker.Shadow.Text = game.Workspace.CurrentRooms.RoomsNumber.Value
end

function module:InstanceGenerate()
	local Rooms = game:GetService("ServerScriptService"):WaitForChild("Server"):FindFirstChild("Hunt_Rooms"):GetChildren()
	
end

return module
