local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if not Enums.IsPartyServer then  --only runs in party mode
	script:Destroy()
	return
end


local Character = script.Parent
local Humanoid = Character:WaitForChild("Humanoid")
local Leg = Character:FindFirstChild("Left Leg") or Character:FindFirstChild("LeftFoot")
local RUN_INCREASE = 10

local Timer = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Timer"))
local RunTimer = Timer.new()
RunTimer:OnFinish(function()
	if Humanoid and Humanoid.Parent then
		Humanoid.WalkSpeed = 16
	end
end)
RunTimer:Start(2)

Leg.Touched:connect(function(hit)
	if hit and hit.Parent and hit.Name == "Street" then
		Humanoid.WalkSpeed = 36
		RunTimer:Reset()
	end
end)






