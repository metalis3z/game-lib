-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v4 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v5 = require(l_ReplicatedStorage_0.Packages.Observers);
local v6 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v7 = require(l_ReplicatedStorage_0.Packages.FFlags);
local v8 = require(l_ReplicatedStorage_0.Packages.Timer);
local v9 = require(l_ReplicatedStorage_0.Packages.Trove);
local v10 = require(l_ReplicatedStorage_0.Packages.Net);
local v11 = require(l_ReplicatedStorage_0.Packages.Spr);
local v12 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v13 = require(l_ReplicatedStorage_0.Shared.Animals);
local v14 = require(l_ReplicatedStorage_0.Shared.Mutations);
local v15 = require(l_ReplicatedStorage_0.Shared.Marketplace);
local v16 = require(l_ReplicatedStorage_0.Shared.UsersAPI);
local v17 = require(l_ReplicatedStorage_0.Shared.Friends);
local v18 = require(l_ReplicatedStorage_0.Shared.Updates);
local v19 = require(l_ReplicatedStorage_0.Shared.Policy);
local v20 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v21 = require(l_ReplicatedStorage_0.Datas.ValentinesShop);
local v22 = require(l_ReplicatedStorage_0.Datas.LuckyBlocks);
local v23 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v24 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v25 = require(l_ReplicatedStorage_0.Datas.Animals);
local v26 = require(l_ReplicatedStorage_0.Datas.Mutations);
local v27 = require(l_ReplicatedStorage_0.Datas.Shop);
local v28 = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local v29 = require(l_ReplicatedStorage_0.Controllers.CornerNotificationController);
local v30 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v31 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v32 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v33 = require(l_ReplicatedStorage_0.Controllers.ShopController);
local v34 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v37 = v10:RemoteFunction("ValentinesShopService/SearchUser");
local v38 = v10:RemoteFunction("ValentinesShopService/OpenGift");
local v39 = v10:RemoteFunction("ValentinesShopService/Gift");
local v40 = v10:RemoteEvent("ValentinesShopService/GiftNotify");
local l_ValentinesShop_0 = l_PlayerGui_0:WaitForChild("ValentinesShop").ValentinesShop;
local l_List_0 = l_ValentinesShop_0.Sections.Send.List;
local l_ValentinesSendGift_0 = l_PlayerGui_0:WaitForChild("ValentinesSendGift").ValentinesSendGift;
local l_ValentinesCard_0 = l_PlayerGui_0:WaitForChild("ValentinesCard"):WaitForChild("ValentinesCard");
local v45 = nil;
local v46 = nil;
local v47 = {};
local _ = function(v48) --[[ Line: 70 ]] --[[ Name: getFailedGiftKeyFromDiscounted ]]
	-- upvalues: v21 (copy)
	for _, v50 in v21.Products do
		if v50.discountedProductId == v48 then
			return v50.failedGiftKey or tostring(v48);
		end;
	end;
	return (tostring(v48));
end;
local v52 = nil;
local v53 = nil;
local v54 = nil;
local function v64() --[[ Line: 90 ]] --[[ Name: updateSelectedProductUI ]]
	-- upvalues: v7 (copy), l_ValentinesSendGift_0 (copy), v54 (ref), v53 (ref), v27 (copy), v47 (copy), v14 (copy), v13 (copy), v15 (copy), v33 (copy)
	local v55 = if not v7:GetInstant("ValentinesShop/MessagesDisabled", true) then l_ValentinesSendGift_0.RightMessage else l_ValentinesSendGift_0.Right;
	if not v7:GetInstant("ValentinesShop/MessagesDisabled", true) then
		l_ValentinesSendGift_0.RightMessage.Visible = true;
		l_ValentinesSendGift_0.Right.Visible = false;
	else
		l_ValentinesSendGift_0.RightMessage.Visible = false;
		l_ValentinesSendGift_0.Right.Visible = true;
	end;
	if v54 then
		v54:Destroy();
		v54 = nil;
	end;
	local l_BrainrotViewport_0 = v55.Box.Item:FindFirstChild("BrainrotViewport");
	if l_BrainrotViewport_0 then
		l_BrainrotViewport_0:Destroy();
	end;
	v55.Cost.Text = "???";
	if v53 then
		local v57 = v27[v53.rawId];
		v47:BindLabelToProductPrice(v55.Cost, v53.remappedId, "Product");
		v55.Title.Text = v57 and v57.Display or "???";
		if v57 and (v57.Type == "LuckyBlock" or v57.Type == "Brainrot") and v57.Value then
			v55.Box.Item.Image = "";
			local v58 = if typeof(v57.Value) == "table" then v57.Value[1] else v57.Value;
			local l_ViewportFrame_0 = Instance.new("ViewportFrame");
			l_ViewportFrame_0.Name = "BrainrotViewport";
			l_ViewportFrame_0.Size = UDim2.fromScale(1, 1);
			l_ViewportFrame_0.Position = UDim2.fromScale(0.5, 0.5);
			l_ViewportFrame_0.AnchorPoint = Vector2.new(0.5, 0.5);
			l_ViewportFrame_0.BackgroundTransparency = 1;
			l_ViewportFrame_0.Parent = v55.Box.Item;
			local v60 = v14.get();
			local v61 = v13:AttachOnViewport(v58, l_ViewportFrame_0, true, v60);
			if v61 then
				v54 = v61;
				return;
			end;
		elseif v57 and v57.Icon then
			v55.Box.Item.Image = v57.Icon;
			return;
		else
			task.spawn(function() --[[ Line: 144 ]]
				-- upvalues: v53 (ref), v15 (ref), v55 (copy)
				local l_v53_0 = v53;
				local l_v15_ProductInfo_0 = v15:GetProductInfo(v53.rawId, "Product");
				if not l_v15_ProductInfo_0 then
					return;
				elseif v53 ~= l_v53_0 then
					return;
				else
					v55.Box.Item.Image = l_v15_ProductInfo_0.Icon or "";
					return;
				end;
			end);
			return;
		end;
	else
		v33:UnbindLabelProductPrice(v55.Cost);
		v55.Title.Text = "NONE";
		v55.Box.Item.Image = "";
	end;
end;
local function v66(v65) --[[ Line: 166 ]] --[[ Name: setSelectedProduct ]]
	-- upvalues: v53 (ref), v64 (copy), v21 (copy), v47 (copy)
	if v65 == nil then
		v53 = nil;
		v64();
		return true;
	elseif not v21.Products[v65] then
		return false;
	else
		v53 = {
			remappedId = v47:GetProductId(v65), 
			rawId = v65
		};
		v64();
		return true;
	end;
end;
local function _(v67) --[[ Line: 186 ]] --[[ Name: setSelectedUser ]]
	-- upvalues: v52 (ref)
	local l_v52_0 = v52;
	v52 = v67;
	if l_v52_0 and l_v52_0.card and l_v52_0.card.Parent then
		local l_Fill_0 = l_v52_0.card:FindFirstChild("Fill");
		if l_Fill_0 then
			l_Fill_0.BackgroundColor3 = Color3.fromRGB(255, 189, 240);
		end;
	end;
end;
local function v77(v71, v72) --[[ Line: 199 ]] --[[ Name: renderBrainrotAtFrame ]]
	-- upvalues: v25 (copy), v9 (copy), v24 (copy), v6 (copy), v13 (copy)
	local v73 = v25[v72];
	if not v73 then
		return nil;
	else
		local v74 = v9.new();
		local v75 = v24[v73.Rarity];
		v71.Title.Text = v72;
		v71.UIStroke.Color = Color3.new(0, 0, 0);
		if v75.GradientPreset then
			v71.Title.TextColor3 = Color3.new(1, 1, 1);
			v74:Add(v6.apply(v71.Title, v75.GradientPreset));
		else
			v71.Title.TextColor3 = v75.Color;
		end;
		v71.Visible = true;
		local v76 = v13:AttachOnViewportWithOptimizations(v72, v71.ViewportFrame, true);
		if v76 then
			v74:Add(v76);
		end;
		return v74;
	end;
