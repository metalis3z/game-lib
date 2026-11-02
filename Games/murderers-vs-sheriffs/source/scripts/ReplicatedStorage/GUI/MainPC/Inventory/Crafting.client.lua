-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Game_0 = script.Parent.Parent.Game;
local l_Crafting_0 = l_Game_0.Crafting;
local l_Salvage_0 = l_Game_0.Salvage;
local _ = l_Game_0.Inventory;
local v5 = require(game.ReplicatedStorage.Modules.CraftModule);
local l_ScrollFrame_0 = l_Crafting_0.Inventory.Salvage.ScrollFrame;
local l_ScrollFrame_1 = l_Crafting_0.Inventory.Craft.ScrollFrame;
local l_Recipe_0 = script.Recipe;
local l_Item_0 = script.Item;
local l_Confirm_0 = l_Crafting_0.Action.Confirm;
v5.SetSalvageConfirmButton(v5.ShowSalvageRewards);
v5.SetCraftConfirmButton(v5.UpdateCraftConfirm);
v5.SetCraftGUI(l_Crafting_0, l_ScrollFrame_1, l_Recipe_0, l_Crafting_0.Action, l_ScrollFrame_0, l_Item_0, l_Crafting_0.Action.Salvage, l_Salvage_0, l_Confirm_0);
v5.GenerateRecipes();
v5.GenerateSalvageInventory(l_Crafting_0.Inventory.Salvage.ScrollFrame, script.Item);
l_WindowService_0:RegisterFrame(l_Game_0:WaitForChild("Crafting"), "Crafting");
l_Crafting_0.Title.Back.Activated:Connect(function() --[[ Line: 32 ]]
	l_WindowService_0:Back();
end);
l_Crafting_0.Action.Nav.Salvage.MouseButton1Click:connect(function() --[[ Line: 39 ]]
	l_Crafting_0.Inventory.Craft.Visible = false;
	l_Crafting_0.Inventory.Salvage.Visible = true;
	l_Crafting_0.Action.Craft.Visible = false;
	l_Crafting_0.Action.Salvage.Visible = true;
	l_Crafting_0.Action.Nav.Salvage.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l_Crafting_0.Action.Nav.Craft.Style = Enum.ButtonStyle.RobloxRoundButton;
	v5.ChangeMode("Salvage", true);
end);
l_Crafting_0.Action.Nav.Craft.MouseButton1Click:connect(function() --[[ Line: 52 ]]
	l_Crafting_0.Inventory.Craft.Visible = true;
	l_Crafting_0.Inventory.Salvage.Visible = false;
	l_Crafting_0.Action.Craft.Visible = true;
	l_Crafting_0.Action.Salvage.Visible = false;
	l_Crafting_0.Action.Nav.Craft.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l_Crafting_0.Action.Nav.Salvage.Style = Enum.ButtonStyle.RobloxRoundButton;
	v5.ChangeMode("Craft", true);
end);
l_Salvage_0.Claim.MouseButton1Click:connect(function() --[[ Line: 66 ]]
	if l_Salvage_0.Claim.Style == Enum.ButtonStyle.RobloxRoundDefaultButton then
		l_Salvage_0.Visible = false;
		l_Crafting_0.Visible = true;
	end;
end);