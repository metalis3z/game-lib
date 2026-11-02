-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: EventShopClient, time of decompilation: Fri Nov 28 21:12:17 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.Misc.Trove);
local v9 = require(l_ReplicatedStorage_0.Modules.Misc.Signal);
local v10 = require(l_ReplicatedStorage_0.Modules.Sounds);
local v11 = require(l_ReplicatedStorage_0.Modules.Util);
local v12 = require(l_ReplicatedStorage_0.Systems.Player.Miscellaneous.NotificationDisplay);
local v13 = require(script.Parent.Parent.Meta.EventShopMeta);
local v14 = require(script.Dialog);
local v15 = l_RunService_0:IsStudio();
local l_script_FullName_0 = script:GetFullName();
local l_EventShop_0 = script:FindFirstChild("EventUI").EventShop;
local v18 = {
    Normal = "Bribe Nosferatu", 
    MakeSure = "Are you sure?", 
    Processing = "PROCESSING..."
};
local v19 = {
    Normal = "Purchase", 
    MakeSure = "Are you sure?", 
    Processing = "PROCESSING..."
};
local v20 = Color3.fromRGB(177, 26, 28);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v22 = l_LocalPlayer_0 and l_LocalPlayer_0.PlayerGui;
local v23 = l_LocalPlayer_0 and l_LocalPlayer_0:FindFirstChild("PlayerData");
local v24 = l_LocalPlayer_0 and l_LocalPlayer_0:GetMouse();
local l_Presets_0 = script.Presets;
local l_max_0 = math.max;
local l_floor_0 = math.floor;
local l_clamp_0 = math.clamp;
local l_time_0 = os.time;
local l_delay_0 = task.delay;
local function _(v31) --[[ Line: 59 ]] --[[ Name: __displayWarn ]]
    -- upvalues: v15 (copy), l_script_FullName_0 (copy)
    assert(type(v31) == "string", "bad message");
    if not v15 then
        return;
    else
        warn((("[%*]: %*"):format(l_script_FullName_0, v31)));
        return;
    end;
end;
local l_Assets_0 = l_ReplicatedStorage_0:WaitForChild("Assets");
local function v39(v34) --[[ Line: 70 ]] --[[ Name: __getCosmeticFromDirectory ]]
    -- upvalues: l_Assets_0 (copy)
    local v35 = string.split(v34, "/");
    local l_l_Assets_0_0 = l_Assets_0;
    for _, v38 in v35 do
        if not l_l_Assets_0_0 then
            return nil;
        else
            l_l_Assets_0_0 = l_l_Assets_0_0:FindFirstChild(v38);
        end;
    end;
    return l_l_Assets_0_0;
end;
local function _(v40) --[[ Line: 84 ]] --[[ Name: __hideString ]]
    return (string.gsub(v40, ".", "?"));
end;
local function _() --[[ Line: 89 ]] --[[ Name: __getSecondsWithinHour ]]
    -- upvalues: l_time_0 (copy)
    return 3600 - l_time_0() % 3600;
end;
local function _(v43, v44, v45) --[[ Line: 93 ]] --[[ Name: __mapValue ]]
    -- upvalues: l_clamp_0 (copy)
    return (l_clamp_0(v44 + (v45 - v44) * v43, v44, v45));
end;
local function _(v47, v48, v49) --[[ Line: 97 ]] --[[ Name: __normalizeValue ]]
    -- upvalues: l_clamp_0 (copy)
    return (l_clamp_0((v47 - v48) / (v49 - v48), 0, 1));
end;
local function _(v51, v52) --[[ Line: 101 ]] --[[ Name: __snap ]]
    -- upvalues: l_floor_0 (copy)
    return v52 == 0 and v51 or l_floor_0((v51 + v52 / 2) / v52) * v52;
end;
local v54 = nil;
local function v58() --[[ Line: 109 ]] --[[ Name: __getTotalStock ]]
    -- upvalues: v7 (copy), v54 (ref), v15 (copy), l_script_FullName_0 (copy)
    local v55 = nil;
    local v56 = 0;
    while true do
        if typeof(v55) ~= "table" then
            v55 = v7:FireServerConnection("GetCurrentStockAsync", "REMOTE_FUNCTION");
            if not v55 or (v55 and v55.Stock) ~= (v54 and v54.Stock) then
                v56 = v56 + 1;
                if v56 >= 3 then
                    assert(true, "bad message");
                    if v15 then
                        warn((("[%*]: Failed to get current stock."):format(l_script_FullName_0)));
                    end;
                    return nil;
                else
                    local v57 = ("Failed to get stock, retrying... (attempt #%*/%*)"):format(v56, 3);
                    assert(type(v57) == "string", "bad message");
                    if v15 then
                        warn((("[%*]: %*"):format(l_script_FullName_0, v57)));
                    end;
                    task.wait(v56 * 2 + 1);
                end;
            end;
        else
            return v55;
        end;
    end;
