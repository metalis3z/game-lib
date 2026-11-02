local WindowService = require(game:GetService("ReplicatedStorage").Modules.WindowService)
local GameGUI = script.Parent.Parent.Game;
local ShopGUI = GameGUI.Shop;
local ShopModule = require(game.ReplicatedStorage.Modules.ShopModule);
ShopModule.GUI.ShopFrame = ShopGUI;
ShopModule.GUI.Main = ShopGUI.Main;
ShopModule.GUI.Nav = ShopGUI.Nav;
ShopModule.GUI.Title = ShopGUI.Title;
ShopModule.GUI.FeaturedFrame = ShopGUI.Main.Featured;
ShopModule.GUI.ViewBoxFrame = ShopGUI.Main.ViewCrate.Container;
ShopModule.GUI.Processing = GameGUI.Processing;
ShopModule.GUI.HotItemsContainer = ShopGUI.Main.Featured.HotItems.Container;
ShopModule.GenerateHotItems();
ShopModule.ConnectNavButtons();
ShopModule.ConnectViewBoxFrame();
ShopModule.ConnectBuyPopup();
ShopModule.ConnectGems();
ShopModule.GenerateShopItems();
WindowService:RegisterFrame(GameGUI.Shop, "Shop");
GameGUI.Dock.Shop.Activated:Connect(function()
	WindowService:ToggleFrame("Shop");
	ShopModule.ViewFeatured();
end);
local Attribute = game.Players.LocalPlayer:GetAttribute("Radio");
GameGUI.Shop.Main.Radios.NoRadioCover.Visible = not Attribute;
game.ReplicatedStorage.Remotes.Shop.GetRadio.OnClientEvent:connect(function()
	GameGUI.Shop.Main.Radios.NoRadioCover.Visible = false;
end);
GameGUI.Shop.Main.Radios.NoRadioCover.Buy.MouseButton1Click:connect(function()
    game.ReplicatedStorage.Remotes.Shop.GetRadio:FireServer();
end);