-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Modules = Library:WaitForChild("Modules")
local Client = Library:WaitForChild("Client")
local Signal = require(Library.Signal)
local Network = require(Client.Network)
local Settings = require(Client.Settings)
local Mutex = require(Modules.Mutex)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local DeepFreezeUnsafe = require(ReplicatedStorage.Library.Functions.DeepFreezeUnsafe)
local v1 = require(Modules.Event)
local v2 = require(Modules.Packages.Log).new()
local Trove = require(Modules.Packages.Trove)

require(Library.Modules.DefaultStats.Types.Interface)

local t = {}
local t2 = {}
local t3 = {}
local LocalPlayer = Players.LocalPlayer
local v3 = false
local v4 = v1.new()
local v5 = v1.new()
local v6 = v1.new()
local v7 = v1.new()
local v8 = v1.new()
local v9 = v1.new()
local v10 = v1.new()
local t4 = {
	StatChanged = v4,
	OtherStatChanged = v5,
	StatsChanged = v6,
	OtherStatsChanged = v7,
	LoadedStats = v8,
	LoadedOtherStats = v9,
	StatsRemoved = v10,
	GetSaves = function() --[[ GetSaves | Line: 87 | Upvalues: t (copy) ]]
		return t
	end
}

function t4.GetUnsafe(p1) --[[ GetUnsafe | Line: 91 | Upvalues: t4 (copy) ]]
	return t4.Get(p1)
end
function t4.IsLocalDataLoaded() --[[ IsLocalDataLoaded | Line: 95 | Upvalues: v3 (ref) ]]
	return v3
end
function t4.Get(p1, p2) --[[ Get | Line: 99 | Upvalues: LocalPlayer (copy), t (copy), t2 (copy), Mutex (copy) ]]
	local v2 = p1 or LocalPlayer

	if not (v2 and v2.Parent) then
		return nil
	end

	if (if p2 == nil then true elseif p2 == true then true else false) and t[v2] then
		return t[v2]
	end

	local v3 = t2[v2]

	if not v3 then
		local v4 = Mutex.new()

		t2[v2] = v4
		v3 = v4
	end

	return v3:run(function() --[[ Line: 117 | Upvalues: v2 (copy), LocalPlayer (ref), t (ref) ]]
		if not (v2 and v2.Parent) then
			return nil
		end

		if not Update(v2) and (v2 and v2 == LocalPlayer) then
			repeat
				task.wait(1.05)
			until not (v2 and (v2.Parent and Update(v2)))
		end

		if v2 then
			return t[v2]
		end

		return nil
	end)
end
function Update(p1) --[[ Update | Line: 137 | Upvalues: t (copy), LocalPlayer (copy), Network (copy), RunService (copy), v2 (copy), Settings (copy), DeepFreezeUnsafe (copy), v3 (ref), v8 (copy), Signal (copy), v9 (copy) ]]
	assert(if typeof(p1) == "Instance" then p1:IsA("Player") else false, "Expected player to be a Player Instance when updating save.")

	if t[p1] then
		return true
	end

	local UserId = p1.UserId
	local v22 = LocalPlayer == p1
	local ok, result = pcall(function() --[[ Line: 150 | Upvalues: Network (ref), p1 (copy) ]]
		return Network.Invoke("Get Stats", p1)
	end)

	if not ok then
		print("ARE WE ON THE CLIENT", RunService:IsClient())
		warn(string.format("[SAVE] Player \'%d\' save failed to load: \'%s\'", UserId, (tostring(result))))

		return false
	end

	if not p1 then
		warn(string.format("[SAVE] Player \'%d\' logged out while loading save", UserId))

		return false
	end

	if not result then
		return false
	end

	v2:AtTrace():Log("[SAVE] retried player save form server:", result)

	if typeof(result) == "table" then
		if t[p1] then
			return true
		end

		for k, v in pairs(result) do
			if type(v) == "table" and not Settings.StatsNoFreeze[k] then
				DeepFreezeUnsafe(v)
			end
		end

		t[p1] = result

		if v22 then
			v3 = true
			v8:FireAsync(p1)
			Signal.Fire("Loaded Stats", p1)
		else
			v9:FireAsync(p1)
			Signal.Fire("Loaded Other Stats", p1)
		end

		return true
	end

	warn(string.format("[SAVE] Player \'%d\' save was invalid type: \'%s\'", UserId, (typeof(result))))

	if not v22 then
		return false
	end

	p1.Character = nil
	p1:Kick("Something went wrong fetching save. Please rejoin!")

	return false
end

local function ApplyInventoryPatch(p1, p2) --[[ ApplyInventoryPatch | Line: 205 ]]
	if typeof(p2) == "table" and p2.__patch == true then
		local v1 = p1.Inventory or {}

		if p2.Remove then
			for v2 in p2.Remove do
				if v1[v2] ~= nil then
					v1[v2] = nil
				end
			end
		end

		if p2.Set then
			for v3, v4 in p2.Set do
				v1[v3] = v4
			end
		end

		return v1, true
	end

	return p2, false
end

local function ProcessChanges(p1, p2, p3) --[[ ProcessChanges | Line: 230 | Upvalues: Asserts (copy), t (copy), ApplyInventoryPatch (copy), Settings (copy), DeepFreezeUnsafe (copy) ]]
	Asserts.Player(p1)
	Asserts.table(p2)

	if p3 then
		Asserts.table(p3)
	end

	local v1 = t[p1]

	if not v1 then
		return
	end

	local t2 = {}
	local t3 = {}

	if p3 then
		for k in pairs(p3) do
			t3[k] = v1[k]
			v1[k] = nil
		end
	end

	for k, v in pairs(p2) do
		local v2

		t3[k] = v1[k]

		if k == "Inventory" then
			local v3, v4 = ApplyInventoryPatch(v1, v)

			v2 = if v4 then v3 else v
		else
			v2 = v
		end

		if type(v2) == "table" and not Settings.StatsNoFreeze[k] then
			DeepFreezeUnsafe(v2)
		end

		v1[k] = v2
		t2[k] = v2
	end

	FireStatChangedForChange(p1, t2, p3, t3, p2)
