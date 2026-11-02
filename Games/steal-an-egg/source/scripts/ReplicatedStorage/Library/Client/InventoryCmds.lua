-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Library = ReplicatedStorage:WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Client = Library:WaitForChild("Client")
local Asserts = require(Library.Asserts)
local Signal = require(Library.Signal)
local AbstractItem = require(Items.AbstractItem)
local InventoryProjection = require(Items.InventoryProjection)
local Save = require(Client.Save)
local Network = require(Client.Network)
local DevRAPCmds = require(Client.DevRAPCmds)
local ClientPlayerState = require(script.ClientPlayerState)
local t = {
	PlayerState = ClientPlayerState
}
local t2 = {}

local function State(p1) --[[ State | Line: 43 | Upvalues: Asserts (copy), Players (copy), t2 (copy), Save (copy), ClientPlayerState (copy) ]]
	if p1 == nil then
		p1 = Players.LocalPlayer
	else
		Asserts.Player(p1)

		if p1 ~= Players.LocalPlayer then
			return nil
		end
	end

	assert(p1, "luau")

	local v1 = t2[p1.UserId]

	if v1 then
		return v1
	end

	local v2 = Save.Get(p1)

	if not v2 then
		return nil
	end

	local v3 = ClientPlayerState.new(p1, v2)

	if t2[p1.UserId] then
		return t2[p1.UserId]
	end

	t2[p1.UserId] = v3

	return v3
end

local function DestroyState(p1, p2) --[[ DestroyState | Line: 84 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 or p2 and v1.player ~= p2 then
		return
	end

	t2[p1] = nil
	v1:Destroy()
end

local function applyInventoryPatchPacket(p1, p2) --[[ applyInventoryPatchPacket | Line: 92 | Upvalues: InventoryProjection (copy), State (copy) ]]
	if typeof(p2) ~= "table" or p2.__patch ~= true then
		return
	end

	local v1 = InventoryProjection.BuildInventoryPatchPacket(p2.Set, p2.Remove)

	if not v1 then
		return
	end

	local v2 = State(p1)

	if v2 then
		v2.container:ApplyPacket(v1)
	end
end

t.State = State
function t.Container(p1) --[[ Container | Line: 118 | Upvalues: State (copy) ]]
	local v1 = State(p1)

	return if v1 then v1.container else v1
end

local function CollectExact(p1, p2) --[[ CollectExact | Line: 131 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:CollectExact(p1) else v1
end

AbstractItem.Prototype.CollectExact = CollectExact

local function CollectAny(p1, p2) --[[ CollectAny | Line: 142 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:CollectAny(p1) else v1
end

AbstractItem.Prototype.CollectAny = CollectAny

local function HasExact(p1, p2) --[[ HasExact | Line: 153 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:HasExact(p1) else v1
end

AbstractItem.Prototype.HasExact = HasExact

local function HasAny(p1, p2) --[[ HasAny | Line: 164 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:HasAny(p1) else v1
end

AbstractItem.Prototype.HasAny = HasAny

local function CountExact(p1, p2) --[[ CountExact | Line: 175 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:CountExact(p1) or 0 else 0
end

AbstractItem.Prototype.CountExact = CountExact

local function CountAny(p1, p2) --[[ CountAny | Line: 186 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:CountAny(p1) or 0 else 0
end

AbstractItem.Prototype.CountAny = CountAny

local function FindExact(p1, p2) --[[ FindExact | Line: 197 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:FindExact(p1) or {} else {}
end

AbstractItem.Prototype.FindExact = FindExact

local function FindAny(p1, p2) --[[ FindAny | Line: 208 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:FindAny(p1) or {} else {}
end

AbstractItem.Prototype.FindAny = FindAny

local function GetRAP(p1) --[[ GetRAP | Line: 218 ]]
	return 1
end

AbstractItem.Prototype.GetRAP = GetRAP

local function GetDevRAP(p1) --[[ GetDevRAP | Line: 227 | Upvalues: DevRAPCmds (copy) ]]
	return DevRAPCmds.Get(p1)
end

AbstractItem.Prototype.GetDevRAP = GetDevRAP

local function Find(p1, p2) --[[ Find | Line: 239 | Upvalues: t2 (copy) ]]
	for k, v in pairs(t2) do
		local v1 = v.container:Get(p2, p1)

		if v1 then
			return v1, v.player
		end
	end

	return nil, nil
end

AbstractItem.Globals.Find = Find

local function Get(p1, p2, p3) --[[ Get | Line: 256 | Upvalues: State (copy) ]]
	local v1 = State(p3)

	return if v1 then v1.container:Get(p2, p1) else v1
end

AbstractItem.Globals.Get = Get

local function All(p1, p2) --[[ All | Line: 267 | Upvalues: State (copy) ]]
	local v1 = State(p2)

	return if v1 then v1.container:All(p1) or {} else {}
end

AbstractItem.Globals.All = All

local function Each(p1, p2, p3, ...) --[[ Each | Line: 280 | Upvalues: State (copy) ]]
	local v1 = State(p3)

	if v1 then
		return v1.container:Each(p1, p2, ...)
	end
end

AbstractItem.Globals.Each = Each
Signal.Fired("Loaded Stats"):Connect(function(p1) --[[ Line: 289 | Upvalues: State (copy) ]]
	State(p1)
end)
Signal.Fired("Loaded Other Stats"):Connect(function(p1) --[[ Line: 293 | Upvalues: State (copy) ]]
	State(p1)
end)
Signal.Fired("Stats Removed"):Connect(function(p1, p2) --[[ Line: 297 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 or p1 and v1.player ~= p1 then
		return
	end

	t2[p2] = nil
	v1:Destroy()
end)
Network.Fired("Items: Update"):Connect(function(p1, p2, p3) --[[ Line: 302 | Upvalues: State (copy) ]]
	local v1 = State(p1)

	if v1 then
		v1.container:ApplyPacket(p2)
	end
end)
Save.GetStatChangedSignal("Inventory"):Connect(function(p1, p2, p3) --[[ Line: 315 | Upvalues: Players (copy), InventoryProjection (copy), State (copy) ]]
	if typeof(p3) ~= "table" then
		return
	end

	if p3.__patch ~= true then
		return
	end

	local v1 = InventoryProjection.BuildInventoryPatchPacket(p3.Set, p3.Remove)

	if not v1 then
		return
	end

	local v2 = State(Players.LocalPlayer)

	if not v2 then
		return
	end

	v2.container:ApplyPacket(v1)
end)

return t