-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.BetterDebris);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewModels"):WaitForChild("Riot Shield"));
local u2 = { { "rbxassetid://105059726931047", "rbxassetid://79914271483818" }, { "rbxassetid://77461546699017", "rbxassetid://76552313877907" } };
local u3 = setmetatable({}, u1);
u3.__index = u3;

function u3.new(...) -- Line: 15
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    local v4 = u1.new(...);
    local v5 = setmetatable(v4, u3);
    v5._painting_data = u2[math.random(#u2)];
    v5:_Init();

    return v5;
end;

function u3.GetImage(p6) -- Line: 29
    return p6._painting_data[2];
end;

function u3.AbsorbedHit(p7) -- Line: 33
    p7:CreateSound("rbxassetid://134671375134755", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u3._Setup(p8) -- Line: 41
    p8.ItemModel:WaitForChild("Body"):WaitForChild("Canvas"):WaitForChild("Decal").Texture = p8._painting_data[1];
end;

function u3._Init(p9) -- Line: 45
    p9:_Setup();
end;

return u3;