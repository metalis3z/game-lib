-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local TextService = game:GetService("TextService");
local u1 = {};

local function getXSize(p2, p3, p4)
    if p2.Visible ~= true or not p2:IsDescendantOf(game) or p2.AbsoluteSize.Y <= 0 then
        return nil;
    end;

    local Y = p2.AbsoluteSize.Y;
    local params = Instance.new("GetTextBoundsParams");
    local padding = string.rep(" ", math.max(0, tonumber(p3) or 0));
    local relativeMargin = typeof(p4) == "number" and Y * p4 or 0;
    params.Font = p2.FontFace;
    params.Size = math.max(1, Y);
    params.Width = math.huge;

    local function measure(text)
        params.Text = text;

        for attempt = 1, 3 do
            local success, result = pcall(TextService.GetTextBoundsAsync, TextService, params);

            if success and result then
                return result;
            end;

            if attempt < 3 then
                task.wait(0.03 * attempt);
            end;
        end;

        return nil;
    end;

    local paddedBounds = measure(padding .. p2.ContentText .. padding);
    local rawBounds = measure(p2.Text);
    params:Destroy();

    if paddedBounds and rawBounds then
        return paddedBounds.X + relativeMargin / 2, rawBounds.X;
    end;

    return nil;
end;

local function isFullyVisible(p9) -- Line: 54
    while p9 do
        if p9:IsA("GuiObject") then
            if not p9.Visible then
                return false;
            end;
        else
            if p9:IsA("LayerCollector") then
                return p9.Enabled and true or false;
            end;

            if p9 == game then
                return false;
            end;
        end;

        p9 = p9.Parent;
    end;

    return false;
end;

local function dummy(u10)
    local state = u1[u10];

    if not state or not u10:IsDescendantOf(game) then
        return;
    end;

    if state.pending then
        state.dirty = true;
        return;
    end;

    state.pending = true;
    task.defer(function()
        if u1[u10] ~= state or not u10:IsDescendantOf(game) then
            return;
        end;

        state.dirty = false;
        local parent = u10.Parent;

        if parent and u10.Visible and u10.AbsoluteSize.Y > 0 then
            u10.TextScaled = true;
            local margin = parent:GetAttribute("margin") or 0;
            local relativeMargin = u10:GetAttribute("relativeMargin");
            local width, textBoundsX = getXSize(u10, margin, relativeMargin);

            if width then
                local newSize = UDim2.new(0, width, u10.Size.Y.Scale, 0);
                state.applying = true;
                u10:SetAttribute("textBoundsX", textBoundsX);

                if u10.Size ~= newSize then
                    u10.Size = newSize;
                end;

                state.applying = false;
            end;
        end;

        state.pending = false;

        if state.dirty and u1[u10] == state then
            dummy(u10);
        end;
    end);
end;

local function onLabelVisibilityChanged(p16) -- Line: 94
    -- upvalues: isFullyVisible (copy), dummy (copy)
    if isFullyVisible(p16) then
        dummy(p16);
    end;
end;

function instanceAdded(u17)
    if not (u17:IsA("TextLabel") or u17:IsA("TextButton")) or u1[u17] then
        return;
    end;

    local u18 = {
        connections = {},
        pending = false,
        dirty = false,
        applying = false
    };
    u1[u17] = u18;
    task.spawn(function()
        while not u17:IsDescendantOf(game) and u1[u17] == u18 do
            u17.AncestryChanged:Wait();
        end;

        if u1[u17] ~= u18 then
            return;
        end;

        if u17:IsDescendantOf(StarterGui) then
            u1[u17] = nil;
            return;
        end;

        dummy(u17);
        table.insert(u18.connections, u17:GetPropertyChangedSignal("Visible"):Connect(function()
            if u17.Visible then
                dummy(u17);
            end;
        end));
        table.insert(u18.connections, u17:GetPropertyChangedSignal("Text"):Connect(function()
            dummy(u17);
        end));
        table.insert(u18.connections, u17:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            if not u18.applying then
                dummy(u17);
            end;
        end));
        table.insert(u18.connections, u17:GetAttributeChangedSignal("relativeMargin"):Connect(function()
            dummy(u17);
        end));
    end);
end;

function instanceRemoved(p24)
    local state = u1[p24];

    if state then
        for _, connection in ipairs(state.connections or {}) do
            connection:Disconnect();
        end;

        u1[p24] = nil;
    end;
end;

CollectionService:GetInstanceAddedSignal("ScaledTextSizeAutomaticSizeFix"):Connect(instanceAdded);
CollectionService:GetInstanceRemovedSignal("ScaledTextSizeAutomaticSizeFix"):Connect(instanceRemoved);

local function onViewportChanged() -- Line: 100
    -- upvalues: u1 (copy), isFullyVisible (copy), dummy (copy)
    for i in u1 do
        if isFullyVisible(i) then
            dummy(i);
        end;
    end;
end;

for _, v in CollectionService:GetTagged("ScaledTextSizeAutomaticSizeFix") do
    task.spawn(instanceAdded, v);
end;

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportChanged);