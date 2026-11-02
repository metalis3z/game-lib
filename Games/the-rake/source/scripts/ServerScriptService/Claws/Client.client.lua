local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local tool = script.Parent

repeat wait() until char:FindFirstChildOfClass("Humanoid")

local equipAnim = char.Humanoid:LoadAnimation(script.Parent.Animations.Equip)
local idleAnim = char.Humanoid:LoadAnimation(script.Parent.Animations.Idle)
local swingR = char.Humanoid:LoadAnimation(script.Parent.Animations.SwingR)
local swingL = char.Humanoid:LoadAnimation(script.Parent.Animations.SwingL)

local idleCool = true

tool.Equipped:Connect(function()
	

	script.Parent.ConnectM6D:FireServer()
	
	char["Right Arm"].ToolGrip.Part0 = char["Right Arm"]
	char["Right Arm"].ToolGrip.Part1 = tool.RightArmAttach
	
	char["Left Arm"].ToolGrip2.Part0 = char["Left Arm"]
	char["Left Arm"].ToolGrip2.Part1 = tool.LeftArmAttach
	
	equipAnim:Play()
	wait()
	idleAnim:Play()
	idleCool = false
	
end)

tool.Unequipped:Connect(function()

	script.Parent.DisconnectM6D:FireServer()
	
	equipAnim:Stop()
	repeat wait() until idleCool == false
	idleAnim:Stop()
	idleCool = true
	
end)