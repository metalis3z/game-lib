--credit to leon games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CamShake = require(ReplicatedStorage.ClientModules.CamShake)
local t = {}

local function getLocalHrp() --[[ getLocalHrp | Line: 38 | Upvalues: Players (copy) ]]
	local LocalPlayer = Players.LocalPlayer
	local v1 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
	local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1

	if v2 and v2:IsA("BasePart") then
		return v2
	end

	return nil
end

local function isInRange(p1) --[[ isInRange | Line: 48 | Upvalues: Players (copy) ]]
	local LocalPlayer = Players.LocalPlayer
	local v1 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
	local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
	local v3 = if v2 and v2:IsA("BasePart") then v2 else nil

	if not v3 then
		return false
	end

	return (v3.Position - p1).Magnitude <= 250
end

local function resolvePathSize(p1) --[[ resolvePathSize | Line: 56 ]]
	if p1 ~= "Big" and p1 ~= "Huge" then
		return "Normal"
	end

	return p1
end

local function computeGrowImpact(p1, p2) --[[ computeGrowImpact | Line: 63 ]]
	local v1 = p1 - 1

	return (v1 * 0.85 + 1.4) * (if p2 == "Huge" then 1.25 else 1) * 1, v1 * 3 + 8
end

local function playImpactShake(p1, p2, p3, p4) --[[ playImpactShake | Line: 73 | Upvalues: CamShake (copy) ]]
	CamShake:ShakeOnce(p1, p2, p3 or 0.04, p4 or 0.4, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5))
end

local function playGrowImpact(p1, p2) --[[ playGrowImpact | Line: 84 | Upvalues: Players (copy), CamShake (copy) ]]
	if p1._pathSize == "Normal" then
		return
	end

	if p2 < 1 then
		return
	end

	local LocalPlayer = Players.LocalPlayer
	local v1 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
	local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
	local v3 = if v2 and v2:IsA("BasePart") then v2 else nil

	if not (if v3 then if (v3.Position - p1._eggPosition).Magnitude <= 250 then true else false else false) then
		return
	end

	local v5 = p2 - 1

	CamShake:ShakeOnce((v5 * 0.85 + 1.4) * (if p1._pathSize == "Huge" then 1.25 else 1) * 1, v5 * 3 + 8, 0.04, 0.4, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5))
end

local function playHatchImpact(p1) --[[ playHatchImpact | Line: 99 | Upvalues: Players (copy), CamShake (copy) ]]
	if p1._pathSize == "Normal" then
		return
	end

	if p1._maxGrowTier < 1 then
		return
	end

	local LocalPlayer = Players.LocalPlayer
	local v1 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
	local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
	local v3 = if v2 and v2:IsA("BasePart") then v2 else nil

	if not (if v3 then if (v3.Position - p1._eggPosition).Magnitude <= 250 then true else false else false) then
		return
	end

	local v5 = p1._maxGrowTier + 1 - 1

	CamShake:ShakeOnce((v5 * 0.85 + 1.4) * (if p1._pathSize == "Huge" then 1.25 else 1) * 1, v5 * 3 + 8, 0.08, 0.8, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5))
end

function t.begin(p1, p2) --[[ begin | Line: 119 | Upvalues: Players (copy), CamShake (copy) ]]
	return {
		_maxGrowTier = 0,
		_resolved = false,
		_eggPosition = p1,
		_pathSize = if p2 == "Big" or p2 == "Huge" then p2 else "Normal",
		onWobbleBeat = function(p1, p2) --[[ onWobbleBeat | Line: 129 ]] end,
		onGrowBeat = function(p1, p2, p3) --[[ onGrowBeat | Line: 132 | Upvalues: Players (ref), CamShake (ref) ]]
			if p1._resolved or p1._pathSize == "Normal" then
				return
			end

			p1._maxGrowTier = math.max(p1._maxGrowTier, p2)

			if p1._pathSize == "Normal" then
				return
			end

			if p2 < 1 then
				return
			end

			local LocalPlayer = Players.LocalPlayer
			local v1 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
			local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
			local v3 = if v2 and v2:IsA("BasePart") then v2 else nil

			if not (if v3 then if (v3.Position - p1._eggPosition).Magnitude <= 250 then true else false else false) then
				return
			end

			local v5 = p2 - 1

			CamShake:ShakeOnce((v5 * 0.85 + 1.4) * (if p1._pathSize == "Huge" then 1.25 else 1) * 1, v5 * 3 + 8, 0.04, 0.4, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5))
		end,
		onHatch = function(p1, p2) --[[ onHatch | Line: 140 ]] end,
		onPetRevealed = function(p1) --[[ onPetRevealed | Line: 143 | Upvalues: Players (ref), CamShake (ref) ]]
			if p1._resolved or p1._pathSize == "Normal" then
				return
			end

			p1._resolved = true

			if p1._pathSize == "Normal" then
				return
			end

			if p1._maxGrowTier < 1 then
				return
			end

			local LocalPlayer = Players.LocalPlayer
			local v1 = if LocalPlayer then LocalPlayer.Character else LocalPlayer
			local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
			local v3 = if v2 and v2:IsA("BasePart") then v2 else nil

			if not (if v3 then if (v3.Position - p1._eggPosition).Magnitude <= 250 then true else false else false) then
				return
			end

			local v5 = p1._maxGrowTier + 1 - 1

			CamShake:ShakeOnce((v5 * 0.85 + 1.4) * (if p1._pathSize == "Huge" then 1.25 else 1) * 1, v5 * 3 + 8, 0.08, 0.8, Vector3.new(0.3, 0.3, 0.3), Vector3.new(2, 2, 5))
		end,
		finishHatch = function(p1) --[[ finishHatch | Line: 151 ]]
			p1._resolved = true
		end
	}
end

return t