-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Player = require(ReplicatedStorage.Library.Player)
local SurfaceTracker = require(script.SurfaceTracker)
local LocalPlayer = Players.LocalPlayer
local t = {}
local v1 = nil
local t2 = {}

local function getLocalPlayerPosition() --[[ getLocalPlayerPosition | Line: 49 | Upvalues: Player (copy), LocalPlayer (copy) ]]
	local v1 = Player.Optional.PrimaryPart(LocalPlayer)

	if v1 then
		return v1.Position
	end

	return nil
end

local function cleanupPrompt(p1) --[[ cleanupPrompt | Line: 54 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if v1 ~= nil then
		t[p1] = nil
		v1.Tracker:Destroy()
		v1.PromptPart:Destroy()
	end
end

local function updatePromptStates(p1) --[[ updatePromptStates | Line: 65 | Upvalues: t (copy), v1 (ref), Player (copy), LocalPlayer (copy) ]]
	if next(t) == nil then
		local v12 = v1

		if v12 == nil then
			return
		end

		v12:Disconnect()
		v1 = nil
	else
		local v2 = Player.Optional.PrimaryPart(LocalPlayer)
		local v3 = if v2 then v2.Position else nil

		if v3 == nil then
			return
		end

		for k, v in pairs(t) do
			if k.Parent == nil or (v.Model.Parent == nil or v.PromptPart.Parent == nil) then
				local v4 = t[k]

				if v4 ~= nil then
					t[k] = nil
					v4.Tracker:Destroy()
					v4.PromptPart:Destroy()
				end

				continue
			end

			local v5, v6 = v.Tracker:GetClosestSurfacePoint(v3, v.SurfaceOffset)

			if v5 ~= nil and (v6 ~= nil and not (v.TrackDistance < v6)) then
				v.PromptPart.CFrame = CFrame.new(v.PromptPart.Position:Lerp(v5, (math.clamp(p1 * v.FollowSpeed, 0, 1))))
			end
		end
	end
end

local function ensureHeartbeat() --[[ ensureHeartbeat | Line: 96 | Upvalues: v1 (ref), RunService (copy), updatePromptStates (copy) ]]
	if v1 == nil then
		v1 = RunService.Heartbeat:Connect(updatePromptStates)
	end
end

function t2.AttachToModel(p1, p2, p3) --[[ AttachToModel | Line: 108 | Upvalues: Workspace (copy), SurfaceTracker (copy), t (copy), v1 (ref), RunService (copy), updatePromptStates (copy) ]]
	local v12 = "SmartPromptPart"
	local v2 = 0.75
	local v3 = 18
	local v4 = 7
	local v5

	if p3 == nil then
		v5 = nil
	else
		v12 = p3.PartName or v12
		v2 = p3.SurfaceOffset or v2
		v3 = p3.FollowSpeed or v3
		v4 = p3.TrackDistance or v4
		v5 = p3.MaxActivationDistance
	end

	if v5 ~= nil then
		p1.MaxActivationDistance = v5
	end

	local v6 = math.max(v4, p1.MaxActivationDistance)
	local Part = Instance.new("Part")

	Part.Name = v12
	Part.Size = Vector3.new(1, 1, 1)
	Part.Transparency = 1
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanTouch = false
	Part.CanQuery = false
	Part.CFrame = p2:GetPivot()
	Part.Parent = Workspace

	local v7 = SurfaceTracker.new(p2, Part)

	p1.RequiresLineOfSight = false
	p1.Parent = Part
	t[p1] = {
		Model = p2,
		PromptPart = Part,
		Tracker = v7,
		SurfaceOffset = v2,
		FollowSpeed = v3,
		TrackDistance = v6
	}

	local v8, v9

	if v1 ~= nil then
		v8 = p1.Destroying:Once(function() --[[ Line: 151 | Upvalues: p1 (copy), t (ref) ]]
			local v1 = p1
			local v2 = t[v1]

			if v2 ~= nil then
				t[v1] = nil
				v2.Tracker:Destroy()
				v2.PromptPart:Destroy()
			end
		end)
		v9 = p2.Destroying:Once(function() --[[ Line: 154 | Upvalues: p1 (copy), t (ref) ]]
			local v1 = p1
			local v2 = t[v1]

			if v2 ~= nil then
				t[v1] = nil
				v2.Tracker:Destroy()
				v2.PromptPart:Destroy()
			end
		end)

		return function() --[[ Line: 158 | Upvalues: v8 (copy), v9 (copy), p1 (copy), t (ref) ]]
			v8:Disconnect()
			v9:Disconnect()

			local v1 = p1
			local v2 = t[v1]

			if v2 ~= nil then
				t[v1] = nil
				v2.Tracker:Destroy()
				v2.PromptPart:Destroy()
			end
		end
	end

	v1 = RunService.Heartbeat:Connect(updatePromptStates)
	v8 = p1.Destroying:Once(function() --[[ Line: 151 | Upvalues: p1 (copy), t (ref) ]]
		local v1 = p1
		local v2 = t[v1]

		if v2 ~= nil then
			t[v1] = nil
			v2.Tracker:Destroy()
			v2.PromptPart:Destroy()
		end
	end)
	v9 = p2.Destroying:Once(function() --[[ Line: 154 | Upvalues: p1 (copy), t (ref) ]]
		local v1 = p1
		local v2 = t[v1]

		if v2 ~= nil then
			t[v1] = nil
			v2.Tracker:Destroy()
			v2.PromptPart:Destroy()
		end
	end)

	return function() --[[ Line: 158 | Upvalues: v8 (copy), v9 (copy), p1 (copy), t (ref) ]]
		v8:Disconnect()
		v9:Disconnect()

		local v1 = p1
		local v2 = t[v1]

		if v2 ~= nil then
			t[v1] = nil
			v2.Tracker:Destroy()
			v2.PromptPart:Destroy()
		end
	end
end

return t2