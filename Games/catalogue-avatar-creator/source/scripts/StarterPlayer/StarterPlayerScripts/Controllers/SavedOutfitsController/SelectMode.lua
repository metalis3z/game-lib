-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = {};
local u3 = nil;
local u4 = false;
local u5 = {};
local u6 = 0;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;

local function sortedList() -- Line: 17
    -- upvalues: u3 (ref)
    return u3.Controller.SortedOutfits or {};
end;

local function outfitsData() -- Line: 18
    -- upvalues: u3 (ref)
    return u3.Controller.SavedOutfitsData;
end;

local function updateCountLabel() -- Line: 20
    -- upvalues: u16 (ref), u6 (ref)
    u16.Text = u6 .. " selected";
end;

local function setCount(p20) -- Line: 24
    -- upvalues: u6 (ref), u16 (ref)
    u6 = p20;
    u16.Text = u6 .. " selected";
end;

local function recount() -- Line: 29
    -- upvalues: u5 (copy), u6 (ref), u16 (ref)
    local v21 = 0;

    for _ in u5 do
        v21 = v21 + 1;
    end;

    u6 = v21;
    u16.Text = u6 .. " selected";
end;

local function isAllFilteredSelected() -- Line: 35
    -- upvalues: u3 (ref), u5 (copy)
    local v22 = u3.Controller.SortedOutfits or {};

    if #v22 == 0 then
        return false;
    end;

    for _, v in v22 do
        if not u5[v.Id] then
            return false;
        end;
    end;

    return true;
end;

local function updateMaster() -- Line: 44
    -- upvalues: TweenService (copy), u15 (ref), u1 (copy), u3 (ref), u5 (copy)
    local v23 = {};
    local v24 = u3.Controller.SortedOutfits or {};
    local v25;

    if #v24 == 0 then
        v25 = false;
    else
        v25 = true;

        for _, v in v24 do
            if not u5[v.Id] then
                v25 = false;
                break;
            end;
        end;
    end;

    v23.ImageTransparency = v25 and 0 or 1;
    TweenService:Create(u15, u1, v23):Play();
end;

local function refreshTileVisual(p26) -- Line: 48
    -- upvalues: u5 (copy), TweenService (copy), u1 (copy)
    local selectOverlay = p26:FindFirstChild("selectOverlay");

    if not selectOverlay then
        return;
    end;

    local v27 = u5[p26:GetAttribute("outfitId")] == true;
    TweenService:Create(selectOverlay.selStroke.UIStroke, u1, {
        Transparency = v27 and 0 or 1
    }):Play();
    TweenService:Create(selectOverlay.badge.checked, u1, {
        ImageTransparency = v27 and 0 or 1
    }):Play();
end;

local function forEachTile(p28) -- Line: 56
    -- upvalues: u3 (ref)
    for _, child in u3.outfitsContainer:GetChildren() do
        if child:GetAttribute("isItem") then
            p28(child);
        end;
    end;
end;

local function toggleTile(p29) -- Line: 62
    -- upvalues: u5 (copy), u6 (ref), u16 (ref), refreshTileVisual (copy), TweenService (copy), u15 (ref), u1 (copy), u3 (ref)
    local v30 = p29:GetAttribute("outfitId");

    if not v30 then
        return;
    end;

    if u5[v30] then
        u5[v30] = nil;
        u6 = u6 - 1;
        u16.Text = u6 .. " selected";
    else
        u5[v30] = true;
        u6 = u6 + 1;
        u16.Text = u6 .. " selected";
    end;

    refreshTileVisual(p29);
    local v31 = {};
    local v32 = u3.Controller.SortedOutfits or {};
    local v33;

    if #v32 == 0 then
        v33 = false;
    else
        v33 = true;

        for _, v in v32 do
            if not u5[v.Id] then
                v33 = false;
                break;
            end;
        end;
    end;

    v31.ImageTransparency = v33 and 0 or 1;
    TweenService:Create(u15, u1, v31):Play();
end;

