local l_Parent_0 = script.Parent
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

local v2 = 1
local shakeAnim = script:WaitForChild("ShakeAnimation")
local v3 = animator:LoadAnimation(shakeAnim)

local function onActivated()
	if os.clock() - v2 < 10 then
		return
	else
		v2 = os.clock()
		v3:Play()
	end
end

l_Parent_0.Activated:Connect(onActivated)