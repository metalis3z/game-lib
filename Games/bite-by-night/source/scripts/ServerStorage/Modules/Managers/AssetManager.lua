local AssetManager = {
	Player = {}
}
AssetManager.__index = AssetManager

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');

-- <- Public Variables -> --
local TemporaryAssets = ReplicatedStorage.TemporaryAssets

-- <- Public Functions -> --

-- // If the asset code part is shit, its normal my mind is being jealous of shitty stuff. (DO NOT MIND)
function AssetManager:RequestAsset(AssetName: string, Clone: boolean): any
	if not self.Player then
		warn(self)
		warn(`No player for in the self ???`);
		
		return
	end
	
	if not self.AssetFolder then
		warn(self)
		warn(`No assetfolder for {self.Player}`)
		
		return
	end

	warn(AssetName, self);
	
	local Asset = self.AssetFolder:FindFirstChild(AssetName);
	if not Asset then
		warn(`Couldn't find {AssetName} for {self.Player}.`);
		
		return
	end
	
	return Clone and Asset:Clone() or Asset
end

function AssetManager:RequestAssetFolderCleanUp(): ()
	if not self.Player then
		return
	end
	
	if not self.AssetFolder then
		return
	end
	
	self.AssetFolder:Destroy();
	self.AssetFolder = nil
end

function AssetManager.CreateAndLinkAssetFolder(Player: Player, NormalFolder: Folder, SkinFolder: Folder): ()
	local self = setmetatable({}, AssetManager);
	self.Player = Player

	local NormalAssetFolder = NormalFolder:FindFirstChild('Assets');
	if not NormalAssetFolder then -- // This means something is wrong btw... :(
		warn(`Normal assets weren't found for {Player}.`);
		
		return
	end
	
	local function FinishLink(): ()
		AssetManager.Player[Player] = self
	end
	
	local function DoNormalLink(): ()
		-- // Copy the asset folder
		local Assets = NormalAssetFolder:Clone();
		Assets.Parent = TemporaryAssets
		
		-- // This is the link.
		self.AssetFolder = Assets
		
		FinishLink();
	end
	
	local function DoSkinLink(SkinAssetsFolder: Folder): ()
		local Assets = NormalAssetFolder:Clone();

		for _, Instances in SkinAssetsFolder:GetChildren() do 
			local NeedToReplace = Assets:FindFirstChild(Instances.Name)
			if NeedToReplace then
				NeedToReplace:Destroy();

				Instances:Clone().Parent = Assets
			end
		end

		self.AssetFolder = Assets
		self.AssetFolder.Parent = TemporaryAssets

		FinishLink();
	end
	
	local function DoCustomSkinLink(CustomSkinFolder: Folder): ()
		local Assets = CustomSkinFolder:Clone();
		Assets.Parent = TemporaryAssets
		
		self.AssetFolder = Assets

		FinishLink();
	end
	
	-- // Check if the skin equipped is the normal one.
	local IsSkinNormalFolder = SkinFolder.Name == NormalFolder.Name
	if IsSkinNormalFolder then
		-- // If it is, do the normal link
		DoNormalLink();
	else 
		local CustomSkinFolder = SkinFolder:FindFirstChild('Assets');
		local SkinAssetsFolder = SkinFolder:FindFirstChild('AssetsReplace');
		if not SkinAssetsFolder and not CustomSkinFolder then
			-- // Do the normal link so the player doesn't end up without assets.
			return DoNormalLink();
		elseif CustomSkinFolder then
			-- // This is a custom link, same logic as the others. (Rarer cause only 1 or 2 skins have this thing)
			return DoCustomSkinLink(CustomSkinFolder);
		end
		
		DoSkinLink(SkinAssetsFolder);
	end
end

function AssetManager.RequestPlayerMeta(Player: Player)
	local PlayerMeta = AssetManager.Player[Player]
	if not PlayerMeta then
		return
	end
	
	return PlayerMeta
end

-- <- Return -> --
return AssetManager