local function addOverlay(u34) -- Line: 76
    -- upvalues: refreshTileVisual (copy), u19 (ref), u5 (copy), u6 (ref), u16 (ref), TweenService (copy), u15 (ref), u1 (copy), u3 (ref)
    if u34:FindFirstChild("selectOverlay") then
        refreshTileVisual(u34);

        return;
    end;

    local v35 = u19:Clone();
    local preview = u34:FindFirstChild("preview");

    if preview then
        local selStroke = v35.selStroke;
        selStroke.Size = preview.Size;
        selStroke.Position = preview.Position;
        selStroke.AnchorPoint = preview.AnchorPoint;
        local v36 = preview:FindFirstChildWhichIsA("UICorner");
        local v37 = selStroke:FindFirstChildWhichIsA("UICorner");

        if v36 and v37 then
            v37.CornerRadius = v36.CornerRadius;
        end;

        local v38 = preview:FindFirstChildWhichIsA("UIAspectRatioConstraint");

        if v38 then
            local v39 = selStroke:FindFirstChildWhichIsA("UIAspectRatioConstraint") or Instance.new("UIAspectRatioConstraint", selStroke);
            v39.AspectRatio = v38.AspectRatio;
            v39.AspectType = v38.AspectType;
            v39.DominantAxis = v38.DominantAxis;
        end;
    end;

    v35.Parent = u34;
    v35.selectButton.Activated:Connect(function() -- Line: 97
        -- upvalues: u34 (copy), u5 (ref), u6 (ref), u16 (ref), refreshTileVisual (ref), TweenService (ref), u15 (ref), u1 (ref), u3 (ref)
        local v40 = u34;
        local v41 = v40:GetAttribute("outfitId");

        if not v41 then
            return;
        end;

        if u5[v41] then
            u5[v41] = nil;
            u6 = u6 - 1;
            u16.Text = u6 .. " selected";
        else
            u5[v41] = true;
            u6 = u6 + 1;
            u16.Text = u6 .. " selected";
        end;

        refreshTileVisual(v40);
        local v42 = {};
        local v43 = u3.Controller.SortedOutfits or {};
        local v44;

        if #v43 == 0 then
            v44 = false;
        else
            v44 = true;

            for _, v in v43 do
                if not u5[v.Id] then
                    v44 = false;
                    break;
                end;
            end;
        end;

        v42.ImageTransparency = v44 and 0 or 1;
        TweenService:Create(u15, u1, v42):Play();
    end);
    refreshTileVisual(u34);
end;

local function removeOverlay(p45) -- Line: 103
    local selectOverlay = p45:FindFirstChild("selectOverlay");

    if selectOverlay then
        selectOverlay:Destroy();
    end;
end;

local function toggleSelectAll() -- Line: 108
    -- upvalues: u3 (ref), u5 (copy), u6 (ref), u16 (ref), forEachTile (copy), refreshTileVisual (copy), TweenService (copy), u15 (ref), u1 (copy)
    local v46 = u3.Controller.SortedOutfits or {};
    local v47 = u3.Controller.SortedOutfits or {};
    local v48;

    if #v47 == 0 then
        v48 = false;
    else
        v48 = true;

        for _, v in v47 do
            if not u5[v.Id] then
                v48 = false;
                break;
            end;
        end;
    end;

    if v48 then
        for _, v in v46 do
            u5[v.Id] = nil;
        end;
    else
        for _, v in v46 do
            u5[v.Id] = true;
        end;
    end;

    local v49 = 0;

    for _ in u5 do
        v49 = v49 + 1;
    end;

    u6 = v49;
    u16.Text = u6 .. " selected";
    forEachTile(refreshTileVisual);
    local v50 = {};
    local v51 = u3.Controller.SortedOutfits or {};
    local v52;

    if #v51 == 0 then
        v52 = false;
    else
        v52 = true;

        for _, v in v51 do
            if not u5[v.Id] then
                v52 = false;
                break;
            end;
        end;
    end;

    v50.ImageTransparency = v52 and 0 or 1;
    TweenService:Create(u15, u1, v50):Play();
end;

local function prune() -- Line: 120
    -- upvalues: u3 (ref), u5 (copy), u6 (ref), u16 (ref)
    local SavedOutfitsData = u3.Controller.SavedOutfitsData;

    if SavedOutfitsData then
        SavedOutfitsData = SavedOutfitsData.Outfits;
    end;

    if not SavedOutfitsData then
        return;
    end;

    for i in u5 do
        if not SavedOutfitsData[i] then
            u5[i] = nil;
        end;
    end;

    local v53 = 0;

    for _ in u5 do
        v53 = v53 + 1;
    end;

    u6 = v53;
    u16.Text = u6 .. " selected";
