local EncryptedAssetsService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local Net = require(ReplicatedStorage.Packages.Net)

local Load = Net:RemoteFunction("EncryptedAssetsService/Load") :: RemoteFunction

local EncryptedAssetIds = {
	"rbxassetid://76695984293943",
	"rbxassetid://134787237568321",
	"rbxassetid://109765355928080",
	"rbxassetid://106751797274517",
	"rbxassetid://92776706078734",
	"rbxassetid://104396128892246",
	"rbxassetid://137701898045492",
	"rbxassetid://125023107152555",
	"rbxassetid://125227402419630"
}

Load.OnServerInvoke = function(Player: Player)
	local DecryptionKeys: {[string]: string} = {}
	for _, AssetId in ipairs(EncryptedAssetIds) do
		DecryptionKeys[AssetId] = AssetId
	end
	return DecryptionKeys
end

return EncryptedAssetsService