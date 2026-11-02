-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local item = script:WaitForChild("item");
local u1 = {};
u1.__index = u1;
local u2 = {
    SCROLL_SPEED = 15,
    SCROLL_THRESHOLD = 40,
    GHOST_ADD_TRANSPARENCY = 0.5,
    PLACEHOLDER_ADD_TRANSPARENCY = 0.5,
    LINE_THICKNESS = 3,
    DRAG_BUTTON_NAME = "drag",
    ITEM_ATTRIBUTE = "isItem",
    LINE_COLOR = Color3.new(1, 1, 1),
    HOVER_COLOR = Color3.fromHex("3d3f45")
};

function u1.new(p3, p4) -- Line: 33
    -- upvalues: u1 (copy)
    if type(p4) ~= "table" then
        error("[DraggableList] Argument #2 must be a Data Table.");
    end;

    local v5 = setmetatable({}, u1);
    v5._scrollingFrame = p3;
    v5._uiListLayout = p3:FindFirstChildOfClass("UIListLayout");
    v5.OnOrderChange = nil;
    v5.OnHover = nil;
    v5.OnItemCreated = nil;

    if not v5._uiListLayout then
        warn("[DraggableList] No UIListLayout found in ScrollingFrame.");

        return nil;
    end;

    v5._items = {};
    v5._itemColors = {};
    v5._connections = {};
    v5._uiToData = {};
    v5._dragData = {
        isDragging = false,
        item = nil,
        placeholder = nil,
        ghost = nil,
        line = nil,
        targetIndex = 1,
        renderConn = nil,
        inputConn = nil,
        dragOffset = Vector2.zero,
        cachedItems = {}
    };
    v5:Update(p4);

    return v5;
end;

function u1.Update(p6, p7) -- Line: 74
    if p6._dragData.isDragging then
        p6:_endDrag();
    end;

    for i, _ in pairs(p6._uiToData) do
        if i then
            p6:_cleanupItem(i);
            i:Destroy();
        end;
    end;

    p6._uiToData = {};
    p6._items = {};
    p6._itemColors = {};
    table.sort(p7, function(p8, p9) -- Line: 90
        return (p8.Order or 0) > (p9.Order or 0);
    end);

    for i, v in ipairs(p7) do
        p6:_createItem(v, i);
    end;
end;

function u1._cleanupItem(p10, p11) -- Line: 99
    if p10._items[p11] then
        for _, v in ipairs(p10._items[p11]) do
            v:Disconnect();
        end;

        p10._items[p11] = nil;
    end;

    p10._itemColors[p11] = nil;
end;

function u1._createItem(p12, p13, p14) -- Line: 107
    -- upvalues: item (copy), u2 (copy)
    local v15 = item:Clone();
    v15.Name = "Item_" .. p13.AssetId;
    v15:SetAttribute(u2.ITEM_ATTRIBUTE, true);
    v15.LayoutOrder = p14;
    p12._uiToData[v15] = p13;
    local itemName = v15:FindFirstChild("itemName");

    if itemName then
        itemName.Text = p13.AssetName or "";
    end;

    local itemThumb = v15:FindFirstChild("itemThumb");

    if itemThumb then
        itemThumb.Image = `rbxthumb://type=Asset&id={p13.AssetId}&w=150&h=150`;
    end;

    v15.Parent = p12._scrollingFrame;

    if p12.OnItemCreated then
        p12.OnItemCreated(v15, p13);
    end;

    p12:_registerItem(v15);
end;

function u1._registerItem(u16, u17) -- Line: 135
    -- upvalues: u2 (copy), ThemeController (copy)
    if not u17:IsA("GuiObject") then
        return;
    end;

    task.defer(function() -- Line: 138
        -- upvalues: u17 (copy), u16 (copy), u2 (ref), ThemeController (ref)
        if not u17.Parent then
            return;
        end;

        if u16._items[u17] then
            return;
        end;

        local v18 = u17:FindFirstChild(u2.DRAG_BUTTON_NAME, true);

        if not v18 then
            return;
        end;

        u16._itemColors[u17] = u17.BackgroundColor3;
        local v19 = {};
        table.insert(v19, v18.InputBegan:Connect(function(p20) -- Line: 149
            -- upvalues: u16 (ref), u17 (ref)
            if (p20.UserInputType == Enum.UserInputType.MouseButton1 or p20.UserInputType == Enum.UserInputType.Touch) and p20.UserInputState == Enum.UserInputState.Begin then
                u16:_startDrag(u17, p20);
            end;
        end));
        table.insert(v19, v18.MouseEnter:Connect(function() -- Line: 157
            -- upvalues: u16 (ref), u17 (ref), ThemeController (ref), u2 (ref)
            if not u16._dragData.isDragging then
                u17.BackgroundColor3 = ThemeController.GetColor(u2.HOVER_COLOR);

                if u16.OnHover then
                    u16.OnHover(u17, u16._uiToData[u17], true);
                end;
            end;
        end));
        table.insert(v19, v18.MouseLeave:Connect(function() -- Line: 163
            -- upvalues: u16 (ref), u17 (ref)
            if u16._itemColors[u17] then
                u17.BackgroundColor3 = u16._itemColors[u17];
            end;

            if u16.OnHover then
                u16.OnHover(u17, u16._uiToData[u17], false);
            end;
        end));
        u16._items[u17] = v19;
    end);