end;
local v78 = false;
v47.OpenAnimation = function(_, v80) --[[ Line: 230 ]] --[[ Name: OpenAnimation ]]
	-- upvalues: v78 (ref), v20 (copy), l_ValentinesCard_0 (copy), v16 (copy), v9 (copy), v21 (copy), v27 (copy), v77 (copy), v13 (copy), v53 (ref), v15 (copy), v32 (copy), l_ReplicatedStorage_0 (copy)
	while v78 do
		task.wait();
	end;
	v78 = true;
	local v81 = true;
	v20(l_ValentinesCard_0.Parent.Frame, TweenInfo.new(0.25), {
		BackgroundTransparency = 0.5
	});
	l_ValentinesCard_0.bgbtmback.ImageTransparency = 0;
	l_ValentinesCard_0.bgbtmfront.ImageTransparency = 0;
	l_ValentinesCard_0.CardInside.ZIndex = 1;
	l_ValentinesCard_0.bgtopseal.Visible = true;
	l_ValentinesCard_0.bgtopseal.Position = UDim2.fromScale(0.5, 0.486);
	l_ValentinesCard_0.bgtopseal.HeartSeal.Position = UDim2.fromScale(0.5, 0.5);
	l_ValentinesCard_0.bgtopseal.HeartSeal.ImageTransparency = 0;
	l_ValentinesCard_0.Visible = false;
	l_ValentinesCard_0.Position = UDim2.fromScale(0.5, 2);
	local l_Message_0 = l_ValentinesCard_0.CardInside:FindFirstChild("Message");
	if l_Message_0 then
		l_Message_0.Text = "";
		l_Message_0.Visible = false;
	end;
	l_ValentinesCard_0.bgtopseal.Title.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v80.Sender);
	if v80.SenderUsername then
		l_ValentinesCard_0.bgtopseal.Title.User.Text = ("@%*"):format(v80.SenderUsername);
	else
		l_ValentinesCard_0.bgtopseal.Title.User.Text = "???";
		task.spawn(function() --[[ Line: 270 ]]
			-- upvalues: v16 (ref), v80 (copy), v81 (ref), l_ValentinesCard_0 (ref)
			local l_v16_User_0 = v16:GetUser(v80.Sender);
			if l_v16_User_0 and v81 then
				l_ValentinesCard_0.bgtopseal.Title.User.Text = ("@%*"):format(l_v16_User_0.Username);
			end;
		end);
	end;
	local v84 = v80.GiftType or "purchased";
	local v85 = "Gift";
	local v86 = nil;
	local v87 = nil;
	local v88 = v9.new();
	if v84 == "purchased" then
		local v89 = nil;
		for v90, v91 in v21.Products do
			if v80.ProductId == v91.discountedProductId then
				v89 = v27[v90];
				break;
			end;
		end;
		if v89 then
			v85 = v89.Display;
			if (v89.Type == "LuckyBlock" or v89.Type == "Brainrot") and v89.Value then
				v87 = if typeof(v89.Value) == "table" then v89.Value[1] else v89.Value;
			else
				v86 = v89.Icon;
			end;
		end;
	elseif v84 == "pool" then
		v85 = v80.RewardName or "Mystery Gift";
	elseif v84 == "brainrot" then
		v85 = v80.RewardName or v80.BrainrotName or "Special Gift";
		l_ValentinesCard_0.CardInside.Box.Visible = false;
		l_ValentinesCard_0.CardInside.BoxBrainrot.Visible = true;
		v88:Add(function() --[[ Line: 312 ]]
			-- upvalues: l_ValentinesCard_0 (ref)
			l_ValentinesCard_0.CardInside.BoxBrainrot.Visible = false;
			l_ValentinesCard_0.CardInside.Box.Visible = true;
		end);
		local v92 = v77(l_ValentinesCard_0.CardInside.BoxBrainrot, v80.RewardName or v80.BrainrotName);
		if v92 then
			v88:Add(v92);
		end;
	end;
	l_ValentinesCard_0.CardInside.Box.Title.Text = v85;
	local l_Item_0 = l_ValentinesCard_0.CardInside.Box.Item;
	local l_BrainrotViewport_1 = l_Item_0:FindFirstChild("BrainrotViewport");
	if l_BrainrotViewport_1 then
		l_BrainrotViewport_1:Destroy();
	end;
	l_Item_0.Image = "";
	if v87 then
		local v95 = v88:Add(Instance.new("ViewportFrame"));
		v95.Name = "BrainrotViewport";
		v95.Size = UDim2.fromScale(1, 1);
		v95.Position = UDim2.fromScale(0.5, 0.5);
		v95.AnchorPoint = Vector2.new(0.5, 0.5);
		v95.BackgroundTransparency = 1;
		v95.Parent = l_Item_0;
		local l_Mutation_0 = v80.Mutation;
		local v97 = v13:AttachOnViewport(v87, v95, true, l_Mutation_0);
		if v97 then
			v88:Add(v97);
		end;
	elseif v86 then
		l_Item_0.Image = v86;
	elseif v84 == "purchased" and v80.ProductId then
		local v98 = nil;
		for v99, v100 in v21.Products do
			if v80.ProductId == v100.discountedProductId then
				v98 = v99;
				break;
			end;
		end;
		do
			local l_v98_0 = v98;
			task.spawn(function() --[[ Line: 359 ]]
				-- upvalues: v53 (ref), v15 (ref), l_v98_0 (ref), v80 (copy), l_Item_0 (copy)
				local l_v53_1 = v53;
				local l_v15_ProductInfo_1 = v15:GetProductInfo(l_v98_0 or v80.ProductId, "Product");
				if not l_v15_ProductInfo_1 then
					return;
				elseif v53 ~= l_v53_1 then
					return;
				else
					l_Item_0.Image = l_v15_ProductInfo_1.Icon or "";
					return;
				end;
			end);
		end;
	elseif (v84 == "pool" or v84 == "brainrot") and (v80.RewardName or v80.BrainrotName) then
		local v104 = v80.RewardName or v80.BrainrotName;
		local v105 = v88:Add(Instance.new("ViewportFrame"));
		v105.Name = "BrainrotViewport";
		v105.Size = UDim2.fromScale(1, 1);
		v105.Position = UDim2.fromScale(0.5, 0.5);
		v105.AnchorPoint = Vector2.new(0.5, 0.5);
		v105.BackgroundTransparency = 1;
		v105.Parent = l_Item_0;
		local v106 = v13:AttachOnViewport(v104, v105, true, v80.Mutation);
		if v106 then
			v88:Add(v106);
		end;
	end;
	if v80.Message and typeof(v80.Message) == "string" and #v80.Message > 0 then
		local l_Message_1 = l_ValentinesCard_0.CardInside:FindFirstChild("Message");
		if l_Message_1 then
			l_Message_1.Text = v80.Message;
			l_Message_1.Visible = true;
		end;
	end;
	task.wait(0.5);
	l_ValentinesCard_0.Visible = true;
	v20(l_ValentinesCard_0, TweenInfo.new(0.75), {
		Position = UDim2.fromScale(0.5, 0.5)
	});
	task.wait(0.75);
	v32:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx.ValentinesLetter, nil, false);
	v20(l_ValentinesCard_0.bgtopseal.HeartSeal, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Position = UDim2.fromScale(0.5, 2)
	});
	task.wait(0.8);
	l_ValentinesCard_0.bgtopseal.HeartSeal.ImageTransparency = 1;
	v20(l_ValentinesCard_0.bgtopseal, TweenInfo.new(1, Enum.EasingStyle.Quad), {
		Position = UDim2.fromScale(0.5, -1)
	});
	task.wait(0.6);
	v20(l_ValentinesCard_0.CardInside, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		Position = UDim2.fromScale(0.5, -0.4)
	});
	task.wait(0.3);
	l_ValentinesCard_0.bgtopseal.Visible = false;
	l_ValentinesCard_0.CardInside.ZIndex = 20;
	v20(l_ValentinesCard_0.CardInside, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		Position = UDim2.fromScale(0.5, 0.5)
	});
	l_ValentinesCard_0.CardInside.Close.Activated:Once(function() --[[ Line: 447 ]]
		-- upvalues: v20 (ref), l_ValentinesCard_0 (ref), v88 (copy), v78 (ref), v81 (ref)
		v20(l_ValentinesCard_0.Parent.Frame, TweenInfo.new(0.25), {
			BackgroundTransparency = 1
		});
		v20(l_ValentinesCard_0, TweenInfo.new(0.5), {
			Position = UDim2.fromScale(0.5, 2)
		});
		task.wait(1);
		v88:Destroy();
		v78 = false;
		v81 = false;
	end);
	task.delay(1, function() --[[ Line: 465 ]]
		-- upvalues: v20 (ref), l_ValentinesCard_0 (ref)
		v20(l_ValentinesCard_0.bgbtmback, TweenInfo.new(0.5), {
			ImageTransparency = 1
		});
		v20(l_ValentinesCard_0.bgbtmfront, TweenInfo.new(0.5), {
			ImageTransparency = 1
		});
	end);
