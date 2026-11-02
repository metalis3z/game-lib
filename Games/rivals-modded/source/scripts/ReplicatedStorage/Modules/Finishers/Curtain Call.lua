-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 22
    -- upvalues: Ragdoll (copy), RunService (copy), TweenService (copy)
    Ragdoll.PlayClient(p4, ...);
    local u5 = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    local u6 = script.Model:Clone();
    u6.Parent = workspace;
    table.insert(p4._destroy_these, u6);
    local u7 = tick();
    local v10 = RunService.RenderStepped:Connect(function() -- Line: 33
        -- upvalues: u7 (copy), u6 (copy), u5 (copy)
        local v8 = (tick() - u7) / 1;
        local v9 = 1 - (1 - math.clamp(v8, 0, 1)) ^ 5;
        u6:PivotTo(CFrame.new(u5.Position, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, v9 * 8 + -8, 0));
    end);
    table.insert(p4._connections, v10);

    local function reposition() -- Line: 41
        -- upvalues: u6 (copy)
        u6.LeftCurtain.CFrame = u6.Main.LeftAttachment.WorldCFrame * CFrame.new(0, 0, -u6.LeftCurtain.Size.Z / 2);
        u6.RightCurtain.CFrame = u6.Main.RightAttachment.WorldCFrame * CFrame.new(0, 0, u6.RightCurtain.Size.Z / 2);
    end;

    u6.LeftCurtain:GetPropertyChangedSignal("Size"):Connect(reposition);
    u6.RightCurtain:GetPropertyChangedSignal("Size"):Connect(reposition);
    TweenService:Create(u6.LeftCurtain, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.865, 6.719, 5.066)
    }):Play();
    TweenService:Create(u6.RightCurtain, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.865, 6.719, 5.066)
    }):Play();
    p4:CreateSound("rbxassetid://129997046680336", 0.75, 0.75 + 0.1 * math.random(), u5, true, 10);
    wait(1.5);
    p4:_HideBody();
    TweenService:Create(u6.LeftCurtain, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Size = Vector3.new(0.865, 6.719, 2.066)
    }):Play();
    TweenService:Create(u6.RightCurtain, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Size = Vector3.new(0.865, 6.719, 2.066)
    }):Play();
    p4:CreateSound("rbxassetid://129997046680336", 1, 0.9 + 0.1 * math.random(), u5, true, 10);
    wait(1.5);

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
        end;
    end;

    v10:Disconnect();
    wait(0.5);
end;

function u1._Init(p11) -- Line: 80
end;

return u1;