end;

local function idList() -- Line: 130
    -- upvalues: u5 (copy)
    local v54 = {};

    for i in u5 do
        table.insert(v54, i);
    end;

    return v54;
end;

local function closePopup() -- Line: 136
    -- upvalues: u17 (ref), u7 (ref)
    u17.Visible = false;

    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;
end;

local function selectionHasTag(p55) -- Line: 141
    -- upvalues: u3 (ref), u5 (copy)
    local SavedOutfitsData = u3.Controller.SavedOutfitsData;

    if SavedOutfitsData then
        SavedOutfitsData = SavedOutfitsData.Outfits;
    end;

    if not SavedOutfitsData then
        return false;
    end;

    local v56 = false;

    for i in u5 do
        v56 = true;
        local v57 = SavedOutfitsData[i];
        local v58 = false;

        if v57 and v57.Tags then
            for _, v in v57.Tags do
                if v == p55 then
                    v58 = true;
                    break;
                end;
            end;
        end;

        if not v58 then
            return false;
        end;
    end;

    return v56;
end;

local function refreshGroupRows() -- Line: 158
    -- upvalues: u17 (ref), u3 (ref), u18 (ref), selectionHasTag (copy), u6 (ref), u5 (copy)
    local container = u17.container;

    for _, child in container:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy();
        end;
    end;

    local SavedOutfitsData = u3.Controller.SavedOutfitsData;

    for i, v in SavedOutfitsData and SavedOutfitsData.Tags or {} do
        local v59 = u18:Clone();
        v59.Name = v;
        v59.LayoutOrder = i;
        v59.tagName.Text = v;
        local checked = v59.checkbox.back.checked;
        checked.ImageTransparency = selectionHasTag(v) and 0 or 1;
        v59.Activated:Connect(function() -- Line: 172
            -- upvalues: u6 (ref), checked (copy), u3 (ref), u5 (ref), v (copy)
            if u6 == 0 then
                return;
            end;

            local v60 = checked.ImageTransparency < 0.5;
            local SavedOutfitAction = u3.remotes.SavedOutfitAction;
            local v61 = {};
            local v62 = {
                Action = v60 and "BulkUntagOutfit" or "BulkTagOutfit"
            };

            for i2 in u5 do
                table.insert(v61, i2);
            end;

            v62.Ids = v61;
            v62.Tag = v;

            if SavedOutfitAction:InvokeServer(v62) then
                checked.ImageTransparency = v60 and 1 or 0;

                return;
            end;

            u3.events.Notify:Fire(utf8.char(10060) .. " Could not update that group. Try again.");
        end);
        v59.Visible = true;
        v59.Parent = container;
    end;
end;

local function positionPopup() -- Line: 188
    -- upvalues: u11 (ref), u17 (ref), u3 (ref)
    if not u11 then
        return;
    end;

    local AbsolutePosition = u11.AbsolutePosition;
    local AbsoluteSize = u17.AbsoluteSize;
    local AbsolutePosition2 = u3.wrapper.AbsolutePosition;
    local AbsoluteSize2 = u3.wrapper.AbsoluteSize;
    local v63 = AbsolutePosition.X + u11.AbsoluteSize.X / 2 - AbsoluteSize.X / 2 - AbsolutePosition2.X;
    local v64 = AbsolutePosition.Y - AbsoluteSize.Y - AbsoluteSize2.Y * 0.004 - AbsolutePosition2.Y;
    local v65 = AbsoluteSize2.X * 0.0075;
    local v66 = math.max(v65, AbsoluteSize2.X - AbsoluteSize.X - v65);
    local v67 = math.clamp(v63, v65, v66);
    local v68 = math.max(v64, AbsoluteSize2.Y * 0.0075);
    u17.Position = UDim2.fromOffset(v67, v68);
end;

local function attachOutside() -- Line: 203
    -- upvalues: u7 (ref), u3 (ref), u17 (ref), closePopup (copy), u11 (ref)
    if u7 then
        u7:Disconnect();
    end;

    u7 = u3.OutsideClickDetector({ u17 }, closePopup, {
        include = { u11 }
    });
end;

