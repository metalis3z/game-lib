repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local Tool = script.Parent
local Char = Tool.Parent
local Clicked = false
local Drinked = false
local Equip = Char:WaitForChild("Humanoid"):LoadAnimation(script.Equip)
local Idle = Char:WaitForChild("Humanoid"):LoadAnimation(script.Idle)
local Drink = Char:WaitForChild("Humanoid"):LoadAnimation(script.Drink)
script.Parent.Base.DrinkSound.Parent = Char.Head

Tool.Equipped:Connect(function()
	if Drinked == false then
	script.Parent.Base.OpenSound:Play()
	Equip:Play()
	Idle:Play()
	end
end)

Tool.Unequipped:Connect(function()
	if Drinked == false then
	script.Parent.Base.OpenSound:Stop()
	Equip:Stop()
	Idle:Stop()
	end
end)



Tool.Activated:Connect(function()
if Clicked == false then
	Clicked = true
	script.Parent.Base.OpenSound:Stop()
	Drink:Play()
	wait()
	Equip:Stop()
	Idle:Stop()
	wait(0.2)
	Char.Head.DrinkSound:Play()
	Drinked = true
	wait(3)
		Char.Humanoid.Health = Char.Humanoid.MaxHealth
		Char.StaminaBar.Stamina.Value = Char.StaminaBar.MaxStamina.Value
	local DroppedItem = Tool.Base:Clone()
	DroppedItem.Name = "ThrownBloxyCola"
	DroppedItem.CanCollide = true
	DroppedItem.Parent = game.Workspace
	DroppedItem.Decompose.Disabled = false
	DroppedItem.CFrame = Char["Right Arm"].CFrame
	script.Parent:Destroy()
	wait(2)
	Clicked = false
	end
end)