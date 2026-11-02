-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_PacksConfig_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("PacksConfig"));
local l_PoseConfig_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("PoseConfig"));
local v6 = require(l_ReplicatedStorage_0.Frameworks.Notifications);
local v7 = {};
v7.__index = v7;
local function v8(...) --[[ Line: 16 ]] --[[ Name: dprint ]]

end;
v7.new = function(v9) --[[ Line: 22 ]] --[[ Name: new ]]
    -- upvalues: v7 (copy), v8 (copy)
    local v10 = setmetatable({}, v7);
    v10.Frame = v9;
    v10.PackService = nil;
    v10.EntryMap = {};
    v10.EntryConnections = {};
    v10.ActiveTracks = {};
    v10.ProductPriceCache = {};
    v10.OwnedPackLookup = {};
    v10.PackDataConn = nil;
    v10.PackData = {
        OwnedPacks = {}, 
        OwnedPackTitles = {}, 
        EquippedPackTitle = ""
    };
    v8("new() created ShopFrame for frame:", v9:GetFullName());
    return v10;
end;
v7.Init = function(v11) --[[ Line: 46 ]] --[[ Name: Init ]]
    -- upvalues: v8 (copy), l_Knit_0 (copy)
    v8("Init() start");
    v11.PackService = l_Knit_0.GetService("PackService");
    v8("PackService resolved:", v11.PackService);
    v11:_buildEntries();
    v11:_bindPackData();
    v11:_requestPackDataRefresh();
    v8("Init() done. Entry count =", v11:_countEntries());
end;
v7.Destroy = function(v12) --[[ Line: 59 ]] --[[ Name: Destroy ]]
    -- upvalues: v8 (copy)
    v8("Destroy() start");
    if v12.PackDataConn then
        v12.PackDataConn:Disconnect();
        v12.PackDataConn = nil;
        v8("Disconnected PackDataConn");
    end;
    for v13, v14 in pairs(v12.EntryConnections) do
        v8("Disconnecting entry connection:", v13);
        v14:Disconnect();
    end;
    v12.EntryConnections = {};
    for v15, v16 in pairs(v12.ActiveTracks) do
        v8("Destroying active track for viewport:", v15:GetFullName());
        pcall(function() --[[ Line: 76 ]]
            -- upvalues: v16 (copy)
            v16:Stop(0);
            v16:Destroy();
        end);
    end;
    v12.ActiveTracks = {};
    v12.EntryMap = {};
    v12.OwnedPackLookup = {};
    v8("Destroy() done");
end;
v7._countEntries = function(v17) --[[ Line: 89 ]] --[[ Name: _countEntries ]]
    local v18 = 0;
    for _ in pairs(v17.EntryMap) do
        v18 = v18 + 1;
    end;
    return v18;
end;
v7._rebuildOwnedPackLookup = function(v20) --[[ Line: 97 ]] --[[ Name: _rebuildOwnedPackLookup ]]
    -- upvalues: v8 (copy)
    table.clear(v20.OwnedPackLookup);
    local v21 = v20.PackData and v20.PackData.OwnedPacks;
    local v22 = v20.PackData and v20.PackData.OwnedPackTitles;
    v8("_rebuildOwnedPackLookup() start");
    if typeof(v21) == "table" then
        for v23, v24 in pairs(v21) do
            v8("OwnedPacks raw entry:", tostring(v23), "=>", (tostring(v24)));
            if type(v23) == "string" and v24 == true then
                v20.OwnedPackLookup[v23] = true;
            end;
            if type(v24) == "string" and v24 ~= "" then
                v20.OwnedPackLookup[v24] = true;
            end;
            if type(v23) == "number" and type(v24) == "string" and v24 ~= "" then
                v20.OwnedPackLookup[v24] = true;
            end;
        end;
    end;
    if typeof(v22) == "table" then
        for v25, v26 in pairs(v22) do
            v8("OwnedPackTitles raw entry:", tostring(v25), "=>", (tostring(v26)));
            if type(v25) == "string" and v26 == true then
                v20.OwnedPackLookup[v25] = true;
            end;
            if type(v26) == "string" and v26 ~= "" then
                v20.OwnedPackLookup[v26] = true;
            end;
            if type(v25) == "number" and type(v26) == "string" and v26 ~= "" then
                v20.OwnedPackLookup[v26] = true;
            end;
        end;
    end;
    for v27, _ in pairs(v20.OwnedPackLookup) do
        v8("OwnedPackLookup contains:", (tostring(v27)));
    end;
    v8("_rebuildOwnedPackLookup() done");
