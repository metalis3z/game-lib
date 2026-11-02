-- // Values \\ --
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Animator = Humanoid:WaitForChild("Animator")
local Animations = script.Parent:WaitForChild('Animations')
local Sounds = script.Parent.Sounds
local PourSound = Sounds.Pour
local DrinkSound = Sounds.Drink
local IdleAnim = Animations:WaitForChild('Idle')
local IdleTrack = Animator:LoadAnimation(IdleAnim)
local PourAnim = Animations:WaitForChild('Pour')
local PourTrack = Animator:LoadAnimation(PourAnim)
local DrinkAnim = Animations:WaitForChild('Drink')
local DrinkTrack = Animator:LoadAnimation(DrinkAnim)
local ProximityPrompt = script.Parent:FindFirstChild('Handle'):FindFirstChild('Pour')
local UnEquipped = true
local Tool = script.Parent
local T1 = script.Parent:FindFirstChild('T1')
local T2 = script.Parent:FindFirstChild('T2')
local Poured = script.Parent:FindFirstChild('Poured').Value
local CanDrink = false
local DrinksLeft = script.Parent.DrinksLeft.Value

function UpdateGUI()
	local GUI = Player.PlayerGui:FindFirstChild('LGui')
	local Main = GUI.Main
	local Left = Main.LeftFrame
	local DrinksLeftText = Left.DrinksLeft
	DrinksLeftText.Text = DrinksLeft
end

Tool.Equipped:Connect(function()
	print('Equipped')
	UnEquipped = false
	IdleTrack:Play()
	if not Player.PlayerGui:FindFirstChild('LGui') then
		script.LGui:Clone().Parent = Player.PlayerGui
	end
	if Poured == false and Player.Backpack:FindFirstChild('PurpleC') then
		DrinksLeft = 'PurpleC Needed!'
		ProximityPrompt.Enabled = true
	end
	UpdateGUI()
end)

Tool.Unequipped:Connect(function()
	print('UnEquipped')
	UnEquipped = true
	IdleTrack:Stop()
	PourTrack:Stop()
	ProximityPrompt.Enabled = false
	UpdateGUI()
	Player.PlayerGui:FindFirstChild('LGui'):Destroy()
end)

ProximityPrompt.PromptButtonHoldBegan:Connect(function()
	print('Hold Began')
	PourSound:Play()
	PourTrack:Play()
end)
ProximityPrompt.PromptButtonHoldEnded:Connect(function()
	print('Hold Ended')
	PourTrack:Stop()
	PourSound:Stop()
end)
ProximityPrompt.Triggered:Connect(function()
	print('Triggered')
	PourSound:Stop()
	T1.Transparency = 0
	T2.Transparency = 0
	CanDrink = true
	DrinksLeft = 6
	UpdateGUI()
	ProximityPrompt.Enabled = false
end)
local CoolDown = false
Tool.Activated:Connect(function()
	if CanDrink == true and CoolDown == false and DrinksLeft > 0 then
		CoolDown = true
		DrinkTrack:Play()
		DrinksLeft -= 1
		UpdateGUI()
		DrinkSound:Play()
		print(DrinksLeft)
		task.wait(3)
		CoolDown = false
	elseif CanDrink == true and CoolDown == false and DrinksLeft == 0 then
		DrinksLeft = 'Empty'
		UpdateGUI()
	end
end)