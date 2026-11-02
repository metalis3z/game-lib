-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Parent_0 = script.Parent.Parent;
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local l_Screens_0 = l_Parent_0:WaitForChild("Lobby"):WaitForChild("Screens");
local _ = l_Parent_0:WaitForChild("Game");
local l_Shop_0 = l_Screens_0:WaitForChild("Shop");
local v6 = require(game.ReplicatedStorage.Modules.ShopModule);
local _ = require(game.ReplicatedStorage.Modules.ItemModule);
local l_ShopModule_0 = game.ReplicatedStorage.Modules.ShopModule;
v6.GUI.ShopFrame = l_Shop_0;
v6.GUI.Main = l_Shop_0.Main;
v6.GUI.Nav = l_Shop_0.Main.Featured.Nav;
v6.GUI.Title = l_Shop_0.Title;
v6.GUI.FeaturedFrame = l_Shop_0.Main.Featured;
v6.GUI.ViewBoxFrame = l_Shop_0.Main.ViewCrate.Container;
v6.GUI.Processing = l_Screens_0.Processing;
v6.GUI.HotItemsContainer = l_Shop_0.Main.Featured.HotItems.ScrollingFrame.Container;
v6.GUI.HotItemLayout = l_ShopModule_0.HotItems.Phone.HotItemLayout;
v6.GUI.NewHotItem = l_ShopModule_0.HotItems.Phone.HotItem;
v6.GUI.BoxContentsLayout = l_ShopModule_0.ViewBoxContents.Phone.BoxContentsLayout;
v6.GUI.NewBoxContent = l_ShopModule_0.ViewBoxContents.Phone.NewItem;
v6.GUI.ShopItemLayout = l_ShopModule_0.ShopTabs.Phone.ItemGridLayout;
v6.GenerateHotItems();
v6.ConnectNavButtonsPhone();
v6.ConnectViewBoxFrame(true);
v6.ConnectBuyPopup();
v6.ConnectGems();
v6.GenerateShopItems();
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
l_WindowService_0:RegisterFrame(l_Shop_0, "Inventory")
l_Shop_0.Title.Back.MouseButton1Click:connect(function()
    l_Shop_0.Title.Back.Visible = false;
    l_Shop_0.Title.Title.Visible = true;
    for _, v10 in pairs(l_Shop_0.Main:GetChildren()) do
        v10.Visible = v10.Name == "Featured";
    end;
end);
comma_value = function(v11)
    local l_v11_0 = v11;
    while true do
        local v13, v14 = string.gsub(l_v11_0, "^(-?%d+)(%d%d%d)", "%1,%2");
        k = v14;
        l_v11_0 = v13;
        if not (k ~= 0) then
            break;
        end;
    end;
    return l_v11_0;
end;
UpdateCash = function()
    local l_Coins_0 = l_ProfileData_0.Coins;
    local l_Gems_0 = l_ProfileData_0.Gems;
    l_Shop_0.Title.Coins.Container.Amount.Text = comma_value((math.floor(l_Coins_0)));
    l_Shop_0.Title.Gems.Container.Amount.Text = comma_value(l_Gems_0);
end;
l_Remotes_0:WaitForChild("Inventory"):WaitForChild("ProfileDataChanged").Event:Connect(function(v17, _)
	UpdateCash();
end);
UpdateCash();