end;
v47._createRightFrame = function(_) --[[ Line: 476 ]] --[[ Name: _createRightFrame ]]
	-- upvalues: v7 (copy), v64 (copy), l_ValentinesSendGift_0 (copy), v52 (ref), v30 (copy), v53 (ref), v39 (copy), v31 (copy), l_TextService_0 (copy)
	local v109 = nil;
	v7:OnUpdate(function() --[[ Line: 478 ]]
		-- upvalues: v7 (ref), v109 (ref), v64 (ref)
		local v110 = not v7:GetInstant("ValentinesShop/MessagesDisabled", true);
		if v109 ~= v110 then
			v109 = v110;
			v64();
		end;
	end);
	local l_TextBox_0 = l_ValentinesSendGift_0.RightMessage.Frame.ScrollingFrame.TextBox;
	if l_TextBox_0 then
		l_TextBox_0.TextSize = 22;
	end;
	local v112 = false;
	local function v116() --[[ Line: 492 ]] --[[ Name: buy ]]
		-- upvalues: v112 (ref), v52 (ref), v30 (ref), v53 (ref), l_TextBox_0 (copy), v7 (ref), l_ValentinesSendGift_0 (ref), v39 (ref), v31 (ref)
		if v112 then
			return;
		elseif not v52 then
			v30:Error("You need to select a user to send a gift to!");
			return;
		elseif not v53 then
			return;
		else
			local v113 = nil;
			if l_TextBox_0 then
				local v114 = string.gsub(l_TextBox_0.Text, "^%s+", "");
				v114 = string.gsub(v114, "%s+$", "");
				if #v114 > 0 then
					v113 = v114;
				end;
			end;
			local v115 = if v7:GetInstant("ValentinesShop/MessagesDisabled", true) then l_ValentinesSendGift_0.RightMessage else l_ValentinesSendGift_0.Right;
			if v7:GetInstant("ValentinesShop/MessagesDisabled", true) then
				v113 = nil;
			end;
			v112 = true;
			v115.Buy.BackgroundColor3 = Color3.fromRGB(115, 152, 172);
			v115.Buy.Price.Text = "...";
			pcall(function() --[[ Line: 528 ]]
				-- upvalues: v39 (ref), v53 (ref), v52 (ref), v113 (ref), l_TextBox_0 (ref), v31 (ref)
				if v39:InvokeServer(v53.rawId, v52.user.userId, v113) then
					if l_TextBox_0 then
						l_TextBox_0.Text = "";
					end;
					v31:SetState("ValentinesSendGift", false);
					v31:SetState("ValentinesShop", true);
				end;
			end);
			v115.Buy.BackgroundColor3 = Color3.fromRGB(81, 158, 86);
			v115.Buy.Price.Text = "GIFT";
			v112 = false;
			return;
		end;
	end;
	l_ValentinesSendGift_0.RightMessage.Buy.Activated:Connect(v116);
	l_ValentinesSendGift_0.Right.Buy.Activated:Connect(v116);
	if l_TextBox_0 then
		local l_Parent_0 = l_TextBox_0.Parent;
		local l_GetTextBoundsParams_0 = Instance.new("GetTextBoundsParams");
		l_GetTextBoundsParams_0.Size = l_TextBox_0.TextSize;
		l_GetTextBoundsParams_0.Font = l_TextBox_0.FontFace;
		l_GetTextBoundsParams_0.Width = l_TextBox_0.AbsoluteSize.X;
		local function v127() --[[ Line: 558 ]] --[[ Name: updateTextBoxSize ]]
			-- upvalues: l_TextBox_0 (copy), l_GetTextBoundsParams_0 (copy), l_TextService_0 (ref), l_Parent_0 (copy)
			local l_Text_0 = l_TextBox_0.Text;
			if utf8.len(l_Text_0) and utf8.len(l_Text_0) > 60 then
				local v120 = 0;
				local v121 = 0;
				for v122, _ in utf8.codes(l_Text_0) do
					v120 = v120 + 1;
					if v120 <= 60 then
						v121 = v122;
					else
						break;
					end;
				end;
				if v121 > 0 then
					l_TextBox_0.Text = string.sub(l_Text_0, 1, (utf8.offset(l_Text_0, 2, v121) or #l_Text_0 + 1) - 1);
				end;
				return;
			else
				l_GetTextBoundsParams_0.Text = l_TextBox_0.Text;
				if #l_TextBox_0.Text == 0 then
					l_GetTextBoundsParams_0.Text = l_TextBox_0.PlaceholderText or " ";
				end;
				l_GetTextBoundsParams_0.Width = l_TextBox_0.AbsoluteSize.X;
				local l_status_0, l_result_0 = pcall(function() --[[ Line: 586 ]]
					-- upvalues: l_TextService_0 (ref), l_GetTextBoundsParams_0 (ref)
					return l_TextService_0:GetTextBoundsAsync(l_GetTextBoundsParams_0);
				end);
				if l_status_0 and l_result_0 then
					local v126 = math.max(l_result_0.Y + 10, l_TextBox_0.TextSize + 10);
					l_TextBox_0.Size = UDim2.new(0.975, 0, 0, v126);
					if l_Parent_0 then
						l_Parent_0.CanvasSize = UDim2.new(0, 0, 0, v126);
						if l_TextBox_0.CursorPosition > 0 then
							l_Parent_0.CanvasPosition = Vector2.new(0, l_Parent_0.AbsoluteCanvasSize.Y);
						end;
					end;
				end;
				return;
			end;
		end;
		l_TextBox_0:GetPropertyChangedSignal("Text"):Connect(v127);
		l_TextBox_0:GetPropertyChangedSignal("CursorPosition"):Connect(function() --[[ Line: 606 ]]
			-- upvalues: l_TextBox_0 (copy), l_Parent_0 (copy)
			if l_TextBox_0.CursorPosition > 0 and l_Parent_0 then
				l_Parent_0.CanvasPosition = Vector2.new(0, l_Parent_0.AbsoluteCanvasSize.Y);
			end;
		end);
		task.spawn(v127);
	end;
	return nil;
end;
v47._createGiftsTab = function(_) --[[ Line: 618 ]] --[[ Name: _createGiftsTab ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), l_ValentinesShop_0 (copy), v16 (copy), v12 (copy), v38 (copy), v47 (copy)
	local v129 = v4:Wait(l_LocalPlayer_0);
	if not v129 then
		return;
	else
		local l_List_1 = l_ValentinesShop_0.Sections.Gifts.List;
		local v131 = {};
		local function v145() --[[ Line: 633 ]] --[[ Name: reconcileGiftInventory ]]
			-- upvalues: v129 (copy), l_List_1 (copy), v131 (copy), v16 (ref), v12 (ref), v38 (ref), v47 (ref)
			local v132 = v129:Get({
				"ValentinesEvent", 
				"GiftInventory"
			});
			l_List_1.Parent.NoGifts.Visible = #v132 == 0;
			local v133 = {};
			for v134, v135 in v132 do
				v133[v135.Id] = true;
				local v136 = v131[v135.Id];
				if not v136 then
					local v137 = {};
					local v138 = l_List_1.Template:Clone();
					v138.Name = v135.Id;
					v138.Visible = true;
					v138.Frame.PlayerIcon.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v135.Sender);
					if v135.SenderUsername then
						v138.Frame.Username.Text = ("@%*"):format(v135.SenderUsername);
					else
						v138.Frame.Username.Text = "???";
						v137.thread = task.spawn(function() --[[ Line: 655 ]]
							-- upvalues: v16 (ref), v135 (copy), v138 (copy)
							local l_v16_User_1 = v16:GetUser(v135.Sender);
							if l_v16_User_1 then
								v138.Frame.Username.Text = ("@%*"):format(l_v16_User_1.Username);
							end;
						end);
					end;
					local v140 = v12.new(v138.Frame.Send);
					v140:Animate();
					v140.OnActivated:Connect(function() --[[ Line: 665 ]]
						-- upvalues: v38 (ref), v135 (copy), v47 (ref)
						local v141, v142 = v38:InvokeServer(v135.Id);
						if v141 then
							v47:OpenAnimation(v142);
						end;
					end);
					v138.Parent = l_List_1;
					v137.frame = v138;
					v131[v135.Id] = v137;
					v136 = v137;
				end;
				v136.frame.LayoutOrder = v134;
			end;
			for v143, v144 in v131 do
				if not v133[v143] then
					pcall(task.cancel, v144.thread);
					v144.frame:Destroy();
					v131[v143] = nil;
				end;
			end;
		end;
		v129:OnArrayInserted({
			"ValentinesEvent", 
			"GiftInventory"
		}, v145);
		v129:OnArrayRemoved({
			"ValentinesEvent", 
			"GiftInventory"
		}, v145);
		task.spawn(v145);
		return;
	end;
end;
v47._createShopTabs = function(_) --[[ Line: 698 ]] --[[ Name: _createShopTabs ]]
	-- upvalues: l_ValentinesShop_0 (copy), v12 (copy)
	local function v152(v147) --[[ Line: 699 ]] --[[ Name: setTab ]]
		-- upvalues: l_ValentinesShop_0 (ref)
		for _, v149 in l_ValentinesShop_0.Sections:GetChildren() do
			v149.Visible = v149.Name == v147;
		end;
		for _, v151 in l_ValentinesShop_0.SideBtns:GetChildren() do
			if v151:IsA("GuiButton") then
				v151.BackgroundColor3 = if v151.Name == v147 then Color3.fromRGB(244, 102, 190) else Color3.fromRGB(244, 181, 241);
			end;
		end;
	end;
	for _, v154 in l_ValentinesShop_0.SideBtns:GetChildren() do
		if v154:IsA("GuiButton") then
			local v155 = v12.new(v154);
			v155:Animate();
			v155.OnActivated:Connect(function() --[[ Line: 722 ]]
				-- upvalues: v152 (copy), v154 (copy)
				v152(v154.Name);
			end);
		end;
	end;
	v152("Send");
end;
v47._createPlayerList = function(_) --[[ Line: 730 ]] --[[ Name: _createPlayerList ]]
	-- upvalues: v46 (ref), v31 (copy), l_ValentinesSendGift_0 (copy), v52 (ref), v53 (ref), v64 (copy), v12 (copy), v9 (copy), v17 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy), v23 (copy), v37 (copy), v16 (copy)
	v46 = v31:Register("ValentinesSendGift", l_ValentinesSendGift_0, "TopQuint");
	v46:Close();
	v46.OnClose:Connect(function() --[[ Line: 735 ]]
		-- upvalues: v52 (ref), v53 (ref), v64 (ref), l_ValentinesSendGift_0 (ref)
		local l_v52_1 = v52;
		v52 = nil;
		if l_v52_1 and l_v52_1.card and l_v52_1.card.Parent then
			local l_Fill_1 = l_v52_1.card:FindFirstChild("Fill");
			if l_Fill_1 then
				l_Fill_1.BackgroundColor3 = Color3.fromRGB(255, 189, 240);
			end;
		end;
		v53 = nil;
		v64();
		l_v52_1 = l_ValentinesSendGift_0.RightMessage.Frame.ScrollingFrame.TextBox;
		if l_v52_1 then
			l_v52_1.Text = "";
		end;
	end);
	local v159 = v12.new(l_ValentinesSendGift_0.Header.Close);
	v159:Animate();
	v159.OnActivated:Connect(function() --[[ Line: 748 ]]
		-- upvalues: v31 (ref)
		v31:SetState("ValentinesSendGift", false);
		v31:SetState("ValentinesShop", true);
	end);
	local l_SearchBox_0 = l_ValentinesSendGift_0.Left.SearchFrame.SearchBox;
	local v161 = nil;
	local v162 = nil;
	local function v169(v163, v164, v165, v166) --[[ Line: 758 ]] --[[ Name: updateUserCard ]]
		-- upvalues: v52 (ref)
		local v167 = ("%*_%*"):format(v164.username, v164.userId);
		local v168 = v166 or v163:FindFirstChild(v167);
		if not v168 then
			return;
		else
			v168.Fill.Status2.Text = v164.inGame and "Online" or v164.isFriend and "Away" or "Offline";
			v168.Fill.Status2.TextColor3 = if v164.inGame then Color3.fromRGB(86, 211, 74) else if v164.isFriend then Color3.fromRGB(239, 225, 69) else Color3.fromRGB(211, 38, 38);
			v168.Fill.PlayerImage.Status.BackgroundColor3 = if v164.inGame then Color3.fromRGB(86, 211, 74) else if v164.isFriend then Color3.fromRGB(239, 225, 69) else Color3.fromRGB(211, 38, 38);
			v168.LayoutOrder = if v164.inGame then v165 else v165 + 300;
			v168.Fill.BackgroundColor3 = if v52 and v52.user and v52.user.userId == v164.userId then Color3.fromRGB(244, 102, 190) else Color3.fromRGB(255, 189, 240);
			return;
		end;
	end;
	local function v181(v170, v171, v172) --[[ Line: 791 ]] --[[ Name: createUserCard ]]
		-- upvalues: l_ValentinesSendGift_0 (ref), v169 (copy), v52 (ref)
		local v173 = ("%*_%*"):format(v171.username, v171.userId);
		local v174 = l_ValentinesSendGift_0.Left.LocalList.UIListLayout.Template:Clone();
		v174.Name = v173;
		v174.Fill.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v171.userId);
		v174.Fill.Username.Text = ("@%*"):format(v171.username);
		v169(v170, v171, v172, v174);
		v174.Visible = true;
		v174.Parent = v170;
		v174.Destroying:Once(function() --[[ Line: 802 ]]
			-- upvalues: v52 (ref), v174 (copy)
			if v52 and v52.card == v174 then
				local l_v52_2 = v52;
				v52 = nil;
				if l_v52_2 and l_v52_2.card and l_v52_2.card.Parent then
					local l_Fill_2 = l_v52_2.card:FindFirstChild("Fill");
					if l_Fill_2 then
						l_Fill_2.BackgroundColor3 = Color3.fromRGB(255, 189, 240);
					end;
				end;
			end;
		end);
		v174.Fill.Activated:Connect(function() --[[ Line: 808 ]]
			-- upvalues: v52 (ref), v170 (copy), v174 (copy), v171 (copy), v172 (copy), v169 (ref)
			local l_v52_3 = v52;
			local v178 = {
				parent = v170, 
				card = v174, 
				user = v171, 
				index = v172
			};
			local l_v52_4 = v52;
			v52 = v178;
			if l_v52_4 and l_v52_4.card and l_v52_4.card.Parent then
				local l_Fill_3 = l_v52_4.card:FindFirstChild("Fill");
				if l_Fill_3 then
					l_Fill_3.BackgroundColor3 = Color3.fromRGB(255, 189, 240);
				end;
			end;
			if l_v52_3 then
				v169(l_v52_3.parent, l_v52_3.user, l_v52_3.index, l_v52_3.card);
			end;
			v169(v170, v171, v172, v174);
		end);
		return v174;
	end;
	local v182 = v9.new();
	local function v196() --[[ Line: 834 ]] --[[ Name: updateLists ]]
		-- upvalues: v162 (ref), v182 (copy), v17 (ref), l_LocalPlayer_0 (ref), v161 (ref), l_Players_0 (ref), v23 (ref), v181 (copy), l_ValentinesSendGift_0 (ref)
		local v183 = coroutine.running();
		v162 = v183;
		v182:Clean();
		local l_v17_InGameFriends_0 = v17:GetInGameFriends(l_LocalPlayer_0);
		local v185 = {};
		if v161 == "Server" then
			for _, v187 in l_Players_0:GetPlayers() do
				if v187 ~= l_LocalPlayer_0 then
					table.insert(v185, {
						username = v187.Name, 
						userId = v187.UserId, 
						inGame = true, 
						isFriend = table.find(l_v17_InGameFriends_0, v187) ~= nil
					});
				end;
			end;
		elseif v161 == "Global" then
			local l_v17_OnlineFriends_0, v189 = v17:GetOnlineFriends();
			if l_v17_OnlineFriends_0 and typeof(v189) == "table" then
				for _, v191 in v189 do
					local v192 = {
						username = v191.UserName, 
						userId = v191.VisitorId
					};
					local v193 = false;
					if v191.PlaceId ~= nil then
						v193 = table.find(v23.AllPlaces, v191.PlaceId) ~= nil;
					end;
					v192.inGame = v193;
					v192.isFriend = true;
					table.insert(v185, v192);
				end;
			end;
		end;
		if v183 ~= v162 then
			return;
		else
			for v194, v195 in v185 do
				v182:Add((v181(if v161 == "Global" then l_ValentinesSendGift_0.Left.GlobalList else l_ValentinesSendGift_0.Left.LocalList, v195, v194)));
			end;
			return;
		end;
	end;
	local function v200(v197) --[[ Line: 887 ]] --[[ Name: setTab ]]
		-- upvalues: v161 (ref), l_SearchBox_0 (copy), l_ValentinesSendGift_0 (ref), v196 (copy)
		if v161 == v197 then
			return;
		else
			v161 = v197;
			l_SearchBox_0.Text = "";
			l_ValentinesSendGift_0.Left.LocalList.Visible = v161 ~= "Global";
			l_ValentinesSendGift_0.Left.GlobalList.Visible = v161 == "Global";
			l_ValentinesSendGift_0.Left.SearchFrame.Visible = v161 == "Global";
			for _, v199 in l_ValentinesSendGift_0.Left.Btns:GetChildren() do
				if v199:IsA("GuiButton") then
					v199.BackgroundColor3 = if v199.Name == v161 then Color3.fromRGB(244, 102, 190) else Color3.fromRGB(225, 162, 220);
				end;
			end;
			v196();
			return;
		end;
	end;
	l_Players_0.PlayerAdded:Connect(function() --[[ Line: 915 ]]
		-- upvalues: v161 (ref), v196 (copy)
		if v161 == "Server" then
			v196();
		end;
	end);
	l_Players_0.PlayerRemoving:Connect(function() --[[ Line: 921 ]]
		-- upvalues: v161 (ref), v196 (copy)
		if v161 == "Server" then
			v196();
		end;
	end);
	l_ValentinesSendGift_0.Left.SearchFrame.SearchBox.FocusLost:Connect(function(v201) --[[ Line: 927 ]]
		-- upvalues: v53 (ref), l_SearchBox_0 (copy), v182 (copy), l_Players_0 (ref), v196 (copy), v37 (ref), v16 (ref), v181 (copy), l_ValentinesSendGift_0 (ref)
		assert(v53);
		if not v201 then
			return;
		else
			local l_Text_1 = l_SearchBox_0.Text;
			l_SearchBox_0.TextEditable = false;
			l_SearchBox_0.Active = false;
			l_SearchBox_0.Text = "...";
			v182:Clean();
			local l_status_1, l_result_1 = pcall(function() --[[ Line: 942 ]]
				-- upvalues: l_Players_0 (ref), l_Text_1 (copy)
				return l_Players_0:GetUserIdFromNameAsync(l_Text_1);
			end);
			if not l_status_1 or typeof(l_result_1) ~= "number" then
				l_SearchBox_0.Text = string.find(l_result_1, "Unknown user") and "User not found!" or "Failed to search for user, try again later";
				task.wait(5);
				l_SearchBox_0.Text = "";
				l_SearchBox_0.TextEditable = true;
				l_SearchBox_0.Active = true;
				v196();
				return false;
			else
				local v205, v206, v207 = pcall(function() --[[ Line: 962 ]]
					-- upvalues: v37 (ref), v53 (ref), l_result_1 (copy)
					return v37:InvokeServer(v53.rawId, l_result_1);
				end);
				if not v205 or not v206 then
					l_SearchBox_0.Text = if typeof(v206) == "string" then v206 else if typeof(v207) == "string" then v207 else "Failed to search for user, try again later";
					task.wait(5);
					l_SearchBox_0.Text = "";
					l_SearchBox_0.TextEditable = true;
					l_SearchBox_0.Active = true;
					v196();
					return false;
				else
					local l_status_2, l_result_2 = pcall(function() --[[ Line: 984 ]]
						-- upvalues: v16 (ref), l_result_1 (copy)
						return v16:GetUser(l_result_1);
					end);
					v182:Add((v181(l_ValentinesSendGift_0.Left.GlobalList, {
						userId = l_result_1, 
						username = if l_status_2 and typeof(l_result_2) == "table" and l_result_2.IsLoaded then l_result_2.Username else string.upper(l_Text_1), 
						inGame = v207
					}, 1)));
					l_SearchBox_0.Text = "";
					task.wait(5);
					l_SearchBox_0.TextEditable = true;
					l_SearchBox_0.ClearTextOnFocus = true;
					l_SearchBox_0.Active = true;
					return;
				end;
			end;
		end;
	end);
	for _, v211 in l_ValentinesSendGift_0.Left.Btns:GetChildren() do
		if v211:IsA("GuiButton") then
			local l_Name_0 = v211.Name;
			local v213 = v12.new(v211);
			v213:Animate();
			v213.OnActivated:Connect(function() --[[ Line: 1017 ]]
				-- upvalues: v200 (copy), l_Name_0 (copy)
				v200(l_Name_0);
			end);
		end;
	end;
	v200("Server");
