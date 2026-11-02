local Remote = script.Parent.Stranger
local Remote2 = script.Parent.Namer
local Players = game:GetService("Players")
local Mask2 = game.ReplicatedStorage.Masks:FindFirstChild("Surgical Mask")
local Tool = script.Parent
local Handle = script.Parent.Handle




Remote.OnServerEvent:connect(function(player,character)
	local Masks = Mask2:Clone()
	Masks.Parent = script.Parent.Parent
	Masks.Name = "Mask"
	Masks.Handle.BrickColor = BrickColor.new("Black")
	script.Parent.Parent.Head.Card.Frame.Namey.Text = "Stranger " .. player.UserId
	 Tool.Handle.Transparency = 1
end)

Remote2.OnServerEvent:connect(function(player,character)
     script.Parent.Parent.Head.Card.Frame.Namey.Text = player.CharSettings.CharacterName.Value
     script.Parent.Parent.Mask:Destroy()
	local Hats = player.Character:GetChildren()
Tool.Handle.Transparency = 0 
end)