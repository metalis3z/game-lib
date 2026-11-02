repeat wait() until script.Parent.Parent:FindFirstChild("Humanoid")
local human = script.Parent.Parent:FindFirstChild("Humanoid")
local char = script.Parent.Parent
local equipAnim = human:LoadAnimation(script.Parent.Equip)
local idleAnim = human:LoadAnimation(script.Parent.Idle)
local shotAnim = human:LoadAnimation(script.Parent.Shot)
local idleCool = true
local useCool = true
local tool = script.Parent

tool.Base.EquipSound.Volume = 0
tool.Base.ShotSound.Volume = 0

local newEquipSound = Instance.new("Sound",tool.Base)
newEquipSound.Name = "ClientEquipSound"
newEquipSound.SoundId = "rbxassetid://3603316577"
newEquipSound.Volume = 1
newEquipSound.PlaybackSpeed = 0.9

local newShotSound = Instance.new("Sound",tool.Base)
newShotSound.Name = "ClientShotSound"
newShotSound.SoundId = "rbxassetid://6740247243"
newShotSound.Volume = 1.5
newShotSound.PlaybackSpeed = 1.5

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
	shotAnim:Play()
	newShotSound:Play()
	script.Parent.ShotPart.ParticleEmitter.Enabled = true
end)

tool.ShotPart.ParticleEmitter.Changed:Connect(function()
	if tool.ShotPart.ParticleEmitter.Enabled == true then
		wait(0.1)
		tool.ShotPart.ParticleEmitter.Enabled = false
	end
end)