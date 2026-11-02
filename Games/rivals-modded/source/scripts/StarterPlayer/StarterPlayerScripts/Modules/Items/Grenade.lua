-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.Spring);
local Throwable = require(Players.LocalPlayer.PlayerScripts.Modules.ItemTypes.Throwable);
local u1 = setmetatable({}, Throwable);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: Throwable (copy), u1 (copy)
    local v2 = Throwable.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(u4) -- Line: 30
    -- upvalues: BetterDebris (copy), RunService (copy)
    u4.ProjectileThrown:Connect(function(p5, p6) -- Line: 31
        -- upvalues: BetterDebris (ref), u4 (copy), RunService (ref)
        local Highlight = Instance.new("Highlight");
        Highlight.FillColor = Color3.fromRGB(255, 0, 0);
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 0;
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.Adornee = p6;
        Highlight.Parent = p6;
        BetterDebris:AddItem(Highlight, 10);
        local Random_new_ret = Random.new();
        local v7 = tick();

        while p5:IsDescendantOf(workspace) do
            local v8 = (tick() - v7) / u4.Info.DetonateDelay;
            local math_min_ret = math.min(1, v8);
            local v9 = Random_new_ret:NextUnitVector() * 0.25 * math_min_ret ^ 4;
            p6.WorldPivot = p6:GetPivot() + v9;
            Highlight.FillTransparency = 1 - math_min_ret ^ 4 / 2;
            RunService.RenderStepped:Wait();
        end;

        Highlight:Destroy();
    end);
end;

return u1;