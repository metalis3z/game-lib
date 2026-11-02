
local l_Parent_0 = script.Parent.Parent;
local v1 = require(game.ReplicatedStorage.Modules.ItemModule);
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_NewItem_0 = script.Parent.Parent.NewItem;
local v4 = nil;
local v5 = {};
game.Lighting.NewItemBlur.Enabled = false;
local v6 = 1;
local v7 = 1;
local function _()
    if v7 > 1 then
        l_NewItem_0.Container.Claim.Text = "Claim (" .. v6 .. "/" .. v7 .. ")";
        return;
    else
        l_NewItem_0.Container.Claim.Text = "Claim";
        return;
    end;
end;
local function v13()
    local v9 = v5[1];
    local v10 = l_Sync_0[v9.Type][v9.ItemName];
    local v11 = v9.Amount or nil;
    v1.DisplayItem(l_NewItem_0.Container.NewItem, v10, v11);
    local l_Color_0 = l_Sync_0.Rarities[v10.Rarity].Color;
    l_NewItem_0.Container.Starburst.ImageColor3 = Color3.fromRGB(l_Color_0.r, l_Color_0.g, l_Color_0.b) or Color3.new(1, 1, 1);
    l_NewItem_0.Container.Title.Text = v9.TitleText;
    if v9.LFrame then
        v4 = v9.LFrame;
        v4.Visible = false;
    end;
    game.Lighting.NewItemBlur.Enabled = true;
    l_NewItem_0.Visible = true;
end;
_G.NewItem = function(v14, v15, v16, v17, v18)
	local sync = l_Sync_0[v17 or "Weapons"] and l_Sync_0[v17 or "Weapons"][v14]
	if sync and sync.DoesntCreate then
		return
	end
    table.insert(v5, {
        ItemName = v14, 
        TitleText = v15 or "You Got...", 
        LFrame = v16, 
        Type = v17 or "Weapons", 
        Amount = v18
    });
    if not l_NewItem_0.Visible then
        v6 = 1;
        v7 = #v5;
        v13();
    else
        v7 = v7 + 1;
    end;
    if v7 > 1 then
        l_NewItem_0.Container.Claim.Text = "Claim (" .. v6 .. "/" .. v7 .. ")";
        return;
    else
        l_NewItem_0.Container.Claim.Text = "Claim";
        return;
    end;
end;
l_NewItem_0.Container.Claim.MouseButton1Click:connect(function()
    v1.AnimateItemIconIntoInventory(l_NewItem_0.Container.NewItem.Container.Icon, l_Parent_0.Lobby.Dock.Inventory, l_Parent_0);
    l_NewItem_0.Visible = false;
    _G.UnfinishedItem = nil;
    _G.UnfinishedType = nil;
    table.remove(v5, 1);
    game.Lighting.NewItemBlur.Enabled = false;
    if v5[1] ~= nil then
        v6 = v6 + 1;
        if v7 > 1 then
            l_NewItem_0.Container.Claim.Text = "Claim (" .. v6 .. "/" .. v7 .. ")";
        else
            l_NewItem_0.Container.Claim.Text = "Claim";
        end;
        v13();
        return;
    else
        v7 = 1;
        v6 = 1;
        if v4 then
            v4.Visible = true;
        end;
        return;
    end;
end);
game.ReplicatedStorage.ItemGift.OnClientEvent:connect(function(v19, v20, Amount)
    local v21 = nil;
	_G.NewItem(v19, "You Got...", v21, v20, Amount);
end);