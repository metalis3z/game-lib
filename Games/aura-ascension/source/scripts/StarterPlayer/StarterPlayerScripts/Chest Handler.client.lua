-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = false;
local v1 = false;
task.wait();
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_GroupService_0 = game:GetService("GroupService");
local v6 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v7 = require(l_ReplicatedStorage_0["Math Utility"]);
local v8 = require(l_ReplicatedStorage_0.Signals);
local l_Shared_0 = require(l_ReplicatedStorage_0:WaitForChild("Shared"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_Hud_0 = l_PlayerGui_0:WaitForChild("Hud");
local l_ChestTimer_0 = l_Hud_0:WaitForChild("ChestTimer");
local l_GroupRewards_0 = l_PlayerGui_0:WaitForChild("ScreenFrames"):WaitForChild("GroupRewards");
local l_MainHolder_0 = l_GroupRewards_0:WaitForChild("MainHolder");
local l_CheckButton_0 = l_MainHolder_0:WaitForChild("CheckButton");
local l_ScrollingFrame_0 = l_MainHolder_0:WaitForChild("ScrollingFrame");
local l_CloseButton_0 = l_GroupRewards_0:WaitForChild("CloseButton");
local l_ChestCommunication_0 = l_ReplicatedStorage_0.Communication.ChestCommunication;
local l_Chest_0 = workspace.Map:WaitForChild("Chest");
local l_Chest_1 = l_Chest_0:WaitForChild("Chest");
local l_Hitbox_0 = l_Chest_0:WaitForChild("Hitbox");
local l_TimeBillboard_0 = l_Chest_1:WaitForChild("TimeBillboard");
local l_Frame_0 = l_TimeBillboard_0:WaitForChild("Frame");
local l_ClaimFrame_0 = l_TimeBillboard_0:WaitForChild("ClaimFrame");
local l_Highlight_0 = l_Chest_1:WaitForChild("Highlight");
local function v27(...) --[[ Line: 39 ]] --[[ Name: dprint ]]

end;
local function v28(...) --[[ Line: 45 ]] --[[ Name: dwarn ]]
    warn("[ChestClient]", ...);
end;
local _ = function(v29, v30) --[[ Line: 49 ]] --[[ Name: getChildByNames ]]
    for _, v32 in ipairs(v30) do
        local l_v29_FirstChild_0 = v29:FindFirstChild(v32);
        if l_v29_FirstChild_0 then
            return l_v29_FirstChild_0;
        end;
    end;
    return nil;
end;
local v35;
for _, v37 in ipairs({
    "Text", 
    "GroupOnlyLabel", 
    "Label"
}) do
    local l_l_TimeBillboard_0_FirstChild_0 = l_TimeBillboard_0:FindFirstChild(v37);
    if l_l_TimeBillboard_0_FirstChild_0 then
        v35 = l_l_TimeBillboard_0_FirstChild_0;
        v0 = true;
    end;
    if v0 then
        break;
    end;
end;
if not v0 then
    v35 = nil;
end;
v0 = false;
local v39;
for _, v41 in ipairs({
    "TimerText", 
    "TextLabel", 
    "Text"
}) do
    local l_l_Frame_0_FirstChild_0 = l_Frame_0:FindFirstChild(v41);
    if l_l_Frame_0_FirstChild_0 then
        v39 = l_l_Frame_0_FirstChild_0;
        v1 = true;
    end;
    if v1 then
        break;
    end;
end;
if not v1 then
    v39 = nil;
end;
v1 = false;
assert(v35 and v35:IsA("TextLabel"), "[ChestClient] Missing Billboard group-only TextLabel (expected one of: Text / GroupOnlyLabel / Label)");
assert(v39 and v39:IsA("TextLabel"), "[ChestClient] Missing Timer TextLabel inside Billboard.Frame (expected one of: TimerText / TextLabel / Text)");
l_GroupRewards_0.Visible = false;
local v43 = l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
    FillTransparency = 0
});
local v44 = l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
    FillTransparency = 1
});
local l_Size_0 = l_Chest_1.Size;
local v46 = l_Size_0 * 0.4;
local v47 = l_Size_0 * 1.08;
local v48 = l_TweenService_0:Create(l_Chest_1, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
    Size = v46
});
local v49 = l_TweenService_0:Create(l_Chest_1, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = v47
});
local v50 = l_TweenService_0:Create(l_Chest_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = l_Size_0
});
local l_HeadShot_0 = Enum.ThumbnailType.HeadShot;
local l_Size100x100_0 = Enum.ThumbnailSize.Size100x100;
local function v58(v53, v54) --[[ Line: 108 ]] --[[ Name: setIconFromUserId ]]
    -- upvalues: l_Players_0 (copy), l_HeadShot_0 (copy), l_Size100x100_0 (copy), v28 (copy), v27 (copy)
    if v54 <= 0 then
        return;
    else
        local v55, v56, v57 = pcall(function() --[[ Line: 113 ]]
            -- upvalues: l_Players_0 (ref), v54 (copy), l_HeadShot_0 (ref), l_Size100x100_0 (ref)
            return l_Players_0:GetUserThumbnailAsync(v54, l_HeadShot_0, l_Size100x100_0);
        end);
        if not v55 then
            v28("Failed to get thumbnail for userId", v54, v56);
            return;
        else
            if v56 and v56 ~= "" then
                v53.Image = v56;
                v27("Set icon", v53:GetFullName(), "userId=", v54, "ready=", v57);
            end;
            return;
        end;
    end;
