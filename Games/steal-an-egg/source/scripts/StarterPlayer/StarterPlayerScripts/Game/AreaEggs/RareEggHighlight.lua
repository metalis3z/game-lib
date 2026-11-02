-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

require(ReplicatedStorage.Library.Types.AreaEggs)
require(ReplicatedStorage.Library.Types.AreaEggResetCycle)

local Asserts = require(ReplicatedStorage.Library.Asserts)
local Assets = require(ReplicatedStorage.Directory.Assets)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local WorkspaceEggVisibility = require(script.Parent.WorkspaceEggVisibility)
local v1 = Log.new()
local t = {}
local t2 = {}
local t3 = {}
local v2 = nil
local v3 = false
local v4 = (-1 / 0)
local v5 = false
local t4 = {}

local function getOutlineColor(p1) --[[ getOutlineColor | Line: 47 | Upvalues: Assets (copy), Rarity (copy) ]]
	local v1 = Assets.Directory[p1]

	assert(v1 ~= nil, (("Missing asset config %*"):format(p1)))

	local Rarity2 = v1.Rarity

	if Rarity2 ~= Rarity.Rarities.Secret and Rarity2 ~= Rarity.Rarities.Eternal then
		return nil
	end

	return Rarity2.Color
end

local function clearBinding(p1) --[[ clearBinding | Line: 57 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if v1 == nil then
		return
	end

	t2[p1] = nil

	local DestroyConnection = v1.DestroyConnection

	if DestroyConnection ~= nil then
		DestroyConnection:Disconnect()
	end

	if v1.Highlight.Parent == nil then
		return
	end

	v1.Highlight:Destroy()
end

local function clearAllBindings() --[[ clearAllBindings | Line: 72 | Upvalues: t2 (copy) ]]
	for k in pairs(t2) do
		local v1 = t2[k]

		if v1 ~= nil then
			t2[k] = nil

			local DestroyConnection = v1.DestroyConnection

			if DestroyConnection ~= nil then
				DestroyConnection:Disconnect()
			end

			if v1.Highlight.Parent ~= nil then
				v1.Highlight:Destroy()
			end
		end
	end
end

local function bindModel(p1, p2, p3) --[[ bindModel | Line: 78 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if v1 ~= nil and v1.Model == p2 then
		v1.Highlight.OutlineColor = p3

		return
	end

	local v2 = t2[p1]

	if v2 ~= nil then
		t2[p1] = nil

		local DestroyConnection = v2.DestroyConnection

		if DestroyConnection ~= nil then
			DestroyConnection:Disconnect()
		end

		if v2.Highlight.Parent ~= nil then
			v2.Highlight:Destroy()
		end
	end

	local RareAreaEggHighlight = Instance.new("Highlight")

	RareAreaEggHighlight.Name = "RareAreaEggHighlight"
	RareAreaEggHighlight.Adornee = p2
	RareAreaEggHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	RareAreaEggHighlight.FillTransparency = 1
	RareAreaEggHighlight.OutlineTransparency = 0.25
	RareAreaEggHighlight.OutlineColor = p3
	RareAreaEggHighlight.Parent = p2

	local t = {
		DestroyConnection = nil,
		Model = p2,
		Highlight = RareAreaEggHighlight
	}

	t2[p1] = t
	t.DestroyConnection = p2.Destroying:Connect(function() --[[ Line: 101 | Upvalues: t2 (ref), p1 (copy), t (copy) ]]
		if t2[p1] ~= t then
			return
		end

		t2[p1] = nil
	end)
end

local function syncUid(p1) --[[ syncUid | Line: 108 | Upvalues: t (copy), t3 (copy), t2 (copy), v3 (ref), Assets (copy), Rarity (copy), bindModel (copy), WorkspaceEggVisibility (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		t3[p1] = nil

		local v2 = t2[p1]

		if v2 == nil then
			return
		end

		t2[p1] = nil

		local DestroyConnection = v2.DestroyConnection

		if DestroyConnection ~= nil then
			DestroyConnection:Disconnect()
		end

		if v2.Highlight.Parent == nil then
			return
		end

		v2.Highlight:Destroy()
	elseif v3 then
		local v32 = t2[p1]

		if v32 == nil then
			return
		end

		t2[p1] = nil

		local DestroyConnection = v32.DestroyConnection

		if DestroyConnection ~= nil then
			DestroyConnection:Disconnect()
		end

		if v32.Highlight.Parent == nil then
			return
		end

		v32.Highlight:Destroy()
	else
		local v4 = Assets.Directory[v1]

		assert(v4 ~= nil, (("Missing asset config %*"):format(v1)))

		local Rarity2 = v4.Rarity
		local v7 = if Rarity2 == Rarity.Rarities.Secret or Rarity2 == Rarity.Rarities.Eternal then Rarity2.Color else nil

		if v7 == nil then
			t3[p1] = nil

			local v8 = t2[p1]

			if v8 == nil then
				return
			end

			t2[p1] = nil

			local DestroyConnection = v8.DestroyConnection

			if DestroyConnection ~= nil then
				DestroyConnection:Disconnect()
			end

			if v8.Highlight.Parent == nil then
				return
			end

			v8.Highlight:Destroy()
		else
			local v9 = t3[p1]

			t3[p1] = nil

			if v9 ~= nil and v9.Parent ~= nil then
				bindModel(p1, v9, v7)

				return
			end

			local v10 = t2[p1]

			if v10 ~= nil and v10.Model.Parent ~= nil then
				v10.Highlight.OutlineColor = v7

				return
			end

			local v11 = WorkspaceEggVisibility.ResolveModel(p1)

			if v11 == nil then
				return
			end

			bindModel(p1, v11, v7)
		end
	end
end

local function beginResetReveal(p1) --[[ beginResetReveal | Line: 143 | Upvalues: v4 (ref), v3 (ref), t3 (copy), t2 (copy) ]]
	if p1.DayStartsAt <= v4 then
		return
	end

	v4 = p1.DayStartsAt
	v3 = true
	table.clear(t3)

	for k in pairs(t2) do
		local v1 = t2[k]

		if v1 ~= nil then
			t2[k] = nil

			local DestroyConnection = v1.DestroyConnection

			if DestroyConnection ~= nil then
				DestroyConnection:Disconnect()
			end

			if v1.Highlight.Parent ~= nil then
				v1.Highlight:Destroy()
			end
		end
	end
end

local function completeResetReveal() --[[ completeResetReveal | Line: 153 | Upvalues: v3 (ref), t (copy), syncUid (copy) ]]
	v3 = false

	for k in pairs(t) do
		syncUid(k)
	end
end

local function applyRecord(p1) --[[ applyRecord | Line: 160 | Upvalues: t (copy), syncUid (copy) ]]
	t[p1.Uid] = p1.AssetCategory
	syncUid(p1.Uid)
end

local function applySnapshot(p1) --[[ applySnapshot | Line: 165 | Upvalues: t (copy), v2 (ref), t3 (copy), t2 (copy), syncUid (copy) ]]
	local tbl = {}

	for i, v in ipairs(p1.Records) do
		tbl[v.Uid] = true
		t[v.Uid] = v.AssetCategory
	end

	for k in pairs(t) do
		if tbl[k] ~= true and k ~= v2 then
			t[k] = nil
			t3[k] = nil

			local v1 = t2[k]

			if v1 ~= nil then
				t2[k] = nil

				local DestroyConnection = v1.DestroyConnection

				if DestroyConnection ~= nil then
					DestroyConnection:Disconnect()
				end

				if v1.Highlight.Parent ~= nil then
					v1.Highlight:Destroy()
				end
			end
		end
	end

	for k in pairs(tbl) do
		syncUid(k)
	end
end

local function applyCarryState(p1) --[[ applyCarryState | Line: 183 | Upvalues: v2 (ref), t (copy), syncUid (copy), EggCmds (copy), t3 (copy), t2 (copy) ]]
	local v1 = v2

	if p1.IsCarrying then
		local v22 = assert(p1.Uid, "Carried area egg state must include Uid")

		v2 = v22
		t[v22] = assert(p1.AssetCategory, "Carried area egg state must include AssetCategory")
		syncUid(v22)

		return
	end

	v2 = nil

	if v1 == nil then
		return
	end

	local v4 = EggCmds.GetAreaEggRecord(v1)

	if v4 ~= nil then
		t[v4.Uid] = v4.AssetCategory
		syncUid(v4.Uid)

		return
	end

	t[v1] = nil
	t3[v1] = nil

	local v5 = t2[v1]

	if v5 == nil then
		return
	end

	t2[v1] = nil

	local DestroyConnection = v5.DestroyConnection

	if DestroyConnection ~= nil then
		DestroyConnection:Disconnect()
	end

	if v5.Highlight.Parent == nil then
		return
	end

	v5.Highlight:Destroy()
end

local function observeWorkspaceChild(p1) --[[ observeWorkspaceChild | Line: 208 | Upvalues: v3 (ref), t (copy), Workspace (copy), Assets (copy), Rarity (copy), bindModel (copy) ]]
	if p1:IsA("Model") then
		task.defer(function() --[[ Line: 212 | Upvalues: v3 (ref), p1 (copy), t (ref), Workspace (ref), Assets (ref), Rarity (ref), bindModel (ref) ]]
			if v3 then
				return
			end

			local v1 = p1.Name
			local v2 = t[v1]

			if p1.Parent ~= Workspace or v2 == nil then
				return
			end

			local v32 = Assets.Directory[v2]

			assert(v32 ~= nil, (("Missing asset config %*"):format(v2)))

			local Rarity2 = v32.Rarity
			local v6 = if Rarity2 == Rarity.Rarities.Secret or Rarity2 == Rarity.Rarities.Eternal then Rarity2.Color else nil

			if v6 == nil then
				return
			end

			bindModel(v1, p1, v6)
		end)
	end
end

function t4.BindRenderedModel(p1, p2) --[[ BindRenderedModel | Line: 232 | Upvalues: Asserts (copy), t (copy), v3 (ref), t3 (copy), t2 (copy), Assets (copy), Rarity (copy), bindModel (copy) ]]
	Asserts.table(p1)
	Asserts.Model(p2)
	t[p1.Uid] = p1.AssetCategory

	if v3 then
		t3[p1.Uid] = p2

		local Uid = p1.Uid
		local v1 = t2[Uid]

		if v1 == nil then
			return
		end

		t2[Uid] = nil

		local DestroyConnection = v1.DestroyConnection

		if DestroyConnection ~= nil then
			DestroyConnection:Disconnect()
		end

		if v1.Highlight.Parent == nil then
			return
		end

		v1.Highlight:Destroy()
	else
		local AssetCategory = p1.AssetCategory
		local v2 = Assets.Directory[AssetCategory]

		assert(v2 ~= nil, (("Missing asset config %*"):format(AssetCategory)))

		local Rarity2 = v2.Rarity
		local v5 = if Rarity2 == Rarity.Rarities.Secret or Rarity2 == Rarity.Rarities.Eternal then Rarity2.Color else nil

		if v5 ~= nil then
			bindModel(p1.Uid, p2, v5)

			return
		end

		local Uid = p1.Uid
		local v6 = t2[Uid]

		if v6 == nil then
			return
		end

		t2[Uid] = nil

		local DestroyConnection = v6.DestroyConnection

		if DestroyConnection ~= nil then
			DestroyConnection:Disconnect()
		end

		if v6.Highlight.Parent == nil then
			return
		end

		v6.Highlight:Destroy()
	end
end
function t4.Start() --[[ Start | Line: 249 | Upvalues: v5 (ref), EggCmds (copy), beginResetReveal (copy), completeResetReveal (copy), applySnapshot (copy), applyRecord (copy), v2 (ref), t (copy), t3 (copy), t2 (copy), syncUid (copy), applyCarryState (copy), Workspace (copy), observeWorkspaceChild (copy), v1 (copy) ]]
	assert(not v5, "RareEggHighlight.Start may only be called once")
	v5 = true
	EggCmds.AreaEggResetStartCountdown:Connect(beginResetReveal)
	EggCmds.AreaEggRareSpawnsPresented:Connect(completeResetReveal)
	EggCmds.AreaEggSnapshotUpdated:Connect(applySnapshot)
	EggCmds.AreaEggUpdated:Connect(applyRecord)
	EggCmds.AreaEggRemoved:Connect(function(p1) --[[ Line: 256 | Upvalues: v2 (ref), t (ref), t3 (ref), t2 (ref), syncUid (ref) ]]
		if p1 == v2 then
			syncUid(p1)
		else
			t[p1] = nil
			t3[p1] = nil

			local v1 = t2[p1]

			if v1 == nil then
				return
			end

			t2[p1] = nil

			local DestroyConnection = v1.DestroyConnection

			if DestroyConnection ~= nil then
				DestroyConnection:Disconnect()
			end

			if v1.Highlight.Parent ~= nil then
				v1.Highlight:Destroy()
			end
		end
	end)
	EggCmds.AreaEggCarryStateChanged:Connect(applyCarryState)
	Workspace.ChildAdded:Connect(observeWorkspaceChild)
	applySnapshot(EggCmds.GetAreaEggSnapshot())
	v1:AtDebug():Log("Rare area egg highlight lifecycle started")
end

return table.freeze(t4)