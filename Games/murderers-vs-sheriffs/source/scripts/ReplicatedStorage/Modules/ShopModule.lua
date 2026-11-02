-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
	GUI = {}
};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_EventInfoService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService"));
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Remotes_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local v6 = require(script.Parent.ItemModule);
local _ = require(game.ReplicatedStorage.Modules.BoxModule);
local _ = require(game.ReplicatedStorage.Modules.XboxModule);
local v9 = "Featured";
local v10 = "Featured";
local v11 = nil;
local v12 = nil;
local v13 = nil;
local l_Featured_0 = l_Sync_0.Featured;
local l_HotItems_0 = script.HotItems;
local l_Shop_0 = l_Sync_0.Shop;
local v17 = {
	Gems = true, 
	Candies2024 = true
};
local l_PurchaseOption_0 = script:WaitForChild("PurchaseOption");
local l_PurchaseOptionFrame_0 = script:WaitForChild("PurchaseOptionFrame");
local v20 = {
	Coins = {
		DisplayName = "Coins", 
		Icon = "rbxassetid://3150319038"
	}, 
	Gems = {
		DisplayName = "Gems", 
		Icon = "rbxassetid://377010926"
	}
};
local v21 = {
	"Key"
};
for v22, v23 in l_Sync_0.Materials do
	if v23.Currency then
		v20[v22] = {
			DisplayName = v23.ItemName or v23.Name, 
			Icon = v23.Image
		};
	end;
end;
for _, v25 in v21 do
	local v26 = l_Sync_0.Item[v25];
	v20[v25] = {
		DisplayName = v26.ItemName or v26.Name, 
		Icon = v26.Image or v26.Icon
	};
end;
local _ = function(v27, v28) --[[ Line: 67 ]] --[[ Name: CheckForItem ]]
	-- upvalues: l_ProfileData_0 (copy)
	if l_ProfileData_0[v28].Owned[v27] then
		return true;
	else
		for _, v30 in l_ProfileData_0[v28].Owned do
			if v30 == v27 then
				return true;
			end;
		end;
		return false;
	end;
end;
v0.CheckOwned = function(v32, v33) --[[ Line: 80 ]] --[[ Name: CheckOwned ]]
	-- upvalues: l_ProfileData_0 (copy)
	if v33 ~= "Weapons" and v33 ~= "Pets" and v33 ~= "MysteryBox" and v33 ~= "Eggs" and v33 ~= "Item" then
		if l_ProfileData_0[v33].Owned[v32] then
			return true;
		else
			for _, v35 in l_ProfileData_0[v33].Owned do
				if v35 == v32 then
					return true;
				end;
			end;
			return false;
		end;
	else
		return false;
	end;
end;
v0.SelectObject = function() --[[ Line: 88 ]]

end;
v0.BuyItem = function(v36, v37, v38, v39) --[[ Line: 91 ]]
	-- upvalues: l_Shop_0 (copy), l_ProfileData_0 (copy), v0 (copy)
	local v40 = false;
	local v41 = false;
	local v42 = l_Shop_0[v37][v36];
	local v43 = v42.DataType or v37;
	local l_Price_0 = v42.Price;
	local _ = false;
	if if not (v38 ~= "Coins") or v38 == "Gems" then l_ProfileData_0[v38] >= l_Price_0[v38] else (l_ProfileData_0.Materials.Owned[v38] or 0) >= l_Price_0[v38] then
		local l_v36_0 = v36;
		local v47;
		if v43 ~= "Weapons" and v43 ~= "Pets" and v43 ~= "MysteryBox" and v43 ~= "Eggs" and v43 ~= "Item" then
			if l_ProfileData_0[v43].Owned[l_v36_0] then
				v47 = true;
			else
				for _, v49 in l_ProfileData_0[v43].Owned do
					if v49 == l_v36_0 then
						v47 = true;
						v40 = true;
					end;
					if v40 then
						break;
					end;
				end;
				if not v40 then
					v47 = false;
				end;
			end;
		else
			v47 = false;
		end;
		v40 = false;
		if not v47 then
			v39.PriceFrame[v38].Visible = false;
			v39.PriceFrame.PurchaseLoading.LayoutOrder = v39.PriceFrame[v38].LayoutOrder;
			v39.PriceFrame.PurchaseLoading.Visible = true;
			spawn(function() --[[ Line: 112 ]]
				-- upvalues: v39 (copy)
				while v39.PriceFrame.PurchaseLoading.Visible == true do
					v39.PriceFrame.PurchaseLoading.Container.Spinner.Rotation = v39.PriceFrame.PurchaseLoading.Container.Spinner.Rotation + 5;
					game:GetService("RunService").RenderStepped:wait();
				end;
			end);
			v47 = game.ReplicatedStorage.Remotes.Shop.BuyItem:InvokeServer(v36, v37, v38);
			v39.PriceFrame.PurchaseLoading.Visible = false;
			if v47 then
				if v42.ExchangeAmount then
					v36 = "CoinVisual";
				end;
				v0.UpdateShopFrames();
			end;
			v0.SelectObject(true);
			return;
		end;
	end;
	local l_v36_1 = v36;
	local v51;
	if v43 ~= "Weapons" and v43 ~= "Pets" and v43 ~= "MysteryBox" and v43 ~= "Eggs" and v43 ~= "Item" then
		if l_ProfileData_0[v43].Owned[l_v36_1] then
			v51 = true;
		else
			for _, v53 in l_ProfileData_0[v43].Owned do
				if v53 == l_v36_1 then
					v51 = true;
					v41 = true;
				end;
				if v41 then
					break;
				end;
			end;
			if not v41 then
				v51 = false;
			end;
		end;
	else
		v51 = false;
	end;
	v41 = false;
	if v51 then
		v0.SelectObject();
		return;
	else
		if v38 == "Gems" and l_Price_0.Gems ~= nil then
			v0.SelectObject();
			v0.ViewGems(l_Price_0.Gems - l_ProfileData_0.Gems);
		end;
		return;
	end;
