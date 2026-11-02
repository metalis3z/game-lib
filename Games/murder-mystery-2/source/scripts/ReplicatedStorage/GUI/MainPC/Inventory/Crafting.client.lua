-- Decompiled with the Synapse X Luau decompiler.

local l__Game__1 = script.Parent.Parent.Game;
local l__Crafting__2 = l__Game__1.Crafting;
local l__Salvage__3 = l__Game__1.Salvage;
local l__Inventory__4 = l__Game__1.Inventory;
local v5 = require(game.ReplicatedStorage.Modules.CraftModule);
v5.SetSalvageConfirmButton(v5.ShowSalvageRewards);
v5.SetCraftConfirmButton(v5.UpdateCraftConfirm);
v5.SetCraftGUI(l__Crafting__2, l__Crafting__2.Inventory.Craft.ScrollFrame, script.Recipe, l__Crafting__2.Action, l__Crafting__2.Inventory.Salvage.ScrollFrame, script.Item, l__Crafting__2.Action.Salvage, l__Salvage__3, l__Crafting__2.Action.Confirm);
v5.GenerateRecipes();
v5.GenerateSalvageInventory(l__Crafting__2.Inventory.Salvage.ScrollFrame, script.Item);
_G.Windows.Frames[l__Crafting__2] = true;
_G.Windows.FrameNames.Crafting = l__Crafting__2;
l__Crafting__2.Title.Back.MouseButton1Click:connect(function()
	l__Crafting__2.Visible = false;
end);
game.ReplicatedStorage.UpdateDataClient.Event:Connect(function()
	v5.GenerateRecipes();
end);
l__Crafting__2.Action.Nav.Salvage.MouseButton1Click:connect(function()
	l__Crafting__2.Inventory.Craft.Visible = false;
	l__Crafting__2.Inventory.Salvage.Visible = true;
	l__Crafting__2.Action.Craft.Visible = false;
	l__Crafting__2.Action.Salvage.Visible = true;
	l__Crafting__2.Action.Nav.Salvage.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l__Crafting__2.Action.Nav.Craft.Style = Enum.ButtonStyle.RobloxRoundButton;
	v5.ChangeMode("Salvage", true);
end);
l__Crafting__2.Action.Nav.Craft.MouseButton1Click:connect(function()
	l__Crafting__2.Inventory.Craft.Visible = true;
	l__Crafting__2.Inventory.Salvage.Visible = false;
	l__Crafting__2.Action.Craft.Visible = true;
	l__Crafting__2.Action.Salvage.Visible = false;
	l__Crafting__2.Action.Nav.Craft.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	l__Crafting__2.Action.Nav.Salvage.Style = Enum.ButtonStyle.RobloxRoundButton;
	v5.ChangeMode("Craft", true);
end);
l__Salvage__3.Claim.MouseButton1Click:connect(function()
	if l__Salvage__3.Claim.Style == Enum.ButtonStyle.RobloxRoundDefaultButton then
		l__Salvage__3.Visible = false;
		l__Crafting__2.Visible = true;
	end;
end);

