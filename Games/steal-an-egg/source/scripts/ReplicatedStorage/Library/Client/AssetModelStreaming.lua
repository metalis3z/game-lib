-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetModels = require(ReplicatedStorage.Library.Modules.AssetModels)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local t = {}
local t2 = {
	AssetModelReplicated = Signal.new(),
	AllAssetModelsReplicated = Signal.new()
}

function t2._markAssetModelReplicated(p1, p2) --[[ _markAssetModelReplicated | Line: 24 | Upvalues: t (copy), t2 (copy) ]]
	if not t[p1] then
		t[p1] = true
		t2.AssetModelReplicated:Fire(p1, p2)
	end
end
function t2._initReplicatedAssetModelState() --[[ _initReplicatedAssetModelState | Line: 33 | Upvalues: AssetModels (copy), t2 (copy) ]]
	for i, v in ipairs(AssetModels.GetAssetModelsFolder():GetChildren()) do
		if v:IsA("Model") then
			AssetModels.HydrateAssetConfigModelScale(v.Name)
			t2._markAssetModelReplicated(v.Name, v)
		end
	end
end
function t2.IsAssetModelReplicated(p1) --[[ IsAssetModelReplicated | Line: 46 | Upvalues: Asserts (copy), AssetModels (copy) ]]
	Asserts.string(p1)

	return AssetModels.GetAssetModelIfReplicated(p1) ~= nil
end
function t2.ForceLoadAssetModels(p1) --[[ ForceLoadAssetModels | Line: 51 | Upvalues: Asserts (copy) ]]
	Asserts.array.string(p1)

	return true
end
function t2.AreAllAssetModelsReplicated() --[[ AreAllAssetModelsReplicated | Line: 56 ]]
	return true
end

return t2