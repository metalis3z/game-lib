-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1

if game:IsLoaded() then
	task.spawn(function() --[[ Line: 13 ]]
		require(script.Parent:WaitForChild("PlayerModule"))
	end)
	v1 = require(ReplicatedStorage.Library.Loaders.TagPackageLoader)
	task.spawn(function() --[[ Line: 21 | Upvalues: v1 (copy) ]]
		v1.new("[Client]:[Ecosystem]:", { "SpawnInThread" }):Load()
	end)

	return
end

game.Loaded:Wait()
task.spawn(function() --[[ Line: 13 ]]
	require(script.Parent:WaitForChild("PlayerModule"))
end)
v1 = require(ReplicatedStorage.Library.Loaders.TagPackageLoader)
task.spawn(function() --[[ Line: 21 | Upvalues: v1 (copy) ]]
	v1.new("[Client]:[Ecosystem]:", { "SpawnInThread" }):Load()
end)