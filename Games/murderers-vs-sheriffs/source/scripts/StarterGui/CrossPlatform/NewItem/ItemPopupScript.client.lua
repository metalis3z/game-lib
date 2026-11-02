-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_ItemService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"));
local l_ItemPopupService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"));
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local l_GuiService_0 = game:GetService("GuiService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Parent_0 = script.Parent;
local l_Medium_0 = l_Parent_0:WaitForChild("Medium");
local l_Claim_0 = l_Medium_0:WaitForChild("Container"):WaitForChild("Claim");
local l_NewItem_0 = l_Medium_0:WaitForChild("Container"):WaitForChild("NewItem");
local l_NewItemBlur_0 = game:GetService("Lighting"):WaitForChild("NewItemBlur");
local v11 = {};
local v12 = 1;
local v13 = 0;
local v14 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local function v25(v15, v16, _) --[[ Line: 25 ]] --[[ Name: playInventoryAnimation ]]
    -- upvalues: l_NewItem_0 (copy), l_ItemPopupService_0 (copy), l_ItemService_0 (copy), l_Parent_0 (copy), l_TweenService_0 (copy), v14 (copy)
    local l_Icon_0 = l_NewItem_0:WaitForChild("Container"):WaitForChild("Icon");
    local l_AnimationTargetLocation_0 = l_ItemPopupService_0.AnimationTargetLocation;
    local v20 = script:WaitForChild("ItemIcon"):Clone();
    v20.Image = l_ItemService_0:GetDisplayInfo(v15, v16).Image;
    local v21 = UDim2.fromOffset(l_Icon_0.AbsoluteSize.X, l_Icon_0.AbsoluteSize.Y);
    local v22 = UDim2.fromOffset(l_Icon_0.AbsolutePosition.X, l_Icon_0.AbsolutePosition.Y);
    local v23 = UDim2.fromOffset(25, 25);
    local v24 = nil;
    v24 = if l_AnimationTargetLocation_0 then UDim2.fromOffset(l_AnimationTargetLocation_0.AbsolutePosition.X, l_AnimationTargetLocation_0.AbsolutePosition.Y) else UDim2.new(0.5, 0, 1, 25);
    v20.Size = v21;
    v20.Position = v22;
    v20.Parent = l_Parent_0:WaitForChild("Animation");
    l_TweenService_0:Create(v20, v14, {
        Position = v24 + UDim2.fromOffset(12, 8), 
        Size = v23
    }):Play();
    game.Debris:AddItem(v20, 0.5);
end;
local function v31() --[[ Line: 61 ]] --[[ Name: showNewItem ]]
    -- upvalues: v11 (copy), l_ItemService_0 (copy), l_NewItem_0 (copy), l_Medium_0 (copy), v13 (ref), v12 (ref), l_NewItemBlur_0 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), l_Claim_0 (copy)
    local v26 = v11[1];
    local l_ID_0 = v26.ID;
	local l_Type_0 = v26.Type;
	local v31 = v26.Amount or 1;
    local l_l_ItemService_0_DisplayInfo_0 = l_ItemService_0:GetDisplayInfo(l_ID_0, l_Type_0);
    l_NewItem_0:WaitForChild("Container"):WaitForChild("Icon").Image = l_l_ItemService_0_DisplayInfo_0.Image;
    l_NewItem_0:WaitForChild("ItemName"):WaitForChild("Label").Text = l_l_ItemService_0_DisplayInfo_0.Name;
    l_NewItem_0:WaitForChild("ItemName").BackgroundColor3 = l_l_ItemService_0_DisplayInfo_0.Color;
    l_Medium_0:WaitForChild("Container"):WaitForChild("Starburst").ImageColor3 = l_l_ItemService_0_DisplayInfo_0.Color;
	l_NewItem_0.Container.Amount.Text = v31 > 1 and ("x%*"):format(v31) or "";
	if v13 > 1 then
        l_Medium_0:WaitForChild("Container"):WaitForChild("Claim").Text = ("Claim (%*/%*)"):format(v12, v13);
    else
        l_Medium_0:WaitForChild("Container"):WaitForChild("Claim").Text = "Claim";
    end;
    l_NewItemBlur_0.Enabled = true;
    l_Medium_0.Visible = true;
    local v30 = l_UserInputService_0.PreferredInput == Enum.PreferredInput.Gamepad;
    if v30 then
        l_GuiService_0.SelectedObject = l_Claim_0;
    end;
    l_Claim_0.ImageLabel.Visible = v30;
end;
local function v34(itemId, itemType, qAmount)
	local categories = {"Weapons", "Effects", "Perks", "Emotes", "Radios", "Pets", "Toys"}
	for _, category in ipairs(categories) do
		if l_ItemService_0:ItemExists(itemId, category) then
			itemType = category
			break
		end
	end

	table.insert(v11, {
		ID = itemId,
		Type = itemType,
		Amount = qAmount
	})

	v13 = v13 + 1
	v31()
end



local function v35() --[[ Line: 96 ]] --[[ Name: onItemClaimed ]]
    -- upvalues: v25 (copy), v11 (copy), v12 (ref), v31 (copy), l_GuiService_0 (copy), l_Medium_0 (copy), l_Shop_0 (copy), v13 (ref), l_NewItemBlur_0 (copy), l_ItemPopupService_0 (copy)
    v25(v11[1].ID, v11[1].Type);
    table.remove(v11, 1);
    if v11[1] ~= nil then
        v12 = v12 + 1;
        v31();
        return;
    else
        l_GuiService_0.SelectedObject = nil;
        l_Medium_0.Visible = false;
        l_Shop_0:WaitForChild("NewItemsClaimed"):Fire();
        v13 = 0;
        v12 = 1;
        l_NewItemBlur_0.Enabled = false;
        l_ItemPopupService_0.ItemClaimsComplete:Fire();
        return;
    end;
end;
(function() --[[ Line: 114 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_Medium_0 (copy), v35 (copy), v34 (copy), l_ItemPopupService_0 (copy), l_Shop_0 (copy), l_GuiService_0 (copy)
    l_Medium_0.Visible = false;
    l_Medium_0:WaitForChild("Container"):WaitForChild("Claim").Activated:Connect(v35);
    game:GetService("ReplicatedStorage"):WaitForChild("ItemGift").OnClientEvent:Connect(v34);
    l_ItemPopupService_0.ItemReceived.Event:Connect(v34);
    l_Shop_0.NewItemReceived.Event:Connect(v34);
    if l_GuiService_0:IsTenFootInterface() then
        l_Medium_0:WaitForChild("Container"):WaitForChild("UIScale").Scale = 1.5;
    end;
end)();