end;
v0.GenerateHotItems = function() --[[ Line: 142 ]]
	-- upvalues: v0 (copy), v6 (copy), l_Sync_0 (copy), l_Featured_0 (copy), v10 (ref), l_HotItems_0 (copy), l_EventInfoService_0 (copy), l_WindowService_0 (copy), l_Shop_0 (copy)
	v0.GenerateFeaturedBox = function() --[[ Line: 144 ]]
		-- upvalues: v6 (ref), v0 (ref), l_Sync_0 (ref), l_Featured_0 (ref), v10 (ref)
		v6.DisplayItem(v0.GUI.FeaturedFrame.Box.ItemFrame.ItemContainer, l_Sync_0.MysteryBox[l_Featured_0.Box]);
		local l_Box_0 = l_Sync_0.Featured.Box;
		local v55 = l_Sync_0.MysteryBox[l_Box_0];
		local v56 = l_Sync_0.Shop.Weapons[l_Box_0];
		v0.GUI.Main.Featured.Box.ItemFrame.ItemContainer.Container.ActionButton.MouseButton1Click:connect(function() --[[ Line: 150 ]]
			-- upvalues: v10 (ref), v0 (ref), l_Box_0 (copy), v55 (copy), v56 (copy)
			v10 = "Featured";
			v0.ViewBoxContents(l_Box_0, v55, v56);
		end);
		v0.GUI.Main.Featured.Box.Buy.MouseButton1Click:Connect(function() --[[ Line: 154 ]]
			-- upvalues: v10 (ref), v0 (ref), l_Box_0 (copy), v55 (copy), v56 (copy)
			v10 = "Featured";
			v0.ViewBoxContents(l_Box_0, v55, v56);
		end);
		for _, v58 in pairs(v0.GUI.Main.Featured.Box.ItemFrame.Price:GetChildren()) do
			if v58:IsA("Frame") then
				local l_Name_0 = v58.Name;
				v58.Visible = v56.Price[l_Name_0] ~= nil;
				v58.PriceFrame.PriceLabel.Text = v6.Commafy(v56.Price[l_Name_0] or 0);
			end;
		end;
	end;
	v0.GenerateFeaturedBox();
	v0.GUI.HotItemsContainer:ClearAllChildren();
	local v60 = (v0.GUI.HotItemLayout or l_HotItems_0.HotItemLayout):Clone();
	v60.Parent = v0.GUI.HotItemsContainer;
	local l_ItemSizer_0 = v0.GUI.HotItemsContainer.Parent.Parent:FindFirstChild("ItemSizer");
	if l_ItemSizer_0 then
		local l_CellSize_0 = v60.CellSize;
		v60.CellSize = UDim2.new(0, l_ItemSizer_0.AbsoluteSize.X, l_CellSize_0.Y.Scale, l_CellSize_0.Y.Offset);
	end;
	for v63, v64 in pairs(l_Featured_0.HotItems) do
		if v63 <= 4 then
			if v64.Type == "ItemPack" then
				local l_l_EventInfoService_0_CurrentItemPack_0 = l_EventInfoService_0:GetCurrentItemPack();
				if l_l_EventInfoService_0_CurrentItemPack_0 then
					local v66 = (v0.GUI.NewHotItem or l_HotItems_0.NewHotItem):Clone();
					v66.Container.Icon.Image = l_l_EventInfoService_0_CurrentItemPack_0.FeaturedIcon;
					v66.ItemName.Label.Text = "Item Pack";
					v66.Container.New.Visible = false;
					v66.Container.Limited.Visible = true;
					v66.Parent = v0.GUI.HotItemsContainer;
					v66.Container.ActionButton.Activated:Connect(function() --[[ Line: 198 ]]
						-- upvalues: l_WindowService_0 (ref)
						l_WindowService_0:AddToStack("ItemPack");
					end);
				end;
			elseif v64.Type == "EventFrame" then
				local l_l_EventInfoService_0_CurrentEvent_0 = l_EventInfoService_0:GetCurrentEvent();
				local v68 = (v0.GUI.NewHotItem or l_HotItems_0.NewHotItem):Clone();
				v68.Container.Icon.Image = l_l_EventInfoService_0_CurrentEvent_0.FeaturedIcon;
				v68.ItemName.Label.Text = "Evo Item";
				v68.Container.New.Visible = false;
				v68.Container.Limited.Visible = true;
				v68.Parent = v0.GUI.HotItemsContainer;
				v68.Container.ActionButton.Activated:Connect(function() --[[ Line: 211 ]]
					-- upvalues: l_WindowService_0 (ref), v64 (copy)
					l_WindowService_0:AddToStack("CurrentEvent", v64.ItemID);
				end);
			else
				local v69 = (v0.GUI.NewHotItem or l_HotItems_0.NewHotItem):Clone();
				local v70 = l_Sync_0[v64.Type][v64.ItemID];
				v6.DisplayItem(v69, v70);
				local v71 = l_Sync_0.Shop[v64.Type];
				if v71 then
					local v72 = v71[v64.ItemID];
					if v72 then
						if v72.Price then
							local v73 = v72.Price.Gems or v72.Price.Coins;
							if v73 then
								v69.Tags.Price.PriceFrame.Amount.Text = v6.Commafy(v73);
								v69.Tags.Price.Icon.Image = l_Sync_0.Currencies[v72.Price.Gems ~= nil and "Gems" or "Coins"];
								v69.Tags.Price.Visible = true;
							else
								v69.Tags.Price.Visible = false;
							end;
						end;
						v69.Container.ActionButton.MouseButton1Click:connect(function() --[[ Line: 239 ]]
							-- upvalues: l_Shop_0 (ref), v64 (copy), v0 (ref), v70 (copy), v72 (copy)
							local v74 = l_Shop_0[v64.Type][v64.ItemID].DataType or v64.Type;
							local l_Type_0 = v64.Type;
							v0.OpenBuyPopup(v64.ItemID, v70, v74, l_Type_0, v72);
						end);
					end;
				end;
				v69.Container.New.Visible = v70.New == true;
				v69.Parent = v0.GUI.HotItemsContainer;
			end;
		else
			break;
		end;
	end;