end;
local function v62(v59) --[[ Line: 128 ]] --[[ Name: updateProfileIcon ]]
    -- upvalues: v28 (copy), v58 (copy)
    if not v59:IsA("ImageLabel") then
        return;
    else
        local l_v59_Attribute_0 = v59:GetAttribute("Id");
        local v61 = tonumber(l_v59_Attribute_0);
        if not v61 then
            v28("Icon missing valid Id attribute:", v59:GetFullName(), "rawId=", l_v59_Attribute_0);
            return;
        else
            v58(v59, v61);
            return;
        end;
    end;
end;
local function v65() --[[ Line: 144 ]] --[[ Name: refreshAllProfileIcons ]]
    -- upvalues: l_ScrollingFrame_0 (copy), v62 (copy)
    for _, v64 in ipairs(l_ScrollingFrame_0:GetDescendants()) do
        if v64:IsA("ImageLabel") and v64.Name == "Icn" then
            v62(v64);
        end;
    end;
end;
local function v67(v66) --[[ Line: 152 ]] --[[ Name: hookProfileIcon ]]
    -- upvalues: v62 (copy)
    if not v66:IsA("ImageLabel") or v66.Name ~= "Icn" then
        return;
    else
        v62(v66);
        v66:GetAttributeChangedSignal("Id"):Connect(function() --[[ Line: 159 ]]
            -- upvalues: v62 (ref), v66 (copy)
            v62(v66);
        end);
        return;
    end;
end;
local v68 = false;
local v69 = false;
local v70 = 0;
local v71 = false;
local v72 = false;
local v73 = false;
local v74 = false;
v27("Init");
v27("Hud:", l_Hud_0:GetFullName());
v27("GroupRewardsFrame:", l_GroupRewards_0:GetFullName());
v27("Chest:", l_Chest_0:GetFullName());
v27("Hitbox:", l_Hitbox_0:GetFullName());
local function v77() --[[ Line: 178 ]] --[[ Name: playChestClaimSequence ]]
    -- upvalues: v27 (copy), l_Highlight_0 (copy), v43 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), v48 (copy), v49 (copy), v50 (copy), v44 (copy)
    v27("playChestClaimSequence");
    l_Highlight_0.FillTransparency = 1;
    l_Highlight_0.Enabled = true;
    v43:Play();
    task.spawn(function() --[[ Line: 185 ]]
        -- upvalues: v8 (ref)
        v8.PlayConfetti:Fire();
    end);
    local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    if l_Assets_0 and l_Assets_0:FindFirstChild("Sounds") then
        local l_Sounds_0 = l_Assets_0.Sounds;
        if l_Sounds_0:FindFirstChild("PurchaseSound") then
            l_Sounds_0.PurchaseSound:Play();
        end;
        if l_Sounds_0:FindFirstChild("Gadget") then
            l_Sounds_0.Gadget:Play();
        end;
        task.delay(0.5, function() --[[ Line: 201 ]]
            -- upvalues: l_Sounds_0 (copy)
            if l_Sounds_0:FindFirstChild("XP") then
                l_Sounds_0.XP:Play();
            end;
        end);
    end;
    v48:Play();
    v48.Completed:Once(function() --[[ Line: 209 ]]
        -- upvalues: v49 (ref), v50 (ref)
        v49:Play();
        v49.Completed:Once(function() --[[ Line: 211 ]]
            -- upvalues: v50 (ref)
            v50:Play();
        end);
    end);
    task.delay(0.5, function() --[[ Line: 216 ]]
        -- upvalues: v44 (ref)
        v44:Play();
    end);
