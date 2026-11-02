-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Sounds);
local _ = require(game.ReplicatedStorage.Modules.Util);
local _ = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
local _ = require(game.ReplicatedStorage.Modules.Network);
v0.SummonZombie = function(_, v7) --[[ Line: 9 ]] --[[ Name: SummonZombie ]]
    if not v7 then
        return;
    else
        if v7.PrimaryPart then
            if not v7.PrimaryPart:FindFirstChild("Radius") then
                return;
            else
                v7.PrimaryPart.Radius:Play();
            end;
        end;
        return;
    end;
end;
return v0;