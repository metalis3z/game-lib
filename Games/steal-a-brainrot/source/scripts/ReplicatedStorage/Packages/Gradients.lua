local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
if RunService:IsServer() then
    return {
        apply = function(v2, v3)
            local v4 = ("Gradients_%*"):format(v3);
            v2:AddTag(v4);
            return function()
                v2:RemoveTag(v4);
            end;
        end
    };
else
	local v5 = require(ReplicatedStorage.Packages.Observers);
    local v6 = {};
    local v7 = {};
    for _, v9 in script.Effects:GetChildren() do
        v6[v9.Name] = require(v9);
        v7[v9.Name] = {};
    end;
    local function v17(v10, v11)
        assert(typeof(v11) == "string", "effect is not a string");
        local v12 = assert(v6[v11], "Effect not found").apply(v10, v11);
        local v13 = {
            main = v12.main, 
            stroke = v12.stroke
        };
        table.insert(v7[v11], v13);
        local v14 = nil;
        local function v16()
            if v14 then
                v14:Disconnect();
                v14 = nil;
            end;
            local v15 = table.find(v7[v11], v13);
            if v15 then
                table.remove(v7[v11], v15);
            end;
            if v12 and v12.cleanup then
                v12.cleanup();
                v12 = nil;
            end;
        end;
        v14 = v10.Destroying:Connect(v16);
        return v16;
    end;
    RunService.PostSimulation:Connect(function(v18)
        debug.profilebegin("Gradients:Simulate");
        for v19, v20 in v7 do
            if #v20 ~= 0 then
                debug.profilebegin(v19);
                debug.profilebegin("Simulate");
                local v21 = v6[v19].simulate(v18);
                debug.profileend();
                debug.profilebegin("Apply");
                for _, v23 in v20 do
                    v23.main.Color = v21.main;
                    if v23.stroke and v21.stroke then
                        v23.stroke.Color = v21.stroke;
                    end;
                end;
                debug.profileend();
                debug.profileend();
            end;
        end;
        debug.profileend();
    end);
    for v24 in v7 do
        v5.observeTag(("Gradients_%*"):format(v24), function(v25)
            return (v17(v25, v24));
        end);
    end;
    return {
        apply = v17
    };
end;