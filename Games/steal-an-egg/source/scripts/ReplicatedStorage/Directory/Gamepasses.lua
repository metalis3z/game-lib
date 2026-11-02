-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local PurchaseIdConfig = require(ReplicatedStorage:WaitForChild("PurchaseIdConfig"))
local t = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "GamepassesDir",
	rootName = "Gamepasses.Dir",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

for name, config in pairs(v1) do
	local mappedId = PurchaseIdConfig.GamepassIds[name]
	if typeof(mappedId) == "number" and mappedId > 0 then
		config.ProductId = mappedId
	end
end

t.Directory = v1
t.Types = Interface

if Constants.IS_STUDIO then
	local t2 = {}

	for k, v in pairs(v1) do
		local v2, v3 = Interface.DefaultConfig(v)

		assert(v2, (("Bad config found in Gamepasses: %* - %*"):format(k, v3)))

		if t2[v.ProductId] then
			error((("Duplicate Gamepass: %* / %*"):format(k, v.ProductId)))
		end

		t2[v.ProductId] = k
	end
end

MakeTableStrict(v1, "Gamepasses")

return t