end;
local function _(v59) --[[ Line: 129 ]] --[[ Name: __setUIState ]]
    -- upvalues: v22 (copy), v15 (copy), l_script_FullName_0 (copy)
    if not v22 then
        assert(true, "bad message");
        if not v15 then
            return;
        else
            warn((("[%*]: Failed to find the local players PlayerGui, returning..."):format(l_script_FullName_0)));
            return;
        end;
    else
        local l_MainUI_0 = v22:FindFirstChild("MainUI");
        if l_MainUI_0 then
            l_MainUI_0.Enabled = not v59;
        end;
        return;
    end;
end;
return {
    __isInitialized = false, 
    __internalTrove = v8.new(), 
    __internalState = {
        isSureForPurchase = false, 
        isProcessingRestockPurchase = false, 
        isSureForSkinPurchase = false, 
        isProcessingSkinPurchase = false, 
        isSelectSkinDebounce = false, 
        isDragging = false
    }, 
    _currentDialogThread = nil, 
    ShopUI = nil, 
    FirstTimeOpened = false, 
    __switchDialogue = function(v62, v63) --[[ Line: 206 ]] --[[ Name: __switchDialogue ]]
        -- upvalues: v15 (copy), l_script_FullName_0 (copy), v14 (copy)
        local v64 = ("Setting dialog type to %*"):format(v63);
        assert(type(v64) == "string", "bad message");
        if v15 then
            warn((("[%*]: %*"):format(l_script_FullName_0, v64)));
        end;
        v64 = v62.ShopUI.ConversionFrame.ConversationFrame.Display;
        local v65 = v14[v63];
        local v66 = typeof(v65) == "table" and v65[math.random(1, #v65)] or v65;
        if v62._currentDialogThread then
            task.cancel(v62._currentDialogThread);
            v62._currentDialogThread = nil;
        end;
        v64.Text = "";
        v64.MaxVisibleGraphemes = 0;
        v64.Text = v66;
        local v67 = utf8.len(v66);
        if v67 then
            local v68 = 2 / v67;
            v62._currentDialogThread = task.spawn(function() --[[ Line: 226 ]]
                -- upvalues: v67 (copy), v64 (copy), v68 (copy), v62 (copy)
                for v69 = 0, v67 do
                    v64.MaxVisibleGraphemes = v69;
                    task.wait(v68);
                end;
                v62._currentDialogThread = nil;
            end);
        end;
    end, 
    __initializeUI = function(v70) --[[ Line: 236 ]] --[[ Name: __initializeUI ]]
        -- upvalues: l_EventShop_0 (copy), v15 (copy), l_script_FullName_0 (copy), v54 (ref), v58 (copy), l_max_0 (copy), l_time_0 (copy), l_RunService_0 (copy), l_floor_0 (copy), l_LocalPlayer_0 (copy), v11 (copy), v24 (copy), l_clamp_0 (copy), v10 (copy), l_TweenService_0 (copy), v18 (copy), l_UserInputService_0 (copy), v7 (copy), v23 (copy), v39 (copy), l_Presets_0 (copy), v12 (copy), v20 (copy), v13 (copy), v9 (copy), l_Debris_0 (copy), l_delay_0 (copy), v19 (copy)
        local v71 = l_EventShop_0 and l_EventShop_0.Parent:Clone();
        if not v71 then
            assert(true, "bad message");
            if not v15 then
                return;
            else
                warn((("[%*]: Failed to find the Event Shop UI."):format(l_script_FullName_0)));
                return;
            end;
        else
            local l_EventShop_1 = v71:FindFirstChild("EventShop");
            l_EventShop_1.Visible = false;
            local v73 = v54 or v58();
            if not v73 then
                assert(true, "bad message");
                if not v15 then
                    return;
                else
                    warn((("[%*]: Failed to get current stock, returning..."):format(l_script_FullName_0)));
                    return;
                end;
            else
                v54 = v73;
                local v74 = l_max_0(v73.Stock - v73.PlayerAmountBought, 0);
                local l_ConversionButton_0 = l_EventShop_1.ConversionFrame.ConversionButton;
                local l_Exchange_0 = l_ConversionButton_0:FindFirstChild("Exchange");
                local l_Display_0 = l_ConversionButton_0:FindFirstChild("Display");
                local l_RestockAmountDisplay_0 = l_ConversionButton_0:FindFirstChild("RestockAmountDisplay");
                local function _(v79) --[[ Line: 259 ]] --[[ Name: __decrementAvailableBuy ]]
                    -- upvalues: v74 (ref), l_max_0 (ref)
                    return (l_max_0(v74 - v79, 0));
                end;
                local function _() --[[ Line: 263 ]] --[[ Name: __hasAvailableStock ]]
                    -- upvalues: v74 (ref)
                    return v74 > 0;
                end;
                if l_RestockAmountDisplay_0 then
                    l_RestockAmountDisplay_0.Text = ("(%*/%*)"):format(v74, v73.Stock);
                end;
                l_EventShop_1.InformationFrame.ExitButton.Activated:Connect(function() --[[ Line: 271 ]]
                    -- upvalues: v70 (copy)
                    v70:__closeUI();
                end);
                local l_RestockTimeDisplay_0 = l_EventShop_1.ConversionFrame.ConversionButton.RestockTimeDisplay;
                local v83 = 3600 - l_time_0() % 3600;
                local v84 = false;
                v70.__internalTrove:Connect(l_RunService_0.Heartbeat, function(v85) --[[ Line: 278 ]]
                    -- upvalues: v83 (ref), v84 (ref), v58 (ref), l_RestockTimeDisplay_0 (copy), v74 (ref), l_max_0 (ref), l_time_0 (ref), l_RestockAmountDisplay_0 (copy), l_floor_0 (ref)
                    if v83 <= 0 and not v84 then
                        v84 = true;
                        local l_status_0, l_result_0 = pcall(v58);
                        if l_status_0 and l_result_0 then
                            l_RestockTimeDisplay_0.Text = "Restocking!";
                            v74 = l_max_0(l_result_0.Stock - l_result_0.PlayerAmountBought, 0);
                            v83 = 3600 - l_time_0() % 3600;
                            if l_RestockAmountDisplay_0 then
                                l_RestockAmountDisplay_0.Text = ("(%*/%*)"):format(v74, l_result_0.Stock);
                            end;
                        end;
                        v84 = false;
                    end;
                    v83 = l_max_0(v83 - v85, 0);
                    local v88 = l_floor_0(v83 / 60);
                    local v89 = l_floor_0(v83 % 60);
                    local v90 = string.format("%02d:%02d", v88, v89);
                    if l_RestockTimeDisplay_0.Text ~= v90 then
                        l_RestockTimeDisplay_0.Text = v90;
                    end;
                end);
                local v91 = l_LocalPlayer_0 and l_LocalPlayer_0:FindFirstChild("PlayerData");
                local v92 = v91 and v91.EventCurrency:FindFirstChild("2025_MASQUERADE");
                local l_CurrencyText_0 = l_EventShop_1.ConversionFrame.CurrencyDisplay.CurrencyText;
                if v92 then
                    local function v95(v94) --[[ Line: 311 ]] --[[ Name: __onValueChanged ]]
                        -- upvalues: l_CurrencyText_0 (copy), v11 (ref)
                        l_CurrencyText_0.Text = v11:ToCommas(v94);
                    end;
                    local l_Value_0 = v92.Value;
                    l_CurrencyText_0.Text = v11:ToCommas(l_Value_0);
                    v70.__internalTrove:Connect(v92.Changed, v95);
                else
                    warn((("[%*]: Failed to get Event currency... not displaying!"):format((script:GetFullName()))));
                end;
                l_EventShop_1.ConversionFrame.CurrencyDisplay.Visible = v92 ~= nil;
                local l_DragBar_0 = l_EventShop_1.ConversionFrame:FindFirstChild("DragBar");
                local v98 = l_DragBar_0 and l_DragBar_0:FindFirstChild("Dragger");
                local v99 = v98 and v98:FindFirstChild("Title");
                local v100 = TweenInfo.new(0.1);
                local v101 = 1;
                local function v111(v102) --[[ Line: 329 ]] --[[ Name: __calculateDrag ]]
                    -- upvalues: l_DragBar_0 (copy), v98 (copy), v24 (ref), v74 (ref), l_clamp_0 (ref), l_floor_0 (ref), v101 (ref), v10 (ref), l_TweenService_0 (ref), v100 (copy), v99 (copy), l_Exchange_0 (copy), v11 (ref), l_Display_0 (copy), v70 (copy), v18 (ref)
                    local v103 = false;
                    if not l_DragBar_0 and not v98 then
                        return;
                    else
                        local v104 = v24 and v24.X or 0;
                        local l_X_0 = l_DragBar_0.AbsoluteSize.X;
                        local v106 = (v104 - l_DragBar_0.AbsolutePosition.X) / l_X_0;
                        local v107, v108;
                        if v102 then
                            v108 = v74 / 2;
                            v103 = v108;
                        end;
                        if not v103 then
                            v107 = v74;
                            v108 = l_clamp_0((v107 - 0) * v106 + 0, 0, v107);
                        end;
                        v103 = false;
                        v107 = l_floor_0((v108 + 0.5) / 1) * 1;
                        if v101 ~= v107 then
                            v10:Play("tick", {
                                Volume = 0.025
                            });
                            v101 = v107;
                            local l_v101_0 = v101;
                            local l_v74_0 = v74;
                            l_v101_0 = l_clamp_0(l_clamp_0((l_v101_0 - 1) / (l_v74_0 - 1), 0, 1), 0, 1);
                            l_TweenService_0:Create(v98, v100, {
                                Position = UDim2.fromScale(l_v101_0, 0.5)
                            }):Play();
                            if v99 then
                                v99.Text = tostring(v101);
                            end;
                            if l_Exchange_0 then
                                l_Exchange_0.Text = ("$%* -> %* Candy"):format(v11:ToCommas(v101 * 75), v101);
                            end;
                            if l_Display_0 and v70.__internalState.isSureForPurchase then
                                v70.__internalState.isSureForPurchase = false;
                                l_Display_0.Text = v18.Normal;
                            end;
                        end;
                        return;
                    end;
                end;
                if l_DragBar_0 and v98 then
                    local function v112() --[[ Line: 370 ]] --[[ Name: __onDrag ]]
                        -- upvalues: v70 (copy), v10 (ref), v111 (copy)
                        v70.__internalState.isDragging = true;
                        v10:Play("switch");
                        while task.wait() and v70.__internalState.isDragging do
                            v111();
                        end;
                    end;
                    local function v114(v113) --[[ Line: 379 ]] --[[ Name: __stopDrag ]]
                        -- upvalues: v70 (copy), v10 (ref)
                        if not v70.__internalState.isDragging then
                            return;
                        else
                            if v113.UserInputType == Enum.UserInputType.MouseButton1 or v113.UserInputType == Enum.UserInputType.Touch or v113.UserInputType == Enum.UserInputType.Gamepad1 and v113.KeyCode == Enum.KeyCode.ButtonR2 then
                                v70.__internalState.isDragging = false;
                                v10:Play("switch");
                            end;
                            return;
                        end;
                    end;
                    v111(true);
                    v70.__internalTrove:Connect(v98.MouseButton1Down, v112);
                    v70.__internalTrove:Connect(l_UserInputService_0.InputEnded, v114);
                end;
                v70.__internalTrove:Connect(l_ConversionButton_0.MouseButton1Down, function() --[[ Line: 398 ]]
                    -- upvalues: l_Display_0 (copy), v70 (copy), v101 (ref), v10 (ref), v18 (ref), v7 (ref), v74 (ref), l_max_0 (ref), v54 (ref), l_RestockAmountDisplay_0 (copy), v73 (copy), v111 (copy)
                    if not l_Display_0 or v70.__internalState.isProcessingRestockPurchase or v101 <= 0 then
                        v70:__switchDialogue("OutOfStock");
                        return;
                    elseif not v70.__internalState.isSureForPurchase then
                        v70.__internalState.isSureForPurchase = true;
                        v10:Play("switch");
                        l_Display_0.Text = v18.MakeSure;
                        return;
                    else
                        v70.__internalState.isProcessingRestockPurchase = true;
                        l_Display_0.Text = v18.Processing;
                        if v7:FireServerConnection("PurchaseStockAsync", "REMOTE_FUNCTION", v101) then
                            v74 = l_max_0(v74 - v101, 0);
                            if v54 then
                                local l_v54_0 = v54;
                                l_v54_0.PlayerAmountBought = l_v54_0.PlayerAmountBought + v101;
                            end;
                            if l_RestockAmountDisplay_0 then
                                l_RestockAmountDisplay_0.Text = ("(%*/%*)"):format(v74, v73.Stock);
                            end;
                        end;
                        v111(true);
                        l_Display_0.Text = v18.Normal;
                        v70.__internalState.isSureForPurchase = false;
                        v70.__internalState.isProcessingRestockPurchase = false;
                        return;
                    end;
                end);
                local l_Display_1 = l_EventShop_1.InformationFrame:FindFirstChild("Display");
                local l_PurchaseFrame_0 = l_EventShop_1.InformationFrame:FindFirstChild("PurchaseFrame");
                if l_Display_1 then
                    l_Display_1.Gradient.Position = UDim2.fromScale(0, 1);
                end;
                local v118 = l_Display_1 and l_Display_1:FindFirstChild("DisplayImage");
                if v118 then
                    v118.Image = "";
                end;
                if l_PurchaseFrame_0 then
                    l_PurchaseFrame_0.Character.Text = "";
                    l_PurchaseFrame_0.Quote.Text = "";
                    l_PurchaseFrame_0.CurrencyDisplay.Visible = false;
                end;
                local l_Main_0 = l_EventShop_1.ShopFrame:FindFirstChild("Main");
                local l_PurchaseButton_0 = l_PurchaseFrame_0.PurchaseButton;
                local v121 = "";
                local v122 = nil;
                local v123 = false;
                local v124 = nil;
                local function v159(v125, v126, v127) --[[ Line: 461 ]] --[[ Name: __createCard ]]
                    -- upvalues: v23 (ref), v15 (ref), l_script_FullName_0 (ref), v39 (ref), v70 (copy), l_Presets_0 (ref), v10 (ref), v12 (ref), v20 (ref), l_TweenService_0 (ref), v121 (ref), v122 (ref), v118 (copy), l_PurchaseFrame_0 (copy), l_Display_1 (copy), l_PurchaseButton_0 (copy), v13 (ref), v124 (ref), v123 (ref), v9 (ref), l_Debris_0 (ref), l_delay_0 (ref)
                    if not v23 then
                        assert(true, "bad message");
                        if not v15 then
                            return;
                        else
                            warn((("[%*]: Failed to find clients data."):format(l_script_FullName_0)));
                            return;
                        end;
                    else
                        local l_ReleaseDate_0 = v126.ReleaseDate;
                        if l_ReleaseDate_0 then
                            v125.Lock.Amount.Text = l_ReleaseDate_0;
                            v125.DisplayImage.Image = v126.DisplayImage;
                            v125.DisplayImage.ImageTransparency = 0.75;
                            v125.Lock.ZIndex = 2;
                            return;
                        else
                            local v129 = v23 and v23.Purchased.Skins:FindFirstChild(v126.Cosmetic.Name) ~= nil or v23.Purchased.Killers:FindFirstChild(v126.Cosmetic.Name) ~= nil or false;
                            local v130 = v39(v126.Cosmetic.Directory .. ("/%*"):format(v126.Cosmetic.Name));
                            if not v130 then
                                local v131 = ("Could not find cosmetic with directory: %*/%*"):format(v126.Cosmetic.Directory, v126.Cosmetic.Name);
                                assert(type(v131) == "string", "bad message");
                                if v15 then
                                    warn((("[%*]: %*"):format(l_script_FullName_0, v131)));
                                end;
                                return;
                            else
                                local l_status_1, l_result_1 = pcall(require, v130:FindFirstChild("Config"));
                                if not l_status_1 then
                                    local v134 = ("Could not require cosmetic configuration file: %*/%*"):format(v126.Cosmetic.Directory, v126.Cosmetic.Name);
                                    assert(type(v134) == "string", "bad message");
                                    if v15 then
                                        warn((("[%*]: %*"):format(l_script_FullName_0, v134)));
                                    end;
                                    return;
                                else
                                    local l_Descendants_0 = v125.Lock:GetDescendants();
                                    local l_CurrentOwnedSurvivorSkins_0 = v23.EventCurrency:FindFirstChild("CurrentOwnedSurvivorSkins");
                                    local l_RequiredSurvivorSkins_0 = v126.RequiredSurvivorSkins;
                                    if not l_RequiredSurvivorSkins_0 then
                                        local v138 = ("No required survivor skins, removing lock on %*/%*..."):format(v126.Cosmetic.Directory, v126.Cosmetic.Name);
                                        assert(type(v138) == "string", "bad message");
                                        if v15 then
                                            warn((("[%*]: %*"):format(l_script_FullName_0, v138)));
                                        end;
                                        v125.Lock:Destroy();
                                    elseif not l_ReleaseDate_0 and l_CurrentOwnedSurvivorSkins_0 and l_CurrentOwnedSurvivorSkins_0.Value < l_RequiredSurvivorSkins_0 then
                                        v125.Lock.Amount.Text = tostring(l_RequiredSurvivorSkins_0 - l_CurrentOwnedSurvivorSkins_0.Value);
                                        v125.DisplayImage.ImageTransparency = 0.75;
                                        v125.Lock.ZIndex = 2;
                                        local v139 = nil;
                                        do
                                            local l_v139_0 = v139;
                                            l_v139_0 = v70.__internalTrove:Connect(l_CurrentOwnedSurvivorSkins_0.Changed, function(v141) --[[ Line: 504 ]]
                                                -- upvalues: l_RequiredSurvivorSkins_0 (copy), v125 (copy), l_v139_0 (ref)
                                                local v142 = l_RequiredSurvivorSkins_0 - v141;
                                                if v142 <= 0 then
                                                    v125.Lock:Destroy();
                                                    v125.DisplayImage.ImageTransparency = 0;
                                                    if l_v139_0 then
                                                        l_v139_0:Disconnect();
                                                        l_v139_0 = nil;
                                                        return;
                                                    end;
                                                else
                                                    v125.Lock.Amount.Text = tostring(v142);
                                                end;
                                            end);
                                        end;
                                    elseif l_CurrentOwnedSurvivorSkins_0 and l_RequiredSurvivorSkins_0 <= l_CurrentOwnedSurvivorSkins_0.Value then
                                        v125.Lock:Destroy();
                                    end;
                                    if v129 then
                                        local l_DamnedCard_0 = v125:FindFirstChild("DamnedCard");
                                        if l_DamnedCard_0 then
                                            l_DamnedCard_0:Destroy();
                                        end;
                                        l_Presets_0.Outline:Clone().Parent = v125;
                                    end;
                                    v125.DisplayImage.Image = v129 and l_result_1.RenderImage or v126.DisplayImage;
                                    local function v144(v145) --[[ Line: 535 ]] --[[ Name: __changeDisplayCard ]]
                                        -- upvalues: v10 (ref), l_CurrentOwnedSurvivorSkins_0 (copy), l_RequiredSurvivorSkins_0 (copy), v12 (ref), l_Descendants_0 (copy), v20 (ref), l_TweenService_0 (ref), v121 (ref), v127 (copy), v122 (ref), v125 (copy), v70 (ref), v129 (ref), l_result_1 (copy), v130 (copy), v118 (ref), v126 (copy), l_PurchaseFrame_0 (ref), l_Display_1 (ref), l_PurchaseButton_0 (ref), v13 (ref), v124 (ref), v123 (ref), v9 (ref), l_Debris_0 (ref), l_delay_0 (ref), v144 (copy)
                                        local v146 = false;
                                        v10:Play("switch");
                                        if l_CurrentOwnedSurvivorSkins_0 and l_RequiredSurvivorSkins_0 and l_CurrentOwnedSurvivorSkins_0.Value < l_RequiredSurvivorSkins_0 then
                                            local v147 = v12:DisplayNotification("You do not have enough survivor skins from the event!", Color3.fromRGB(203, 53, 53));
                                            if v147 then
                                                v147.Size = UDim2.new(0.65, 0, 0, 40);
                                            end;
                                            for _, v149 in l_Descendants_0 do
                                                local v150 = v149:IsA("TextLabel") and "TextColor3" or "ImageColor3";
                                                if v149:IsA("TextLabel") then
                                                    v149.TextColor3 = v20;
                                                elseif v149:IsA("ImageLabel") then
                                                    v149.ImageColor3 = v20;
                                                end;
                                                l_TweenService_0:Create(v149, TweenInfo.new(1), {
                                                    [v150] = Color3.fromRGB(255, 255, 255)
                                                }):Play();
                                            end;
                                            return;
                                        elseif (v121 == v127 or v122 == v125) and not v145 then
                                            return;
                                        else
                                            v121 = v127;
                                            v122 = v125;
                                            if v70.__internalState.isSelectSkinDebounce then
                                                return;
                                            else
                                                v70.__internalState.isSelectSkinDebounce = true;
                                                local v151, v152;
                                                if v129 then
                                                    v152 = l_result_1.DisplayName;
                                                    v146 = v152;
                                                end;
                                                if not v146 then
                                                    v151 = l_result_1.DisplayName;
                                                    v152 = string.gsub(v151, ".", "?");
                                                end;
                                                v146 = false;
                                                v151 = v130 and v130.Parent and v130.Parent.Name;
                                                v118.Image = v129 and l_result_1.RenderImage or v126.DisplayImage;
                                                l_PurchaseFrame_0.Character.Text = ("%*, %*"):format(v152, v151 or "None");
                                                l_PurchaseFrame_0.Quote.Text = l_result_1.Description;
                                                l_Display_1.Gradient.Position = UDim2.fromScale(0, 0);
                                                local v153 = l_TweenService_0:Create(l_Display_1.Gradient, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                    Position = UDim2.fromScale(0, 1)
                                                });
                                                v153:Play();
                                                v70.__internalTrove:Add(v153);
                                                l_Display_1.Outline.Visible = v129;
                                                l_Display_1.DamnedCard.Visible = not v129;
                                                local l_Display_2 = l_PurchaseButton_0:FindFirstChild("Display");
                                                if l_Display_2 then
                                                    l_Display_2.Text = v129 and "Owned" or "Purchase";
                                                end;
                                                l_PurchaseFrame_0.CurrencyDisplay.CurrencyText.Text = ("%*"):format(v13.PriceTiers[v126.PriceTier]);
                                                l_PurchaseFrame_0.CurrencyDisplay.Visible = true;
                                                if v124 then
                                                    v124:Destroy();
                                                    v124 = nil;
                                                end;
                                                v123 = v129;
                                                v124 = v9.new();
                                                v124:Connect(function(v155) --[[ Line: 615 ]]
                                                    -- upvalues: v129 (ref), v125 (ref), l_result_1 (ref), v126 (ref), l_TweenService_0 (ref), v70 (ref), l_Debris_0 (ref), l_delay_0 (ref), v144 (ref)
                                                    if not v155 then
                                                        return;
                                                    else
                                                        v129 = v155;
                                                        local v156 = v125.DisplayImage:Clone();
                                                        v156.Name = "FAKE_DisplayImage";
                                                        v156.Parent = v125;
                                                        v125.DisplayImage.Position = UDim2.fromScale(0, -1);
                                                        v125.DisplayImage.Image = v129 and l_result_1.RenderImage or v126.DisplayImage;
                                                        local v157 = l_TweenService_0:Create(v156, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                                            Position = UDim2.fromScale(0, 1)
                                                        });
                                                        local v158 = l_TweenService_0:Create(v125.DisplayImage, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                                            Position = UDim2.fromScale(0, 0)
                                                        });
                                                        v157:Play();
                                                        v158:Play();
                                                        v70.__internalTrove:Add(v157);
                                                        v70.__internalTrove:Add(v158);
                                                        l_Debris_0:AddItem(v156, 1);
                                                        v70.__internalTrove:Add(l_delay_0(0.5, function() --[[ Line: 653 ]]
                                                            -- upvalues: v144 (ref)
                                                            v144(true);
                                                        end));
                                                        return;
                                                    end;
                                                end);
                                                l_delay_0(0.25, function() --[[ Line: 658 ]]
                                                    -- upvalues: v70 (ref)
                                                    v70.__internalState.isSelectSkinDebounce = false;
                                                end);
                                                return;
                                            end;
                                        end;
                                    end;
                                    v70.__internalTrove:Connect(v125.Interact.MouseButton1Down, v144);
                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
                local function v160(v161, v162, v163) --[[ Line: 666 ]] --[[ Name: __createCardsInDirectory ]]
                    -- upvalues: v160 (copy), v159 (copy)
                    for v164, v165 in v162 do
                        local l_v161_FirstChild_0 = v161:FindFirstChild((tostring(v164)));
                        if typeof(v164) == "string" and l_v161_FirstChild_0 then
                            v160(l_v161_FirstChild_0, v165, v163 .. ("/%*"):format(v164));
                        else
                            local v167 = v163 .. ("/%*"):format(v164);
                            v159(l_v161_FirstChild_0, v165, v167);
                        end;
                    end;
                end;
                v70.__internalTrove:Connect(l_PurchaseButton_0.MouseButton1Down, function() --[[ Line: 679 ]]
                    -- upvalues: v123 (ref), v121 (ref), v70 (copy), l_PurchaseButton_0 (copy), v122 (ref), v10 (ref), v19 (ref), v7 (ref), l_Presets_0 (ref), v124 (ref)
                    if v123 then
                        return;
                    elseif v121 == "" or v70.__internalState.isProcessingSkinPurchase then
                        return;
                    else
                        local l_Display_3 = l_PurchaseButton_0:FindFirstChild("Display");
                        local l_v122_0 = v122;
                        if not l_Display_3 or not l_v122_0 then
                            return;
                        else
                            v10:Play("switch");
                            if not v70.__internalState.isSureForSkinPurchase then
                                v70.__internalState.isSureForSkinPurchase = true;
                                if l_Display_3 then
                                    l_Display_3.Text = v19.MakeSure;
                                end;
                                return;
                            else
                                v70.__internalState.isProcessingSkinPurchase = true;
                                l_Display_3.Text = v19.Processing;
                                local v170 = v7:FireServerConnection("PurchaseSkinAsync", "REMOTE_FUNCTION", v121);
                                if v170 then
                                    local l_DamnedCard_1 = l_v122_0:FindFirstChild("DamnedCard");
                                    if l_DamnedCard_1 then
                                        l_DamnedCard_1:Destroy();
                                    end;
                                    l_Presets_0.Outline:Clone().Parent = l_v122_0;
                                    if v121 == "CosmeticRows/KillersRow/7" then
                                        v70:__switchDialogue("FinalPurchase");
                                    else
                                        v70:__switchDialogue("SuccessfulPurchase");
                                    end;
                                    if v124 then
                                        v124:Fire(v170);
                                    end;
                                else
                                    v70:__switchDialogue("InsufficientBribery");
                                end;
                                l_Display_3.Text = v19.Normal;
                                v70.__internalState.isSureForSkinPurchase = false;
                                v70.__internalState.isProcessingSkinPurchase = false;
                                return;
                            end;
                        end;
                    end;
                end);
                if l_Main_0 then
                    v160(l_Main_0, v13.CosmeticRows, "CosmeticRows");
                end;
                if l_LocalPlayer_0 then
                    v71.Parent = l_LocalPlayer_0.PlayerGui;
                end;
                v70.ShopUI = l_EventShop_1;
                v70.__isInitialized = true;
                local v172 = l_LocalPlayer_0 and l_LocalPlayer_0.Character;
                if v172 then
                    v70.__internalTrove:Connect(v172.AncestryChanged, function(_, v174) --[[ Line: 751 ]]
                        -- upvalues: v70 (copy)
                        if not v70.__isInitialized then
                            return;
                        elseif v174 and v174.Name == "Spectating" then
                            return;
                        else
                            v70:__closeUI();
                            return;
                        end;
                    end);
                end;
                return;
            end;
        end;
    end, 
    __closeUI = function(v175) --[[ Line: 765 ]] --[[ Name: __closeUI ]]
        -- upvalues: v22 (copy), v15 (copy), l_script_FullName_0 (copy)
        if not v175.ShopUI or not v175.__isInitialized then
            return;
        else
            if not v22 then
                assert(true, "bad message");
                if v15 then
                    warn((("[%*]: Failed to find the local players PlayerGui, returning..."):format(l_script_FullName_0)));
                end;
            else
                local l_MainUI_1 = v22:FindFirstChild("MainUI");
                if l_MainUI_1 then
                    l_MainUI_1.Enabled = true;
                end;
            end;
            if v175._currentDialogThread then
                task.cancel(v175._currentDialogThread);
                v175._currentDialogThread = nil;
            end;
            v175.__internalTrove:Destroy();
            v175.__internalState.isSelectSkinDebounce = false;
            v175.__internalState.isProcessingRestockPurchase = false;
            v175.__internalState.isSureForSkinPurchase = false;
            v175.__internalState.isProcessingSkinPurchase = false;
            v175.__internalState.isSureForPurchase = false;
            v175.__internalState.isDragging = false;
            if v175.__closeCallback then
                v175.__closeCallback();
            end;
            v175.ShopUI.Visible = false;
            v175.__isInitialized = false;
            return;
        end;
    end, 
    OpenUI = function(v177, v178) --[[ Line: 797 ]] --[[ Name: OpenUI ]]
        -- upvalues: v22 (copy), v15 (copy), l_script_FullName_0 (copy)
        if not v177.__isInitialized or not v177.ShopUI then
            v177:__initializeUI();
        end;
        if not v22 then
            assert(true, "bad message");
            if v15 then
                warn((("[%*]: Failed to find the local players PlayerGui, returning..."):format(l_script_FullName_0)));
            end;
        else
            local l_MainUI_2 = v22:FindFirstChild("MainUI");
            if l_MainUI_2 then
                l_MainUI_2.Enabled = false;
            end;
        end;
        if not v177.FirstTimeOpened then
            v177.FirstTimeOpened = true;
            v177:__switchDialogue("FirstMeeting");
        else
            v177:__switchDialogue("EnteringShop");
        end;
        v177.ShopUI.Visible = true;
        v177.__closeCallback = v178;
    end
};