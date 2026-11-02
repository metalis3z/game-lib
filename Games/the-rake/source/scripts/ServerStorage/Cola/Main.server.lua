repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local Clicked = false
local Cooldown = false
local Equiped = false
local Idle = script.Parent.Parent:FindFirstChild("Humanoid"):LoadAnimation(script.Idle)
local Drink = script.Parent.Parent:FindFirstChild("Humanoid"):LoadAnimation(script.Drink)
local Character = script.Parent.Parent
script.Parent.Base.DrinkSound.Parent = script.Parent.Parent.Head

script.Parent.Equipped:Connect(function()
	Idle:Play()
end)

script.Parent.Unequipped:Connect(function()
	Idle:Stop()
end)



script.Parent.Activated:Connect(function()
if Clicked == false then
	Clicked = true
	Drink:Play()
	wait()
	Idle:Stop()
	wait(0.2)
	Character.Head.DrinkSound:Play()
	wait(3)
		Character.Humanoid.Health = Character.Humanoid.MaxHealth
		Character.StaminaBar.Stamina.Value = Character.StaminaBar.MaxStamina.Value
	local DroppedItem = script.Parent.Base:Clone()
	DroppedItem.Name = "ThrownSoda"
	DroppedItem.CanCollide = true
	DroppedItem.Parent = game.Workspace
	DroppedItem.Decompose.Disabled = false
		DroppedItem.CFrame = Character["Right Arm"].CFrame
	script.Parent.Base.Transparency = 1
		wait(10)
		script.Parent.Base.Transparency = 0
		Clicked = false
	end
end)