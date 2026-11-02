
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v2 = require(l_ReplicatedStorage_0.Packages.Observers);
local v3 = require(l_ReplicatedStorage_0.Packages.Trove);
local v4 = require(l_ReplicatedStorage_0.Packages.Net):RemoteEvent("EggCity/EggBurst");
local v5 = {};
local function _(v6, v7, v8)
    local v9 = v6:LoadAnimation(v7);
    v8:Add(function()
        v9:Stop(0);
        v9:Destroy();
    end);
    return v9;
end;
local v28 = {
    Start = function(_)
        local v12 = v3.new();
        for v13 = 1, 4 do
            local l_script_FirstChild_0 = script:FindFirstChild((("Egg%*"):format(v13)));
            if l_script_FirstChild_0 and l_script_FirstChild_0:IsA("Model") then
                v5[v13] = l_script_FirstChild_0;
            end;
        end;
        v12:Add(v2.observeTag("EggCityEgg", function(v15)
            local v16 = v3.new();
            local l_Parent_0 = v15.Parent;
            if not l_Parent_0 then
                return nil;
            else
                local v18 = v5[l_Parent_0:GetAttribute("Variant") or 1] or v5[1];
                if not v18 then
                    return nil;
                else
                    local v19 = v16:Clone(v18);
                    v19:ScaleTo(l_Parent_0:GetAttribute("Scale") or 1);
                    v19.Parent = workspace;
                    local l_Weld_0 = Instance.new("Weld");
                    l_Weld_0.Part0 = v19.PrimaryPart;
                    l_Weld_0.Part1 = v15;
                    l_Weld_0.C0 = v19.PrimaryPart.PivotOffset;
                    l_Weld_0.Parent = v19.PrimaryPart;
                    local l_Animator_0 = v19.AnimationController.Animator;
                    local v22 = l_Animator_0:LoadAnimation(script.EggIdle);
                    v16:Add(function()
                        v22:Stop(0);
                        v22:Destroy();
                    end);
                    local l_v22_0 = v22;
                    l_v22_0.Priority = Enum.AnimationPriority.Idle;
                    l_v22_0.Looped = true;
                    l_v22_0:Play();
                    local v24 = l_Animator_0:LoadAnimation(script.EggWalk);
                    v16:Add(function()
                        v24:Stop(0);
                        v24:Destroy();
                    end);
                    local l_v24_0 = v24;
                    l_v24_0.Priority = Enum.AnimationPriority.Action;
                    l_v24_0.Looped = true;
                    v16:Add(v2.observeAttribute(l_Parent_0, "Moving", function(v26)
                        if v26 then
                            l_v24_0:Play(0.2, 1, 2);
                        else
                            l_v24_0:Stop();
                        end;
                        return nil;
                    end));
                    return v16:WrapClean();
                end;
            end;
        end, {
            workspace
        }));
        v12:Add(v4.OnClientEvent:Connect(function(v27)
            if type(v27) ~= "string" then
                return;
            else
                v1.playBurst(script.Burst, v27, {
                    l_ReplicatedStorage_0.Sounds.Events.Easter.Hit
                });
                return;
            end;
        end));
        return function()
            v12:Destroy();
        end;
    end
};
return table.freeze(v28);