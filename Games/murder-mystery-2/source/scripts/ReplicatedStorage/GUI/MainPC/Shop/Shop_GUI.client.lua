local GameGUI = script.Parent.Parent.Game;
local ShopFrame = GameGUI.Shop;
local TitleFrame = ShopFrame.Title.TextLabel;
local Main = ShopFrame.Main;
local Navigation = ShopFrame.Nav.Container;
local Dock = GameGUI.Dock;
local ItemPackFrame = GameGUI.ItemPack;
_G.Windows.Frames[ShopFrame] = true;
_G.Windows.FrameNames.Shop = ShopFrame;
local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

_G.Tweening = false;
_G.CurrentFrame = "Featured";

--[[
	ShopFrame:TweenSizeAndPosition(
				UDim2.new(0,450,0,325),				
				UDim2.new(0.5,-225,0.5,-163),
				Direction,Style,Time
			);

--]]

TitleFrame.Parent.Close.MouseButton1Click:connect(function()
	script.Parent.Click:Play();
	_G.Navigate("Featured")
	ShopFrame.Visible = false
end)


_G.Navigate = function(FrameName,Override)
	_G.PromptingPurchase = false
	Main.Featured.Visible = false
	if FrameName == "Elite" then
		ShopFrame.Visible = false;
		GameGUI.GetElite.Visible = true;
		return;
	elseif FrameName == "ItemPack" then
		return;
	elseif FrameName == "Featured" then
		if not _G.Tweening then
			for _,Frame in pairs(Main:GetChildren()) do
				Frame.Visible = false
			end
			_G.Tweening = true;_G.CurrentFrame = FrameName;local CustomTime = Override or Time;
			for _,NavButton in pairs(Navigation:GetChildren()) do
				if NavButton:IsA("TextButton") and NavButton.Name ~= FrameName then
					NavButton.IsSelected.Visible = false
					NavButton.NotSelected.Visible = true
					NavButton.Back.Visible = false
				end
			end
			Main[FrameName].Visible = false
			ShopFrame.Main.Featured.Visible = true
			GameGUI.Inventory.Visible = false;
			GameGUI.Shop.Visible = true;
			_G.Tweening = false;
		end;
		return;
	end;

	if not _G.Tweening then
		for _,Frame in pairs(Main:GetChildren()) do
			Frame.Visible = false
		end
		for _,NavButton in pairs(Navigation:GetChildren()) do
			if NavButton:IsA("TextButton") and NavButton.Name ~= FrameName then
				NavButton.IsSelected.Visible = false
				NavButton.NotSelected.Visible = true
				NavButton.Back.Visible = false
			end
		end
		_G.Tweening = true;
		TitleFrame.Text = FrameName;
		_G.CurrentFrame = FrameName;
		local CustomTime = Override or Time;

		ShopFrame.Main.Featured.Visible = false

		for _,NavButton in pairs(Navigation:GetChildren()) do
			if NavButton:IsA("TextButton") and NavButton.Name == FrameName then
				NavButton.NotSelected.Visible = false
				NavButton.IsSelected.Visible = true
				NavButton.Back.Visible = false
			end
		end
		Main[FrameName].Visible = true
		GameGUI.Inventory.Visible = false;
		GameGUI.Shop.Visible = true;
		_G.Tweening = false;
	end;

end

for _,NavButton in pairs(Navigation:GetChildren()) do
	if NavButton:IsA("TextButton") then
		NavButton.MouseButton1Click:connect(function()
			script.Parent.Click:Play();
			if not NavButton.IsSelected.Visible or NavButton.Back.Visible then
				_G.Navigate(NavButton.Name);
			else
				_G.Navigate("Featured");
			end
		end)
	end
end

local function GetCurrency(Currency,Ammount)
	if not _G.Tweening and _G.CurrentFrame ~= "Get"..Currency then
		_G.CurrentFrame = "Get"..Currency;
		if _G.CurrentFrame == "GetGems" then
			for _,Frame in pairs(Main:GetChildren()) do
				Frame.Visible = false
			end
			ShopFrame.Main.Gems.Visible = true
		end;
		_G.Tweening = false;
	end;
end


_G.GetGems = function(Ammount)
	_G.PromptingPurchase = false
	GetCurrency("Gems",Ammount);
end

_G.GetCredits = function()
	--[[if not _G.Tweening then
		_G.Tweening = true;
		TitleFrame.Title.Text = "Coins!";
		TitleFrame.Back.Letter.Text = "<";
		_G.CurrentFrame = "GetCoins";
		
		ShopFrame.Container.Coins:TweenPosition(
			UDim2.new(0,0,0,0),
			Direction,Style,Time
		);
		ShopFrame.Container.Featured:TweenPosition(
			UDim2.new(0,-ShopFrame.Container.Featured.Size.X.Offset,0,0),
			Direction,Style,Time
		);
		Navigation:TweenPosition(
			UDim2.new(-1,0,0,0),
			Direction,Style,Time
		);
		ShopFrame:TweenSizeAndPosition(
			UDim2.new(0,450,0,325),				
			UDim2.new(0.5,-225,0.5,-163),
			Direction,Style,Time
		);
		for _,Frame in pairs(Main:GetChildren()) do
			Frame:TweenPosition(
				UDim2.new(-1,0,0,0),
				Direction,Style,Time
			);
		end;
		
		wait(Time);
		for _,Frame in pairs(Main:GetChildren()) do
			Frame.Position = UDim2.new(1,0,0,0);
		end;
		_G.Tweening = false;
	end;]]
end




ShopFrame.Title.Gems.GetMore.MouseButton1Click:Connect(function()
	_G.GetGems();
end)

Main.Radios.NoRadioCover.Buy.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.GetRadio:FireServer();
end)

for i,Button in pairs(ShopFrame.Main.Gems:GetChildren()) do
	Button.MouseButton1Click:connect(function()
		game.ReplicatedStorage.PurchaseProduct:FireServer(Button.Name,"Gems");
	end)
end



Dock.Inventory.MouseButton1Click:connect(function()	 
	ShopFrame.Visible = false;
end);

Dock.Shop.MouseButton1Click:connect(function() 
	_G.Windows.ViewFrame(ShopFrame)
end);




local function u3(p4)
	for v19, v20 in pairs(p4) do
		v20:Play();
	end;
end;

local TweenService = game:GetService("TweenService");
local u5 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u6 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u7 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local Coins = 0;
local Elite = game.ReplicatedStorage.AmElite:InvokeServer();
