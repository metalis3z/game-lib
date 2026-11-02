-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Library.Player)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local t = {}
local v1 = 0

local function getLeaderboardPart(p1) --[[ getLeaderboardPart | Line: 30 ]]
	local Adornee = p1.Adornee

	if Adornee and Adornee:IsA("BasePart") then
		return Adornee
	end

	local v1 = p1.Parent

	if v1 and v1:IsA("BasePart") then
		return v1
	end

	return nil
end

local function updateLeaderboard(p1, p2) --[[ updateLeaderboard | Line: 44 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	local v2 = true
	local MaxDistance = v1.Gui.MaxDistance

	if p2 then
		if MaxDistance > 0 then
			v2 = if (p2.Position - v1.Part.Position).Magnitude <= MaxDistance then true else false
		end
	else
		v2 = false
	end

	if v1.Gui.Enabled == v2 then
		return
	end

	v1.Gui.Enabled = v2
end

local function cleanupLeaderboard(p1) --[[ cleanupLeaderboard | Line: 65 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	v1.Trove:Clean()

	if not v1.Gui.Parent then
		t[p1] = nil

		return
	end

	v1.Gui.Enabled = true
	t[p1] = nil
end

local function trackLeaderboard(p1) --[[ trackLeaderboard | Line: 79 | Upvalues: t (copy), Trove (copy), Player (copy), LocalPlayer (copy) ]]
	if not p1:IsA("ScrollingFrame") then
		return
	end

	local v1 = t[p1]

	if v1 then
		v1.Trove:Clean()

		if v1.Gui.Parent then
			v1.Gui.Enabled = true
		end

		t[p1] = nil
	end

	local v2 = p1.Parent

	if not (v2 and v2:IsA("Frame")) then
		return
	end

	local v3 = v2.Parent

	if not (v3 and v3:IsA("SurfaceGui")) then
		return
	end

	local Adornee = v3.Adornee
	local v4

	if Adornee and Adornee:IsA("BasePart") then
		v4 = Adornee
	else
		local v5 = v3.Parent

		v4 = if v5 and v5:IsA("BasePart") then v5 else nil
	end

	if not v4 then
		return
	end

	local v6 = Trove.new()

	t[p1] = {
		Part = v4,
		Gui = v3,
		Trove = v6
	}
	v6:Add(p1.Destroying:Connect(function() --[[ Line: 108 | Upvalues: p1 (copy), t (ref) ]]
		local v1 = p1
		local v2 = t[v1]

		if not v2 then
			return
		end

		v2.Trove:Clean()

		if not v2.Gui.Parent then
			t[v1] = nil

			return
		end

		v2.Gui.Enabled = true
		t[v1] = nil
	end))
	v6:Add(v3.Destroying:Connect(function() --[[ Line: 112 | Upvalues: p1 (copy), t (ref) ]]
		local v1 = p1
		local v2 = t[v1]

		if not v2 then
			return
		end

		v2.Trove:Clean()

		if v2.Gui.Parent then
			v2.Gui.Enabled = true
		end

		t[v1] = nil
	end))

	local v7 = Player.Optional.HumanoidRootPart(LocalPlayer)
	local v8 = t[p1]

	if not v8 then
		return
	end

	local v9 = true
	local MaxDistance = v8.Gui.MaxDistance

	if v7 then
		if MaxDistance > 0 then
			v9 = if (v7.Position - v8.Part.Position).Magnitude <= MaxDistance then true else false
		end
	else
		v9 = false
	end

	if v8.Gui.Enabled == v9 then
		return
	end

	v8.Gui.Enabled = v9
end

local function updateLeaderboards() --[[ updateLeaderboards | Line: 119 | Upvalues: Player (copy), LocalPlayer (copy), t (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)

	for v2 in t do
		local v3 = t[v2]

		if v3 then
			local v4 = true
			local MaxDistance = v3.Gui.MaxDistance

			if v1 then
				if MaxDistance > 0 then
					v4 = if (v1.Position - v3.Part.Position).Magnitude <= MaxDistance then true else false
				end
			else
				v4 = false
			end

			if v3.Gui.Enabled ~= v4 then
				v3.Gui.Enabled = v4
			end
		end
	end
end

local function stepLeaderboards(p1) --[[ stepLeaderboards | Line: 126 | Upvalues: v1 (ref), Player (copy), LocalPlayer (copy), t (copy) ]]
	v1 = v1 + p1

	if v1 < 0.2 then
		return
	end

	v1 = 0

	local v12 = Player.Optional.HumanoidRootPart(LocalPlayer)

	for v2 in t do
		local v3 = t[v2]

		if v3 then
			local v4 = true
			local MaxDistance = v3.Gui.MaxDistance

			if v12 then
				if MaxDistance > 0 then
					v4 = if (v12.Position - v3.Part.Position).Magnitude <= MaxDistance then true else false
				end
			else
				v4 = false
			end

			if v3.Gui.Enabled ~= v4 then
				v3.Gui.Enabled = v4
			end
		end
	end
end

for v2, v3 in CollectionService:GetTagged("Leaderboard") do
	trackLeaderboard(v3)
end

CollectionService:GetInstanceAddedSignal("Leaderboard"):Connect(trackLeaderboard)
CollectionService:GetInstanceRemovedSignal("Leaderboard"):Connect(cleanupLeaderboard)
RunService.Heartbeat:Connect(stepLeaderboards)