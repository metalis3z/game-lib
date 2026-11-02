-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_PerkService_0 = require(game.ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("PerkService"));
local _ = require(game.ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("DeviceService"));
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Perk_0 = script.Parent.Parent:WaitForChild("Game"):WaitForChild("Perk");
local function v4() --[[ Line: 8 ]] --[[ Name: onPreferredInputChanged ]]
	-- upvalues: l_UserInputService_0 (copy), l_PerkService_0 (copy), l_Perk_0 (copy)
	if l_UserInputService_0.PreferredInput ~= Enum.PreferredInput.Touch then
		l_PerkService_0.PerkButton = l_Perk_0;
		l_Perk_0.Visible = l_PerkService_0.PerkIsActive;
		return;
	else
		l_Perk_0.Visible = false;
		return;
	end;
end;
if l_UserInputService_0.PreferredInput ~= Enum.PreferredInput.Touch then
	l_PerkService_0.PerkButton = l_Perk_0;
	l_Perk_0.Visible = l_PerkService_0.PerkIsActive;
else
	l_Perk_0.Visible = false;
end;
l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(v4);