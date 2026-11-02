-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Functions = require(ReplicatedStorage.Library.Functions)
local Player = require(ReplicatedStorage.Library.Player)
local FFlags = require(ReplicatedStorage.Library.Client.FFlags)
local Variables = require(ReplicatedStorage.Library.Variables)
local SpatialTable = require(ReplicatedStorage.Library.Modules.SpatialTable)
local t = {}
local v1 = nil
local t2 = {}
local t3 = {}
local v2 = nil
local v3 = SpatialTable.new(25)

local function updateRaycastFilter() --[[ updateRaycastFilter | Line: 41 | Upvalues: t2 (copy), v1 (ref) ]]
	local t = {}

	for k, v in pairs(t2) do
		table.insert(t, v.pad)
	end

	v1 = RaycastParams.new()
	assert(v1, "luau")
	v1.FilterType = Enum.RaycastFilterType.Include
	v1.FilterDescendantsInstances = t
end

function t.new(p1) --[[ new | Line: 52 | Upvalues: Functions (copy), v2 (ref), t2 (copy), t3 (copy), v3 (copy), updateRaycastFilter (copy) ]]
	local t = {
		destroyed = false,
		uid = Functions.GenerateUID(),
		pad = p1,
		padPosition = p1:GetPivot().Position,
		enterListeners = {},
		leaveListeners = {},
		distanceChecker = Functions.LazyDistanceChecker(p1)
	}

	if t.pad.Parent then
		local Arrow = t.pad.Parent:FindFirstChild("Arrow")

		if Arrow then
			t.arrow = Arrow
			t.arrowPivot = Arrow:GetPivot()
		end
	end

	function t.AddEnterListener(p1, p2) --[[ Line: 71 | Upvalues: Functions (ref) ]]
		local v1 = Functions.GenerateUID()

		p1.enterListeners[v1] = p2

		return function() --[[ Line: 74 | Upvalues: p1 (copy), v1 (copy) ]]
			p1.enterListeners[v1] = nil
		end
	end
	function t.AddLeaveListener(p1, p2) --[[ Line: 79 | Upvalues: Functions (ref) ]]
		local v1 = Functions.GenerateUID()

		p1.leaveListeners[v1] = p2

		return function() --[[ Line: 82 | Upvalues: p1 (copy), v1 (copy) ]]
			p1.leaveListeners[v1] = nil
		end
	end
	function t.IsStandingOn(p1) --[[ Line: 87 | Upvalues: v2 (ref) ]]
		return v2 == p1
	end
	function t.FireEnterListeners(p1) --[[ Line: 91 ]]
		for k, v in pairs(p1.enterListeners) do
			task.spawn(v)
		end
	end
	function t.Destroy(p1) --[[ Line: 97 | Upvalues: t2 (ref), t3 (ref), v3 (ref), updateRaycastFilter (ref) ]]
		if p1.destroyed then
			return
		end

		p1.destroyed = true

		for k in pairs(p1.enterListeners) do
			p1.enterListeners[k] = nil
		end

		for k in pairs(p1.leaveListeners) do
			p1.leaveListeners[k] = nil
		end

		t2[p1.uid] = nil
		t3[p1.pad] = nil
		v3:Remove(p1.padPosition, p1)
		updateRaycastFilter()
	end
	t2[t.uid] = t
	t3[t.pad] = t
	updateRaycastFilter()
	t.pad.Destroying:Connect(function() --[[ Line: 119 | Upvalues: t (copy) ]]
		t:Destroy()
	end)
	v3:Insert(t.padPosition, t)

	return t
end

local function animateArrows() --[[ animateArrows | Line: 126 | Upvalues: RunService (copy), FFlags (copy), Variables (copy), t2 (copy) ]]
	local v1 = tick()

	RunService.RenderStepped:Connect(function(p1) --[[ Line: 128 | Upvalues: FFlags (ref), Variables (ref), v1 (copy), t2 (ref) ]]
		if FFlags.Get(FFlags.Keys.DisableWorldFrontend) or Variables.PotatoMode then
			return
		end

		local v3 = CFrame.new(0, math.sin((tick() - v1) * 3) * 0.45, 0)

		for k, v in pairs(t2) do
			if v.arrow and (v.arrowPivot and v.distanceChecker()) then
				v.arrow:PivotTo(v.arrowPivot * v3)
			end
		end
	end)
end

task.spawn(function() --[[ Line: 142 | Upvalues: updateRaycastFilter (copy), Player (copy), v3 (copy), v1 (ref), t2 (copy), v2 (ref) ]]
	updateRaycastFilter()

	while task.wait(0.1) do
		local v12 = Player.Optional.PrimaryPart()

		if v12 then
			assert(v12, "PrimaryPart should not be nil")

			if v3:Query(v12.Position) then
				local v22 = workspace:Raycast(v12.Position, Vector3.new(0, -10, 0), v1)

				if v22 and v22.Instance then
					local v32 = v22.Instance
					local v4 = nil

					for k, v in pairs(t2) do
						if v32 == v.pad or v32:IsDescendantOf(v.pad) then
							v4 = v

							break
						end
					end

					if v4 then
						assert(v4, "A pad was expected to be found via raycast")

						if not v2 or v4 ~= v2 then
							for k, v in pairs(v4.enterListeners) do
								task.spawn(v)
							end
						end

						v2 = v4

						continue
					end

					if v2 then
						for k, v in pairs(v2.leaveListeners) do
							task.spawn(v)
						end

						v2 = nil
					end

					continue
				end

				if v2 then
					for k, v in pairs(v2.leaveListeners) do
						task.spawn(v)
					end

					v2 = nil
				end

				continue
			end

			if v2 then
				for k, v in pairs(v2.leaveListeners) do
					task.spawn(v)
				end

				v2 = nil
			end

			continue
		end

		if not v2 then
			continue
		end

		for k, v in pairs(v2.leaveListeners) do
			task.spawn(v)
		end

		v2 = nil
	end
end)
task.spawn(animateArrows)

return t