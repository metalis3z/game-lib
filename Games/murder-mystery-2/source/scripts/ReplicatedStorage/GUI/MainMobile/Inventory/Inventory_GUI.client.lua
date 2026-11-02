local GameGUI = script.Parent.Parent;
local Screens = GameGUI.Lobby.Screens;
local InventoryFrame = Screens.Inventory;
local Navigation = InventoryFrame.Nav;
local Main = InventoryFrame.Main;
local Dock = GameGUI.Lobby.Dock;

local NavOrder = {
	"Weapons";
	"Effects";
	"Perks";
	"Emotes";
	"Radios";
	"Toys";
	"Pets";
};

local Time = 0.2;
local Style = "Quad";
local Direction = "Out";

local CurrentFrame = "Weapons";
local CurrentAction = "Equip";
local Tweening = false;

-- Weapons Tab 
local WeaponsFrame = InventoryFrame.Main.Weapons;

local ActionsFrame = WeaponsFrame.Actions;
local EquippedFrame = WeaponsFrame.Equipped;
local ItemsFrame = WeaponsFrame.Items;

local ActionContainer = ActionsFrame.ActionContainer
local CraftingFrame = ActionContainer.Craft;

local EquipButton = ActionsFrame.Equip;
local CraftButton = ActionsFrame.Craft;
local RecycleButton = ActionsFrame.Recycle;
--local RecipesFrame = InventoryFrame.Recipes;

local Sizes = {

	[ItemsFrame] = {
		[EquipButton] = {
			Size = ItemsFrame.Size;
			Position = ItemsFrame.Position;
		};
		[CraftButton] = {
			Size = UDim2.new(0,-427,1,-155);
			Position = ItemsFrame.Position;
		};
		[RecycleButton] = {
			Size = UDim2.new(0,-427,1,-200);
			Position = ItemsFrame.Position;
		};
	};

	[ActionsFrame] = {
		[EquipButton] = {
			Size = ActionsFrame.Size;
			Position = ActionsFrame.Position;
		};
		[CraftButton] = {
			Size = UDim2.new(1,0,0,160);
			Position = UDim2.new(0,0,1,-160);
		};
		[RecycleButton] = {
			Size = UDim2.new(1,0,0,205);
			Position = UDim2.new(0,0,1,-205);
		};
	};

	[EquippedFrame] = {
		[EquipButton] = {
			Size = EquippedFrame.Size;
			Position = EquippedFrame.Position;
		};
		[CraftButton] = {
			Size = UDim2.new(0,130,1,-155);
			Position = UDim2.new(1,0,0,0);
		};
		[RecycleButton] = {
			Size = UDim2.new(0,130,1,-200);
			Position = EquippedFrame.Position;
		};
	};

	--[[[RecipesFrame] = {
		[EquipButton] = {
			Size = RecipesFrame.Size;
			Position = RecipesFrame.Position;
		};
		[CraftButton] = {
			Size = UDim2.new(0,292,1,-155);
			Position = RecipesFrame.Position; --EquippedFrame.Position;
		};
		[RecycleButton] = {
			Size = UDim2.new(0,0,1,-200);
			Position = ItemsFrame.Position;
		};
	};]]

};

--[[local Buttons = {EquipButton,CraftButton,RecycleButton};

local function ChangeAction(Button,CustomTime)
	CurrentAction = Button.Name;
	for _,B in pairs(Buttons) do B.Style = (B==Button and Enum.ButtonStyle.RobloxRoundDefaultButton) or Enum.ButtonStyle.RobloxRoundButton; end;
	if Button.Name ~= "Equip" then for _,F in pairs(ActionContainer:GetChildren()) do F.Visible = (F.Name==Button.Name); end; end;
	for Frame,Data in pairs(Sizes) do
		Frame:TweenSizeAndPosition(
			Data[Button].Size,
			Data[Button].Position,
			Direction,Style,((tonumber(CustomTime)~=nil and CustomTime) or Time)
		);
	end
end
for _,Button in pairs(Buttons) do
	Button.MouseButton1Click:connect(function()
		ChangeAction(Button);
	end)
end]]


-- End of Weapons Tab


-- Navigation 
for _,NavButton in pairs(Navigation.Main:GetChildren()) do
	if NavButton:IsA("TextButton") then
		NavButton.MouseButton1Click:connect(function()
			if not Tweening then
				Tweening = true;
				Navigation:TweenPosition(UDim2.new(-1,0,0,0),Direction,Style,Time);
				Main[NavButton.Name]:TweenPosition(UDim2.new(0,0,0,0),Direction,Style,Time);
				wait(Time);
				Tweening = false;
			end;
		end)
	end;
end

for _,Frame in pairs(Main:GetChildren()) do
	for i,v in pairs(Frame:GetDescendants()) do
		if v.Name == "Back" then
			v.MouseButton1Click:connect(function()
				if not Tweening then
					Tweening = true;
					Navigation:TweenPosition(UDim2.new(0,0,0,0),Direction,Style,Time);
					Main[Frame.Name]:TweenPosition(UDim2.new(1,0,0,0),Direction,Style,Time);
					wait(Time);
					Tweening = false;
				end;
			end)
		end
	end
end

Main.Radios.Equipped.Container.Songs.MouseButton1Click:Connect(function()
	Navigation:TweenPosition(UDim2.new(-1,0,0,0),Direction,Style,Time);
	Main.Radios:TweenPosition(UDim2.new(-1,0,0,0),Direction,Style,Time);
	Main.Songs:TweenPosition(UDim2.new(0,0,0,0),Direction,Style,Time);
end)



-- End of Navigation

--[[Main.Radios.BuyRadio.Get.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetRadio:FireServer();
end)]]
