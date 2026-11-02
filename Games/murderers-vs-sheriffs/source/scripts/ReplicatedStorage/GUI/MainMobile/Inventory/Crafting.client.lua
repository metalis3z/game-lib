
local l_Parent_0 = script.Parent.Parent;
wait(0.5);
local l_Crafting_0 = l_Parent_0.Lobby.Screens.Inventory.Main.Crafting;
local l_ScrollFrame_0 = l_Crafting_0.Main.Salvage.ScrollFrame;
local l_ScrollFrame_1 = l_Crafting_0.Main.Craft.ScrollFrame;
local l_Confirm_0 = l_Crafting_0.Main.Salvage.Confirm;
local l_Salvaging_0 = l_Parent_0.Lobby.Screens.Inventory.Main.Salvaging;
local l_Confirm_1 = l_Confirm_0.Confirm;
local l_Recipe_0 = script.Recipe;
local l_Item_0 = script.Item;
local v9 = require(game.ReplicatedStorage.Modules.CraftModule);
v9.SetCraftGUI(l_Crafting_0, l_ScrollFrame_1, l_Recipe_0, l_Crafting_0.Nav, l_ScrollFrame_0, l_Item_0, l_Confirm_0, l_Salvaging_0, l_Confirm_1);
v9.GenerateRecipes();
v9.GenerateSalvageInventory();
v9.SetCraftConfirmButton(v9.UpdateCraftConfirmMobile);
v9.SetSalvageConfirmButton(v9.SalvageConfirmMobile);
l_Crafting_0.Nav.Salvage.MouseButton1Click:connect(function()
    l_Crafting_0.Main.Craft.Visible = false;
    l_Crafting_0.Main.Salvage.Visible = true;
    l_Crafting_0.Nav.Salvage.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
    l_Crafting_0.Nav.Craft.Style = Enum.ButtonStyle.RobloxRoundButton;
    v9.ChangeMode("Salvage");
end);
l_Crafting_0.Nav.Craft.MouseButton1Click:connect(function()
    l_Crafting_0.Main.Craft.Visible = true;
    l_Crafting_0.Main.Salvage.Visible = false;
    l_Crafting_0.Nav.Craft.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
    l_Crafting_0.Nav.Salvage.Style = Enum.ButtonStyle.RobloxRoundButton;
    v9.ChangeMode("Craft");
end);
l_Salvaging_0.Claim.MouseButton1Click:connect(function()
    if l_Salvaging_0.Claim.Style == Enum.ButtonStyle.RobloxRoundDefaultButton then
        l_Salvaging_0.Visible = false;
        l_Crafting_0.Visible = true;
    end;
end);