end;
v0.SelectItemToPurchase = function(v76, v77, v78, v79, v80) --[[ Line: 254 ]]
	-- upvalues: v6 (copy), l_ProfileData_0 (copy), l_Sync_0 (copy)
	local v81 = false;
	v6.DisplayItem(v76.ItemFrame.ItemContainer, v78);
	local l_Description_0 = v76.Description;
	local v83 = true;
	if v80.Description == nil then
		v83 = v78.Description ~= nil;
	end;
	l_Description_0.Visible = v83;
	v76.Description.TextLabel.Text = v80.Description or v78.Description or "";
	v76.BuyTitle.Visible = true;
	if v79 ~= "Weapons" and v79 ~= "Pets" and v79 ~= "MysteryBox" and v79 ~= "Eggs" and v79 ~= "Item" then
		if l_ProfileData_0[v79].Owned[v77] then
			l_Description_0 = true;
		else
			for _, v85 in l_ProfileData_0[v79].Owned do
				if v85 == v77 then
					l_Description_0 = true;
					v81 = true;
				end;
				if v81 then
					break;
				end;
			end;
			if not v81 then
				l_Description_0 = false;
			end;
		end;
	else
		l_Description_0 = false;
	end;
	v81 = false;
	for _, v87 in pairs(v76.PriceFrame:GetChildren()) do
		if l_Sync_0.Currencies[v87.Name] ~= nil then
			local l_Name_1 = v87.Name;
			v87.Visible = v80.Price[l_Name_1] ~= nil;
			v87.Container.PriceFrame.PriceLabel.Text = v80.Price[l_Name_1] and v6.Commafy(v80.Price[l_Name_1]) or "";
			v87.Buy.Style = (not not l_Description_0 or l_Name_1 == "Coins" and v80.Price.Coins ~= nil and l_ProfileData_0.Coins < v80.Price.Coins) and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton;
		end;
	end;
	v76.PriceFrame.BuyTitle.Title.Text = l_Description_0 and "OWNED" or "Buy It Now!";
	v83 = v76.PriceFrame.GetMoreGems;
	local v89 = false;
	if v80.Price.Gems ~= nil then
		v89 = false;
		if v80.Price.Coins == nil then
			v89 = l_ProfileData_0.Gems < (v80.Price and v80.Price.Gems or 0);
		end;
	end;
	v83.Visible = v89;