end;
v7._requestPackDataRefresh = function(v29) --[[ Line: 148 ]] --[[ Name: _requestPackDataRefresh ]]
    -- upvalues: v8 (copy)
    v8("_requestPackDataRefresh() called");
    if not v29.PackService then
        v8("_requestPackDataRefresh() aborted: no PackService");
        return;
    else
        local l_PackData_0 = v29.PackService:GetPackData();
        v8("GetPackData() returned:", l_PackData_0);
        if not l_PackData_0 or typeof(l_PackData_0.andThen) ~= "function" then
            v8("GetPackData() did not return promise-like object");
            return;
        else
            l_PackData_0:andThen(function(v31) --[[ Line: 165 ]]
                -- upvalues: v8 (ref), v29 (copy)
                v8("GetPackData() resolved. typeof(data) =", (typeof(v31)));
                if typeof(v31) ~= "table" then
                    v8("GetPackData() ignored non-table payload");
                    return;
                else
                    v8("PackData keys:", "OwnedPacks =", typeof(v31.OwnedPacks), "OwnedPackTitles =", typeof(v31.OwnedPackTitles), "EquippedPackTitle =", (tostring(v31.EquippedPackTitle)));
                    v29.PackData = v31;
                    v29:_rebuildOwnedPackLookup();
                    v8("PackData replaced from GetPackData(). Refreshing all entry states.");
                    v29:_refreshAllEntryStates();
                    return;
                end;
            end):catch(function(v32) --[[ Line: 185 ]]
                warn("[ShopFrame] GetPackData failed:", v32);
            end);
            return;
        end;
    end;
end;
v7._bindPackData = function(v33) --[[ Line: 190 ]] --[[ Name: _bindPackData ]]
    -- upvalues: v8 (copy)
    v8("_bindPackData() called");
    if not v33.PackService then
        v8("_bindPackData() aborted: no PackService");
        return;
    elseif not v33.PackService.PackDataUpdated then
        v8("_bindPackData() aborted: no PackDataUpdated signal");
        return;
    else
        v33.PackDataConn = v33.PackService.PackDataUpdated:Connect(function(v34) --[[ Line: 203 ]]
            -- upvalues: v8 (ref), v33 (copy)
            v8("PackDataUpdated fired. typeof(newData) =", (typeof(v34)));
            if typeof(v34) ~= "table" then
                v8("PackDataUpdated ignored non-table payload");
                return;
            else
                v33.PackData = v34;
                v33:_rebuildOwnedPackLookup();
                v8("PackData replaced from PackDataUpdated. Refreshing all entry states.");
                v33:_refreshAllEntryStates();
                return;
            end;
        end);
        v8("_bindPackData() connected successfully");
        return;
    end;
