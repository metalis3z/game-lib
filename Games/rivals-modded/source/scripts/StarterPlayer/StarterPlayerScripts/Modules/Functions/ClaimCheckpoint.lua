-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(u1, p2) -- Line: 6
    -- upvalues: Utility (copy), DuelLibrary (copy)
    Utility:PlayParticles(u1.Primary);
    Utility:CreateSound("rbxassetid://98948832050219", 2, 1, u1.Primary, true, 5);
    Utility:CreateSound("rbxassetid://129130524317348", 1.5, 1, u1.Primary, true, 5);
    local Flag = u1.Flag;
    Flag.CFrame = Flag.CFrame * CFrame.new(0, 4, 0);
    u1.Flag.Color = DuelLibrary:GetTeamColor(p2);
    u1.Flag.Transparency = 0;
    local Pivot = u1:GetPivot();
    local CFrame_Angles_ret = CFrame.Angles(6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random());
    local Scale = u1:GetScale();
    local u3 = Scale * 0.5;
    Utility:RenderstepForLoop(0, 100, 2, function(p4) -- Line: 23
        -- upvalues: u1 (copy), u3 (copy), Scale (copy), Pivot (copy), CFrame_Angles_ret (copy)
        local v5 = 1 - (1 - p4 / 100) ^ 3;
        u1:ScaleTo(u3 + (Scale - u3) * v5);
        u1:PivotTo(Pivot * CFrame.Angles(0, 0 + 9.42477796076938 * v5, 0) * CFrame_Angles_ret:Lerp(CFrame.identity, v5));
    end);
end;