end;
local function _(v78) --[[ Line: 221 ]] --[[ Name: setGroupRewardsVisible ]]
    -- upvalues: l_GroupRewards_0 (copy), v27 (copy)
    if l_GroupRewards_0.Visible ~= v78 then
        v27("setGroupRewardsVisible", v78);
    end;
    l_GroupRewards_0.Visible = v78;
end;
local function _() --[[ Line: 229 ]] --[[ Name: refreshGroupRewardsVisibility ]]
    -- upvalues: v71 (ref), v72 (ref), l_GroupRewards_0 (copy), v27 (copy)
    if v71 and not v72 then
        if l_GroupRewards_0.Visible ~= true then
            v27("setGroupRewardsVisible", true);
        end;
        l_GroupRewards_0.Visible = true;
        return;
    else
        if l_GroupRewards_0.Visible ~= false then
            v27("setGroupRewardsVisible", false);
        end;
        l_GroupRewards_0.Visible = false;
        return;
    end;
end;
local function _(v81, v82) --[[ Line: 237 ]] --[[ Name: setChestVisual ]]
    -- upvalues: v27 (copy), v35 (ref), l_Frame_0 (copy), l_ClaimFrame_0 (copy), l_ChestTimer_0 (copy), v74 (ref), v39 (ref), v6 (copy), v7 (copy)
    v27("setChestVisual", v81, v82);
    if v81 == "locked" then
        v35.Visible = true;
        v35.Text = "Group Only";
        l_Frame_0.Visible = false;
        l_ClaimFrame_0.Visible = false;
        l_ChestTimer_0.Text = "GROUP ONLY";
        l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 200, 0);
        local l_RainbowGradient_0 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
        if l_RainbowGradient_0 and l_RainbowGradient_0:IsA("UIGradient") then
            l_RainbowGradient_0.Enabled = false;
        end;
        local l_UIStroke_0 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_0 then
            l_UIStroke_0.Color = Color3.fromRGB(120, 85, 0);
        end;
        v74 = false;
        return;
    else
        v35.Visible = false;
        l_Frame_0.Visible = true;
        if v81 == "ready" then
            v39.Text = "\240\159\142\129 READY!";
            l_ClaimFrame_0.Visible = true;
            l_ChestTimer_0.Text = "CHEST READY!";
            l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 255, 255);
            local l_RainbowGradient_1 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
            if l_RainbowGradient_1 and l_RainbowGradient_1:IsA("UIGradient") then
                l_RainbowGradient_1.Enabled = true;
            end;
            local l_UIStroke_1 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
            if l_UIStroke_1 then
                l_UIStroke_1.Color = Color3.fromRGB(58, 58, 58);
            end;
            if not v74 then
                v74 = true;
                v6.New("CHEST READY TO CLAIM", "Spin");
            end;
            return;
        else
            if v81 == "cooldown" then
                l_ClaimFrame_0.Visible = false;
                local v87 = v7.FormatSecondsIntoCleanTime(v82 or 0);
                v39.Text = v87;
                l_ChestTimer_0.Text = "CHEST - " .. v87;
                l_ChestTimer_0.TextColor3 = Color3.fromRGB(0, 255, 0);
                local l_RainbowGradient_2 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
                if l_RainbowGradient_2 and l_RainbowGradient_2:IsA("UIGradient") then
                    l_RainbowGradient_2.Enabled = false;
                end;
                local l_UIStroke_2 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
                if l_UIStroke_2 then
                    l_UIStroke_2.Color = Color3.fromRGB(0, 76, 0);
                end;
                v74 = false;
            end;
            return;
        end;
    end;
