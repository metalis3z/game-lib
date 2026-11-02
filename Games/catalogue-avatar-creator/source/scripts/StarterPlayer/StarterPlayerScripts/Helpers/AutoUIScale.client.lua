-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local u1 = Vector2.new(1920, 1080);
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u2 = {};

local function update(p3) -- Line: 26
    -- upvalues: u1 (copy)
    local AbsoluteSize = p3.AbsoluteSize;

    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        return;
    end;

    local AutoUIScale = p3:FindFirstChild("AutoUIScale");

    if not AutoUIScale then
        AutoUIScale = Instance.new("UIScale");
        AutoUIScale.Name = "AutoUIScale";
        AutoUIScale.Parent = p3;
    end;

    local v4 = p3:GetAttribute("ReferenceResolution");

    if typeof(v4) ~= "Vector2" or (v4.X <= 0 or v4.Y <= 0) then
        v4 = u1;
    end;

    local v5 = math.min(AbsoluteSize.X / v4.X, AbsoluteSize.Y / v4.Y);
    local v6 = p3:GetAttribute("MinScale");

    if typeof(v6) == "number" then
        v5 = math.max(v5, v6);
    end;

    local v7 = p3:GetAttribute("MaxScale");

    if typeof(v7) == "number" then
        v5 = math.min(v5, v7);
    end;

    AutoUIScale.Scale = v5;
end;

local function bind(u8) -- Line: 64
    -- upvalues: u2 (copy), PlayerGui (copy), update (copy)
    if u2[u8] or not (u8:IsA("ScreenGui") and u8:IsDescendantOf(PlayerGui)) then
        return;
    end;

    local v11 = {};
    table.insert(v11, u8:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        update(u8);
    end));
    table.insert(v11, u8:GetAttributeChangedSignal("ReferenceResolution"):Connect(function()
        update(u8);
    end));
    table.insert(v11, u8:GetAttributeChangedSignal("MinScale"):Connect(function()
        update(u8);
    end));
    table.insert(v11, u8:GetAttributeChangedSignal("MaxScale"):Connect(function()
        update(u8);
    end));
    table.insert(v11, u8.Destroying:Connect(function()
        local connections = u2[u8];

        if not connections then
            return;
        end;

        for _, connection in ipairs(connections) do
            connection:Disconnect();
        end;

        u2[u8] = nil;
    end));
    u2[u8] = v11;
    update(u8);
end;

local function unbind(p12) -- Line: 53
    -- upvalues: u2 (copy)
    local v13 = u2[p12];

    if not v13 then
        return;
    end;

    for _, v in ipairs(v13) do
        v:Disconnect();
    end;

    u2[p12] = nil;
end;

for _, v in ipairs(CollectionService:GetTagged("AutoUIScale")) do
    bind(v);
end;

CollectionService:GetInstanceAddedSignal("AutoUIScale"):Connect(bind);
CollectionService:GetInstanceRemovedSignal("AutoUIScale"):Connect(unbind);
PlayerGui.DescendantAdded:Connect(function(p14) -- Line: 92
    -- upvalues: CollectionService (copy), bind (copy)
    if p14:IsA("ScreenGui") and CollectionService:HasTag(p14, "AutoUIScale") then
        bind(p14);
    end;
end);