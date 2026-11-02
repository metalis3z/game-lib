--credit to prince games studio
local Players = game:GetService("Players")
local TutorialUtils = require(script.Parent.TutorialController.TutorialUtils)
local v1 = assert(Players.LocalPlayer)
local Gardens = workspace:WaitForChild("Gardens")
local t = {}
local v2 = nil

local function getHomeSpawnPoint() --[[ getHomeSpawnPoint | Line: 20 | Upvalues: v1 (copy), Gardens (copy) ]]
	local v12 = v1:GetAttribute("PlotId")

	if v12 == nil then
		return nil
	end

	local v2 = Gardens:FindFirstChild((("Plot%*"):format(v12)))

	if not v2 then
		return nil
	end

	local SpawnPoint = v2:FindFirstChild("SpawnPoint")

	if SpawnPoint and SpawnPoint:IsA("BasePart") then
		return SpawnPoint
	end

	return nil
end

local function update() --[[ update | Line: 36 | Upvalues: v1 (copy), v2 (ref), getHomeSpawnPoint (copy), TutorialUtils (copy) ]]
	local v12 = v1:GetAttribute("CarryingStolenFruit") == true

	if v12 and not v2 then
		local v22 = getHomeSpawnPoint()

		if v22 then
			v2 = TutorialUtils.createArrow(v1, CFrame.new(v22.Position)).destroy
		end
	else
		if v12 or not v2 then
			return
		end

		v2()
		v2 = nil
	end
end

function t.Start(p1) --[[ Start | Line: 50 | Upvalues: v1 (copy), update (copy) ]]
	v1:GetAttributeChangedSignal("CarryingStolenFruit"):Connect(update)
	update()
end

return t