end;
local function v101(v91) --[[ Line: 315 ]] --[[ Name: syncCooldown ]]
    -- upvalues: v27 (copy), v72 (ref), v69 (ref), v70 (ref), v35 (ref), l_Frame_0 (copy), l_ClaimFrame_0 (copy), l_ChestTimer_0 (copy), v74 (ref), v7 (copy), v39 (ref), v6 (copy), v71 (ref), l_GroupRewards_0 (copy)
    v27("syncCooldown raw payload:", v91);
    if typeof(v91) == "number" then
        v91 = {
            Remaining = v91, 
            InGroup = true
        };
    end;
    local v92 = 0;
    if typeof(v91) == "table" then
        v92 = tonumber(v91.Remaining) or 0;
        v72 = v91.InGroup == true;
    else
        v72 = true;
    end;
    v27("syncCooldown parsed", "secondsRemaining=", v92, "inGroup=", v72);
    if not v72 then
        v69 = false;
        v70 = 0;
        v27("setChestVisual", "locked", nil);
        v35.Visible = true;
        v35.Text = "Group Only";
        l_Frame_0.Visible = false;
        l_ClaimFrame_0.Visible = false;
        l_ChestTimer_0.Text = "GROUP ONLY";
        l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 200, 0);
        local l_RainbowGradient_3 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
        if l_RainbowGradient_3 and l_RainbowGradient_3:IsA("UIGradient") then
            l_RainbowGradient_3.Enabled = false;
        end;
        local l_UIStroke_3 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_3 then
            l_UIStroke_3.Color = Color3.fromRGB(120, 85, 0);
        end;
        v74 = false;
    elseif v92 > 0 then
        v69 = true;
        v70 = time() + v92;
        local l_v92_0 = v92;
        v27("setChestVisual", "cooldown", l_v92_0);
        v35.Visible = false;
        l_Frame_0.Visible = true;
        l_ClaimFrame_0.Visible = false;
        local v96 = v7.FormatSecondsIntoCleanTime(l_v92_0 or 0);
        v39.Text = v96;
        l_ChestTimer_0.Text = "CHEST - " .. v96;
        l_ChestTimer_0.TextColor3 = Color3.fromRGB(0, 255, 0);
        local l_RainbowGradient_4 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
        if l_RainbowGradient_4 and l_RainbowGradient_4:IsA("UIGradient") then
            l_RainbowGradient_4.Enabled = false;
        end;
        local l_UIStroke_4 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_4 then
            l_UIStroke_4.Color = Color3.fromRGB(0, 76, 0);
        end;
        v74 = false;
    else
        v69 = false;
        v70 = 0;
        v27("setChestVisual", "ready", nil);
        v35.Visible = false;
        l_Frame_0.Visible = true;
        v39.Text = "\240\159\142\129 READY!";
        l_ClaimFrame_0.Visible = true;
        l_ChestTimer_0.Text = "CHEST READY!";
        l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 255, 255);
        local l_RainbowGradient_5 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
        if l_RainbowGradient_5 and l_RainbowGradient_5:IsA("UIGradient") then
            l_RainbowGradient_5.Enabled = true;
        end;
        local l_UIStroke_5 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
        if l_UIStroke_5 then
            l_UIStroke_5.Color = Color3.fromRGB(58, 58, 58);
        end;
        if not v74 then
            v74 = true;
            v6.New("CHEST READY TO CLAIM", "Spin");
        end;
    end;
    if v71 and not v72 then
        if l_GroupRewards_0.Visible ~= true then
            v27("setGroupRewardsVisible", true);
        end;
        l_GroupRewards_0.Visible = true;
        return;
    else
        if l_GroupRewards_0.Visible ~= false then
            v27("setGroupRewardsVisible", false);
        end;
        l_GroupRewards_0.Visible = false;
        return;
    end;