end;

local function applyTransparency(u21, u22) -- Line: 172
    -- upvalues: applyTransparency (copy)
    if u21:IsA("CanvasGroup") then
        u21.GroupTransparency = math.clamp(u21.GroupTransparency + u22, 0, 1);

        return;
    end;

    local function safeSet(u23) -- Line: 174
        -- upvalues: u21 (copy), u22 (copy)
        pcall(function() -- Line: 174
            -- upvalues: u21 (ref), u23 (copy), u22 (ref)
            u21[u23] = math.clamp(u21[u23] + u22, 0, 1);
        end);
    end;

    if u21:IsA("GuiObject") then
        local u24 = "BackgroundTransparency";
        pcall(function() -- Line: 174
            -- upvalues: u21 (copy), u24 (copy), u22 (copy)
            u21[u24] = math.clamp(u21[u24] + u22, 0, 1);
        end);
    end;

    if u21:IsA("ImageLabel") or u21:IsA("ImageButton") then
        local u25 = "ImageTransparency";
        pcall(function() -- Line: 174
            -- upvalues: u21 (copy), u25 (copy), u22 (copy)
            u21[u25] = math.clamp(u21[u25] + u22, 0, 1);
        end);
    end;

    if u21:IsA("ScrollingFrame") then
        local u26 = "ScrollBarImageTransparency";
        pcall(function() -- Line: 174
            -- upvalues: u21 (copy), u26 (copy), u22 (copy)
            u21[u26] = math.clamp(u21[u26] + u22, 0, 1);
        end);
    end;

    if u21:IsA("TextLabel") or u21:IsA("TextButton") then
        local u27 = "TextTransparency";
        pcall(function() -- Line: 174
            -- upvalues: u21 (copy), u27 (copy), u22 (copy)
            u21[u27] = math.clamp(u21[u27] + u22, 0, 1);
        end);
        local u28 = "TextStrokeTransparency";
        pcall(function() -- Line: 174
            -- upvalues: u21 (copy), u28 (copy), u22 (copy)
            u21[u28] = math.clamp(u21[u28] + u22, 0, 1);
        end);
    end;

    if u21:IsA("UIStroke") then
        local u29 = "Transparency";
        pcall(function() -- Line: 174
            -- upvalues: u21 (copy), u29 (copy), u22 (copy)
            u21[u29] = math.clamp(u21[u29] + u22, 0, 1);
        end);
    end;

    for _, child in ipairs(u21:GetChildren()) do
        applyTransparency(child, u22);
    end;
end;

function u1._cleanClone(p30, p31) -- Line: 183
    local v32 = p31:Clone();

    if p30._itemColors[p31] then
        v32.BackgroundColor3 = p30._itemColors[p31];
    end;

    for _, descendant in ipairs(v32:GetDescendants()) do
        if descendant:IsA("BaseScript") then
            descendant:Destroy();
        end;

        if descendant:IsA("GuiButton") then
            descendant.Active = false;
        end;
    end;

    return v32;
end;

function u1._createGhost(p33, p34) -- Line: 193
    -- upvalues: applyTransparency (copy), u2 (copy)
    local v35 = p33:_cleanClone(p34);
    v35.Name = "GhostItem";
    v35.AnchorPoint = Vector2.zero;
    v35.ZIndex = 3000;
    v35.Size = UDim2.fromOffset(p34.AbsoluteSize.X, p34.AbsoluteSize.Y);
    applyTransparency(v35, u2.GHOST_ADD_TRANSPARENCY);
    v35.Parent = p33._scrollingFrame:FindFirstAncestorWhichIsA("ScreenGui") or p33._scrollingFrame.Parent;

    return v35;
end;