end;
v7._buildEntries = function(v35) --[[ Line: 221 ]] --[[ Name: _buildEntries ]]
    -- upvalues: v8 (copy), l_PacksConfig_0 (copy)
    v8("_buildEntries() start");
    local v36 = l_PacksConfig_0.GetAllPacks and l_PacksConfig_0.GetAllPacks();
    if typeof(v36) ~= "table" then
        warn("[ShopFrame] PacksConfig.GetAllPacks() missing or invalid");
        return;
    else
        v8("PacksConfig.GetAllPacks() returned count:", #v36);
        local v37 = {};
        for _, v39 in ipairs(v36) do
            local l_Id_0 = v39.Id;
            local v41 = v35:_getPackPoseId(v39);
            v8("Pack config entry:", "packId =", tostring(l_Id_0), "poseId =", (tostring(v41)));
            if type(l_Id_0) == "string" and l_Id_0 ~= "" and type(v41) == "string" and v41 ~= "" then
                v37[v41] = v39;
            end;
        end;
        local v42 = false;
        for _, v44 in ipairs(v35.Frame:GetDescendants()) do
            if v44:IsA("ViewportFrame") then
                local v45 = v35:_findTaggedPoseId(v44);
                v8("Viewport found:", v44:GetFullName(), "poseId =", (tostring(v45)));
                if v45 then
                    local v46 = v37[v45];
                    if v46 then
                        local v47 = v35:_findCardFromViewport(v44);
                        if v47 then
                            v8("Matched viewport to pack:", v45, "->", tostring(v46.Id), "card =", v47:GetFullName());
                            v35:_setupPackCard(v47, v46, v44, v45);
                            v42 = true;
                        else
                            warn(("[ShopFrame] Could not resolve card container for viewport pose '%s'"):format(v45));
                        end;
                    else
                        v8("No packData found for poseId:", v45);
                    end;
                end;
            end;
        end;
        if not v42 then
            warn("[ShopFrame] No tagged shop viewports matched any pack pose ids");
            return;
        else
            v8("_buildEntries() done. Entry count =", v35:_countEntries());
            return;
        end;
    end;
end;
v7._findCardFromViewport = function(v48, v49) --[[ Line: 277 ]] --[[ Name: _findCardFromViewport ]]
    -- upvalues: v8 (copy)
    local l_v49_0 = v49;
    while true do
        if l_v49_0 and l_v49_0 ~= v48.Frame then
            if l_v49_0:IsA("GuiObject") then
                local l_l_v49_0_FirstChild_0 = l_v49_0:FindFirstChild("BuyBtn", true);
                if l_l_v49_0_FirstChild_0 and l_l_v49_0_FirstChild_0:IsA("GuiButton") then
                    v8("_findCardFromViewport() resolved card:", l_v49_0:GetFullName(), "for viewport:", v49:GetFullName());
                    return l_v49_0;
                end;
            end;
            l_v49_0 = l_v49_0.Parent;
        elseif v49.Parent and v49.Parent:IsA("GuiObject") then
            v8("_findCardFromViewport() fallback parent card:", v49.Parent:GetFullName());
            return v49.Parent;
        else
            v8("_findCardFromViewport() failed for viewport:", v49:GetFullName());
            return nil;
        end;
    end;
end;
v7._setupPackCard = function(v52, v53, v54, v55, v56) --[[ Line: 300 ]] --[[ Name: _setupPackCard ]]
    -- upvalues: v8 (copy)
    local l_Id_1 = v54.Id;
    local v58 = v54.DisplayName or l_Id_1;
    local v59 = v56 or v52:_getPackPoseId(v54);
    v8("_setupPackCard() start:", "packId =", tostring(l_Id_1), "poseId =", tostring(v59), "card =", v53:GetFullName());
    if v55 and v59 then
        v52:_buildViewportPreview(v55, v59);
    end;
    local v60 = v53:FindFirstChild("Name", true) or v53:FindFirstChild("Title", true);
    if v60 and v60:IsA("TextLabel") then
        v60.Text = v58;
        v8("Set name label for", l_Id_1, "to", v60.Text);
    else
        v8("No Name/Title label found for", l_Id_1);
    end;
    local l_v53_FirstChild_0 = v53:FindFirstChild("BuyBtn", true);
    local l_v53_FirstChild_1 = v53:FindFirstChild("Price", true);
    if l_v53_FirstChild_0 then
        v8("BuyBtn found for", l_Id_1, ":", l_v53_FirstChild_0:GetFullName(), "class =", l_v53_FirstChild_0.ClassName);
    else
        v8("BuyBtn missing for", l_Id_1);
    end;
    if l_v53_FirstChild_1 then
        v8("Price label candidate found for", l_Id_1, ":", l_v53_FirstChild_1:GetFullName(), "class =", l_v53_FirstChild_1.ClassName);
    end;
    if l_v53_FirstChild_1 and not l_v53_FirstChild_1:IsA("TextLabel") then
        v8("Price label rejected for", l_Id_1, "because it is not a TextLabel");
        l_v53_FirstChild_1 = nil;
    end;
    if not l_v53_FirstChild_1 then
        v8("Price label missing for", l_Id_1);
    end;
    if l_v53_FirstChild_0 and l_v53_FirstChild_0:IsA("GuiButton") then
        if v52.EntryConnections[l_Id_1 .. "_Buy"] then
            v52.EntryConnections[l_Id_1 .. "_Buy"]:Disconnect();
            v8("Disconnected existing BuyBtn connection for", l_Id_1);
        end;
        v52.EntryConnections[l_Id_1 .. "_Buy"] = l_v53_FirstChild_0.MouseButton1Click:Connect(function() --[[ Line: 347 ]]
            -- upvalues: v8 (ref), l_Id_1 (copy), v52 (copy)
            v8("BuyBtn clicked for", l_Id_1);
            v52:_onBuyClicked(l_Id_1);
        end);
    else
        v8("BuyBtn invalid or not GuiButton for", l_Id_1);
    end;
    v52.EntryMap[l_Id_1] = {
        PackData = v54, 
        Card = v53, 
        Viewport = v55, 
        BuyBtn = l_v53_FirstChild_0, 
        PriceLabel = l_v53_FirstChild_1, 
        PoseId = v59, 
        DisplayName = v58
    };
    v8("EntryMap stored for", l_Id_1);
    v52:_updateCardPrice(l_Id_1);
    v52:_refreshEntryState(l_Id_1);
end;
v7._getPackPoseId = function(_, v64) --[[ Line: 370 ]] --[[ Name: _getPackPoseId ]]
    -- upvalues: l_PacksConfig_0 (copy)
    if type(v64) ~= "table" then
        return nil;
    elseif type(v64.Pose) == "table" and type(v64.Pose.Id) == "string" and v64.Pose.Id ~= "" then
        return v64.Pose.Id;
    else
        if l_PacksConfig_0.GetPoseId then
            local v65 = l_PacksConfig_0.GetPoseId(v64.Id);
            if type(v65) == "string" and v65 ~= "" then
                return v65;
            end;
        end;
        return nil;
    end;
end;
v7._getPackProductId = function(_, v67) --[[ Line: 389 ]] --[[ Name: _getPackProductId ]]
    -- upvalues: l_PacksConfig_0 (copy)
    if l_PacksConfig_0.GetProductId then
        local v68 = l_PacksConfig_0.GetProductId(v67);
        if typeof(v68) == "number" and v68 > 0 then
            return v68;
        end;
    end;
    return nil;
end;
v7._findTaggedPoseId = function(_, v70) --[[ Line: 400 ]] --[[ Name: _findTaggedPoseId ]]
    -- upvalues: l_PoseConfig_0 (copy), l_CollectionService_0 (copy)
    for _, v72 in ipairs(l_PoseConfig_0.GetAllPoses()) do
        if l_CollectionService_0:HasTag(v70, v72.Id) then
            return v72.Id;
        end;
    end;
    local l_v70_Attribute_0 = v70:GetAttribute("PoseId");
    if type(l_v70_Attribute_0) == "string" and l_v70_Attribute_0 ~= "" then
        return l_v70_Attribute_0;
    else
        return nil;
    end;
end;
v7._buildViewportPreview = function(v74, v75, v76) --[[ Line: 415 ]] --[[ Name: _buildViewportPreview ]]
    -- upvalues: v8 (copy), l_PoseConfig_0 (copy), l_ReplicatedStorage_0 (copy)
    v8("_buildViewportPreview() for viewport:", v75:GetFullName(), "poseId =", v76);
    local v77 = v74.ActiveTracks[v75];
    if v77 then
        pcall(function() --[[ Line: 420 ]]
            -- upvalues: v77 (copy)
            v77:Stop(0);
            v77:Destroy();
        end);
        v74.ActiveTracks[v75] = nil;
        v8("Destroyed existing track for viewport:", v75:GetFullName());
    end;
    v75:ClearAllChildren();
    local v78 = l_PoseConfig_0.GetPose(v76);
    if not v78 then
        warn(("[ShopFrame] Missing PoseConfig entry for pose '%s'"):format((tostring(v76))));
        return;
    else
        local l_WorldModel_0 = Instance.new("WorldModel");
        l_WorldModel_0.Parent = v75;
        local l_FirstChild_0 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Poses"):FindFirstChild(v76);
        if not l_FirstChild_0 or not l_FirstChild_0:IsA("Model") then
            warn(("[ShopFrame] Missing rig model for pose '%s'"):format((tostring(v76))));
            return;
        else
            local v81 = l_FirstChild_0:Clone();
            v81.Parent = l_WorldModel_0;
            local v82 = v81.PrimaryPart or v81:FindFirstChild("HumanoidRootPart") or v81:FindFirstChildWhichIsA("BasePart");
            if v82 then
                v81.PrimaryPart = v82;
                v81:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, 3.141592653589793, 0));
            end;
            local l_Humanoid_0 = v81:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_0 then
                local l_Animator_0 = l_Humanoid_0:FindFirstChildOfClass("Animator");
                if not l_Animator_0 then
                    l_Animator_0 = Instance.new("Animator");
                    l_Animator_0.Parent = l_Humanoid_0;
                end;
                local l_Animation_0 = v78.Animation;
                do
                    local l_l_Animator_0_0 = l_Animator_0;
                    if l_Animation_0 and l_Animation_0.Id then
                        local l_Animation_1 = Instance.new("Animation");
                        l_Animation_1.AnimationId = l_Animation_0.Id;
                        local l_status_0, l_result_0 = pcall(function() --[[ Line: 469 ]]
                            -- upvalues: l_l_Animator_0_0 (ref), l_Animation_1 (copy)
                            return l_l_Animator_0_0:LoadAnimation(l_Animation_1);
                        end);
                        if l_status_0 and l_result_0 then
                            l_result_0.Looped = true;
                            l_result_0.Priority = l_Animation_0.Priority or Enum.AnimationPriority.Action3;
                            l_result_0:Play(0, 1, l_Animation_0.Speed or 1);
                            v74.ActiveTracks[v75] = l_result_0;
                            l_Humanoid_0.HipHeight = l_Animation_0.HipHeight or l_Humanoid_0.HipHeight;
                            v8("Animation track started for pose:", v76);
                        else
                            v8("Failed to load animation track for pose:", v76);
                        end;
                    else
                        v8("No animation data for pose:", v76);
                    end;
                end;
            end;
            local l_Camera_0 = Instance.new("Camera");
            l_Camera_0.Parent = v75;
            v75.CurrentCamera = l_Camera_0;
            v74:_positionViewportCamera(l_Camera_0, v81);
            return;
        end;
    end;
