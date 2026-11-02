repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local human = script.Parent.Parent:FindFirstChild("Humanoid")
local char = script.Parent.Parent
local equipAnim = human:LoadAnimation(script.Parent.Equip)
local idleAnim = human:LoadAnimation(script.Parent.Idle)
local useAnim = human:LoadAnimation(script.Parent.Use)
local useLeftAnim = human:LoadAnimation(script.Parent.UseLeft)
local idleCool = true
local useCool = true
local tool = script.Parent

tool.Base.Swing.Volume = 0
tool.Base.Swing2.Volume = 0
tool.Base.Equip.Volume = 0

local newSwingSound = Instance.new("Sound",tool.Base)
newSwingSound.Name = "ClientSwing"
newSwingSound.SoundId = "http://www.roblox.com/asset?id=153647529"
newSwingSound.Volume = 1
newSwingSound.PlaybackSpeed = 1

local newSwingSound2 = Instance.new("Sound",tool.Base)
newSwingSound2.Name = "ClientSwing2"
newSwingSound2.SoundId = "http://www.roblox.com/asset?id=153647529"
newSwingSound2.Volume = 1
newSwingSound.PlaybackSpeed = 1.1

local newEquipSound = Instance.new("Sound",tool.Base)
newEquipSound.Name = "ClientEquip"
newEquipSound.SoundId = "http://www.roblox.com/asset?id=153647514"
newEquipSound.Volume = 1

tool.Equipped:Connect(function()
	
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()

	script.Parent.ConnectM6D:FireServer(tool.ArmAttach)

	char["Right Arm"].ToolGrip.Part0 = char["Right Arm"]
	char["Right Arm"].ToolGrip.Part1 = tool.ArmAttach
	
	newEquipSound:Play()
	
	equipAnim:Play()
	wait(0.1)
	idleAnim:Play()
	idleCool = false
end)

tool.Unequipped:Connect(function()
	
	script.Parent.DisconnectM6D:FireServer()
	
	equipAnim:Stop()
	repeat wait() until idleCool == false
	idleAnim:Stop()
end)

tool.Activated:Connect(function()
	if useCool == true and char.StaminaBar.Stamina.Value > 25 then
		useCool = false
		local aAnim = math.random(2)
		if aAnim == 1 then
			useAnim:Play()
		else
			useLeftAnim:Play()
		end
		wait(0.2)
		local aSwing = math.random(2)
		if aSwing == 1 then
			newSwingSound:Play()
		else
			newSwingSound2:Play()
		end
		script.Parent.Server.SwingEvent:FireServer()
		wait(0.6)
		useCool = true
	end
end)