end;
local v90 = {};
v0.OpenBuyPopup = function(v91, v92, v93, v94, v95) --[[ Line: 277 ]]
	-- upvalues: v0 (copy), v90 (ref)
	v0.SelectItemToPurchase(v0.GUI.Main.BuyPopup.Container, v91, v92, v93, v95);
	v90 = {
		ItemID = v91, 
		ItemData = v92, 
		ItemType = v93, 
		ShopType = v94, 
		ItemShopData = v95
	};
	v0.GUI.Main.BuyPopup.Visible = true;
end;
local v96 = {};
v0.GenerateShopItems = function() --[[ Line: 295 ]]
	-- upvalues: l_Shop_0 (copy), v0 (copy), l_Sync_0 (copy), v6 (copy), l_ProfileData_0 (copy), v17 (copy), v10 (ref), l_EventInfoService_0 (copy), v96 (copy)
	local v97 = false;
	local v98 = false;
	local l_Attribute_0 = game.ReplicatedFirst:GetAttribute("CratesRestricted");
	for v100, v101 in pairs(l_Shop_0) do
		local l_ScrollFrame_0 = v0.GUI.Main[v100].ScrollFrame;
		l_ScrollFrame_0.Container:ClearAllChildren();
		local v103 = (v0.GUI.ShopItemLayout or script.ShopTabs.ItemGridLayout):Clone();
		v103.Parent = l_ScrollFrame_0.Container;
		v103:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 304 ]]
			-- upvalues: l_ScrollFrame_0 (copy), v103 (copy)
			l_ScrollFrame_0.CanvasSize = UDim2.new(0, 0, 0, v103.AbsoluteContentSize.Y + 5);
		end);
		local l_ItemSizer_1 = l_ScrollFrame_0:FindFirstChild("ItemSizer");
		if l_ItemSizer_1 then
			local l_CellSize_1 = v103.CellSize;
			v103.CellSize = UDim2.new(l_CellSize_1.X.Scale, l_CellSize_1.X.Offset, 0, l_ItemSizer_1.AbsoluteSize.Y);
		end;
		for v106, v107 in pairs(v101) do
			local v108 = v107.DataType or v100;
			local v109 = l_Sync_0[v108][v106];
			if v106 ~= "Key" or not l_Attribute_0 then
				local v110 = true;
				if v108 ~= "MysteryBox" then
					v110 = v108 == "Eggs";
				end;
				if v109 ~= nil then
					local v111 = script.ShopTabs.NewItem:Clone();
					v6.DisplayItem(v111, v109);
					v111.Container.Icon.SizeConstraint = v109.ImageRelative and Enum.SizeConstraint[v109.ImageRelative] or v111.Container.Icon.SizeConstraint;
					local v112;
					if v108 ~= "Weapons" and v108 ~= "Pets" and v108 ~= "MysteryBox" and v108 ~= "Eggs" and v108 ~= "Item" then
						if l_ProfileData_0[v108].Owned[v106] then
							v112 = true;
						else
							for _, v114 in l_ProfileData_0[v108].Owned do
								if v114 == v106 then
									v112 = true;
									v97 = true;
								end;
								if v97 then
									break;
								end;
							end;
							if not v97 then
								v112 = false;
							end;
						end;
					else
						v112 = false;
					end;
					v97 = false;
					if v112 then
						v111.Tags.Owned.Visible = true;
					else
						for v115, v116 in v107.Price do
							local l_FirstChild_0 = v111.Tags:FindFirstChild(v115);
							if l_FirstChild_0 then
								l_FirstChild_0.Container.PriceFrame.PriceLabel.Text = v6.Commafy(v116);
								l_FirstChild_0.Visible = true;
								if v110 and v17[v115] and l_Attribute_0 then
									l_FirstChild_0.Visible = false;
								end;
							end;
						end;
					end;
					v111.Container.ActionButton.MouseButton1Click:connect(function() --[[ Line: 347 ]]
						-- upvalues: v107 (copy), v10 (ref), v0 (ref), v106 (copy), v109 (copy), v108 (copy), v100 (copy)
						if v107.DataType == "MysteryBox" then
							v10 = "Weapons";
							v0.ViewBoxContents(v106, v109, v107);
							return;
						elseif v107.DataType == "Eggs" then
							v10 = "Pets";
							v0.ViewBoxContents(v106, v109, v107);
							return;
						else
							v0.OpenBuyPopup(v106, v109, v108, v100, v107);
							return;
						end;
					end);
					if v107.LiveEvent == true and not l_EventInfoService_0:IsEventActive() then
						v111.Visible = false;
						v111:AddTag("EventShopItem");
					end;
					v111.Parent = l_ScrollFrame_0.Container;
					local v118;
					if v108 ~= "Weapons" and v108 ~= "Pets" and v108 ~= "MysteryBox" and v108 ~= "Eggs" and v108 ~= "Item" then
						if l_ProfileData_0[v108].Owned[v106] then
							v118 = true;
						else
							for _, v120 in l_ProfileData_0[v108].Owned do
								if v120 == v106 then
									v118 = true;
									v98 = true;
								end;
								if v98 then
									break;
								end;
							end;
							if not v98 then
								v118 = false;
							end;
						end;
					else
						v118 = false;
					end;
					v98 = false;
					v112 = v118 and 20000 or 0;
					v111.LayoutOrder = (v107.LayoutOrder or v107.Price.Gems or v107.Price.Coins and v107.Price.Coins + 10000) + v112;
					v96[v100] = v96[v100] or {};
					v96[v100][v106] = {
						DataType = v100, 
						Frame = v111
					};
				end;
			end;
		end;
	end;
