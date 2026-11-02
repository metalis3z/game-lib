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
v0.GetZombie = function(v8) --[[ Line: 17 ]] --[[ Name: GetZombie ]]
    local v9 = not v8.isRareZombieSpawned and math.random(100) == 1;
    local v10 = v9 and "SpecialZombieTemplate" or "ZombieTemplate";
    if v9 then
        v8.isRareZombieSpawned = true;
    end;
    return v8.Config[v10]:GetChildren()[math.random(#v8.Config[v10]:GetChildren())]:Clone();
end;
return v0;