end;
local function _() --[[ Line: 353 ]] --[[ Name: isInsideHitbox ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Hitbox_0 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return false;
    else
        local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
        if not l_HumanoidRootPart_0 or not l_HumanoidRootPart_0:IsA("BasePart") then
            return false;
        else
            return (l_HumanoidRootPart_0.Position - l_Hitbox_0.Position).Magnitude <= 25;
        end;
    end;
end;
local function _(v105) --[[ Line: 368 ]] --[[ Name: isLocalCharacterFromPart ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_v105_FirstAncestorOfClass_0 = v105:FindFirstAncestorOfClass("Model");
    local v107 = false;
    if l_v105_FirstAncestorOfClass_0 ~= nil then
        v107 = l_v105_FirstAncestorOfClass_0 == l_LocalPlayer_0.Character;
    end;
    return v107;
end;
local function v109() --[[ Line: 373 ]] --[[ Name: tryClaimChest ]]
    -- upvalues: v27 (copy), v68 (ref), v72 (ref), v69 (ref), v71 (ref), l_GroupRewards_0 (copy), l_ChestCommunication_0 (copy)
    v27("tryClaimChest", "touchDebounce=", v68, "inGroup=", v72, "onCooldown=", v69, "insideChestZone=", v71);
    if v68 then
        return;
    elseif not v72 then
        if v71 and not v72 then
            if l_GroupRewards_0.Visible ~= true then
                v27("setGroupRewardsVisible", true);
            end;
            l_GroupRewards_0.Visible = true;
            return;
        else
            if l_GroupRewards_0.Visible ~= false then
                v27("setGroupRewardsVisible", false);
            end;
            l_GroupRewards_0.Visible = false;
            return;
        end;
    elseif v69 then
        return;
    else
        v68 = true;
        l_ChestCommunication_0:FireServer("Claim");
        task.delay(0.75, function() --[[ Line: 398 ]]
            -- upvalues: v68 (ref)
            v68 = false;
        end);
        return;
    end;
end;
l_ChestCommunication_0.OnClientEvent:Connect(function(v110, v111) --[[ Line: 403 ]]
    -- upvalues: v27 (copy), v101 (copy), v77 (copy), v72 (ref), v35 (ref), l_Frame_0 (copy), l_ClaimFrame_0 (copy), l_ChestTimer_0 (copy), v74 (ref), v71 (ref), l_GroupRewards_0 (copy)
    v27("OnClientEvent", v110, v111);
    if v110 == "SyncCooldown" then
        v101(v111);
        return;
    elseif v110 == "ClaimSuccess" then
        v101({
            Remaining = v111 and v111.Cooldown or 300, 
            InGroup = true
        });
        v77();
        return;
    else
        if v110 == "ClaimFail" and typeof(v111) == "table" then
            if v111.Reason == "Cooldown" and v111.Remaining then
                v101({
                    Remaining = v111.Remaining, 
                    InGroup = v72
                });
                return;
            elseif v111.Reason == "NotInGroup" then
                v72 = false;
                v27("setChestVisual", "locked", nil);
                v35.Visible = true;
                v35.Text = "Group Only";
                l_Frame_0.Visible = false;
                l_ClaimFrame_0.Visible = false;
                l_ChestTimer_0.Text = "GROUP ONLY";
                l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 200, 0);
                local l_RainbowGradient_6 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
                if l_RainbowGradient_6 and l_RainbowGradient_6:IsA("UIGradient") then
                    l_RainbowGradient_6.Enabled = false;
                end;
                local l_UIStroke_6 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
                if l_UIStroke_6 then
                    l_UIStroke_6.Color = Color3.fromRGB(120, 85, 0);
                end;
                v74 = false;
                if v71 and not v72 then
                    if l_GroupRewards_0.Visible ~= true then
                        v27("setGroupRewardsVisible", true);
                    end;
                    l_GroupRewards_0.Visible = true;
                    return;
                else
                    if l_GroupRewards_0.Visible ~= false then
                        v27("setGroupRewardsVisible", false);
                    end;
                    l_GroupRewards_0.Visible = false;
                end;
            end;
        end;
        return;
    end;
end);
l_CheckButton_0.Activated:Connect(function() --[[ Line: 436 ]]
    -- upvalues: v27 (copy), v73 (ref), v72 (ref), l_GroupRewards_0 (copy), l_GroupService_0 (copy), l_Shared_0 (copy), v28 (copy), l_ChestCommunication_0 (copy), v71 (ref)
    v27("CheckButton.Activated", "isPromptingGroupJoin=", v73, "inGroup=", v72);
    if v73 then
        return;
    elseif v72 then
        if l_GroupRewards_0.Visible ~= false then
            v27("setGroupRewardsVisible", false);
        end;
        l_GroupRewards_0.Visible = false;
        return;
    else
        v73 = true;
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 450 ]]
            -- upvalues: l_GroupService_0 (ref), l_Shared_0 (ref)
            return l_GroupService_0:PromptJoinAsync(l_Shared_0.GroupId);
        end);
        if not l_status_0 then
            v28("PromptJoinAsync failed:", l_result_0);
        end;
        task.delay(2, function() --[[ Line: 458 ]]
            -- upvalues: l_ChestCommunication_0 (ref)
            l_ChestCommunication_0:FireServer("RequestSync");
        end);
        task.delay(5, function() --[[ Line: 462 ]]
            -- upvalues: v73 (ref), l_ChestCommunication_0 (ref), v71 (ref), v72 (ref), l_GroupRewards_0 (ref), v27 (ref)
            v73 = false;
            l_ChestCommunication_0:FireServer("RequestSync");
            if v71 and not v72 then
                if l_GroupRewards_0.Visible ~= true then
                    v27("setGroupRewardsVisible", true);
                end;
                l_GroupRewards_0.Visible = true;
                return;
            else
                if l_GroupRewards_0.Visible ~= false then
                    v27("setGroupRewardsVisible", false);
                end;
                l_GroupRewards_0.Visible = false;
                return;
            end;
        end);
        return;
    end;
end);
l_CloseButton_0.Activated:Connect(function() --[[ Line: 469 ]]
    -- upvalues: v27 (copy), l_GroupRewards_0 (copy)
    v27("CloseButton.Activated");
    if l_GroupRewards_0.Visible ~= false then
        v27("setGroupRewardsVisible", false);
    end;
    l_GroupRewards_0.Visible = false;
end);
task.spawn(function() --[[ Line: 474 ]]
    -- upvalues: v69 (ref), v70 (ref), v72 (ref), v27 (copy), v35 (ref), l_Frame_0 (copy), v39 (ref), l_ClaimFrame_0 (copy), l_ChestTimer_0 (copy), v74 (ref), v6 (copy), v7 (copy)
    while true do
        if v69 then
            local v116 = math.max(0, (math.ceil(v70 - time())));
            if v116 <= 0 then
                v69 = false;
                v70 = 0;
                if v72 then
                    v27("setChestVisual", "ready", nil);
                    v35.Visible = false;
                    l_Frame_0.Visible = true;
                    v39.Text = "\240\159\142\129 READY!";
                    l_ClaimFrame_0.Visible = true;
                    l_ChestTimer_0.Text = "CHEST READY!";
                    l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 255, 255);
                    local l_RainbowGradient_7 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
                    if l_RainbowGradient_7 and l_RainbowGradient_7:IsA("UIGradient") then
                        l_RainbowGradient_7.Enabled = true;
                    end;
                    local l_UIStroke_7 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
                    if l_UIStroke_7 then
                        l_UIStroke_7.Color = Color3.fromRGB(58, 58, 58);
                    end;
                    if not v74 then
                        v74 = true;
                        v6.New("CHEST READY TO CLAIM", "Spin");
                    end;
                else
                    v27("setChestVisual", "locked", nil);
                    v35.Visible = true;
                    v35.Text = "Group Only";
                    l_Frame_0.Visible = false;
                    l_ClaimFrame_0.Visible = false;
                    l_ChestTimer_0.Text = "GROUP ONLY";
                    l_ChestTimer_0.TextColor3 = Color3.fromRGB(255, 200, 0);
                    local l_RainbowGradient_8 = l_ChestTimer_0:FindFirstChild("RainbowGradient");
                    if l_RainbowGradient_8 and l_RainbowGradient_8:IsA("UIGradient") then
                        l_RainbowGradient_8.Enabled = false;
                    end;
                    local l_UIStroke_8 = l_ChestTimer_0:FindFirstChildOfClass("UIStroke");
                    if l_UIStroke_8 then
                        l_UIStroke_8.Color = Color3.fromRGB(120, 85, 0);
                    end;
                    v74 = false;
                end;
            else
                local v121 = v7.FormatSecondsIntoCleanTime(v116);
                v39.Text = v121;
                l_ChestTimer_0.Text = "CHEST - " .. v121;
            end;
        end;
        task.wait(1);
    end;
