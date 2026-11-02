--!strict
local EncryptedAssetsService = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local Net = require(ReplicatedStorage.Packages.Net)
local Load = Net:RemoteFunction("EncryptedAssetsService/Load") :: RemoteFunction

local EncryptedAssetIds = {
	"rbxassetid://101252122546671"
}

Load.OnServerInvoke = function(Player: Player)
	local DecryptionKeys: {[string]: string} = {}
	for _, AssetId in ipairs(EncryptedAssetIds) do
		DecryptionKeys[AssetId] = AssetId
	end
	return DecryptionKeys
end

return EncryptedAssetsService