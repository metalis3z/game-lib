-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = game:GetService("ReplicatedStorage");
local v1 = game:GetService("RunService");
local v2 = game:GetService("TweenService");
local v3 = game:GetService("Players");
local v4 = game:GetService("Debris");
local v5 = game:GetService("CollectionService");
local v6 = require(v0.Modules.Sounds);
local v7 = require(v0.Modules.Statuses);
local v8 = require(v0.Modules.Util);
local v9 = require(v0.Modules.Actors);
local v10 = {};
v10.__index = v10;
v10.new = function(v11, v12) --[[ Line: 16 ]] --[[ Name: new ]]
    -- upvalues: v10 (copy), v8 (copy)
    local v13 = setmetatable({}, v10);
    local v14 = v11.Config.PuddleRootTemplate:Clone();
    v14.CFrame = v12 * CFrame.Angles(0, 1.5707963267948966, 0);
    v14.Name = ("%*Puddle"):format(v11.Player.Name);
    v14.Parent = workspace.Map.Ingame;
    v8:ApplyUnsafeTouched(v14, false, function(v15, v16) --[[ Line: 24 ]]
        -- upvalues: v8 (ref), v11 (copy), v13 (copy)
        local v17 = v16.Parent;
        if v17 and v17:FindFirstChild("Humanoid") and v8:GetEntityType(v17) and v17 ~= v11.Rig then
            v13:OnContact(v17);
        end;
    end, 20);
    v13.Instance = v14;
    v13.SurvivorDebounces = {};
    v13.Player = v11.Player;
    table.insert(v11.Meta.ServerObjects.Puddles, v13);
    return v13;
end;
v10.GetActor = function(v18) --[[ Line: 45 ]] --[[ Name: GetActor ]]
    -- upvalues: v9 (copy)
    return v9.CurrentActors[v18.Player];
end;
v10.OnContact = function(v19, v20) --[[ Line: 50 ]] --[[ Name: OnContact ]]
    -- upvalues: v7 (copy)
    local v21 = v19.SurvivorDebounces[v20] or 0;
    if os.clock() - v21 < 1 then
        return;
    else
        v19.SurvivorDebounces[v20] = os.clock();
        v7:ApplyStatus(v20, "Bleeding", {
            Duration = 5, 
            Level = 3, 
            Stackable = false
        });
        local v22 = v7:PlayerHasStatus(v20, "Slowness");
        if not v22 or v22.Level <= 1 then
            v7:ApplyStatus(v20, "Slowness", {
                Duration = 5, 
                Level = 2
            });
        end;
        return;
    end;
end;
v10.Destroy = function(v23) --[[ Line: 68 ]] --[[ Name: Destroy ]]
    local v24 = v23:GetActor();
    local v25 = v24 and v24.Meta and table.find(v24.Meta.ServerObjects.Puddles, v23);
    if v25 then
        table.remove(v24.Meta.ServerObjects.Puddles, v25);
    end;
    if v23.Instance then
        game.Debris:AddItem(v23.Instance, 1.8);
        pcall(function() --[[ Line: 78 ]]
            -- upvalues: v23 (copy)
            for v26, v27 in ipairs(v23.Instance.Puddle:GetChildren()) do
                v27.Enabled = false;
            end;
        end);
    end;
    table.clear(v23);
end;
return v10;