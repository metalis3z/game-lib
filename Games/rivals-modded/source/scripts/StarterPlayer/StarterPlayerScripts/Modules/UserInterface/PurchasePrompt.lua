-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 15
    -- upvalues: u1 (copy), UILibrary (copy)
    local v2 = setmetatable({}, u1);
    v2.Frame = UILibrary:GetTo("PurchasePrompt");
    v2._started = false;
    v2._blur = Instance.new("BlurEffect");
    v2:_Init();

    return v2;
end;

function u1.Start(u3) -- Line: 32
    -- upvalues: Utility (copy)
    if u3._started then
        return;
    end;

    u3._started = true;
    Utility:CreateSound("rbxassetid://17900058344", 1, 1, script, true, 10);
    Utility:RenderstepForLoop(0, 100, 2, function(p4) -- Line: 40
        -- upvalues: u3 (copy)
        if not u3._started then
            return true;
        end;

        local v5 = 1 - (1 - p4 / 100) ^ 4;
        u3.Frame.BackgroundTransparency = 1 + -0.5 * v5;
        u3._blur.Size = 56 * v5;
    end);
end;

function u1.Finish(u6, p7) -- Line: 54
    -- upvalues: Utility (copy)
    local v8 = not p7 or typeof(p7) == "boolean";
    local v9 = "Argument 1 invalid, expected a boolean or nil, got " .. tostring(p7);
    assert(v8, v9);

    if not u6._started then
        return;
    end;

    u6._started = false;

    if p7 then
        Utility:CreateSound("rbxassetid://7819009374", 1, 1, script, true, 10);
    end;

    Utility:RenderstepForLoop(0, 100, 2, function(p10) -- Line: 67
        -- upvalues: u6 (copy)
        if u6._started then
            return true;
        end;

        local v11 = 1 - (1 - p10 / 100) ^ 4;
        u6.Frame.BackgroundTransparency = 0.5 + 0.5 * v11;
        u6._blur.Size = 56 * (1 - v11);
    end);
end;

function u1._Setup(p12) -- Line: 83
    -- upvalues: Lighting (copy)
    p12._blur.Size = 0;
    p12._blur.Name = "PurchasePrompt";
    p12._blur.Parent = Lighting;
end;

function u1._Init(u13) -- Line: 89
    -- upvalues: MonetizationController (copy)
    MonetizationController.PurchaseStarted:Connect(function(...) -- Line: 90
        -- upvalues: u13 (copy)
        u13:Start(...);
    end);
    MonetizationController.PurchaseFinished:Connect(function(...) -- Line: 94
        -- upvalues: u13 (copy)
        u13:Finish(...);
    end);
    u13:_Setup();
end;

return u1._new();