end);
task.spawn(function() --[[ Line: 499 ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Hitbox_0 (copy), v71 (ref), v72 (ref), l_GroupRewards_0 (copy), v27 (copy)
    while true do
        local l_Character_1 = l_LocalPlayer_0.Character;
        local v123;
        if not l_Character_1 then
            v123 = false;
        else
            local l_HumanoidRootPart_1 = l_Character_1:FindFirstChild("HumanoidRootPart");
            v123 = if l_HumanoidRootPart_1 and l_HumanoidRootPart_1:IsA("BasePart") then (l_HumanoidRootPart_1.Position - l_Hitbox_0.Position).Magnitude <= 25 else false;
        end;
        if v123 ~= v71 then
            v71 = v123;
            if v71 and not v72 then
                if l_GroupRewards_0.Visible ~= true then
                    v27("setGroupRewardsVisible", true);
                end;
                l_GroupRewards_0.Visible = true;
            else
                if l_GroupRewards_0.Visible ~= false then
                    v27("setGroupRewardsVisible", false);
                end;
                l_GroupRewards_0.Visible = false;
            end;
        end;
        task.wait(0.2);
    end;
end);
l_Hitbox_0.Touched:Connect(function(v125) --[[ Line: 512 ]]
    -- upvalues: l_LocalPlayer_0 (copy), v71 (ref), v72 (ref), l_GroupRewards_0 (copy), v27 (copy), v109 (copy)
    if not v125 then
        return;
    else
        local l_v125_FirstAncestorOfClass_0 = v125:FindFirstAncestorOfClass("Model");
        local v127 = false;
        if l_v125_FirstAncestorOfClass_0 ~= nil then
            v127 = l_v125_FirstAncestorOfClass_0 == l_LocalPlayer_0.Character;
        end;
        if not v127 then
            return;
        else
            v127 = l_LocalPlayer_0.Character;
            if not v127 then
                return;
            else
                l_v125_FirstAncestorOfClass_0 = v127:FindFirstChildOfClass("Humanoid");
                if not l_v125_FirstAncestorOfClass_0 or l_v125_FirstAncestorOfClass_0.Health <= 0 then
                    return;
                else
                    v71 = true;
                    if v71 and not v72 then
                        if l_GroupRewards_0.Visible ~= true then
                            v27("setGroupRewardsVisible", true);
                        end;
                        l_GroupRewards_0.Visible = true;
                    else
                        if l_GroupRewards_0.Visible ~= false then
                            v27("setGroupRewardsVisible", false);
                        end;
                        l_GroupRewards_0.Visible = false;
                    end;
                    v109();
                    return;
                end;
            end;
        end;
    end;
end);
l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 536 ]]
    -- upvalues: l_ChestCommunication_0 (copy)
    task.delay(1, function() --[[ Line: 537 ]]
        -- upvalues: l_ChestCommunication_0 (ref)
        l_ChestCommunication_0:FireServer("RequestSync");
    end);
end);
v65();
for _, v129 in ipairs(l_ScrollingFrame_0:GetDescendants()) do
    v67(v129);
end;
l_ScrollingFrame_0.DescendantAdded:Connect(function(v130) --[[ Line: 548 ]]
    -- upvalues: v67 (copy)
    v67(v130);
end);
l_ChestCommunication_0:FireServer("RequestSync");