end;
v7._positionViewportCamera = function(_, v92, v93) --[[ Line: 496 ]] --[[ Name: _positionViewportCamera ]]
    local l_v93_BoundingBox_0, v95 = v93:GetBoundingBox();
    local l_Position_0 = l_v93_BoundingBox_0.Position;
    local v97 = math.max(6, math.max(v95.X, v95.Y, v95.Z) * 1.75);
    local v98 = Vector3.new(0, v95.Y * 0.15, 0);
    local v99 = Vector3.new(0, v95.Y * 0.15, v97);
    v92.CFrame = CFrame.new(l_Position_0 + v98 + v99, l_Position_0 + v98);
end;
v7._playerOwnsPack = function(v100, v101) --[[ Line: 509 ]] --[[ Name: _playerOwnsPack ]]
    -- upvalues: v8 (copy)
    local v102 = v100.EntryMap[v101];
    local v103 = v102 and v102.DisplayName or nil;
    local v104 = v100.OwnedPackLookup[v101] == true;
    local v105 = v103 and v100.OwnedPackLookup[v103] == true or false;
    local v106 = v104 or v105;
    v8("_playerOwnsPack(", v101, ") ->", v106, "lookup by packId =", tostring(v104), "displayName =", tostring(v103), "lookup by displayName =", (tostring(v105)));
    return v106;
