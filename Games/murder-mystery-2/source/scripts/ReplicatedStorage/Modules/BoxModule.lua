-- scripted by some random dude i think idk

local v1 = {};
local v3 = {};
local Remote = game.ReplicatedStorage;
local Boxes = Remote.GetSyncData:InvokeServer("MysteryBox");
local l__TweenService__4 = game:GetService("TweenService")
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
function v1.OpenBox(CrateName,RewardItem)
	local v10 = Random.new();
	_G.UnfinishedItem = RewardItem;
	_G.UnfinishedType = Boxes[CrateName].Type;
	local Unboxing = script.Unboxing:Clone()
	local CrateSelect = Unboxing.Main.Container.Background.ItemContainer.MainContainer;
	CrateSelect:ClearAllChildren();
	local Contents = Boxes[CrateName]["Contents"];
	local Godlies = Boxes[CrateName]["Godly"];
	local ItemsDB = (Boxes[CrateName].Type=="Weapons" and Items) or Pets;
	local Destination = v10:NextInteger(23, 27);
	local RewardData = ItemsDB[RewardItem];
	local LastItemFrame;
	for i = 1,Destination+5 do

		local ItemRarity;
		local Item;

		if not Boxes[CrateName].OnlyGodly and not Boxes[CrateName].OnlyAncient and not Boxes[CrateName].OnlyVictim then
			
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
			if math.random(1,500) == 1 then
				ItemRarity = "Godly"; -- Godly
			end
			local ItemTable = {
				["Common"] = {};
				["Uncommon"] = {};
				["Rare"] = {};
				["Legendary"] = {};
				["Godly"] = {};
			};
			for _,ItemName in pairs(Contents) do
				table.insert(ItemTable[ItemsDB[ItemName]["Rarity"]],ItemName);
			end


			Item = ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ];
			
		elseif Boxes[CrateName].OnlyGodly then
			local Rarity = math.random(1,100);
			if Rarity >= 1 and Rarity <= 60 then
				ItemRarity = "Godly";
			elseif Rarity > 60 and Rarity <= 85 then
				ItemRarity = "Godly";
			elseif Rarity > 80 and Rarity <= 95 then
				ItemRarity  = "Godly";
			else
				ItemRarity = "Godly";
			end
			if math.random(1,500) == 1 then
				ItemRarity = "Godly"; -- Godly
			end
			local ItemTable = {
				["Common"] = {};
				["Uncommon"] = {};
				["Rare"] = {};
				["Legendary"] = {};
				["Godly"] = {};
			};
			for _,ItemName in pairs(Contents) do
				table.insert(ItemTable[ItemsDB[ItemName]["Rarity"]],ItemName);
			end


			Item = ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ];
			
		elseif Boxes[CrateName].OnlyVictim then
			local Rarity = math.random(1,100);
			if Rarity >= 1 and Rarity <= 60 then
				ItemRarity = "Victim";
			elseif Rarity > 60 and Rarity <= 85 then
				ItemRarity = "Victim";
			elseif Rarity > 80 and Rarity <= 95 then
				ItemRarity  = "Victim";
			else
				ItemRarity = "Victim";
			end
			if math.random(1,500) == 1 then
				ItemRarity = "Victim"; -- Godly
			end
			local ItemTable = {
				["Common"] = {};
				["Uncommon"] = {};
				["Rare"] = {};
				["Legendary"] = {};
				["Victim"] = {};
			};
			for _,ItemName in pairs(Contents) do
				table.insert(ItemTable[ItemsDB[ItemName]["Rarity"]],ItemName);
			end


			Item = ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ];
			
		elseif Boxes[CrateName].OnlyAncient then
			local Rarity = math.random(1,100);
			if Rarity >= 1 and Rarity <= 60 then
				ItemRarity = "Ancient";
			elseif Rarity > 60 and Rarity <= 85 then
				ItemRarity = "Ancient";
			elseif Rarity > 80 and Rarity <= 95 then
				ItemRarity  = "Ancient";
			else
				ItemRarity = "Ancient";
			end
			if math.random(1,500) == 1 then
				ItemRarity = "Ancient"; -- Godly
			end
			local ItemTable = {
				["Common"] = {};
				["Uncommon"] = {};
				["Rare"] = {};
				["Legendary"] = {};
				["Ancient"] = {};
			};
			for _,ItemName in pairs(Contents) do
				table.insert(ItemTable[ItemsDB[ItemName]["Rarity"]],ItemName);
			end


			Item = ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ];
		elseif (Boxes[CrateName].OnlyVictim) then
			local Rarity = math.random(1,100);
			if Rarity >= 1 and Rarity <= 60 then
				ItemRarity = "Victim";
			elseif Rarity > 60 and Rarity <= 85 then
				ItemRarity = "Victim";
			elseif Rarity > 80 and Rarity <= 95 then
				ItemRarity  = "Victim";
			else
				ItemRarity = "Victim";
			end
			if math.random(1,500) == 1 then
				ItemRarity = "Victim"; -- Godly
			end
			local ItemTable = {
				["Common"] = {};
				["Uncommon"] = {};
				["Rare"] = {};
				["Legendary"] = {};
				["Victim"] = {};
			};
			for _,ItemName in pairs(Contents) do
				table.insert(ItemTable[ItemsDB[ItemName]["Rarity"]],ItemName);
			end


			Item = ItemsDB[ ItemTable[ItemRarity][math.random(1,#ItemTable[ItemRarity])] ];
		
		end;


		if i == Destination then
			Item = ItemsDB[RewardItem];
			ItemRarity = Item["Rarity"];
		end	

		local NewFrame = script.Item:Clone();
		NewFrame.Parent = CrateSelect;
		NewFrame.Position = UDim2.new(0,NewFrame.AbsoluteSize.X*(i-1)-(NewFrame.AbsoluteSize.X/2),0.5,-NewFrame.AbsoluteSize.Y/2);
		local NameText = (Boxes[CrateName].Type=="Weapons" and "ItemName") or "Name";
		if ItemRarity ~= "Godly" then
			NewFrame.ItemName.Label.Text = Item[NameText];

			NewFrame.ItemName.BackgroundColor3 = RarityColor[ItemRarity];
			--NewFrame.BorderColor3 = RarityColor[ItemRarity];
			pcall(function()NewFrame.Container.Icon.Image = Item["Image"];end)
			LastItemFrame = NewFrame;
		else
			NewFrame.ItemName.Label.Text = "???"
			NewFrame.ItemName.BackgroundColor3 = RarityColor[ItemRarity];
			NewFrame.Container.Icon.Image = Item["Image"];
			NewFrame.Container.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0)
			--NewFrame.BorderColor3 = RarityColor[ItemRarity];
			LastItemFrame = NewFrame;
		end
	end	 

	--script.Parent.ViewFrame:Fire("CrateSelect");	
	CrateSelect.Position = UDim2.new(0,0,0,0);
	Unboxing.Enabled = true
	Unboxing.Parent = game.Players.LocalPlayer.PlayerGui


	local CurrentX = 0;
	local FinishX = (Destination-1)*LastItemFrame.AbsoluteSize.X;
	local MaxSpeed = 10;
	local Speed = MaxSpeed;
	local OffsetX = math.random(-(LastItemFrame.AbsoluteSize.X/2),LastItemFrame.AbsoluteSize.X/2);
	FinishX = FinishX + OffsetX;
	local SlowdownPoint = FinishX - LastItemFrame.AbsoluteSize.X*2;
	local LastFrame = 0;

	--CrateSelect.Position = UDim2.new(0.5,-(LastItemFrame.AbsoluteSize.X/2),0,0);

	CrateSelect:TweenPosition(UDim2.new(0.5,-FinishX,0,0),"Out","Quad", 4, true)


	wait(5);
	Unboxing:Destroy()
end
local v42 = {};
local u5 = TweenInfo.new(0.125, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
function v1.HatchEgg(p3, p4)
	local v38 = script.Hatching:Clone();
	v38.Parent = game.Players.LocalPlayer.PlayerGui;
	pcall(function() v38.Cracked.PetIcon.Image = GetImage(Pets[p4].Image); end)
	wait(1);
	local l__Egg__39 = v38.Uncracked.Egg;
	for v40, v41 in pairs({ l__TweenService__4:Create(l__Egg__39, u5, {
		Rotation = 10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = -10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = 10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = -10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = 0
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = 10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = -10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = 10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = -10
		}), l__TweenService__4:Create(l__Egg__39, u5, {
			Rotation = 0
		}) }) do
		v41:Play();
		wait(0.125);
	end;
	wait(0.5);
	v38.Uncracked.Visible = false;
	v38.Cracked.Visible = true;
	wait(1);
	v38:Destroy();
end;
for v43, v44 in pairs(script:GetDescendants()) do
	if v44:IsA("ImageLabel") then
		table.insert(v42, v44);
	end;
end;
spawn(function()
	game:GetService("ContentProvider"):PreloadAsync(v42);
end);
return v1;
