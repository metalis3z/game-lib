-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local InsertService = game:GetService("InsertService")
local Players = game:GetService("Players")
local t = {
	fall = "Freefall",
	jump = "Jumping",
	run = "Run",
	walk = "Walk",
	idle = "Idle",
	sit = "Seated",
	swim = "Swimming",
	swimidle = "SwimIdle",
	climb = "Climbing"
}

local function loadAnimations(p1, p2) --[[ loadAnimations | Line: 18 | Upvalues: InsertService (copy), t (copy) ]]
	if p2 == 0 then
		return
	end

	for v1, v2 in InsertService:LoadAsset(p2):GetDescendants() do
		if v2:IsA("Animation") then
			local v3 = if v2:FindFirstChild("Weight") then v2.Weight.Value else 10
			local v4 = t[v2.Parent.Name]

			p1[v4] = p1[v4] or {}
			table.insert(p1[v4], {
				id = string.match(v2.AnimationId, "http://www.roblox.com/asset/%?id%=(%d+)"),
				weight = v3
			})
		end
	end
end

local function loadEmoteAnimations(p1) --[[ loadEmoteAnimations | Line: 44 | Upvalues: InsertService (copy) ]]
	if p1 == 0 then
		return
	end

	local t = {}

	for v1, v2 in InsertService:LoadAsset(p1):GetDescendants() do
		if v2:IsA("Animation") then
			local v3 = if v2:FindFirstChild("Weight") then v2.Weight.Value else 10

			table.insert(t, {
				looped = false,
				id = string.match(v2.AnimationId, "http://www.roblox.com/asset/%?id%=(%d+)"),
				weight = v3
			})
		end
	end

	return t
end

local t2 = {}
local t3 = {}

local function getPlayerAnimPackage(p1) --[[ getPlayerAnimPackage | Line: 75 | Upvalues: t2 (copy), loadAnimations (copy) ]]
	if t2[p1] then
		return
	end

	local Character = p1.Character

	if not Character then
		return
	end

	local v1 = Character:FindFirstChildWhichIsA("HumanoidDescription", true)

	if v1 then
		t2[p1] = os.clock()

		local t = {}

		loadAnimations(t, v1.RunAnimation)
		loadAnimations(t, v1.WalkAnimation)
		loadAnimations(t, v1.ClimbAnimation)
		loadAnimations(t, v1.SwimAnimation)
		loadAnimations(t, v1.JumpAnimation)
		loadAnimations(t, v1.FallAnimation)

		return t
	end
end

local function getPlayerEmotePackage(p1) --[[ getPlayerEmotePackage | Line: 103 | Upvalues: t3 (copy), Players (copy), loadEmoteAnimations (copy) ]]
	if t3[p1] then
		return
	end

	local t = {}

	for v1, v2 in Players:GetCharacterAppearanceInfoAsync(p1.UserId).emotes do
		t[v2.assetName] = loadEmoteAnimations(v2.assetId)
	end

	return t
end

local function cooldownLoop(p1) --[[ cooldownLoop | Line: 118 ]]
	while task.wait(5) do
		for v1, v2 in p1 do
			if not (os.clock() - v2 <= script.Parent.Parent:GetAttribute("AsyncRequestCooldown")) then
				p1[v1] = nil
			end
		end
	end
end

if RunService:IsServer() then
	task.spawn(cooldownLoop, t2)
	task.spawn(cooldownLoop, t3)

	return {
		getPlayerAnimPackage = getPlayerAnimPackage,
		getPlayerEmotePackage = getPlayerEmotePackage
	}
end

return nil