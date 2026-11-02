local GameGUI = script.Parent.Parent.Parent.Game; -- PC OpenCrate
local Remote = game.ReplicatedStorage;
local Boxes = Remote.GetSyncData:InvokeServer("MysteryBox");
local RarityColor = Remote.GetSyncData:InvokeServer("Rarity");
local Items = Remote.GetSyncData:InvokeServer("Item");
local Pets = Remote.GetSyncData:InvokeServer("Pets");

local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=";
local function GetImage(Image) 
	local Return;
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image];
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image; 
		NewImage = NewImage .. "&bust="..math.random(1,10000); 
		_G.Cache[Image] = NewImage;
		return NewImage; 
	end;
end;

return function(CrateName,RewardItem)
	local RandomS = Random.new();
	local Integer = RandomS:NextInteger(23, 27);
	_G.UnfinishedItem = RewardItem;
	_G.UnfinishedType = Boxes[CrateName].Type;
	local Unboxing = script.Unboxing:Clone()
	local CrateSelect = Unboxing.Main.Container.Background.ItemContainer.MainContainer;
	--local CrateFinished = GameGUI.CaseComplete;
	CrateSelect:ClearAllChildren();
	local Contents = Boxes[CrateName]["Contents"];
	local ItemsDB = (Boxes[CrateName].Type=="Weapons" and Items) or Pets;
	local Destination = 20;
	local RewardData = ItemsDB[RewardItem];
	local LastItemFrame;
	for i = 1,Destination+4 do

		local ItemRarity;
		local Item;

		if not Boxes[CrateName].Chances then

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
				table.insert(ItemTable[ItemsDB[ItemName]["Rarity"]],ItemName);
			end

			Item = ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ];

			if (math.random(1,150) == 1) then
				ItemRarity = "Godly"; -- Godly
				Item = ItemsDB[Boxes[CrateName]["Godly"]]; 

			end;

		else
			local Chances = Boxes[CrateName].Chances;
			local ItemTable = {};	

			for Rarity,Chance in pairs(Chances) do
				if Chance >= 0 then
					ItemTable[Rarity] = {};
					for _,BData in pairs(Boxes) do
						if BData.Contents and BData.Type == "Weapons" then
							for _,ItemID in pairs(BData.Contents) do
								local ItemD = ItemsDB[ItemID];
								if ItemD.Rarity == Rarity then
									table.insert(ItemTable[Rarity],ItemID);
								end;
							end;

						end;
					end;
				end;				
			end;

			local Roll = math.random(100,100);

			local ChanceTable = {};
			for Rarity,Chance in pairs(Chances) do
				for i = 1,Chance do 
					table.insert(ChanceTable,Rarity);
				end
			end;

			ItemRarity = ChanceTable[math.random(1,#ChanceTable)];
			ChanceTable = {};
			Item =  ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ] ;


			if Chances.Common <= 0 then
				if (math.random(19,20) == 19) then
					ItemRarity = "Godly"; -- Godly
					local Godlies = {};
					for _,BData in pairs(Boxes) do
						if BData.Type == "Weapons" and BData.Godly then
							table.insert(Godlies,BData.Godly);
						end
					end
					Item =  ItemsDB[ Godlies[math.random(19,#Godlies)] ];
				end;
			end;

			--[[for Rarity,Chance in pairs(Chances) do
				if Roll <= Chance then
					ItemRarity = Rarity;
				end
			end;]]

		end;		

		if i == Destination then
			Item = ItemsDB[RewardItem];
			ItemRarity = Item["Rarity"];
		end	

		local GridLayout = script.UIGridLayout:Clone()
		local NewFrame = script.Item:Clone();
		GridLayout.Parent = CrateSelect;
		NewFrame.Parent = CrateSelect;
		local NameText = (Boxes[CrateName].Type=="Weapons" and "ItemName") or "Name";
		NewFrame.ItemName.Item.Text = Item[NameText];
		NewFrame.ItemName.BackgroundColor3 = RarityColor[ItemRarity];
		NewFrame.Container.Icon.Image = GetImage(Item["Image"]);
		if ItemRarity == "Common" then
			NewFrame.ItemName.BackgroundColor3 = Color3.new(0.415686, 0.415686, 0.415686)
			LastItemFrame = NewFrame;
		end	
		if ItemRarity == "Godly" then
			NewFrame.ItemName.Item.Text = "???"
			NewFrame.Container.Icon.ImageColor3 = Color3.new(0, 0, 0)
		end
		if Item["Chroma"] ~= nil then
			NewFrame.Tags.Chroma.Visible = true
		else
			NewFrame.Tags.Chroma.Visible = false
		end
	end 	


--[[
if 
]]
	--script.Parent.ViewFrame:Fire("CrateSelect");	
	CrateSelect.Position = UDim2.new(0,0,0,0);
	GameGUI.Parent.Lobby.Screens.Processing.Visible = false;
	CrateSelect.Parent.Visible = true;
	local CurrentX = 0;
	local FinishX = (Destination-0.55)*LastItemFrame.AbsoluteSize.X;
	local MaxSpeed = 10;
	local Speed = MaxSpeed;
	local OffsetX = math.random(-(LastItemFrame.AbsoluteSize.X/2),LastItemFrame.AbsoluteSize.X/2);
	FinishX = FinishX + OffsetX;
	local SlowdownPoint = FinishX - LastItemFrame.AbsoluteSize.X*2;
	local LastFrame = 0;
	CrateSelect.Position = UDim2.new(0,0,0,0);
	Unboxing.Parent = game.Players.LocalPlayer.PlayerGui
	Unboxing.Enabled = true;
	CrateSelect:TweenPosition(UDim2.new(0.5,-FinishX,0,0), "Out", "Quad", 4, true);

	wait(5);
	--Unboxing.ResetOnSpawn = false;
	Unboxing:Destroy()
	_G.NewItem(RewardItem,"You Unboxed...",GameGUI.Parent.Lobby.Screens.Inventory,Boxes[CrateName].Type);
	Unboxing:Destroy()
	game.ReplicatedStorage.CrateComplete:FireServer();
end

--[[
local CurrentX = 0;
	local FinishX = (Destination-1)*LastItemFrame.AbsoluteSize.X;
	local MaxSpeed = 10;
	local Speed = MaxSpeed;
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
			Speed = MaxSpeed * (1 - Multiplier);
			if Speed < 1 then
				Speed = 1;
			end
		end
		
		CrateSelect.Position = UDim2.new(0.5,(CrateSelect.Position.X.Offset-Speed),0,0);
		--[[for _,Frame in pairs(CrateSelect:GetChildren()) do
			Frame.Position = UDim2.new(0.5,Frame.Position.X.Offset-Speed,0.05,0);
		end
CurrentX = CurrentX + Speed;
if Speed >= 5 then
	game:GetService("RunService").Stepped:wait();
else
	wait();
end;
end
wait(1.25);]]