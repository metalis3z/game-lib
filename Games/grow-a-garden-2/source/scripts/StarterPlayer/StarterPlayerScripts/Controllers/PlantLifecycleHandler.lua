--credit to prince games studio
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local t = {}
local t2 = {}
local t3 = {}

for v1, v2 in require(ReplicatedStorage.SharedModules.SeedData) do
	t[v2.SeedName] = v2
end

local t4 = {}

local function CacheOriginalColors(p1) --[[ CacheOriginalColors | Line: 41 ]]
	local t = {}

	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			t[v2] = v2.Color
		end
	end

	return t
end

local function BindDescendantAddedListener(p1, p2) --[[ BindDescendantAddedListener | Line: 52 ]]
	if p1.DescendantAddedConn then
		p1.DescendantAddedConn:Disconnect()
		p1.DescendantAddedConn = nil
	end

	p1.DescendantAddedConn = p2.DescendantAdded:Connect(function(p13) --[[ Line: 57 | Upvalues: p1 (copy) ]]
		if not p13:IsA("BasePart") then
			return
		end

		local OriginalColors = p1.OriginalColors

		if OriginalColors and OriginalColors[p13] == nil then
			OriginalColors[p13] = p13.Color
			p1.LastAppliedColorSig = nil
		end
	end)
end

local function ApplyColors(p1, p2) --[[ ApplyColors | Line: 67 ]]
	for v1, v2 in p1 do
		if v1.Parent then
			local v3, v4, v5 = Color3.toHSV(v2)

			v1.Color = Color3.fromHSV(v3, v4 * (1 - p2 * 0.75), v5)
		end
	end
end

function t2.GetDecayAlpha(p1, p2, p3) --[[ GetDecayAlpha | Line: 81 | Upvalues: t4 (copy), t (copy) ]]
	local v1 = t4[tostring(p2) .. "_" .. p3]

	if not v1 then
		return nil, false
	end

	local v2 = t[v1.SeedName]

	if not (v2 and v2.PrimeTime) then
		return 0, true
	end

	if v1.Mutation or v2.AlwaysPrime then
		return 0, true
	end

	if v1.DisplayDecayAlpha ~= nil then
		return v1.DisplayDecayAlpha, true
	end

	local v3 = os.time() - v1.PrimeStartedAt

	if v3 < v2.PrimeTime then
		return 0, false
	end

	return math.clamp((v3 - v2.PrimeTime) / (v2.PrimeTime * 100), 0, 1) * (1 - (v1.ReviveProgress or 0)), false
end

local function SetLifecycle(p1, p2, p3, p4, p5, p6, p7) --[[ SetLifecycle | Line: 106 | Upvalues: t (copy), t4 (copy), CacheOriginalColors (copy) ]]
	local v1 = t[p3]

	if not (v1 and v1.PrimeTime) then
		return
	end

	local v2 = tostring(p1) .. "_" .. p2

	if t4[v2] then
		t4[v2].PrimeStartedAt = p4
		t4[v2].SeedName = p3
		t4[v2].ReviveProgress = if p6 then p6 else t4[v2].ReviveProgress or 0
		t4[v2].ReviveProgressTarget = if p6 then p6 else t4[v2].ReviveProgressTarget or 0
		t4[v2].Mutation = p7

		if not p5 then
			return
		end

		t4[v2].Model = p5

		if not (t4[v2].OriginalColors and next(t4[v2].OriginalColors)) then
			t4[v2].OriginalColors = CacheOriginalColors(p5)
			t4[v2].LastAppliedColorSig = nil
		end

		local v7 = t4[v2]

		if v7.DescendantAddedConn then
			v7.DescendantAddedConn:Disconnect()
			v7.DescendantAddedConn = nil
		end

		v7.DescendantAddedConn = p5.DescendantAdded:Connect(function(p13) --[[ Line: 57 | Upvalues: v7 (copy) ]]
			if not p13:IsA("BasePart") then
				return
			end

			local OriginalColors = v7.OriginalColors

			if OriginalColors and OriginalColors[p13] == nil then
				OriginalColors[p13] = p13.Color
				v7.LastAppliedColorSig = nil
			end
		end)
	else
		if not p5 then
			return
		end

		t4[v2] = {
			DisplayDecayAlpha = nil,
			PrimeStartedAt = p4,
			SeedName = p3,
			Model = p5,
			OriginalColors = CacheOriginalColors(p5),
			ReviveProgress = p6 or 0,
			ReviveProgressTarget = p6 or 0,
			Mutation = p7
		}

		local v8 = t4[v2]

		if v8.DescendantAddedConn then
			v8.DescendantAddedConn:Disconnect()
			v8.DescendantAddedConn = nil
		end

		v8.DescendantAddedConn = p5.DescendantAdded:Connect(function(p13) --[[ Line: 57 | Upvalues: v8 (copy) ]]
			if not p13:IsA("BasePart") then
				return
			end

			local OriginalColors = v8.OriginalColors

			if OriginalColors and OriginalColors[p13] == nil then
				OriginalColors[p13] = p13.Color
				v8.LastAppliedColorSig = nil
			end
		end)
	end
end

local function RemoveLifecycle(p1, p2) --[[ RemoveLifecycle | Line: 149 | Upvalues: t4 (copy) ]]
	local v1 = tostring(p1) .. "_" .. p2
	local v2 = t4[v1]

	if v2 then
		if v2.DescendantAddedConn then
			v2.DescendantAddedConn:Disconnect()
			v2.DescendantAddedConn = nil
		end

		if v2.OriginalColors then
			for v3, v4 in v2.OriginalColors do
				if v3.Parent then
					v3.Color = v4
				end
			end
		end
	end

	t4[v1] = nil
