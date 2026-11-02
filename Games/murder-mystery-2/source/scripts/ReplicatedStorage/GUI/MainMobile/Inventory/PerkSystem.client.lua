local GameGUI = script.Parent.Parent;
local ServerActivation = game.ReplicatedStorage.ActivatePerk
local LocalPlayer = game.Players.LocalPlayer;
local PerkButton = GameGUI.Game:WaitForChild("Perk");

local Perk;
local Perks = game.ReplicatedStorage.GetSyncData:InvokeServer("Perks")

local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
local function GetImage(Image) 
	local Return;
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image];
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image; 
		NewImage = NewImage .. "&bust="..math.random(1,10000); 
		_G.Cache[Image] = NewImage;
		return NewImage; 
	end;
end;

------------------------------------------
if game.Workspace:FindFirstChild("Footsteps") then
	game.Workspace.Footsteps:Destroy();
end
_G.Sleight = false;
------------------------------------------

ServerActivation.OnClientEvent:connect(function(PerkName)
	Perk = _G.PlayerData.Perks.Equipped[1];
	local PerkData = Perks[Perk]
	PerkButton.PerkIcon.Image = GetImage(PerkData.Image);
	PerkButton.PerkName.Text = (PerkData.Name) or PerkName
	--PerkButton.PerkName.Text = PerkData.Name
	--PerkButton.ActivateText.Visible = (PerkData.Active);
	PerkButton.Visible = true;
	
	PerkButton.AutoButtonColor = (PerkData.Active);
	
	if not PerkData.Active then
		require(script[Perk])();
	end
end)

PerkButton.MouseButton1Click:connect(function()
	if Perk ~= nil and Perks[Perk].Active then
		require(script[Perk])();
	end
end);