end;
v0.UpdateShopFrames = function() --[[ Line: 382 ]]
	-- upvalues: v96 (copy), l_ProfileData_0 (copy)
	local v121 = false;
	for v122, v123 in pairs(v96) do
		if v122 ~= "Weapons" and v122 ~= "Pets" then
			for v124, v125 in pairs(v123) do
				local v126;
				if v122 ~= "Weapons" and v122 ~= "Pets" and v122 ~= "MysteryBox" and v122 ~= "Eggs" and v122 ~= "Item" then
					if l_ProfileData_0[v122].Owned[v124] then
						v126 = true;
					else
						for _, v128 in l_ProfileData_0[v122].Owned do
							if v128 == v124 then
								v126 = true;
								v121 = true;
							end;
							if v121 then
								break;
							end;
						end;
						if not v121 then
							v126 = false;
						end;
					end;
				else
					v126 = false;
				end;
				v121 = false;
				if v126 then
					for _, v130 in pairs(v125.Frame.Tags:GetChildren()) do
						if v130:IsA("Frame") then
							v130.Visible = v130.Name == "Owned";
						end;
					end;
				end;
			end;
		end;
	end;
end;
v0.ViewBoxContents = function(v131, v132, v133) --[[ Line: 398 ]]
	-- upvalues: v0 (copy), v9 (ref), v11 (ref), v12 (ref), v13 (ref), v6 (copy), l_ProfileData_0 (copy), v17 (copy), l_Sync_0 (copy)
	local v134 = false;
	local l_Attribute_1 = game.ReplicatedFirst:GetAttribute("CratesRestricted");
	if v131 == "Christmas2019Box" then
		_G.ViewHalloweenBox();
		if game:GetService("UserInputService").GamepadEnabled then
			_G.ReturnToHWBox();
		end;
		return;
	else
		if _G.MobileDevice == "Phone" then
			for _, v137 in pairs(v0.GUI.Main:GetChildren()) do
				v137.Visible = v137.Name == "Weapons";
			end;
			v9 = "Weapons";
			if v0.GUI.ShopFrame.Title:FindFirstChild("Back") then
				v0.GUI.ShopFrame.Title.Back.Visible = true;
				v0.GUI.ShopFrame.Title.Title.Visible = false;
			end;
		end;
		v11 = v131;
		v12 = v132;
		v13 = v133;
		v9 = v132.BoxType;
		v6.DisplayItem(v0.GUI.ViewBoxFrame.BoxFrame.ItemContainer, v132);
		for v138, v139 in pairs(v132.RarityChances) do
			v0.GUI.ViewBoxFrame.BoxFrame.RarityFrame[v138].Chance.Text = v139 .. "%";
		end;
		local l_GetKeys_0 = v0.GUI.ViewBoxFrame.BuyFrame.GetKeys;
		local v141 = false;
		if v133.Price.Key ~= nil then
			v141 = not l_Attribute_1;
		end;
		l_GetKeys_0.Visible = v141;
		for _, v143 in v0.GUI.ViewBoxFrame.BuyFrame.PurchaseOptions.Container:GetChildren() do
			if v143:IsA("TextButton") then
				v143.Visible = v133.Price[v143.Name] ~= nil;
				local v144 = v6.Commafy(v133.Price[v143.Name] or 0);
				if tonumber(v144) == 1 then
					v144 = "x" .. v144;
				end;
				v143.Cost.Text = v144;
				if v143.Name == "Coins" then
					v143.Style = l_ProfileData_0.Coins >= (v133.Price[v143.Name] or 0) and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
				end;
				if v17[v143.Name] and l_Attribute_1 then
					v143.Visible = false;
				end;
			end;
		end;
		for _, v146 in pairs(v0.GUI.Main:GetChildren()) do
			v146.Visible = v146.Name == "ViewCrate";
		end;
		v0.GUI.Nav.Container[v9].NotSelected.Visible = false;
		v0.GUI.Nav.Container[v9].IsSelected.Visible = false;
		v0.GUI.Nav.Container[v9].Back.Visible = true;
		l_GetKeys_0 = v0.GUI.ViewBoxFrame.BoxContents:FindFirstChild("Container") or v0.GUI.ViewBoxFrame.BoxContents.ScrollingFrame.Container;
		l_GetKeys_0:ClearAllChildren();
		v141 = (v0.GUI.BoxContentsLayout or script.ViewBoxContents.BoxContentsLayout):Clone();
		v141.Parent = l_GetKeys_0;
		if l_GetKeys_0.Parent:IsA("ScrollingFrame") then
			v141:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 473 ]]
				-- upvalues: l_GetKeys_0 (copy), v141 (copy)
				l_GetKeys_0.Parent.CanvasSize = UDim2.new(0, 0, 0, v141.AbsoluteContentSize.Y + 5);
			end);
		end;
		local l_ItemSizer_2 = l_GetKeys_0.Parent:FindFirstChild("ItemSizer");
		if l_ItemSizer_2 then
			local l_CellSize_2 = v141.CellSize;
			v141.CellSize = UDim2.new(l_CellSize_2.X.Scale, l_CellSize_2.X.Offset, 0, l_ItemSizer_2.AbsoluteSize.Y);
		end;
		for v149, v150 in pairs(v132.Contents) do
			local v151 = (v0.GUI.NewBoxContent or script.ViewBoxContents.NewBoxContents):Clone();
			local v152 = l_Sync_0[v132.BoxType][v150];
			v6.DisplayItem(v151, v152);
			v151.LayoutOrder = v149;
			v151.Parent = l_GetKeys_0;
			local l_Owned_0 = v151.Tags.Owned;
			local l_BoxType_0 = v132.BoxType;
			local v155;
			if l_ProfileData_0[l_BoxType_0].Owned[v150] then
				v155 = true;
			else
				for _, v157 in l_ProfileData_0[l_BoxType_0].Owned do
					if v157 == v150 then
						v155 = true;
						v134 = true;
					end;
					if v134 then
						break;
					end;
				end;
				if not v134 then
					v155 = false;
				end;
			end;
			v134 = false;
			l_Owned_0.Visible = v155;
		end;
		return;
	end;