end;
v7._refreshAllEntryStates = function(v107) --[[ Line: 534 ]] --[[ Name: _refreshAllEntryStates ]]
    -- upvalues: v8 (copy)
    v8("_refreshAllEntryStates() start. Entry count =", v107:_countEntries());
    for v108, _ in pairs(v107.EntryMap) do
        v8("Refreshing entry state for", v108);
        v107:_refreshEntryState(v108);
    end;
    v8("_refreshAllEntryStates() done");
end;
v7._refreshEntryState = function(v110, v111) --[[ Line: 545 ]] --[[ Name: _refreshEntryState ]]
    -- upvalues: v8 (copy)
    local v112 = v110.EntryMap[v111];
    if not v112 then
        v8("_refreshEntryState() missing entry for", v111);
        return;
    else
        local v113 = v110:_playerOwnsPack(v111);
        v8("_refreshEntryState()", v111, "owns =", v113);
        local v114 = v112.Card:FindFirstChild("Owned", true) or v112.Card:FindFirstChild("isOwned", true);
        if v114 and v114:IsA("GuiObject") then
            v114.Visible = v113;
            v8("Owned badge updated for", v111, "visible =", v113);
        else
            v8("Owned badge missing for", v111);
        end;
        local v115 = v112.Card:FindFirstChild("Locked", true) or v112.Card:FindFirstChild("isLocked", true);
        if v115 and v115:IsA("GuiObject") then
            v115.Visible = false;
            v8("Locked badge hidden for", v111);
        else
            v8("Locked badge missing for", v111);
        end;
        if v112.BuyBtn and v112.BuyBtn:IsA("GuiObject") then
            v112.BuyBtn.Visible = true;
            v8("BuyBtn forced visible for", v111);
        end;
        if v112.PriceLabel and v112.PriceLabel:IsA("TextLabel") then
            v8("Current PriceLabel text for", v111, "before update =", v112.PriceLabel.Text);
            if v113 then
                v112.PriceLabel.Text = "Owned";
                v8("Set PriceLabel to 'Owned' for", v111);
            else
                v8("Pack not owned; updating price for", v111);
                v110:_updateCardPrice(v111);
            end;
            v8("Current PriceLabel text for", v111, "after update =", v112.PriceLabel.Text);
            return;
        else
            v8("PriceLabel missing/invalid in refresh for", v111);
            return;
        end;
    end;