local function openPopup() -- Line: 208
    -- upvalues: u6 (ref), u3 (ref), refreshGroupRows (copy), u17 (ref), positionPopup (copy), attachOutside (copy)
    if u6 == 0 then
        u3.events.Notify:Fire(utf8.char(9888, 65039) .. " Nothing selected. Tap outfits to select them.");

        return;
    end;

    refreshGroupRows();
    u17.Visible = true;
    positionPopup();
    attachOutside();
end;

local function doDelete() -- Line: 219
    -- upvalues: u6 (ref), u3 (ref), u5 (copy), u2 (copy)
    if u6 == 0 then
        u3.events.Notify:Fire(utf8.char(9888, 65039) .. " Nothing selected. Tap outfits to select them.");

        return;
    end;

    local v69 = u6;

    if not u3.events.PromptConfirmationDialog:Invoke({
        Title = "Delete Outfits",
        Description = "Are you sure you want to delete <b>" .. v69 .. "</b> outfit" .. (v69 == 1 and "" or "s") .. "?\n\n<b>You cannot undo this action.</b>"
    }) then
        return;
    end;

    local SavedOutfitAction = u3.remotes.SavedOutfitAction;
    local v70 = {};
    local v71 = {
        Action = "BulkDelete"
    };

    for i in u5 do
        table.insert(v70, i);
    end;

    v71.Ids = v70;
    local v72, v73 = SavedOutfitAction:InvokeServer(v71);

    if not v72 then
        u3.events.Notify:Fire(utf8.char(10060) .. " Could not delete outfits. Try again.");

        return;
    end;

    local v74 = tonumber(v73) or v69;
    u3.events.Notify:Fire(utf8.char(9989) .. " Deleted <b>" .. v74 .. "</b> outfit" .. (v74 == 1 and "" or "s") .. ".");
    u2.Exit();
end;

function u2.IsActive() -- Line: 240
    -- upvalues: u4 (ref)
    return u4;
end;

function u2.Enter() -- Line: 244
    -- upvalues: u4 (ref), u5 (copy), u6 (ref), u16 (ref), u10 (ref), u9 (ref), u3 (ref), u8 (ref), forEachTile (copy), addOverlay (copy), TweenService (copy), u15 (ref), u1 (copy)
    if u4 then
        return;
    end;

    u4 = true;
    table.clear(u5);
    u6 = 0;
    u16.Text = u6 .. " selected";
    u10.Visible = false;
    u9.Visible = false;
    u3.configureTagContainer.Visible = false;
    u8.Visible = true;
    forEachTile(addOverlay);
    local v75 = {};
    local v76 = u3.Controller.SortedOutfits or {};
    local v77;

    if #v76 == 0 then
        v77 = false;
    else
        v77 = true;

        for _, v in v76 do
            if not u5[v.Id] then
                v77 = false;
                break;
            end;
        end;
    end;

    v75.ImageTransparency = v77 and 0 or 1;
    TweenService:Create(u15, u1, v75):Play();
end;

function u2.Exit() -- Line: 257
    -- upvalues: u4 (ref), u17 (ref), u7 (ref), forEachTile (copy), removeOverlay (copy), u5 (copy), u6 (ref), u16 (ref), u8 (ref), u10 (ref), u9 (ref), u3 (ref)
    if not u4 then
        return;
    end;

    u4 = false;
    u17.Visible = false;

    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    forEachTile(removeOverlay);
    table.clear(u5);
    u6 = 0;
    u16.Text = u6 .. " selected";
    u8.Visible = false;
    u17.Visible = false;
    u10.Visible = true;
    u9.Visible = true;
    u3.configureTagContainer.Visible = u3.Controller.CurrentTagFilter ~= "All";
end;

function u2.OnTileCreated(p78) -- Line: 271
    -- upvalues: u4 (ref), addOverlay (copy)
    if u4 then
        addOverlay(p78);
    end;
end;

