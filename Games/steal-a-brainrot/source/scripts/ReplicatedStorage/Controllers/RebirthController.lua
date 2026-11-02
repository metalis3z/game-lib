-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("TweenService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local l_Utils_0 = l_ReplicatedStorage_0:WaitForChild("Utils");
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local l_Shared_0 = l_ReplicatedStorage_0:WaitForChild("Shared");
local v9 = require(l_Packages_0.Net);
local v10 = require(l_Controllers_0.InterfaceController);
local _ = require(l_Controllers_0.CameraController);
local v12 = require(l_Classes_0.AnimatedButton);
local v13 = require(l_Packages_0.Synchronizer);
local v14 = require(l_Utils_0.NumberUtils);
local v15 = require(l_Datas_0.Rebirth);
local v16 = require(l_Controllers_0.NotificationController);
local v17 = require(l_Controllers_0.AnimalController);
local v18 = require(l_Shared_0.Animals);
local v19 = require(l_Datas_0.Animals);
local v20 = require(l_Datas_0.Rarities);
local v21 = require(l_Datas_0.ShopItems);
local v22 = require(l_Shared_0.Updates);
local v23 = v9:RemoteFunction("Rebirth/RequestRebirth");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_Rebirth_0 = l_PlayerGui_0:WaitForChild("Rebirth"):WaitForChild("Rebirth");
local l_Close_0 = l_Rebirth_0.Header.Close;
local l_Content_0 = l_Rebirth_0.Content;
local l_HolderImage_0 = l_Content_0.Holder.HolderImage;
local l_Bar_0 = l_HolderImage_0.Loader.Bar;
local l_Progress_0 = l_Bar_0.Progress;
local l_ProgressText_0 = l_Bar_0.ProgressText;
local l_Rebirth_1 = l_Content_0.Rebirth;
local l_RequiredCharacters_0 = l_HolderImage_0.RequiredCharacters;
local l_Template_0 = l_RequiredCharacters_0.Template;
local l_Items_0 = l_Content_0.Unlockable.Items;
local l_Template_1 = l_Items_0.Template;
local l_Warning_0 = l_PlayerGui_0:WaitForChild("LeftCenter").LeftCenter.Buttons.Rebirth.Warning;
local v39 = nil;
local v40 = {};
local function v58(v41) --[[ Line: 68 ]] --[[ Name: CreateUnlockableItems ]]
    -- upvalues: v15 (copy), l_Items_0 (copy), l_Template_1 (copy), v21 (copy), v14 (copy)
    local v42 = #v15;
    local v43 = v41 + 1;
    if #l_Items_0:GetChildren() >= 1 then
        for _, v45 in ipairs(l_Items_0:GetChildren()) do
            if v45.Name ~= "Template" and v45:IsA("ImageLabel") then
                v45:Destroy();
            end;
        end;
    end;
    if v42 < v43 then
        return 0;
    elseif v15[v43].IsEnabled and not v15[v43].IsEnabled() and v42 - 1 < v43 then
        return 0;
    else
        local l_Rewards_0 = v15[v43].Rewards;
        for v47, v48 in pairs(l_Rewards_0) do
            if v47 == "Items" and typeof(v48) == "table" then
                for _, v50 in ipairs(v48) do
                    local v51 = l_Template_1:Clone();
                    local l_ItemName_0 = v51.ItemName;
                    local l_ItemImage_0 = v51.ItemImage;
                    l_ItemName_0.Text = string.upper(v50);
                    v51.Name = v50;
                    l_ItemImage_0.Image = v21[v50] and v21[v50].Icon or "";
                    v51.LayoutOrder = 10;
                    v51.Visible = true;
                    v51.Parent = l_Items_0;
                end;
            else
                local v54 = l_Template_1:Clone();
                local l_ItemName_1 = v54.ItemName;
                local l_ItemValue_0 = v54.ItemValue;
                local l_ItemImage_1 = v54.ItemImage;
                v54.Name = v47;
                l_ItemValue_0.Visible = true;
                if v47 == "Cash" then
                    l_ItemName_1.Text = "CASH";
                    l_ItemValue_0.Text = "$" .. v14:ToString(v48, 2);
                    l_ItemImage_1.Image = "rbxassetid://70626497369321";
                    l_ItemImage_1.ImageTransparency = 0.2;
                    v54.LayoutOrder = 2;
                elseif v47 == "Multiplier" then
                    l_ItemName_1.Text = "MULTI";
                    l_ItemValue_0.Text = "x" .. v48;
                    l_ItemImage_1.Image = "rbxassetid://70626497369321";
                    l_ItemImage_1.ImageTransparency = 0.2;
                    v54.LayoutOrder = 1;
                elseif v47 == "AdditionalLockTime" then
                    l_ItemName_1.Text = "LOCK BASE";
                    l_ItemValue_0.Text = "+10 Sec";
                    l_ItemImage_1.Image = "rbxassetid://123877736890165";
                    l_ItemImage_1.Position = UDim2.fromScale(0.5, 0.5);
                    l_ItemImage_1.ImageTransparency = 0.2;
                    v54.LayoutOrder = 3;
                elseif v47 == "FriendController" then
                    l_ItemName_1.Text = "Friend Controller";
                    l_ItemValue_0.Text = "Unlock";
                    l_ItemImage_1.Image = "rbxassetid://96730132757867";
                    l_ItemImage_1.ImageTransparency = 0.2;
                    v54.LayoutOrder = 4;
                elseif v47 == "AnimalSlot" then
                    l_ItemName_1.Text = "Slot";
                    l_ItemValue_0.Text = "+" .. v48;
                    l_ItemImage_1.Image = "rbxassetid://85000857078190";
                    l_ItemImage_1.ImageTransparency = 0.2;
                    v54.LayoutOrder = 4;
                end;
                v54.Visible = true;
                v54.Parent = l_Items_0;
            end;
        end;
        return;
    end;
end;
local function v70(v59) --[[ Line: 161 ]] --[[ Name: CreateViewportCharacters ]]
    -- upvalues: v15 (copy), l_RequiredCharacters_0 (copy), l_Template_0 (copy), v20 (copy), v19 (copy), v17 (copy), v18 (copy)
    local v60 = #v15;
    local v61 = v59 + 1;
    if #l_RequiredCharacters_0:GetChildren() >= 1 then
        for _, v63 in ipairs(l_RequiredCharacters_0:GetChildren()) do
            if v63.Name ~= "Template" and v63:IsA("ImageLabel") then
                v63:Destroy();
            end;
        end;
    end;
    if v60 < v61 then
        return 0;
    elseif v15[v61].IsEnabled and not v15[v61].IsEnabled() and v60 - 1 < v61 then
        return 0;
    else
        local l_RequiredCharacters_1 = v15[v61].Requirements.RequiredCharacters;
        local v65 = 0;
        if #l_RequiredCharacters_1 >= 1 then
            for v66, v67 in ipairs(l_RequiredCharacters_1) do
                local v68 = l_Template_0:Clone();
                v68.Name = v67 .. v66;
                v68.Visible = true;
                local l_Color_0 = v20[v19[v67].Rarity].Color;
                v68.CharacterName.Text = v67;
                v68.UIGradient.Color = v17:HasAnimal(v67) and ColorSequence.new(l_Color_0) or ColorSequence.new(Color3.new(0.223529, 0.196078, 0.215686));
                v65 = v65 + (v17:HasAnimal(v67) and 1 or 0);
                v68.CheckImage.Visible = v17:HasAnimal(v67) and true or false;
                v68.Parent = l_RequiredCharacters_0;
                v68.ViewportFrame.ImageColor3 = v17:HasAnimal(v67) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
                v18:AttachOnViewport(v67, v68.ViewportFrame, true);
            end;
        end;
        return v65;
    end;
end;
local function v76(v71, v72) --[[ Line: 216 ]] --[[ Name: UpdateRebirthButton ]]
    -- upvalues: v13 (copy), l_LocalPlayer_0 (copy), v15 (copy), l_Rebirth_1 (copy), l_Warning_0 (copy)
    local v73 = v13:Get(l_LocalPlayer_0):Get("Coins");
    local v74 = #v15;
    local v75 = v71 + 1;
    if v74 < v75 then
        l_Rebirth_1.ImageColor3 = Color3.fromRGB(138, 138, 138);
        return;
    elseif v15[v75].IsEnabled and not v15[v75].IsEnabled() and v74 - 1 < v75 then
        l_Rebirth_1.ImageColor3 = Color3.fromRGB(138, 138, 138);
        return;
    else
        if v15[v75].Requirements.Cash <= v73 and v72 == #v15[v75].Requirements.RequiredCharacters then
            l_Rebirth_1.ImageColor3 = Color3.fromRGB(255, 255, 255);
            if v75 == 1 then
                l_Warning_0.Visible = true;
                return;
            end;
        else
            l_Rebirth_1.ImageColor3 = Color3.fromRGB(138, 138, 138);
            if v75 == 1 then
                l_Warning_0.Visible = false;
            end;
        end;
        return;
    end;
end;
v40.Start = function(_) --[[ Line: 251 ]] --[[ Name: Start ]]
    -- upvalues: v39 (ref), v10 (copy), l_Rebirth_0 (copy), l_Close_0 (copy), l_Warning_0 (copy), v12 (copy), l_Rebirth_1 (copy), v23 (copy), v16 (copy), v13 (copy), l_LocalPlayer_0 (copy), v58 (copy), v70 (copy), v76 (copy), v15 (copy), l_Progress_0 (copy), l_ProgressText_0 (copy), v14 (copy), v22 (copy)
    local v78 = 0;
    local v79 = 0;
    local v80 = 0;
    v39 = v10:Register("Rebirth", l_Rebirth_0, "TopQuint");
    v39:AttachCloseButton(l_Close_0);
    v39:Close();
    v39.OnOpen:Connect(function() --[[ Line: 262 ]]
        -- upvalues: l_Warning_0 (ref)
        if l_Warning_0.Visible then
            l_Warning_0.Visible = false;
        end;
    end);
    local v81 = v12.new(l_Rebirth_1);
    v81:Animate();
    v81.OnActivated:Connect(function() --[[ Line: 270 ]]
        -- upvalues: v23 (ref), v16 (ref)
        local v82, v83 = v23:InvokeServer();
        if v82 then
            v16:Success(v83);
            return;
        else
            v16:Error(v83);
            return;
        end;
    end);
    v13:WaitAndCall(l_LocalPlayer_0, function(v84) --[[ Line: 279 ]]
        -- upvalues: v78 (ref), v58 (ref), v70 (ref), v79 (ref), v76 (ref), v15 (ref), l_Progress_0 (ref), l_ProgressText_0 (ref), v80 (ref), v14 (ref), v22 (ref)
        v84:OnChanged("Rebirth", function(v85, _) --[[ Line: 281 ]]
            -- upvalues: v78 (ref), v58 (ref), v70 (ref)
            v78 = v85;
            v58(v78);
            v70(v78);
        end, true);
        v84:OnChanged("AnimalAddedOrRemoved", function() --[[ Line: 287 ]]
            -- upvalues: v79 (ref), v70 (ref), v78 (ref), v76 (ref)
            v79 = v70(v78);
            v76(v78, v79);
        end, true);
        local function v91() --[[ Line: 293 ]] --[[ Name: TextUpdates ]]
            -- upvalues: v15 (ref), v78 (ref), v76 (ref), v79 (ref), l_Progress_0 (ref), l_ProgressText_0 (ref), v80 (ref), v14 (ref)
            local v87 = #v15;
            local v88 = v78 + 1;
            if v88 <= v87 and v15[v88].IsEnabled and not v15[v88].IsEnabled() then
                v87 = v87 - 1;
            end;
            v76(v78, v79);
            if v87 < v88 then
                l_Progress_0.Size = UDim2.new(1, 0, 1, 0);
                l_Progress_0.BackgroundColor3 = Color3.new(0.490196, 0.941176, 0.439216);
                l_ProgressText_0.Text = "Completed!";
                return;
            else
                l_Progress_0.Size = UDim2.new(math.clamp(v80 / v15[v88].Requirements.Cash, 0, 1), 0, 1, 0);
                local v89 = v80 >= v15[v88].Requirements.Cash;
                local v90 = v14:ToString(v15[v88].Requirements.Cash, 2);
                l_ProgressText_0.Text = "$ " .. (if v89 then v90 else v14:ToString((math.clamp(v80, 0, v15[v88].Requirements.Cash)))) .. " / " .. "$ " .. v90;
                l_Progress_0.BackgroundColor3 = v89 and Color3.new(0.490196, 0.941176, 0.439216) or Color3.new(0.941176, 0.729412, 0.482353);
                return;
            end;
        end;
        v84:OnChanged("Coins", function(v92, _) --[[ Line: 320 ]]
            -- upvalues: v80 (ref), v91 (copy)
            v80 = v92;
            v91();
        end, true);
        local function v94() --[[ Line: 326 ]] --[[ Name: Update ]]
            -- upvalues: v58 (ref), v78 (ref), v70 (ref), v91 (copy)
            v58(v78);
            v70(v78);
            v91();
        end;
        v22.OnUpdateEnabled:Connect(v94);
        v22.OnUpdateDisabled:Connect(v94);
        task.spawn(v94);
    end);
end;
return v40;