end

function t2.Init(p1) --[[ Init | Line: 172 | Upvalues: Networking (copy), RemoveLifecycle (copy), t4 (copy), t3 (copy), RunService (copy), Players (copy), t (copy), ApplyColors (copy) ]]
	Networking.Garden.PlantRemoved.OnClientEvent:Connect(function(p1, p2) --[[ Line: 174 | Upvalues: RemoveLifecycle (ref) ]]
		RemoveLifecycle(p1, p2)
	end)
	Networking.Garden.PlantReviveProgressUpdated.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 179 | Upvalues: t4 (ref), t3 (ref) ]]
		local v1 = tostring(p1) .. "_" .. p2
		local v2 = t4[v1]

		if v2 then
			v2.ReviveProgressTarget = p3
		end

		local v3 = t3[v1]

		if not v3 then
			return
		end

		v3.ReviveProgress = p3
	end)
	Networking.Garden.PlantMutationUpdated.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 194 | Upvalues: t4 (ref) ]]
		local v1 = t4[tostring(p1) .. "_" .. p2]

		if not v1 then
			return
		end

		v1.Mutation = p3
		v1.LastAppliedColorSig = nil
	end)
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 207 | Upvalues: t4 (ref), Players (ref), t (ref), ApplyColors (ref) ]]
		local v1 = os.time()

		for v3, v4 in t4 do
			local v2

			if v4.Model and v4.Model.Parent then
				if Players.LocalPlayer:GetAttribute("PrimeEnabled") and not v4.Mutation then
					local v5 = t[v4.SeedName]

					if v5 and (v5.PrimeTime and not v5.AlwaysPrime) then
						local PrimeTime = v5.PrimeTime
						local v6 = PrimeTime * 100
						local v7 = v1 - v4.PrimeStartedAt

						if PrimeTime <= v7 then
							local v8 = math.clamp((v7 - PrimeTime) / v6, 0, 1)
							local v9 = v4.ReviveProgressTarget or v4.ReviveProgress or 0
							local v10 = v4.ReviveProgress or 0

							if v10 ~= v9 and v10 < v9 then
								v4.ReviveProgress = math.min(v10 + 0.5 * p1, v9)
							elseif v10 ~= v9 then
								v4.ReviveProgress = math.max(v10 - 0.5 * p1, v9)
							end

							v2 = v8 * (1 - (v4.ReviveProgress or 0))
						else
							v2 = 0
						end

						local DisplayDecayAlpha = v4.DisplayDecayAlpha

						if DisplayDecayAlpha == nil then
							v4.DisplayDecayAlpha = v2
						else
							local v11 = v2 - DisplayDecayAlpha

							if math.abs(v11) < 0.0001 or math.abs(v11) < 0.01 then
								v4.DisplayDecayAlpha = v2
							else
								v4.DisplayDecayAlpha = DisplayDecayAlpha + v11 * math.clamp(p1 / 1, 0, 1)
							end
						end

						local v12 = v4.DisplayDecayAlpha or 0
						local v13 = math.floor(v12 * 1024 + 0.5)

						if v4.LastAppliedColorSig ~= v13 then
							v4.LastAppliedColorSig = v13
							ApplyColors(v4.OriginalColors, v12)
						end
					end
				end

				continue
			end

			if v4.DescendantAddedConn then
				v4.DescendantAddedConn:Disconnect()
				v4.DescendantAddedConn = nil
			end

			t4[v3] = nil
		end
	end)
end
function t2.RegisterPlantModel(p1, p2, p3, p4, p5, p6, p7, p8) --[[ RegisterPlantModel | Line: 291 | Upvalues: t (copy), t3 (copy), SetLifecycle (copy) ]]
	if not p5 or p5 <= 0 then
		return
	end

	local v1 = t[p4]

	if not (v1 and v1.PrimeTime) then
		return
	end

	local v2 = tostring(p2) .. "_" .. p3

	if not p6 then
		t3[v2] = {
			SeedName = p4,
			PrimeStartedAt = p5,
			Mutation = p7,
			ReviveProgress = p8
		}

		return
	end

	local v3 = t3[v2]

	if v3 then
		local v4 = math.max(p5, v3.PrimeStartedAt)
		local v5 = if p7 then p7 else v3.Mutation
		local v6 = if p8 then p8 else v3.ReviveProgress

		t3[v2] = nil
		p5 = v4
		p8 = v6
		p7 = v5
	end

	SetLifecycle(p2, p3, p4, p5, p6, p8, p7)
end
function t2.UnregisterPlantModel(p1, p2, p3) --[[ UnregisterPlantModel | Line: 318 | Upvalues: RemoveLifecycle (copy) ]]
	RemoveLifecycle(p2, p3)
end
function t2.GetDecayAlphaByKey(p1, p2) --[[ GetDecayAlphaByKey | Line: 323 ]]
	local v1, v2 = string.match(p2, "^(%d+)_(.+)$")

	if v1 and v2 then
		return p1:GetDecayAlpha(tonumber(v1), v2)
	end

	return nil, false
end
function t2.GetActiveEntries(p1) --[[ GetActiveEntries | Line: 329 | Upvalues: t4 (copy) ]]
	return t4
end

return t2