end;
v47._createShopObjects = function(v214) --[[ Line: 1025 ]] --[[ Name: _createShopObjects ]]
	-- upvalues: v45 (ref), v31 (copy), l_ValentinesShop_0 (copy), l_List_0 (copy), v19 (copy), l_LocalPlayer_0 (copy), v9 (copy), v14 (copy), v13 (copy), l_RunService_0 (copy), v18 (copy), v7 (copy), v22 (copy), v26 (copy), v12 (copy), v4 (copy), v47 (copy), v8 (copy), v28 (copy), v27 (copy), v15 (copy)
	v45 = v31:Register("ValentinesShop", l_ValentinesShop_0, "TopQuint");
	v45:AttachCloseButton(l_ValentinesShop_0.Header.Close);
	v45:Close();
	task.spawn(function() --[[ Line: 1030 ]]
		-- upvalues: l_List_0 (ref), v19 (ref), l_LocalPlayer_0 (ref)
		l_List_0["Heart Lucky Block"].Visible = false;
		l_List_0.LuckyBlocksList.Secret.Visible = false;
		local v215 = v19.getPolicy(l_LocalPlayer_0);
		if not v215 or v215.ArePaidRandomItemsRestricted then
			return;
		else
			l_List_0["Heart Lucky Block"].Visible = true;
			l_List_0.LuckyBlocksList.Secret.Visible = true;
			return;
		end;
	end);
	local function v244(v216, v217) --[[ Line: 1043 ]] --[[ Name: setupOdds ]]
		-- upvalues: v9 (ref), v14 (ref), v13 (ref), l_RunService_0 (ref), v18 (ref), v45 (ref)
		local v218 = v9.new();
		local v219 = nil;
		local function v243(v220) --[[ Line: 1050 ]] --[[ Name: setOddsVisibility ]]
			-- upvalues: v216 (copy), v219 (ref), v14 (ref), v217 (copy), v218 (copy), v13 (ref), l_RunService_0 (ref)
			v216.Visible = v220;
			if v220 == v219 then
				return;
			else
				v219 = v220;
				if v220 then
					local v221 = v14.get();
					local v222 = {};
					for _, v224 in v217.Animals do
						if (not v224.IsEnabled or v224.IsEnabled()) and v224.Chance then
							table.insert(v222, {
								animal = v224.Name, 
								chance = v224.Chance
							});
						end;
					end;
					table.sort(v222, function(v225, v226) --[[ Line: 1075 ]]
						return v226.chance < v225.chance;
					end);
					local v227 = v216:GetAttribute("XScalar") or 1;
					local v228 = v216.Template.Size.X.Scale * v227;
					local v229 = math.ceil(1 / v228) + 1;
					local v230 = math.ceil(v229 / #v222) * #v222;
					local v231 = table.create(v230);
					local v232 = 0;
					for v233 = 1, v230 do
						local v234 = v222[1 + (v233 - 1) % #v222];
						local v235 = v218:Clone(v216.Template);
						v235.Name = tostring(v233);
						v235.LayoutOrder = v233;
						v235.Chance.Text = ("%*%%"):format(v234.chance);
						v235.Visible = true;
						v235.Position = UDim2.fromScale(v232, 0.5);
						v235.Parent = v216;
						v232 = v232 + v228;
						v231[v233] = v235;
						local v236 = v13:AttachOnViewport(v234.animal, v235, true, v221);
						if v236 then
							v218:Add(v236);
						end;
					end;
					if v229 <= #v231 then
						local v237 = 0.5;
						if v227 > 1 then
							v237 = v237 * v227;
						end;
						do
							local l_v237_0 = v237;
							v218:Add(l_RunService_0.PreRender:Connect(function(v239) --[[ Line: 1137 ]]
								-- upvalues: v228 (ref), l_v237_0 (ref), v231 (copy)
								local v240 = v228 * v239 * l_v237_0;
								for _, v242 in v231 do
									v242.Position = v242.Position - UDim2.fromScale(v240, 0);
									if v242.Position.X.Scale <= -v228 then
										v242.Position = v242.Position + UDim2.fromScale(v228 * #v231, 0);
									end;
								end;
							end));
						end;
					end;
					return;
				else
					v218:Clean();
					return;
				end;
			end;
		end;
		v18.OnUpdateEnabled:Connect(function() --[[ Line: 1152 ]]
			-- upvalues: v216 (copy), v45 (ref), v219 (ref), v218 (copy), v243 (copy)
			if v216.Visible and v45:IsOpened() then
				v216.Visible = false;
				if v219 ~= false then
					v219 = false;
					v218:Clean();
				end;
				v243(true);
			end;
		end);
		v18.OnUpdateDisabled:Connect(function() --[[ Line: 1159 ]]
			-- upvalues: v216 (copy), v45 (ref), v219 (ref), v218 (copy), v243 (copy)
			if v216.Visible and v45:IsOpened() then
				v216.Visible = false;
				if v219 ~= false then
					v219 = false;
					v218:Clean();
				end;
				v243(true);
			end;
		end);
		v45.OnClose:Connect(function() --[[ Line: 1166 ]]
			-- upvalues: v216 (copy), v219 (ref), v218 (copy)
			v216.Visible = false;
			if v219 == false then
				return;
			else
				v219 = false;
				v218:Clean();
				return;
			end;
		end);
		v45.OnOpen:Connect(function() --[[ Line: 1170 ]]
			-- upvalues: v243 (copy)
			v243(true);
		end);
		v14.watch(function() --[[ Line: 1174 ]]
			-- upvalues: v216 (copy), v45 (ref), v219 (ref), v218 (copy), v243 (copy)
			if v216.Visible and v45:IsOpened() then
				v216.Visible = false;
				if v219 ~= false then
					v219 = false;
					v218:Clean();
				end;
				v243(true);
			end;
		end);
	end;
	for _, v246 in l_List_0:GetChildren() do
		local l_Name_1 = v246.Name;
		if l_Name_1 == "Heart Lucky Block" then
			task.spawn(function() --[[ Line: 1186 ]]
				-- upvalues: v19 (ref), l_LocalPlayer_0 (ref), v7 (ref), v246 (copy), v244 (copy), v22 (ref), v9 (ref), v45 (ref), v14 (ref), v26 (ref), v13 (ref), v12 (ref), v214 (copy), v4 (ref), v47 (ref), v8 (ref), v28 (ref)
				local v248 = v19.getPolicy(l_LocalPlayer_0);
				if not v248 or v248.ArePaidRandomItemsRestricted then
					return;
				else
					local function _() --[[ Line: 1195 ]] --[[ Name: isLuckyBlockActive ]]
						-- upvalues: v7 (ref)
						return workspace:GetServerTimeNow() < v7:GetInstant("HeartLuckyBlockPackEndTime", 1771704000);
					end;
					for _, v251 in v246:GetChildren() do
						if v251.Name == "Odds" then
							v244(v251, v22["Premium Heart Lucky Block"]);
						end;
					end;
					local v252 = v9.new();
					local function v258() --[[ Line: 1215 ]] --[[ Name: updateInfo ]]
						-- upvalues: v252 (copy), v45 (ref), v14 (ref), v26 (ref), v246 (ref), v13 (ref)
						v252:Destroy();
						if not v45:IsOpened() then
							return;
						else
							local v253 = v14.get();
							local v254 = v253 and v26[v253];
							if v254 then
								v246.Mutation.Text = v254.DisplayWithRichText;
								v246.Mutation.Visible = true;
							else
								v246.Mutation.Visible = nil;
							end;
							for _, v256 in v246:GetChildren() do
								if v256:IsA("ViewportFrame") and v256.Name == "IconViewport" then
									local v257 = v13:AttachOnViewport("Premium Heart Lucky Block", v256, true, v253);
									if v257 then
										v252:Add(v257);
									end;
								end;
							end;
							return;
						end;
					end;
					task.spawn(v258);
					v45.OnClose:Connect(v258);
					v45.OnOpen:Connect(v258);
					v14.watch(v258);
					local v259 = v12.new(v246.Buttons.Buy);
					v259:Animate();
					v259.OnActivated:Connect(function() --[[ Line: 1249 ]]
						-- upvalues: v214 (ref)
						v214:Purchase(3531057541);
					end);
					local v260 = v12.new(v246.Buttons.Buy3);
					v260:Animate();
					v260.OnActivated:Connect(function() --[[ Line: 1255 ]]
						-- upvalues: v214 (ref)
						v214:Purchase(3531057803);
					end);
					local v261 = v12.new(v246.Buttons.Buy10);
					v261:Animate();
					v261.OnActivated:Connect(function() --[[ Line: 1261 ]]
						-- upvalues: v214 (ref)
						v214:Purchase(3531057804);
					end);
					local function v264() --[[ Line: 1265 ]] --[[ Name: updateBuyVisibility ]]
						-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v261 (copy), v260 (copy)
						local v262 = v4:Get(l_LocalPlayer_0);
						if not v262 then
							return;
						else
							local v263 = v262:Get({
								"LuckyBlocks", 
								(tostring(3531057803))
							}) or 0;
							v261.Instance.Visible = v263 >= 5;
							v260.Instance.Visible = v263 < 5;
							return;
						end;
					end;
					task.spawn(function() --[[ Line: 1279 ]]
						-- upvalues: v47 (ref), v246 (ref)
						v47:BindLabelToProductPrice(v246.Buttons.Buy.Price, v47:GetProductId(3531057541), "Product");
						v47:BindLabelToProductPrice(v246.Buttons.Buy3.Price, v47:GetProductId(3531057803), "Product");
						v47:BindLabelToProductPrice(v246.Buttons.Buy10.Price, v47:GetProductId(3531057804), "Product");
					end);
					task.spawn(function() --[[ Line: 1297 ]]
						-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v264 (copy)
						local v265 = v4:Wait(l_LocalPlayer_0);
						if not v265 then
							return;
						else
							v265:OnChanged({
								"LuckyBlocks", 
								(tostring(3531057803))
							}, v264);
							v264();
							return;
						end;
					end);
					task.spawn(v264);
					local l_Timer_0 = v246:WaitForChild("Timer");
					v8.Simple(1, function() --[[ Line: 1310 ]]
						-- upvalues: v246 (ref), v7 (ref), l_Timer_0 (copy), v28 (ref)
						v246.Visible = workspace:GetServerTimeNow() < v7:GetInstant("HeartLuckyBlockPackEndTime", 1771704000);
						local l_v7_Instant_0 = v7:GetInstant("HeartLuckyBlockPackEndTime", 1771704000);
						local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
						if l_Timer_0 then
							l_Timer_0.Text = ("%* left"):format((v28:E(l_v7_Instant_0 - l_workspace_ServerTimeNow_0)));
						end;
					end);
					return;
				end;
			end);
		elseif l_Name_1 == "LuckyBlocksList" then
			task.spawn(function() --[[ Line: 1322 ]]
				-- upvalues: v246 (copy), v22 (ref), v244 (copy), v9 (ref), v45 (ref), v14 (ref), v26 (ref), v13 (ref), v12 (ref), v214 (copy), v47 (ref)
				local l_Secret_0 = v246.Secret;
				local v270 = v22["Secret Lucky Block"];
				if not v270 then
					return;
				else
					local l_ProductId_0 = v270.ProductId;
					if not l_ProductId_0 then
						return;
					else
						for _, v273 in ipairs(l_Secret_0:GetChildren()) do
							if v273.Name == "Odds" then
								local _ = v273:GetAttribute("LuckyBlock") or "Secret Lucky Block";
								v244(v273, v22["Secret Lucky Block"]);
							end;
						end;
						local v275 = v9.new();
						local function v282() --[[ Line: 1344 ]] --[[ Name: updateInfo ]]
							-- upvalues: v275 (copy), v45 (ref), v14 (ref), v26 (ref), l_Secret_0 (copy), v13 (ref)
							v275:Destroy();
							if not v45:IsOpened() then
								return;
							else
								local v276 = v14.get();
								local v277 = v276 and v26[v276];
								if v277 then
									l_Secret_0.Mutation.Text = v277.DisplayWithRichText;
									l_Secret_0.Mutation.Visible = true;
								else
									l_Secret_0.Mutation.Visible = nil;
								end;
								for _, v279 in ipairs(l_Secret_0:GetChildren()) do
									if v279:IsA("ViewportFrame") and v279.Name == "IconViewport" then
										local v280 = v279:GetAttribute("LuckyBlock") or "Secret Lucky Block";
										local v281 = v13:AttachOnViewport(v280, v279, true, v276);
										if v281 then
											v275:Add(v281);
										end;
									end;
								end;
								return;
							end;
						end;
						task.spawn(v282);
						v45.OnClose:Connect(function() --[[ Line: 1373 ]]
							-- upvalues: v282 (copy)
							v282();
						end);
						v45.OnOpen:Connect(function() --[[ Line: 1377 ]]
							-- upvalues: v282 (copy)
							v282();
						end);
						v14.watch(function() --[[ Line: 1381 ]]
							-- upvalues: v282 (copy)
							task.spawn(v282);
						end);
						local v283 = v12.new(l_Secret_0.Buy);
						v283:Animate();
						v283.OnActivated:Connect(function() --[[ Line: 1387 ]]
							-- upvalues: v214 (ref), l_ProductId_0 (copy)
							v214:Purchase(l_ProductId_0);
						end);
						v47:BindLabelToProductPrice(l_Secret_0.Buy.Price, v47:GetProductId(l_ProductId_0), "Product", 100);
						return;
					end;
				end;
			end);
			task.spawn(function() --[[ Line: 1401 ]]
				-- upvalues: v246 (copy), v19 (ref), l_LocalPlayer_0 (ref), v12 (ref), v214 (copy), v47 (ref)
				local l_Wings_0 = v246.Wings;
				local v285 = v19.getPolicy(l_LocalPlayer_0);
				local v286 = not v285 or v285.ArePaidRandomItemsRestricted;
				local v287 = v286 and 3536298171 or 3536298173;
				l_Wings_0.LuckyBlock.Visible = not v286;
				l_Wings_0.NonLuckyBlock.Visible = v286;
				local v288 = v12.new(l_Wings_0.Buy);
				v288:Animate();
				v288.OnActivated:Connect(function() --[[ Line: 1412 ]]
					-- upvalues: v214 (ref), v287 (copy)
					v214:Purchase(v287);
				end);
				v47:BindLabelToProductPrice(l_Wings_0.Buy.Price, v47:GetProductId(v287), "Product", 100);
			end);
		elseif l_Name_1 == "Rose Base" then
			task.spawn(function() --[[ Line: 1425 ]]
				-- upvalues: v7 (ref), v19 (ref), l_LocalPlayer_0 (ref), v246 (copy), v47 (ref), v8 (ref), v28 (ref), v12 (ref), v214 (copy)
				local function _() --[[ Line: 1429 ]] --[[ Name: isRoseBaseActive ]]
					-- upvalues: v7 (ref)
					return workspace:GetServerTimeNow() < v7:GetInstant("RoseBasePackEndTime", 1771704000);
				end;
				local v290 = v19.getPolicy(l_LocalPlayer_0);
				local v291 = v246:WaitForChild("Buy", 5);
				local v292 = v291 and v291:WaitForChild("Price", 5);
				local v293 = false;
				local function _() --[[ Line: 1441 ]] --[[ Name: getProductId ]]
					-- upvalues: v290 (copy)
					if not v290 or v290.ArePaidRandomItemsRestricted then
						return 3531055923;
					else
						return 3531055926;
					end;
				end;
				v246.LuckyBlock.Visible = ((not v290 or v290.ArePaidRandomItemsRestricted) and 3531055923 or 3531055926) == 3531055926;
				v246.Visible = true;
				v246:SetAttribute("ProductId", (not v290 or v290.ArePaidRandomItemsRestricted) and 3531055923 or 3531055926);
				local function _() --[[ Line: 1454 ]] --[[ Name: updateInfo ]]
					-- upvalues: v290 (copy), v246 (ref), v292 (copy), v47 (ref)
					local v295 = (not v290 or v290.ArePaidRandomItemsRestricted) and 3531055923 or 3531055926;
					v246:SetAttribute("ProductId", v295);
					v246.LuckyBlock.Visible = v295 == 3531055926;
					if v292 then
						v47:BindLabelToProductPrice(v292, v47:GetProductId(v295));
					end;
				end;
				local function _() --[[ Line: 1466 ]] --[[ Name: ToggleVisibility ]]
					-- upvalues: v246 (ref), v7 (ref)
					v246.Visible = workspace:GetServerTimeNow() < v7:GetInstant("RoseBasePackEndTime", 1771704000);
				end;
				v7:OnUpdate(function() --[[ Line: 1470 ]]
					-- upvalues: v246 (ref), v7 (ref)
					v246.Visible = workspace:GetServerTimeNow() < v7:GetInstant("RoseBasePackEndTime", 1771704000);
				end);
				local v298 = v246:WaitForChild("Timer", 5);
				v8.Simple(1, function() --[[ Line: 1475 ]]
					-- upvalues: v7 (ref), v298 (copy), v28 (ref), v293 (ref), v246 (ref)
					local l_v7_Instant_1 = v7:GetInstant("RoseBasePackEndTime", 1771704000);
					local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
					if v298 then
						v298.Text = ("%* left"):format((v28:E(l_v7_Instant_1 - l_workspace_ServerTimeNow_1)));
					end;
					if l_v7_Instant_1 <= l_workspace_ServerTimeNow_1 then
						if not v293 then
							v293 = true;
							v246.Visible = workspace:GetServerTimeNow() < v7:GetInstant("RoseBasePackEndTime", 1771704000);
							return;
						end;
					elseif v293 then
						v293 = false;
						v246.Visible = workspace:GetServerTimeNow() < v7:GetInstant("RoseBasePackEndTime", 1771704000);
					end;
				end);
				local v301 = (not v290 or v290.ArePaidRandomItemsRestricted) and 3531055923 or 3531055926;
				v246:SetAttribute("ProductId", v301);
				v246.LuckyBlock.Visible = v301 == 3531055926;
				if v292 then
					v47:BindLabelToProductPrice(v292, v47:GetProductId(v301));
				end;
				v301 = v12.new(v291);
				v301:Animate();
				v301.OnActivated:Connect(function() --[[ Line: 1499 ]]
					-- upvalues: v214 (ref), v290 (copy)
					v214:Purchase((not v290 or v290.ArePaidRandomItemsRestricted) and 3531055923 or 3531055926);
				end);
			end);
		elseif l_Name_1 == "ItemsList" or l_Name_1 == "GamepassList" then
			local v302 = if l_Name_1 == "GamepassList" then {
				v246["1800820512"], 
				v246.Main["1801015136"], 
				v246.Main["1800564757"]
			} else v246.Fill:GetChildren();
			for _, v304 in v302 do
				if v304:IsA("GuiObject") then
					task.spawn(function() --[[ Line: 1510 ]]
						-- upvalues: v304 (copy), v27 (ref), v15 (ref), v47 (ref), v12 (ref), v214 (copy)
						local v305 = tonumber(v304.Name);
						if not v305 then
							return;
						else
							assert(v305);
							local v306 = v27[v305];
							if not v306 then
								return;
							else
								local v307 = v304:WaitForChild("Buy", 5);
								local v308 = v307 and v307:WaitForChild("Price", 5);
								local l_v304_FirstChild_0 = v304:FindFirstChild("Icon", true);
								if (v306.Type == "LuckyBlock" or v306.Type == "Brainrot") and v306.Value then
									local l_brainrotName_v = if typeof(v306.Value) == "table" then v306.Value[1] else v306.Value;
									if l_v304_FirstChild_0 then
										l_v304_FirstChild_0.Image = "";
										l_v304_FirstChild_0.Visible = false;
									end;
									local l_viewport_v = v304:FindFirstChild("IconViewport", true);
									if l_viewport_v and l_viewport_v:IsA("ViewportFrame") then
										l_viewport_v:SetAttribute("LuckyBlock", l_brainrotName_v);
										local l_mutation_v = v14.get();
										v13:AttachOnViewport(l_brainrotName_v, l_viewport_v, true, l_mutation_v);
									end;
								elseif v306.Icon and l_v304_FirstChild_0 then
									l_v304_FirstChild_0.ScaleType = Enum.ScaleType.Fit;
									l_v304_FirstChild_0.Image = v306.Icon;
								end;
								(function() --[[ Line: 1532 ]] --[[ Name: updateInfo ]]
									-- upvalues: v15 (ref), v305 (copy), v308 (copy), v47 (ref), l_v304_FirstChild_0 (copy), v306 (copy)
									local l_v15_ProductInfo_2 = v15:GetProductInfo(v305, "Product");
									if v308 then
										v47:BindLabelToProductPrice(v308, v47:GetProductId(v305));
									end;
									if v306.Type ~= "LuckyBlock" and l_v15_ProductInfo_2.Icon and l_v304_FirstChild_0 then
										l_v304_FirstChild_0.ScaleType = Enum.ScaleType.Fit;
										if not v306.Icon then
											l_v304_FirstChild_0.Image = l_v15_ProductInfo_2.Icon;
										end;
									end;
								end)();
								local v311 = v12.new(v307);
								v311:Animate();
								v311.OnActivated:Connect(function() --[[ Line: 1554 ]]
									-- upvalues: v214 (ref), v305 (copy)
									v214:Purchase(v305);
								end);
								return;
							end;
						end;
					end);
				end;
			end;
		end;
	end;
end;
v47.GetProductId = function(_, v313) --[[ Line: 1563 ]] --[[ Name: GetProductId ]]
	-- upvalues: v21 (copy)
	return v21.Products[v313].discountedProductId;
end;
v47.Purchase = function(_, v315) --[[ Line: 1567 ]] --[[ Name: Purchase ]]
	-- upvalues: v21 (copy), v66 (copy), v31 (copy)
	if not v21.Products[v315] then
		return;
	else
		v66(v315);
		v31:SetState("ValentinesSendGift", true);
		return;
	end;
end;
v47.BindLabelToProductPrice = function(_, v317, v318, v319, v320) --[[ Line: 1577 ]] --[[ Name: BindLabelToProductPrice ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), v21 (copy), v33 (copy)
	local v321 = false;
	local v322 = v4:Wait(l_LocalPlayer_0);
	if not v322 then
		return;
	else
		local v323;
		for _, v325 in v21.Products do
			if v325.discountedProductId == v318 then
				v323 = v325.failedGiftKey or tostring(v318);
				v321 = true;
			end;
			if v321 then
				break;
			end;
		end;
		if not v321 then
			v323 = tostring(v318);
		end;
		v321 = false;
		local function v327() --[[ Line: 1591 ]] --[[ Name: updatePrice ]]
			-- upvalues: v322 (copy), v323 (copy), v33 (ref), v317 (copy), v318 (copy), v319 (copy), v320 (copy)
			local v326 = v322:Get({
				"ValentinesEvent", 
				"FailedGifts", 
				v323
			});
			if typeof(v326) == "table" and #v326 > 0 then
				v33:UnbindLabelProductPrice(v317);
				v317.Text = ("FREE (%*)"):format(#v326);
				return;
			else
				v33:BindLabelToProductPrice(v317, v318, v319, v320);
				return;
			end;
		end;
		v322:OnChanged({
			"ValentinesEvent", 
			"FailedGifts", 
			v323
		}, v327);
		v322:OnArrayInserted({
			"ValentinesEvent", 
			"FailedGifts", 
			v323
		}, v327);
		v322:OnArrayRemoved({
			"ValentinesEvent", 
			"FailedGifts", 
			v323
		}, v327);
		v327();
		return;
	end;
end;
v47._createGiftSubtitleLabel = function(_) --[[ Line: 1607 ]] --[[ Name: _createGiftSubtitleLabel ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), v5 (copy), v11 (copy)
	local v329 = v4:Wait(l_LocalPlayer_0);
	if not v329 then
		return;
	else
		local function v331() --[[ Line: 1613 ]] --[[ Name: getSubtitleText ]]
			-- upvalues: v329 (copy)
			local v330 = v329:Get({
				"ValentinesEvent", 
				"GiftInventory"
			});
			if typeof(v330) == "table" and #v330 > 0 then
				if #v330 == 1 then
					return "1 Gift Available";
				else
					return (("%* Gifts Available"):format(#v330));
				end;
			else
				return "Send Gifts";
			end;
		end;
		local function v337(v332) --[[ Line: 1625 ]] --[[ Name: listenForGiftInventoryChanges ]]
			-- upvalues: v329 (copy)
			local v333 = v329:OnChanged({
				"ValentinesEvent", 
				"GiftInventory"
			}, v332);
			local v334 = v329:OnArrayInserted({
				"ValentinesEvent", 
				"GiftInventory"
			}, v332);
			local v335 = v329:OnArrayRemoved({
				"ValentinesEvent", 
				"GiftInventory"
			}, v332);
			local v336 = task.spawn(v332);
			return function() --[[ Line: 1631 ]]
				-- upvalues: v336 (copy), v334 (copy), v335 (copy), v333 (copy)
				pcall(task.cancel, v336);
				if v334 then
					v334:Disconnect();
				end;
				if v335 then
					v335:Disconnect();
				end;
				if v333 then
					v333:Disconnect();
				end;
			end;
		end;
		v5.observeTag("ValentinesGiftSubtitle", function(v338) --[[ Line: 1645 ]]
			-- upvalues: v337 (copy), v331 (copy)
			return (v337(function() --[[ Line: 1646 ]]
				-- upvalues: v338 (copy), v331 (ref)
				v338.Text = v331();
			end));
		end);
		v5.observeTag("ValentinesMailboxRotate", function(v339) --[[ Line: 1651 ]]
			-- upvalues: v337 (copy), v329 (copy), v11 (ref)
			local l_v339_Pivot_0 = v339:GetPivot();
			local v343 = v337(function() --[[ Line: 1654 ]]
				-- upvalues: v329 (ref), v11 (ref), v339 (copy), l_v339_Pivot_0 (copy)
				local v341 = v329:Get({
					"ValentinesEvent", 
					"GiftInventory"
				});
				local v342 = false;
				if typeof(v341) == "table" then
					v342 = #v341 > 0;
				end;
				v11.target(v339, 0.75, 3, {
					Pivot = if v342 then l_v339_Pivot_0 * CFrame.Angles(0, 0, 1.5707963267948966) else l_v339_Pivot_0
				});
			end);
			return function() --[[ Line: 1660 ]]
				-- upvalues: v343 (copy), v11 (ref), v339 (copy), l_v339_Pivot_0 (copy)
				v343();
				v11.stop(v339);
				v339:PivotTo(l_v339_Pivot_0);
			end;
		end);
		return;
	end;
end;
v47._createMailboxVFX = function(_) --[[ Line: 1668 ]] --[[ Name: _createMailboxVFX ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), v5 (copy), v34 (copy), v32 (copy), l_ReplicatedStorage_0 (copy)
	local v345 = v4:Wait(l_LocalPlayer_0);
	if not v345 then
		return;
	else
		v5.observeTag("ValentinesShopModel", function(v346) --[[ Line: 1674 ]]
			-- upvalues: v345 (copy), v34 (ref), v32 (ref), l_ReplicatedStorage_0 (ref)
			local v347 = v346:WaitForChild("VFX", 5);
			if not v347 then
				return nil;
			else
				local l_MinorGlow_0 = v347:FindFirstChild("MinorGlow");
				local l_GlowAndHearts_0 = v347:FindFirstChild("GlowAndHearts");
				local l_Burst_0 = v347:FindFirstChild("Burst");
				local function v353() --[[ Line: 1684 ]] --[[ Name: updateMailboxVFX ]]
					-- upvalues: v345 (ref), l_MinorGlow_0 (copy), v34 (ref), l_GlowAndHearts_0 (copy)
					local v351 = v345:Get({
						"ValentinesEvent", 
						"GiftInventory"
					});
					local v352 = false;
					if typeof(v351) == "table" then
						v352 = #v351 > 0;
					end;
					if v352 then
						if l_MinorGlow_0 then
							v34.disable(l_MinorGlow_0);
						end;
						if l_GlowAndHearts_0 then
							v34.enable(l_GlowAndHearts_0);
							return;
						end;
					else
						if l_MinorGlow_0 then
							v34.enable(l_MinorGlow_0);
						end;
						if l_GlowAndHearts_0 then
							v34.disable(l_GlowAndHearts_0);
						end;
					end;
				end;
				local v354 = v345:OnArrayInserted({
					"ValentinesEvent", 
					"GiftInventory"
				}, function() --[[ Line: 1708 ]]
					-- upvalues: l_Burst_0 (copy), v34 (ref), v32 (ref), l_ReplicatedStorage_0 (ref), v346 (copy), v353 (copy)
					if l_Burst_0 then
						v34.emit(l_Burst_0);
						v32:PlaySound(l_ReplicatedStorage_0.Sounds.Sfx.ValentinesMailboxBurst, v346:GetPivot().Position, false);
					end;
					v353();
				end);
				local v355 = v345:OnArrayRemoved({
					"ValentinesEvent", 
					"GiftInventory"
				}, function() --[[ Line: 1716 ]]
					-- upvalues: v353 (copy)
					v353();
				end);
				local v356 = v345:OnChanged({
					"ValentinesEvent", 
					"GiftInventory"
				}, function() --[[ Line: 1720 ]]
					-- upvalues: v353 (copy)
					v353();
				end);
				v353();
				return function() --[[ Line: 1727 ]]
					-- upvalues: v354 (copy), v355 (copy), v356 (copy)
					if v354 then
						v354:Disconnect();
					end;
					if v355 then
						v355:Disconnect();
					end;
					if v356 then
						v356:Disconnect();
					end;
				end;
			end;
		end);
		return;
	end;
end;
v47._createGiftNotifications = function(_) --[[ Line: 1741 ]] --[[ Name: _createGiftNotifications ]]
	-- upvalues: l_PlayerGui_0 (copy), v40 (copy), v16 (copy), v29 (copy), v12 (copy), v32 (copy), v38 (copy), v47 (copy), v20 (copy)
	local l_ValentinesGifts_0 = l_PlayerGui_0:WaitForChild("ValentinesGifts").ValentinesGifts;
	v40.OnClientEvent:Connect(function(v359) --[[ Line: 1746 ]]
		-- upvalues: l_ValentinesGifts_0 (copy), v16 (ref), v29 (ref), v12 (ref), v32 (ref), v38 (ref), v47 (ref), v20 (ref)
		local v360 = l_ValentinesGifts_0.Template:Clone();
		v360.Visible = true;
		local v361 = v360:FindFirstChild("Icon") or v360:FindFirstChild("PlayerIcon");
		if v361 then
			v361.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=100&h=100"):format(v359.Sender);
		end;
		local l_Username_0 = v360:FindFirstChild("Username");
		if l_Username_0 then
			if v359.SenderUsername then
				l_Username_0.Text = ("@%* sent you a gift!"):format(v359.SenderUsername);
			else
				l_Username_0.Text = "Someone sent you a gift!";
				task.spawn(function() --[[ Line: 1762 ]]
					-- upvalues: v16 (ref), v359 (copy), v360 (copy), l_Username_0 (copy)
					local l_v16_User_2 = v16:GetUser(v359.Sender);
					if l_v16_User_2 and v360.Parent then
						l_Username_0.Text = ("@%* sent you a gift!"):format(l_v16_User_2.Username);
					end;
				end);
			end;
		end;
		local v364 = v29:Add(v360);
		local l_Yes_0 = v360:FindFirstChild("Yes");
		if l_Yes_0 then
			local v366 = v12.new(l_Yes_0);
			v366:Animate();
			v366.OnActivated:Connect(function() --[[ Line: 1779 ]]
				-- upvalues: v32 (ref), v364 (copy), v359 (copy), v38 (ref), v47 (ref)
				v32:PlaySound("Sounds.Sfx.Activated");
				v364();
				if v359.Id then
					local v367, v368 = v38:InvokeServer(v359.Id);
					if v367 then
						v47:OpenAnimation(v368);
					end;
				end;
			end);
		end;
		local l_No_0 = v360:FindFirstChild("No");
		if l_No_0 then
			local v370 = v12.new(l_No_0);
			v370:Animate();
			v370.OnActivated:Connect(function() --[[ Line: 1798 ]]
				-- upvalues: v364 (copy)
				v364();
			end);
		end;
		v20(v360.Fill, TweenInfo.new(15), {
			Size = UDim2.fromScale(0, v360.Fill.Size.Y.Scale)
		});
		task.delay(15, v364);
	end);
end;
v47.Start = function(_) --[[ Line: 1810 ]] --[[ Name: Start ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), v47 (copy), v5 (copy), v31 (copy)
	if not v4:Wait(l_LocalPlayer_0) then
		return;
	else
		task.spawn(v47._createGiftsTab, v47);
		task.spawn(v47._createShopTabs, v47);
		task.spawn(v47._createRightFrame, v47);
		task.spawn(v47._createPlayerList, v47);
		task.spawn(v47._createShopObjects, v47);
		task.spawn(v47._createGiftNotifications, v47);
		task.spawn(v47._createGiftSubtitleLabel, v47);
		task.spawn(v47._createMailboxVFX, v47);
		v5.observeTag("ValentinesGiftsPrompt", function(v372) --[[ Line: 1825 ]]
			-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v31 (ref)
			local v373 = v372.Triggered:Connect(function() --[[ Line: 1826 ]]
				-- upvalues: v4 (ref), l_LocalPlayer_0 (ref), v31 (ref)
				if not v4:Get(l_LocalPlayer_0) then
					return;
				else
					v31:Toggle("ValentinesShop");
					return;
				end;
			end);
			return function() --[[ Line: 1835 ]]
				-- upvalues: v373 (copy)
				v373:Disconnect();
			end;
		end);
		return;
	end;
end;
return v47;