-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Items = Library:WaitForChild("Items")
local Container = Items:WaitForChild("Container")
local Asserts = require(Library.Asserts)
local AbstractItem = require(Items.AbstractItem)
local v1 = require(Container)
local InventoryProjection = require(Items.InventoryProjection)
local SimpleStore = require(Container.SimpleStore)
local Save = require(Library.Client.Save)
local t = {}

t.__index = t

local function isStateSourceCurrent(p1, p2) --[[ isStateSourceCurrent | Line: 31 | Upvalues: Save (copy) ]]
	return Save.Get(p1) == p2
end

local function connectContainerSignals(p1) --[[ connectContainerSignals | Line: 35 | Upvalues: AbstractItem (copy) ]]
	p1.container.Added:Connect(function(p12) --[[ Line: 36 | Upvalues: AbstractItem (ref), p1 (copy) ]]
		for i, v in ipairs(p12) do
			AbstractItem.Added:FireAsync(v, p1.player)
			v.Class.Module.Added:FireAsync(v, p1.player)
		end
	end)
	p1.container.Removed:Connect(function(p12) --[[ Line: 43 | Upvalues: AbstractItem (ref), p1 (copy) ]]
		for i, v in ipairs(p12) do
			AbstractItem.Removed:FireAsync(v, p1.player)
			v.Class.Module.Removed:FireAsync(v, p1.player)
		end
	end)
	p1.container.Tracked:Connect(function(p12) --[[ Line: 50 | Upvalues: AbstractItem (ref), p1 (copy) ]]
		for i, v in ipairs(p12) do
			AbstractItem.Tracked:FireAsync(v, p1.player)
			v.Class.Module.Tracked:FireAsync(v, p1.player)
		end
	end)
end

function t.new(p1, p2) --[[ new | Line: 59 | Upvalues: Asserts (copy), InventoryProjection (copy), v1 (copy), SimpleStore (copy), Save (copy), t (copy), connectContainerSignals (copy) ]]
	Asserts.Player(p1)
	Asserts.table(p2)

	local t2 = {
		player = p1,
		container = v1.new(SimpleStore.new(InventoryProjection.BuildSnapshot(p2), function() --[[ Line: 65 | Upvalues: p1 (copy), p2 (copy), Save (ref) ]]
			return p2 == Save.Get(p1)
		end), p1)
	}
	local v3 = setmetatable(t2, t)

	connectContainerSignals(v3)

	return v3
end
function t.Destroy(p1) --[[ Destroy | Line: 80 ]]
	p1.container:Destroy()
end

return t