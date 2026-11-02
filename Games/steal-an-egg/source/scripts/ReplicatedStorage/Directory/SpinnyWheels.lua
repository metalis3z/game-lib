-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local Data = require(script.Data)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local t = {}
local v1 = ModuleLoader(script._Index, {}, {
	typeCast = "SpinnyWheels",
	rootName = "SpinnyWheels.Directory",
	noPrint = true,
	shouldInject = true,
	forceSafeLoad = Constants.IS_CLIENT
})

t.Directory = v1
t.Types = Interface
t.Data = Data
MakeTableStrict(v1, "SpinnyWheels.Directory")

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetChildren()) do
		local v2 = v.Name
		local v3 = v:IsA("ModuleScript")

		assert(v3, (("Bad instance: %*"):format(v2)))

		local v6, v7 = Interface.DefaultConfig(v1[v2])

		assert(v6, (("Invalid config module: %* - %*"):format(v2, v7)))

		local v9 = Interface.AllWheelNames(v2)

		assert(v9, (("Spinny Wheel name: \"%*\" is not registered in AllWheelNames."):format(v2)))
	end
end

return t