end;
v7._updateCardPrice = function(v116, v117) --[[ Line: 593 ]] --[[ Name: _updateCardPrice ]]
    -- upvalues: v8 (copy), l_MarketplaceService_0 (copy)
    local v118 = v116.EntryMap[v117];
    if not v118 or not v118.PriceLabel then
        v8("_updateCardPrice() aborted for", v117, "missing entry or PriceLabel");
        return;
    elseif v116:_playerOwnsPack(v117) then
        v118.PriceLabel.Text = "Owned";
        v8("_updateCardPrice() set Owned for", v117, "because pack is owned");
        return;
    else
        local v119 = v116:_getPackProductId(v117);
        v8("_updateCardPrice()", v117, "productId =", (tostring(v119)));
        if not v119 then
            v118.PriceLabel.Text = "\238\128\130 N/A";
            v8("_updateCardPrice() set N/A for", v117, "because productId missing");
            return;
        else
            local v120 = v116.ProductPriceCache[v119];
            if v120 ~= nil then
                v118.PriceLabel.Text = "\238\128\130 " .. tostring(v120);
                v8("_updateCardPrice() used cached price for", v117, "price =", (tostring(v120)));
                return;
            else
                v118.PriceLabel.Text = "\238\128\130 ...";
                v8("_updateCardPrice() fetching marketplace price for", v117);
                task.spawn(function() --[[ Line: 625 ]]
                    -- upvalues: l_MarketplaceService_0 (ref), v119 (copy), v8 (ref), v117 (copy), v116 (copy)
                    local l_status_1, l_result_1 = pcall(function() --[[ Line: 626 ]]
                        -- upvalues: l_MarketplaceService_0 (ref), v119 (ref)
                        return l_MarketplaceService_0:GetProductInfo(v119, Enum.InfoType.Product);
                    end);
                    local v123 = "N/A";
                    if l_status_1 and typeof(l_result_1) == "table" then
                        local l_PriceInRobux_0 = l_result_1.PriceInRobux;
                        v8("Marketplace info fetched for", v117, "PriceInRobux =", (tostring(l_PriceInRobux_0)));
                        if typeof(l_PriceInRobux_0) == "number" then
                            v123 = tostring(l_PriceInRobux_0);
                            v116.ProductPriceCache[v119] = v123;
                        end;
                    else
                        v8("Marketplace fetch failed for", v117, "ok =", l_status_1, "info =", l_result_1);
                    end;
                    local v125 = v116.EntryMap[v117];
                    if v125 and v125.PriceLabel then
                        if v116:_playerOwnsPack(v117) then
                            v125.PriceLabel.Text = "Owned";
                            v8("Async price update resolved to Owned for", v117);
                            return;
                        else
                            v125.PriceLabel.Text = "\238\128\130 " .. v123;
                            v8("Async price update set price for", v117, "to", v123);
                            return;
                        end;
                    else
                        v8("Async price update skipped for", v117, "because liveEntry/PriceLabel missing");
                        return;
                    end;
                end);
                return;
            end;
        end;
    end;