end;
v0.ViewBoxContentsXbox = function(v158, v159, v160) --[[ Line: 499 ]]
	-- upvalues: v11 (ref), v12 (ref), v13 (ref)
	v11 = v158;
	v12 = v159;
	v13 = v160;
end;
v0.ConnectNavButtons = function() --[[ Line: 509 ]]
	-- upvalues: v0 (copy), v9 (ref), v10 (ref)
	local v161 = {};
	for _, v163 in pairs(v0.GUI.Nav.Container:GetChildren()) do
		if v163:IsA("TextButton") then
			table.insert(v161, v163);
		end;
	end;
	v0.ResetNavButtons = function() --[[ Line: 513 ]]
		-- upvalues: v161 (copy)
		for _, v165 in pairs(v161) do
			v165.IsSelected.Visible = false;
			v165.NotSelected.Visible = true;
			v165.Back.Visible = false;
		end;
	end;
	v0.ViewFeatured = function() --[[ Line: 521 ]]
		-- upvalues: v0 (ref), v9 (ref)
		v0.ResetNavButtons();
		for _, v167 in pairs(v0.GUI.Main:GetChildren()) do
			v167.Visible = v167.Name == "Featured";
		end;
		v9 = "Featured";
	end;
	for _, v169 in pairs(v161) do
		v169.MouseButton1Click:connect(function() --[[ Line: 530 ]]
			-- upvalues: v9 (ref), v169 (copy), v161 (copy), v0 (ref), v10 (ref)
			if v9 ~= v169.Name then
				for _, v171 in pairs(v161) do
					v171.IsSelected.Visible = v171 == v169;
					v171.NotSelected.Visible = v171 ~= v169;
					v171.Back.Visible = false;
				end;
				for _, v173 in pairs(v0.GUI.Main:GetChildren()) do
					v173.Visible = v173.Name == v169.Name;
				end;
				v9 = v169.Name;
				return;
			elseif v0.GUI.ViewBoxFrame.Parent.Visible == true then
				if v10 == "Weapons" or v10 == "Pets" then
					v169.Back.Visible = false;
					v169.IsSelected.Visible = true;
					for _, v175 in pairs(v0.GUI.Main:GetChildren()) do
						v175.Visible = v175.Name == v10;
					end;
					return;
				else
					v0.ViewFeatured();
					return;
				end;
			else
				v0.ViewFeatured();
				return;
			end;
		end);
	end;
	if v0.GUI.ShopFrame.Title:FindFirstChild("Back") then
		v0.GUI.ShopFrame.Title.Back.Visible = true;
		v0.GUI.ShopFrame.Title.Title.Visible = false;
	end;
