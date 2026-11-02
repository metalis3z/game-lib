local LocalPlayer = game.Players.LocalPlayer;
local MainGUI = script.Parent.Parent;
local PlayerGui = MainGUI.Parent;
local LobbyGUI = MainGUI.Lobby;
local Screens = LobbyGUI.Screens;

local Boxes = game.ReplicatedStorage.GetSyncData:InvokeServer("MysteryBox");
local Items = game.ReplicatedStorage.GetSyncData:InvokeServer("Item");
local Rarities = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");



function CrateOpen(CrateName,RewardItem)
	
	local LastItemFrame;
	local CrateSelect = MainGUI.CrateOpen.CrateRow.Container;
	--local CrateFinished = MainGUI.CaseComplete;
	Screens.Shop.Visible = false;
	CrateSelect:ClearAllChildren();
	CrateSelect.Position = UDim2.new(0.5, 0,0, 0);
	
	
	local Contents = Boxes[CrateName]["Contents"];
	local Destination = 20;
	local rItemName = RewardItem;
	RewardItem = Items[RewardItem];
	for i = 1,Destination+3 do
		local ItemRarity;
		local Rarity = math.random(1,100);
		if Rarity >= 1 and Rarity <= 60 then
			ItemRarity = "Common";
		elseif Rarity > 60 and Rarity <= 85 then
			ItemRarity = "Uncommon";
		elseif Rarity > 80 and Rarity <= 95 then
			ItemRarity  = "Rare";
		else
			ItemRarity = "Legendary";
		end
		local ItemTable = {
			["Common"] = {};
			["Uncommon"] = {};
			["Rare"] = {};
			["Legendary"] = {};
			["Godly"] = {Boxes[CrateName]["Godly"]};
		};
		for _,ItemName in pairs(Contents) do
			table.insert(ItemTable[Items[ItemName]["Rarity"]],ItemName);
		end
		
		local Item = Items[ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])]];
		
		if (math.random(1,500) == 1) then
			ItemRarity = "Godly"; -- Godly
			Item = Items[Boxes[CrateName]["Godly"]];
		end;
		
		if i == Destination then
			Item = RewardItem;
			ItemRarity = Item["Rarity"];
		end	
		
		local NewFrame = script.ItemFrame:Clone();
		NewFrame.Parent = CrateSelect;
		NewFrame.Position = UDim2.new(0,NewFrame.AbsoluteSize.X*(i-1)-(NewFrame.AbsoluteSize.X/2),0.05,0);
		NewFrame.ItemName.Text = Item["ItemName"];
		NewFrame.ItemName.TextColor3 = Rarities[Item.Rarity];
		--NewFrame.BorderColor3 = RarityColor[ItemRarity];
		NewFrame.Icon.Image = Item["Image"];
		LastItemFrame = NewFrame;
	end	 
	
	--script.Parent.ViewFrame:Fire("CrateSelect");	
	
	MainGUI.CrateOpen.Visible = true;
	LobbyGUI.Visible = false;
	
	local CurrentX = 0;
	local FinishX = (Destination-1)*LastItemFrame.AbsoluteSize.X;
	local Speed = 20;
	local OffsetX = math.random(-(LastItemFrame.AbsoluteSize.X/2),LastItemFrame.AbsoluteSize.X/2);
	FinishX = FinishX + OffsetX;
	local SlowdownPoint = FinishX - LastItemFrame.AbsoluteSize.X*2;
	local LastFrame = 0;
	
	--CrateSelect.Position = UDim2.new(0.5,-(LastItemFrame.AbsoluteSize.X/2),0,0);
	
	wait(0.25);	
	
	
	while CurrentX < FinishX do
		local Start = CurrentX - SlowdownPoint
		local End = FinishX - SlowdownPoint - (LastItemFrame.AbsoluteSize.X/2);
		
		if CurrentX >= SlowdownPoint then
			local Multiplier = Start/End;
			Speed = 20 * (1 - Multiplier);
			if Speed < 1 then
				Speed = 1;
			end
		end
		
		CrateSelect.Position = UDim2.new(0.5,(CrateSelect.Position.X.Offset-Speed),0,0);
		--[[for _,Frame in pairs(CrateSelect:GetChildren()) do
			Frame.Position = UDim2.new(0.5,Frame.Position.X.Offset-Speed,0.05,0);
		end]]
		CurrentX = CurrentX + Speed;
		wait();
	end
	wait(1.25);
	
	--CrateFinished.ItemImage.ItemName.Text = RewardItem["ItemName"];
	--CrateFinished.ItemImage.ItemName.TextColor3 = RarityColor[RewardItem["Rarity"]];
	--CrateFinished.ItemImage.Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=".. RewardItem["ItemID"];
	--CrateFinished.Visible = true;
	MainGUI.CrateOpen.Visible = false;
	_G.NewItem(rItemName);
	--_G.GiveItem();
	game.ReplicatedStorage.CrateComplete:FireServer();
end

--game.ReplicatedStorage.PurchaseCrate.OnClientEvent:connect(CrateOpen);



--[[if CurrentX >= SlowdownPoint then
local Multiplier = Start/End;
Speed = 20 * (1 - Multiplier);
if Speed < 1 then
	Speed = 1;
end
end]]