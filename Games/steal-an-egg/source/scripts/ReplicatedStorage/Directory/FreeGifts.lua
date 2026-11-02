-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local FreeGifts = require(ReplicatedStorage.Library.Types.FreeGifts)
local t = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "FreeGiftDir",
	rootName = "FreeGift.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t.Directory = v1
t.Types = Interface
t.SortedById = {}

for k, v in pairs(v1) do
	if not v.TypeData then
		v.TypeData = FreeGifts.TypeData[v.Type]
	end
end

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetChildren()) do
		assert(v:IsA("ModuleScript"), (("Bad instance found inside the configs env: %*"):format(v.Name)))
		assert(Interface.DefaultConfig(v1[v.Name]))
	end
end

for k, v in pairs(v1) do
	t.SortedById[v.Id] = v
end

table.sort(t.SortedById, function(p1, p2) --[[ Line: 55 ]]
	return p1.Id < p2.Id
end)
MakeTableStrict(t.SortedById, "SortedByIdFreeGifts")
MakeTableStrict(v1, "FreeGifts")

return t