function u1._createPlaceholder(p36, p37) -- Line: 204
    -- upvalues: applyTransparency (copy), u2 (copy)
    local v38 = p36:_cleanClone(p37);
    v38.Name = "Placeholder";
    v38.LayoutOrder = p37.LayoutOrder;
    applyTransparency(v38, u2.PLACEHOLDER_ADD_TRANSPARENCY);
    v38.Parent = p36._scrollingFrame;

    return v38;
end;

function u1._createInsertionLine(p39) -- Line: 212
    -- upvalues: ThemeController (copy), u2 (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "InsertionLine";
    Frame.BorderSizePixel = 0;
    Frame.BackgroundColor3 = ThemeController.GetColor(u2.LINE_COLOR);
    Frame.Size = UDim2.new(0, 0, 0, u2.LINE_THICKNESS);
    Frame.ZIndex = 2000;
    Frame.Parent = p39._scrollingFrame:FindFirstAncestorWhichIsA("ScreenGui") or p39._scrollingFrame.Parent;

    return Frame;
end;

function u1._snapshotLayout(p40) -- Line: 221
    -- upvalues: u2 (copy)
    local v41 = {};

    for _, child in ipairs(p40._scrollingFrame:GetChildren()) do
        if child:IsA("GuiObject") and (child:GetAttribute(u2.ITEM_ATTRIBUTE) and (child.Visible and (child ~= p40._dragData.item and child ~= p40._dragData.placeholder))) then
            table.insert(v41, child);
        end;
    end;

    table.sort(v41, function(p42, p43) -- Line: 228
        return p42.AbsolutePosition.Y < p43.AbsolutePosition.Y;
    end);
    p40._dragData.cachedItems = v41;
end;

function u1._normalizeLayoutOrders(p44) -- Line: 232
    -- upvalues: u2 (copy)
    local v45 = {};

    for _, child in ipairs(p44._scrollingFrame:GetChildren()) do
        if child:IsA("GuiObject") and (child:GetAttribute(u2.ITEM_ATTRIBUTE) and child.Visible) then
            table.insert(v45, child);
        end;
    end;

    table.sort(v45, function(p46, p47) -- Line: 239
        return p46.AbsolutePosition.Y < p47.AbsolutePosition.Y;
    end);

    for i, v in ipairs(v45) do
        v.LayoutOrder = i;
    end;
end;

function u1._startDrag(u48, p49, p50) -- Line: 243
    -- upvalues: GuiService (copy), UserInputService (copy), RunService (copy)
    if u48._dragData.isDragging then
        return;
    end;

    local v51 = Vector2.new(p50.Position.X, p50.Position.Y) - GuiService:GetGuiInset();
    u48:_normalizeLayoutOrders();
    u48._dragData.isDragging = true;
    u48._dragData.item = p49;
    u48._dragData.dragOffset = v51 - p49.AbsolutePosition;
    u48._dragData.ghost = u48:_createGhost(p49);
    u48._dragData.placeholder = u48:_createPlaceholder(p49);
    u48._dragData.line = u48:_createInsertionLine();
    u48:_snapshotLayout();
    p49.Visible = false;

    if u48._itemColors[p49] then
        p49.BackgroundColor3 = u48._itemColors[p49];
    end;

    u48:_calcInsertionPoint(v51.Y);
    u48._dragData.inputConn = UserInputService.InputEnded:Connect(function(p52) -- Line: 257
        -- upvalues: u48 (copy)
        if p52.UserInputType == Enum.UserInputType.MouseButton1 or p52.UserInputType == Enum.UserInputType.Touch then
            u48:_endDrag();
        end;
    end);
    u48._dragData.renderConn = RunService.RenderStepped:Connect(function() -- Line: 262
        -- upvalues: u48 (copy)
        u48:_updateDrag();
    end);
end;

function u1._updateDrag(p53) -- Line: 265
    -- upvalues: UserInputService (copy), GuiService (copy), u2 (copy)
    if not p53._dragData.isDragging then
        return;
    end;

    local v54 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local v55 = v54 - p53._dragData.dragOffset;

    if p53._dragData.ghost then
        p53._dragData.ghost.Position = UDim2.fromOffset(v55.X, v55.Y);
    end;

    local _scrollingFrame = p53._scrollingFrame;
    local v56 = v54.Y - _scrollingFrame.AbsolutePosition.Y;

    if v56 < u2.SCROLL_THRESHOLD then
        _scrollingFrame.CanvasPosition = Vector2.new(0, (math.max(0, _scrollingFrame.CanvasPosition.Y - u2.SCROLL_SPEED)));
    elseif _scrollingFrame.AbsoluteSize.Y - u2.SCROLL_THRESHOLD < v56 then
        _scrollingFrame.CanvasPosition = Vector2.new(0, _scrollingFrame.CanvasPosition.Y + u2.SCROLL_SPEED);
    end;

    p53:_calcInsertionPoint(v54.Y);
end;

function u1._calcInsertionPoint(p57, p58) -- Line: 281
    -- upvalues: u2 (copy)
    local cachedItems = p57._dragData.cachedItems;
    local X = p57._scrollingFrame.AbsolutePosition.X;
    local Offset = p57._uiListLayout.Padding.Offset;
    local X2 = p57._scrollingFrame.AbsoluteWindowSize.X;

    if cachedItems[1] then
        X2 = cachedItems[1].AbsoluteSize.X;
    end;

    if p57._dragData.line then
        p57._dragData.line.Size = UDim2.fromOffset(X2, u2.LINE_THICKNESS);
    end;

    local v59 = 1;
    local v60 = 0;

    if #cachedItems == 0 then
        v60 = p57._scrollingFrame.AbsolutePosition.Y + Offset;
    else
        local v61 = false;

        for i, v in ipairs(cachedItems) do
            if p58 < v.AbsolutePosition.Y + v.AbsoluteSize.Y * 0.5 then
                v60 = v.AbsolutePosition.Y - Offset * 0.5;
                v59 = i;
                v61 = true;
                break;
            end;
        end;

        if not v61 then
            v59 = #cachedItems + 1;
            local v62 = cachedItems[#cachedItems];
            v60 = v62.AbsolutePosition.Y + v62.AbsoluteSize.Y + Offset * 0.5;
        end;
    end;

    p57._dragData.targetIndex = v59;

    if p57._dragData.line then
        p57._dragData.line.Position = UDim2.fromOffset(X, v60);
    end;
end;

function u1._endDrag(p63) -- Line: 311
    if not p63._dragData.isDragging then
        return;
    end;

    if p63._dragData.renderConn then
        p63._dragData.renderConn:Disconnect();
        p63._dragData.renderConn = nil;
    end;

    if p63._dragData.inputConn then
        p63._dragData.inputConn:Disconnect();
        p63._dragData.inputConn = nil;
    end;

    local item2 = p63._dragData.item;
    local targetIndex = p63._dragData.targetIndex;

    if p63._dragData.ghost then
        p63._dragData.ghost:Destroy();
    end;

    if p63._dragData.line then
        p63._dragData.line:Destroy();
    end;

    if p63._dragData.placeholder then
        p63._dragData.placeholder:Destroy();
    end;

    if item2 then
        item2.Visible = true;
        local v64 = table.clone(p63._dragData.cachedItems);
        local v65 = math.clamp(targetIndex, 1, #v64 + 1);
        table.insert(v64, v65, item2);
        local v66 = {};
        local v67 = {};
        local v68 = false;

        for _, v in ipairs(v64) do
            local v69 = p63._uiToData[v];

            if v69 and v69.Order then
                v68 = v66[v69.Order] and true or v68;
                v66[v69.Order] = true;
                table.insert(v67, v69.Order);
            end;
        end;

        if v68 or #v67 < #v64 then
            v67 = {};

            for i = 1, #v64 do
                v67[i] = #v64 - i + 1;
            end;
        else
            table.sort(v67, function(p70, p71) -- Line: 348
                return p71 < p70;
            end);
        end;

        local v72 = {};

        for i, v in ipairs(v64) do
            v.LayoutOrder = i;
            local v73 = p63._uiToData[v];

            if v73 then
                v73.Order = v67[i];
                table.insert(v72, v73);
            end;
        end;

        if p63.OnOrderChange then
            p63.OnOrderChange(v72);
        end;
    end;

    p63._dragData.isDragging = false;
    p63._dragData.item = nil;
    p63._dragData.placeholder = nil;
    p63._dragData.cachedItems = {};
end;

function u1.Destroy(p74) -- Line: 372
    if p74._dragData.renderConn then
        p74._dragData.renderConn:Disconnect();
    end;

    if p74._dragData.inputConn then
        p74._dragData.inputConn:Disconnect();
    end;

    for i, _ in pairs(p74._uiToData) do
        if i then
            p74:_cleanupItem(i);
            i:Destroy();
        end;
    end;

    for _, v in ipairs(p74._connections) do
        v:Disconnect();
    end;

    p74._items = {};
    p74._uiToData = {};
    p74._itemColors = {};
    setmetatable(p74, nil);
end;

return u1;