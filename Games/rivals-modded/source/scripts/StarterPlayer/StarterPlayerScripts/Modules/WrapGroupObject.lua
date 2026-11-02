-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 8
    -- upvalues: u1 (copy)
    local v5 = setmetatable({}, u1);
    v5.Name = p2;
    v5.Object = p3;
    v5.ExtraObjects = p4;
    v5.IsDestroyed = nil;
    v5._cleanup = {};
    v5._connections = {};
    v5._tweens = {};
    v5._threads = {};
    v5:_Init();

    return v5;
end;

function u1.IsActive(p6) -- Line: 33
    return p6:_IsAncestryVisible();
end;

function u1.Destroy(p7) -- Line: 37
    if p7.IsDestroyed then
        return;
    end;

    p7.IsDestroyed = true;

    for _, v in pairs(p7._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p7._cleanup) do
        v:Destroy();
    end;

    for _, v in pairs(p7._tweens) do
        v:Cancel();
        v:Destroy();
    end;

    for _, v in pairs(p7._threads) do
        pcall(task.cancel, v);
    end;

    p7._connections = {};
    p7._cleanup = {};
    p7._tweens = {};
    p7._threads = {};
end;

function u1._IsAncestryVisible(p8) -- Line: 71
    -- upvalues: PlayerGui (copy)
    if p8.Object:IsDescendantOf(workspace) then
        return true;
    end;

    if not p8.Object:IsDescendantOf(PlayerGui) then
        return false;
    end;

    local Parent = p8.Object.Parent;

    while Parent and Parent ~= game do
        if Parent:IsA("LayerCollector") then
            return Parent.Enabled;
        end;

        if Parent:IsA("GuiBase2d") and not Parent.Visible then
            return false;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

function u1._Init(u9) -- Line: 95
    u9.Object.Destroying:Connect(function() -- Line: 96
        -- upvalues: u9 (copy)
        u9:Destroy();
    end);
end;

return u1;