end;
v0.ConnectNavButtonsPhone = function() --[[ Line: 567 ]]
	-- upvalues: v0 (copy), v9 (ref)
	local v176 = {};
	for _, v178 in pairs(v0.GUI.Nav.Container:GetChildren()) do
		if v178:IsA("TextButton") then
			table.insert(v176, v178);
		end;
	end;
	v0.ResetNavButtons = function() --[[ Line: 571 ]]

	end;
	for _, v180 in pairs(v176) do
		v180.MouseButton1Click:connect(function() --[[ Line: 574 ]]
			-- upvalues: v0 (ref), v180 (copy), v9 (ref)
			for _, v182 in pairs(v0.GUI.Main:GetChildren()) do
				v182.Visible = v182.Name == v180.Name;
			end;
			v9 = v180.Name;
			if v0.GUI.ShopFrame.Title:FindFirstChild("Back") then
				v0.GUI.ShopFrame.Title.Back.Visible = true;
				v0.GUI.ShopFrame.Title.Title.Visible = false;
			end;
		end);
	end;
	v0.GUI.ShopFrame.Title.Gems.More.MouseButton1Click:connect(function() --[[ Line: 586 ]]
		-- upvalues: v0 (ref)
		v0.GUI.ShopFrame.Title.Back.Visible = true;
		v0.GUI.ShopFrame.Title.Title.Visible = false;
	end);
	v0.GUI.ShopFrame.Title.Gems.GetMore.MouseButton1Click:connect(function() --[[ Line: 590 ]]
		-- upvalues: v0 (ref)
		v0.GUI.ShopFrame.Title.Back.Visible = true;
		v0.GUI.ShopFrame.Title.Title.Visible = false;
	end);
end;
v0.PurchaseBox = function(v183, v184, v185) --[[ Line: 599 ]]
	-- upvalues: v0 (copy)
	if v184.BoxType == "Pets" then
		v0.PurchaseEgg(v183, v184, v185);
		return;
	else
		v0.GUI.ShopFrame.Visible = false;
		_G.Process("Unboxing");
		local v186 = time();
		local v187 = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer(v183, "MysteryBox", v185);
		wait(0.75 - (time() - v186));
		v0.GUI.Processing.Visible = false;
		if v187 then
			game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(v183, v187);
		end;
		return;
	end;
end;
v0.PurchaseEgg = function(v188, _, v190) --[[ Line: 627 ]]
	-- upvalues: v0 (copy)
	v0.GUI.ShopFrame.Visible = false;
	_G.Process("Unboxing");
	local v191 = time();
	local v192 = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer(v188, "Eggs", v190);
	wait(0.75 - (time() - v191));
	v0.GUI.Processing.Visible = false;
	if v192 then
		game.ReplicatedStorage.Remotes.Shop.EggController:Fire(v188, v192);
	end;
end;
v0.ConnectViewBoxFrame = function() --[[ Line: 649 ]]
	-- upvalues: l_PurchaseOption_0 (ref), v0 (copy), l_Sync_0 (copy), l_ProfileData_0 (copy), l_Remotes_0 (copy), v20 (copy), v13 (ref), v11 (ref), v12 (ref)
	local l_Attribute_2 = game.ReplicatedFirst:GetAttribute("CratesRestricted");
	if game.Players.LocalPlayer.PlayerGui:GetAttribute("Device") == "Phone" then
		l_PurchaseOption_0 = script:WaitForChild("PurchaseOptionPhone");
	end;
	if not l_Attribute_2 then
		v0.GUI.ViewBoxFrame.BuyFrame.GetKeys.MouseButton1Click:connect(function() --[[ Line: 657 ]]
			-- upvalues: v0 (ref), l_Sync_0 (ref)
			v0.OpenBuyPopup("Key", l_Sync_0.Weapons.Key, "Item", "Weapons", l_Sync_0.Shop.Weapons.Key);
		end);
	end;
	v0.GUI.ViewBoxFrame.BuyFrame.GetKeys.Amount.Text = "You have " .. (l_ProfileData_0.Weapons.Owned.Key or 0) .. " Keys";
	l_Remotes_0:WaitForChild("Inventory"):WaitForChild("InventoryDataChanged").Event:Connect(function(_, v195, _) --[[ Line: 668 ]]
		-- upvalues: v0 (ref), l_ProfileData_0 (ref)
		if v195 ~= "Key" then
			return;
		else
			v0.GUI.ViewBoxFrame.BuyFrame.GetKeys.Amount.Text = "You have " .. (l_ProfileData_0.Weapons.Owned.Key or 0) .. " Keys";
			return;
		end;
	end);
	local l_Container_0 = v0.GUI.ViewBoxFrame.BuyFrame.PurchaseOptions.Container;
	for _, v199 in l_Container_0:GetChildren() do
		if v199:IsA("TextButton") then
			v199:Destroy();
		end;
	end;
	for v200, v201 in v20 do
		local v202 = l_PurchaseOption_0:Clone();
		v202.Icon.Image = v201.Icon;
		v202.Title.Text = v201.DisplayName;
		v202.Name = v200;
		v202.Parent = l_Container_0;
		v202.Activated:Connect(function() --[[ Line: 689 ]]
			-- upvalues: l_ProfileData_0 (ref), v200 (copy), v13 (ref), v0 (ref), v11 (ref), v12 (ref)
			if (l_ProfileData_0[v200] or l_ProfileData_0.Materials.Owned[v200] or l_ProfileData_0.Weapons.Owned[v200] or 0) >= v13.Price[v200] then
				v0.PurchaseBox(v11, v12, v200);
				_G.LastShopSelection = v0.GUI.ViewBoxFrame.BuyFrame.PurchaseOptions.Container[v200];
				return;
			else
				return;
			end;
		end);
	end;