function u2.OnOutfitsUpdated() -- Line: 275
    -- upvalues: u4 (ref), u3 (ref), u5 (copy), u6 (ref), u16 (ref), forEachTile (copy), addOverlay (copy), TweenService (copy), u15 (ref), u1 (copy)
    if not u4 then
        return;
    end;

    local SavedOutfitsData = u3.Controller.SavedOutfitsData;

    if SavedOutfitsData then
        SavedOutfitsData = SavedOutfitsData.Outfits;
    end;

    if SavedOutfitsData then
        for i in u5 do
            if not SavedOutfitsData[i] then
                u5[i] = nil;
            end;
        end;

        local v79 = 0;

        for _ in u5 do
            v79 = v79 + 1;
        end;

        u6 = v79;
        u16.Text = u6 .. " selected";
    end;

    forEachTile(addOverlay);
    local v80 = {};
    local v81 = u3.Controller.SortedOutfits or {};
    local v82;

    if #v81 == 0 then
        v82 = false;
    else
        v82 = true;

        for _, v in v81 do
            if not u5[v.Id] then
                v82 = false;
                break;
            end;
        end;
    end;

    v80.ImageTransparency = v82 and 0 or 1;
    TweenService:Create(u15, u1, v80):Play();
end;

function u2.Init(p83) -- Line: 282
    -- upvalues: u3 (ref), u8 (ref), u9 (ref), u10 (ref), u17 (ref), u18 (ref), u19 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref)
    u3 = p83;
    local bottomBar = u3.bottomBar;
    u8 = bottomBar:WaitForChild("selectActionsBar");
    u9 = bottomBar.right:WaitForChild("selectContainer");
    u10 = bottomBar.left:WaitForChild("createNewOutfitContainer");
    u17 = u3.wrapper:WaitForChild("groupsPopup");
    u17.AnchorPoint = Vector2.new(0, 0);
    u18 = script.Parent:WaitForChild("tagRow");
    u19 = script.Parent:WaitForChild("selectOverlay");
    u11 = u8:FindFirstChild("addToGroup", true);
    u12 = u8:FindFirstChild("deleteSel", true);
    u13 = u8:FindFirstChild("doneSel", true);
    u14 = u8:FindFirstChild("selectMaster", true);
    u15 = u14.checkbox.checked;
    u16 = u14.count;
end;

function u2.Setup(p84) -- Line: 300
    -- upvalues: u9 (ref), u2 (copy), u13 (ref), u14 (ref), toggleSelectAll (copy), u12 (ref), doDelete (copy), u11 (ref), u17 (ref), u7 (ref), u6 (ref), u3 (ref), refreshGroupRows (copy), positionPopup (copy), attachOutside (copy), u4 (ref)
    table.insert(p84, u9.button.Activated:Connect(u2.Enter));
    table.insert(p84, u13.button.Activated:Connect(u2.Exit));
    table.insert(p84, u14.button.Activated:Connect(toggleSelectAll));
    table.insert(p84, u12.button.Activated:Connect(doDelete));
    table.insert(p84, u11.button.Activated:Connect(function() -- Line: 305
        -- upvalues: u17 (ref), u7 (ref), u6 (ref), u3 (ref), refreshGroupRows (ref), positionPopup (ref), attachOutside (ref)
        if u17.Visible then
            u17.Visible = false;

            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;
        else
            if u6 == 0 then
                u3.events.Notify:Fire(utf8.char(9888, 65039) .. " Nothing selected. Tap outfits to select them.");

                return;
            end;

            refreshGroupRows();
            u17.Visible = true;
            positionPopup();
            attachOutside();
        end;
    end));
    local v85 = u11:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(p84, v85:Connect(function() -- Line: 308
        -- upvalues: u17 (ref), positionPopup (ref)
        if u17.Visible then
            positionPopup();
        end;
    end));
    table.insert(p84, u17.createTag.Activated:Connect(function() -- Line: 311
        -- upvalues: u7 (ref), u3 (ref), u4 (ref), u17 (ref), refreshGroupRows (ref), attachOutside (ref)
        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;

        local v86 = u3.events.PromptInputDialog:Invoke({
            Title = "Create Group",
            Description = "What would you like to name your new group?",
            NoText = "Cancel",
            YesText = "Create",
            PlaceholderText = "Group name"
        });

        if v86 and v86 ~= false then
            if not u3.remotes.SavedOutfitAction:InvokeServer({
                Action = "CreateTag",
                Name = v86
            }) then
                u3.events.Notify:Fire(utf8.char(10060) .. " Could not create group.");
            end;

            task.wait();
        end;

        if u4 and u17.Visible then
            refreshGroupRows();
            attachOutside();
        end;
    end));
    table.insert(p84, {
        Disconnect = function() -- Line: 332, Name: Disconnect
            -- upvalues: u7 (ref)
            if u7 then
                u7:Disconnect();
                u7 = nil;
            end;
        end
    });
end;

return u2;