-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("TweenService");
local _ = game:GetService("Chat");
local l_Parent_0 = script.Parent;
local _ = require(l_Parent_0.Info);
local v4 = require(game.ReplicatedStorage.Modules.Util);
local v5 = nil;
local v6 = nil;
local v7 = -2;
local _ = function(v8) --[[ Line: 14 ]] --[[ Name: waitTilNextBeat ]]
    -- upvalues: v7 (ref)
    if not v8 then
        v8 = 1;
    end;
    for _ = 1, v8 do
        local l_v7_0 = v7;
        repeat
            task.wait();
        until v7 ~= l_v7_0;
    end;
end;
local v12 = {};
local v13 = false;
v12.server = function() --[[ Line: 25 ]] --[[ Name: server ]]
    -- upvalues: v7 (ref), v4 (copy), l_Parent_0 (copy), v5 (ref), v13 (ref)
    v7 = v7 + 1;
    local v14 = v4.GetClosestPlayer(l_Parent_0, 40);
    if not v5 then
        v5 = v4.LoadAnimations(l_Parent_0.Humanoid, script.Animations);
    end;
    if v14 and not v13 then
        v13 = true;
        local l_Children_0 = script.Attacks:GetChildren();
        local v16 = l_Children_0[math.random(1, #l_Children_0)];
        require(v16).Attack(v5, wait(0.1));
        v13 = false;
    end;
end;
v12.client = function() --[[ Line: 45 ]] --[[ Name: client ]]
    -- upvalues: v6 (ref), v4 (copy), l_Parent_0 (copy)
    if not v6 then
        v6 = v4.LoadAnimations(l_Parent_0.Humanoid, script.Animations);
    end;
end;
return v12;