end;
v7._onBuyClicked = function(v126, v127) --[[ Line: 658 ]] --[[ Name: _onBuyClicked ]]
    -- upvalues: v8 (copy), v6 (copy)
    v8("_onBuyClicked()", v127);
    if not v126.PackService then
        v8("_onBuyClicked() aborted: no PackService");
        return;
    else
        local v128 = v126.PackService:PromptPackPurchase(v127);
        v8("PromptPackPurchase returned:", v128);
        if not v128 or typeof(v128.andThen) ~= "function" then
            warn("[ShopFrame] PromptPackPurchase did not return a promise-like object");
            v6.New("PURCHASE FAILED", "ErrorNotification");
            return;
        else
            v128:andThen(function(v129, v130) --[[ Line: 676 ]]
                -- upvalues: v8 (ref), v127 (copy), v6 (ref)
                v8("PromptPackPurchase resolved for", v127, "success =", tostring(v129), "result =", (tostring(v130)));
                if v129 then
                    return;
                elseif v130 == "AlreadyOwned" then
                    v6.New("YOU ALREADY OWN THIS PACK", "ErrorNotification");
                    return;
                else
                    v6.New("PURCHASE FAILED", "ErrorNotification");
                    return;
                end;
            end):catch(function(v131) --[[ Line: 689 ]]
                -- upvalues: v6 (ref)
                warn("[ShopFrame] PromptPackPurchase failed:", v131);
                v6.New("PURCHASE FAILED", "ErrorNotification");
            end);
            return;
        end;
    end;
end;
return v7;