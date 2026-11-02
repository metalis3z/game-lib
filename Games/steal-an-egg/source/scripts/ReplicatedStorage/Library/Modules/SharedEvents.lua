-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Modules.Packages.Trove)

local v1 = 0
local t = {}
local t2 = {}

local function pushPartCFrame(p1, p2) --[[ pushPartCFrame | Line: 10 | Upvalues: v1 (ref), t (copy), t2 (copy) ]]
	v1 = v1 + 1
	t[v1] = p1
	t2[v1] = p2

	return nil
end

local function stepParts() --[[ stepParts | Line: 17 | Upvalues: t (copy), t2 (copy), v1 (ref) ]]
	debug.profilebegin("SharedEventUtils:StepParts")
	workspace:BulkMoveTo(t, t2, Enum.BulkMoveMode.FireCFrameChanged)
	v1 = 0
	table.clear(t)
	table.clear(t2)
	debug.profileend()

	return nil
end

local function loadAnimation(p1, p2, p3) --[[ loadAnimation | Line: 27 ]]
	local v1 = p2:LoadAnimation(p3)

	local function cleanup() --[[ cleanup | Line: 29 | Upvalues: v1 (copy) ]]
		v1:Stop(0)
		v1:Destroy()
	end

	p1:Add(cleanup)

	return v1, function() --[[ Line: 34 | Upvalues: p1 (copy), cleanup (copy) ]]
		p1:Remove(cleanup)
	end
end

if RunService:IsServer() then
	RunService.PostSimulation:Connect(stepParts)
else
	RunService.PreRender:Connect(stepParts)
end

return {
	pushPartCFrame = pushPartCFrame,
	loadAnimation = loadAnimation
}