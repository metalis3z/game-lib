repeat task.wait() until script.Parent.Parent:FindFirstChild("Humanoid")

local Humanoid = script.Parent.Parent:WaitForChild("Humanoid")
local Tool = script.Parent
local Equip = Tool.Animations.equip
local EquipA = Humanoid:LoadAnimation(Equip)

local player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)

script.Parent.Cover.Color = script.Parent:GetAttribute("Color")
script.Parent.Handle.Color = script.Parent:GetAttribute("Color")

local d = false

Tool.Equipped:Connect(function()
	script.Parent.UILeft.ImageLabel.ImageRectOffset = Vector2.new(50 * script.Parent:GetAttribute("Figure"), 0);
	script.Parent.UIRight.TextLabel.Text = script.Parent:GetAttribute("Number")
	
	EquipA:Play()
	task.delay(3, function()
		if d == false then
			d = true
			game.ReplicatedStorage.EntityInfo.PadlockHint:FireAllClients(script.Parent:GetAttribute("Figure"), script.Parent:GetAttribute("Number"), player.UserId)
			Tool:Destroy()
		end
	end)
end)

Tool.Unequipped:Connect(function()
	EquipA:Stop()
end)