-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("HttpService");
game:GetService("Lighting");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local u2 = setmetatable({}, Ragdoll);
u2.__index = u2;

function u2.new(...) -- Line: 15
    -- upvalues: Ragdoll (copy), u2 (copy)
    local v3 = Ragdoll.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayClient(p5, p6) -- Line: 27
    -- upvalues: Ragdoll (copy), u1 (copy), Utility (copy), TweenService (copy)
    Ragdoll.PlayClient(p5, p6);

    if not p6 then
        local Fighter = u1:GetFighter(p5._eliminator);

        if not (Fighter and Fighter:Get("IsSpectating")) then
            return;
        end;
    end;

    p5:CreateSound("rbxassetid://127879822444105", 1.25, 0.95 + 0.1 * math.random(), script, true, 10);
    p5:CreateSound("rbxassetid://118355855043527", 0.875, 0.98 + 0.04 * math.random(), script, true, 10);
    local v7 = p5._is_humanoid and p5._subject.RootPart or p5._subject;
    local Part = Instance.new("Part");
    Part.CFrame = CFrame.new(v7.Position);
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 1;
    Part.CastShadow = false;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Anchored = true;
    Part.Parent = v7;
    table.insert(p5._destroy_these, Part);
    local v8 = math.random() < 0.5;
    local v9 = script.BillboardGui:Clone();
    v9.Value.Text = v8 and "NAUGHTY." or "NICE!";
    v9.Value.TextColor3 = v8 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50);
    v9.Value.UIStroke.Color = v8 and Color3.fromRGB(127, 25, 25) or Color3.fromRGB(50, 127, 25);
    v9.Value.UIStroke.Transparency = 0;
    v9.Parent = Part;
    table.insert(p5._destroy_these, v9);
    local Value = v9.Value;
    local u10 = v8 and 1 or -1;
    Utility:RenderstepForLoop(0, 100, 3, function(p11) -- Line: 66
        -- upvalues: TweenService (ref), Value (copy), u10 (copy)
        local v12 = p11 / 100;
        local Value2 = TweenService:GetValue(v12, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        local Value3 = TweenService:GetValue(v12, Enum.EasingStyle.Back, Enum.EasingDirection.In);
        local v13 = 1 - 0.5 * Value3;
        Value.Position = UDim2.new(0.5 + 0.125 * Value2 * u10, 0, 0.5 + 0.125 * Value3, 0);
        Value.Size = UDim2.new(1 * v13, 0, 0.075 * v13, 0);
        Value.Rotation = v12 ^ 4 * 260 * u10;
    end);
    v9:Destroy();
end;

function u2._Init(p14) -- Line: 84
end;

return u2;