end;
v0.ConnectBuyPopup = function() --[[ Line: 802 ]]
	-- upvalues: v0 (copy), v20 (copy), l_PurchaseOptionFrame_0 (copy), v90 (ref), l_Shop_0 (copy), l_ProfileData_0 (copy)
	local l_PriceFrame_0 = v0.GUI.Main.BuyPopup.Container.PriceFrame;
	for _, v205 in l_PriceFrame_0:GetChildren() do
		if v205.Name ~= "BuyTitle" and v205.Name ~= "GetMoreGems" and v205.Name ~= "PurchaseLoading" and v205:IsA("Frame") then
			v205:Destroy();
		end;
	end;
	for v206, v207 in v20 do
		local v208 = l_PurchaseOptionFrame_0:Clone();
		v208.Container.Icon.Image = v207.Icon;
		v208.Name = v206;
		v208.Parent = l_PriceFrame_0;
		v208.Buy.Activated:Connect(function() --[[ Line: 818 ]]
			-- upvalues: v90 (ref), v0 (ref), v206 (copy)
			if v90 then
				v0.BuyItem(v90.ItemID, v90.ShopType, v206, v0.GUI.Main.BuyPopup.Container);
				v0.GUI.Main.BuyPopup.Visible = false;
			end;
		end);
	end;
	v0.GUI.Main.BuyPopup.Container.Close.MouseButton1Click:connect(function() --[[ Line: 827 ]]
		-- upvalues: v0 (ref)
		v0.GUI.Main.BuyPopup.Visible = false;
	end);
	v0.GUI.Main.BuyPopup.Container.PriceFrame.GetMoreGems.Buy.MouseButton1Click:connect(function() --[[ Line: 873 ]]
		-- upvalues: v90 (ref), l_Shop_0 (ref), v0 (ref), l_ProfileData_0 (ref)
		local l_ShopType_0 = v90.ShopType;
		local l_ItemID_0 = v90.ItemID;
		local l_Price_1 = l_Shop_0[l_ShopType_0][l_ItemID_0].Price;
		v0.ViewGems(l_Price_1.Gems - l_ProfileData_0.Gems);
	end);
end;
v0.HighlightGem = function(v212) --[[ Line: 883 ]]
	-- upvalues: v0 (copy)
	if v212 ~= nil then
		local l_Children_0 = v0.GUI.Main.Gems:GetChildren();
		table.sort(l_Children_0, function(v214, v215) --[[ Line: 886 ]]
			return tonumber(v214.Name) < tonumber(v215.Name);
		end);
		for _, v217 in pairs(l_Children_0) do
			local v218 = tonumber(v217.Name);
			if v212 <= v218 then
				print("RQ", v218, v212);
				spawn(function() --[[ Line: 891 ]]
					-- upvalues: v217 (copy)
					local l_Position_0 = v217.Position;
					wait(0.1);
					v217:TweenPosition(UDim2.new(v217.Position.X.Scale, v217.Position.X.Offset, v217.Position.Y.Scale, v217.Position.Y.Offset - 30), "Out", "Sine", 0.3);
					wait(0.31);
					v217:TweenPosition(UDim2.new(v217.Position.X.Scale, v217.Position.X.Offset, v217.Position.Y.Scale, v217.Position.Y.Offset + 30), "In", "Sine", 0.3);
					wait(0.31);
					v217.Position = l_Position_0;
				end);
				return;
			end;
		end;
	end;
end;
v0.ViewGems = function(v220) --[[ Line: 916 ]]
	-- upvalues: v0 (copy), v9 (ref)
	v0.ResetNavButtons();
	for _, v222 in pairs(v0.GUI.Main:GetChildren()) do
		v222.Visible = v222.Name == "Gems";
	end;
	v9 = "Gems";
	v0.HighlightGem(v220);
end;
v0.ConnectGems = function() --[[ Line: 924 ]]
	-- upvalues: v0 (copy)
	for _, v224 in pairs(v0.GUI.Main.Gems:GetChildren()) do
		v224.MouseButton1Click:connect(function() --[[ Line: 926 ]]
			-- upvalues: v224 (copy)
			script.Click:Play();
			game.ReplicatedStorage.Remotes.Shop.PurchaseProduct:FireServer(v224.Name, "Gems");
		end);
	end;
	v0.GUI.Title.Gems.GetMore.MouseButton1Click:connect(function() --[[ Line: 931 ]]
		-- upvalues: v0 (ref)
		v0.ViewGems();
	end);
end;
l_EventInfoService_0:OnEventStarted(function() --[[ Line: 937 ]] --[[ Name: onEventStarted ]]
	for _, v226 in game:GetService("CollectionService"):GetTagged("EventShopItem") do
		v226.Visible = true;
	end;
end);
return v0;