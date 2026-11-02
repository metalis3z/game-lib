local GameGUI = script.Parent.Parent;
local ServerActivation = game.ReplicatedStorage.ActivatePerk
local LocalPlayer = game.Players.LocalPlayer;
local PerkButton = GameGUI.Perk;

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
	PerkButton.Image = GetImage(PerkData.Image);
	PerkButton.PerkName.Text = PerkData.Name;
	PerkButton.ActivateText.Visible = (PerkData.Active);
	PerkButton.Visible = true;
	if not PerkData.Active then
		require(script[Perk])();
	end
end)

local Actions = game:GetService("ContextActionService");
local Bind = function(Name,Button,Function)
	local F = function(_,State)
		if State == Enum.UserInputState.Begin and (not _G.PauseBinds) then
			Function();
		end
	end
	Actions:BindAction(Name,F,false,Button);
end
local Unbind = function(Name,Button,Function)
	Actions:UnbindAction(Name);
end

Bind("ActivatePerk",Enum.KeyCode.ButtonR1,function()
	if Perk ~= nil and Perks[Perk].Active then
		require(script[Perk])();
	end
end)


--[[
game:GetService("UserInputService").InputBegan:connect(function(Input)
	if Perk ~= nil and Input.KeyCode == Enum.KeyCode.ButtonR1 and Perks[Perk].Active then
		require(script[Perk])();
	end
end)]]