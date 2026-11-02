-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local CurrentCamera = workspace.CurrentCamera;
local u1 = {};

local function getScaledFontSize(p2, p3, p4, p5) -- Line: 11
    local v6 = p5 * math.min(p2.X / 2115, p2.Y / 1190) + 0.5;

    return math.floor(v6);
end;

local function isFullyVisible(p7) -- Line: 16
    while p7 do
        if p7:IsA("GuiObject") then
            if not p7.Visible then
                return false;
            end;
        else
            if p7:IsA("LayerCollector") then
                return p7.Enabled and true or false;
            end;

            if p7 == game then
                return false;
            end;
        end;

        p7 = p7.Parent;
    end;

    return false;
end;

local function dummy(p8, p9) -- Line: 36
    -- upvalues: CurrentCamera (copy)
    p8.TextScaled = false;
    local v10 = p9 or CurrentCamera.ViewportSize;
    local v11 = p8:GetAttribute("baseX") or 2115;
    local _ = p8:GetAttribute("baseY") or 1190;

    if p8:GetAttribute("sizeConstraint") == "XX" then
        v10 = Vector2.new(v11, v10.Y);
    end;

    local v12 = (p8:GetAttribute("baseSize") or 35) * math.min(v10.X / 2115, v10.Y / 1190) + 0.5;
    local v13 = math.floor(v12);

    if p8.TextSize ~= v13 then
        p8.TextSize = v13;
    end;
end;

local function onLabelVisibilityChanged(p14) -- Line: 59
    -- upvalues: isFullyVisible (copy), dummy (copy)
    if isFullyVisible(p14) then
        dummy(p14);
    end;
end;

local function instanceAdded(u15) -- Line: 78
    -- upvalues: StarterGui (copy), dummy (copy), isFullyVisible (copy), u1 (copy)
    if u15:IsDescendantOf(StarterGui) then
        return;
    end;

    if not u15:IsA("GuiObject") then
        return;
    end;

    dummy(u15);
    u1[u15] = u15:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 87
        -- upvalues: u15 (copy), isFullyVisible (ref), dummy (ref)
        local v16 = u15;

        if isFullyVisible(v16) then
            dummy(v16);
        end;
    end);
end;

CollectionService:GetInstanceAddedSignal("ScaledTextSizeMultiLine"):Connect(instanceAdded);
CollectionService:GetInstanceRemovedSignal("ScaledTextSizeMultiLine"):Connect(function(p17) -- Line: 94, Name: instanceRemoved
    -- upvalues: u1 (copy)
    if u1[p17] then
        u1[p17]:Disconnect();
        u1[p17] = nil;
    end;
end);

local function onViewportChanged() -- Line: 65
    -- upvalues: CurrentCamera (copy), u1 (copy), dummy (copy)
    local ViewportSize = CurrentCamera.ViewportSize;
    local v18 = 0;

    for i, _ in pairs(u1) do
        dummy(i, ViewportSize);
        v18 = v18 + 1;

        if v18 % 4 == 0 then
            task.wait();
        end;
    end;
end;

for _, v in CollectionService:GetTagged("ScaledTextSizeMultiLine") do
    instanceAdded(v);
end;

CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportChanged);