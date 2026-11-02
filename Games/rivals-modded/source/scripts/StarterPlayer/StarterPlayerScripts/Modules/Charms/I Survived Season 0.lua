-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Charm = require(Players.LocalPlayer.PlayerScripts.Modules.Charm);
local u1 = setmetatable({}, Charm);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Charm (copy), u1 (copy)
    local v2 = Charm.new(...);
    local v3 = setmetatable(v2, u1);
    v3._textlabel = v3.Model:WaitForChild("Extra"):WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel");
    v3._textlabel2 = v3.Model:WaitForChild("Extra"):WaitForChild("Part"):WaitForChild("SurfaceGui2"):WaitForChild("TextLabel");
    v3:_Init();

    return v3;
end;

function u1._Setup(p4) -- Line: 29
    local v5 = p4.EquippedData.Metadata and p4.EquippedData.Metadata.BeforeSeason0ELOResetLeaderboardRank and ("RANK #" .. p4.EquippedData.Metadata.BeforeSeason0ELOResetLeaderboardRank or "") or "";
    p4._textlabel.Text = v5;
    p4._textlabel2.Text = v5;
end;

function u1._Init(p6) -- Line: 36
    p6:_Setup();
end;

return u1;