end

function FireStatChangedForChange(p1, p2, p3, p4, p5) --[[ FireStatChangedForChange | Line: 274 | Upvalues: Asserts (copy), t (copy), LocalPlayer (copy), v4 (copy), t3 (copy), v5 (copy), v6 (copy), v7 (copy) ]]
	Asserts.Player(p1)
	Asserts.table(p2)

	if p3 then
		Asserts.table(p3)
	end

	if not t[p1] then
		return
	end

	local v1 = if LocalPlayer == p1 then true else false

	for k in pairs(p2) do
		local v2 = p2[k]
		local v3 = if p4 then p4[k] else p4
		local v42 = if p5 then p5[k] else p5

		if v1 then
			v4:FireAsync(k, v2, v3, v42)

			if t3[k] then
				t3[k]:FireAsync(v2, v3, v42)
			end

			continue
		end

		v5:FireAsync(p1, k)
	end

	if p3 then
		for k in pairs(p3) do
			local v52 = if p4 then p4[k] else p4

			if v1 then
				v4:FireAsync(k, nil, v52, nil)

				if t3[k] then
					t3[k]:FireAsync(nil, v52, nil)
				end

				continue
			end

			v5:FireAsync(p1, k)
		end
	end

	if v1 then
		v6:FireAsync()
	else
		v7:FireAsync(p1)
	end
end
function t4.GetStatChangedSignal(p1) --[[ GetStatChangedSignal | Line: 328 | Upvalues: t3 (copy), v1 (copy) ]]
	if t3[p1] then
		return t3[p1]
	end

	local v12 = v1.new()

	t3[p1] = v12

	return v12
end
function t4.ConnectForDataChanged(p1, p2) --[[ ConnectForDataChanged | Line: 338 | Upvalues: Asserts (copy), Trove (copy), t4 (copy) ]]
	local v1 = typeof(p1) == "string" and { p1 } or p1

	Asserts.table(v1)
	Asserts.func(p2)

	local v2 = Trove.new()

	for v3, v4 in v1 do
		Asserts.string(v4)
		v2:Connect(t4.GetStatChangedSignal(v4), p2)
	end

	return v2
end
function t4.ProcessManualChange(p1, p2, p3) --[[ ProcessManualChange | Line: 352 | Upvalues: ProcessChanges (copy), LocalPlayer (copy) ]]
	ProcessChanges(if p3 then p3 else LocalPlayer, {
		[p1] = p2
	})
end
function t4.FireStatChangedForManuallyChangedSave(p1, p2, p3) --[[ FireStatChangedForManuallyChangedSave | Line: 358 | Upvalues: LocalPlayer (copy) ]]
	FireStatChangedForChange(if p3 then p3 else LocalPlayer, {
		[p1] = p2
	})
end
function t4.ProcessManualTableKeyChange(p1, p2, p3, p4) --[[ ProcessManualTableKeyChange | Line: 364 | Upvalues: LocalPlayer (copy), t4 (copy), Settings (copy), ProcessChanges (copy) ]]
	local v1 = if p4 then p4 else LocalPlayer
	local v2 = t4.Get(v1)

	if not v2 then
		return
	end

	local v3 = v2[p1]

	if not v3 then
		return
	end

	if not Settings.StatsNoFreeze[p1] then
		v3 = table.clone(v3)
	end

	v3[p2] = p3
	ProcessChanges(v1, {
		[p1] = v3
	})
end
function t4.FetchPlayer(p1) --[[ FetchPlayer | Line: 386 | Upvalues: Asserts (copy), t2 (copy), Mutex (copy), t (copy) ]]
	Asserts.Player(p1)

	local v1 = t2[p1]

	if not v1 then
		local v2 = Mutex.new()

		t2[p1] = v2
		v1 = v2
	end

	v1:run(function() --[[ Line: 395 | Upvalues: p1 (copy), t (ref) ]]
		while p1 and not t[p1] do
			Update(p1)

			if not p1 or (t[p1] or not p1.Parent) then
				break
			end

			task.wait(0.5)
		end
	end)
end
Network.Fired("New Stats"):Connect(function(p1, p2, p3) --[[ Line: 408 | Upvalues: ProcessChanges (copy), LocalPlayer (copy) ]]
	ProcessChanges(if p3 then p3 else LocalPlayer, p1, p2)
end)
Players.PlayerAdded:Connect(function(p1) --[[ Line: 412 | Upvalues: t4 (copy) ]]
	task.spawn(t4.FetchPlayer, p1)
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 416 | Upvalues: t (copy), v10 (copy), Signal (copy) ]]
	if not t[p1] then
		return
	end

	task.delay(5, function() --[[ Line: 418 | Upvalues: t (ref), p1 (copy), v10 (ref), Signal (ref) ]]
		t[p1] = nil
		v10:FireAsync(p1)
		Signal.Fire("Stats Removed", p1)
	end)
end)

for i, v in ipairs(Players:GetPlayers()) do
	task.spawn(t4.FetchPlayer, v)
end

Players.PlayerRemoving:Connect(function(p1) --[[ Line: 432 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	t2[p1] = nil
	v1:destroy()
end)

return t4