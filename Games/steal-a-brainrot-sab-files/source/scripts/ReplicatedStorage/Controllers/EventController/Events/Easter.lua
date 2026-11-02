
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("Lighting");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v4 = {};
local v5 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local v6 = require(l_ReplicatedStorage_0.Controllers.EffectController);
local v7 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v8 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v9 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v10 = require(l_ReplicatedStorage_0.Packages.Observers);
local v11 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v12 = require(l_ReplicatedStorage_0.Packages.Trove);
local v13 = require(l_ReplicatedStorage_0.Packages.Net);
local l_Name_0 = script.Name;
local v15 = v13:RemoteEvent((("EventService/%*/Burst"):format(l_Name_0)));
local v16 = v12.new();
local function _(v17, v18, v19)
    local v20 = v17:LoadAnimation(v18);
    (v19 or v16):Add(function()
        v20:Stop(0);
        v20:Destroy();
    end);
    return v20;
end;
v4.OnStart = function(_)
    assert((v8:GetActiveEventData(l_Name_0)));
    v16:Add(function()
        v6:Activate("Blink");
        v9:Update();
        v7:UpdateOST();
    end);
    if v11.IsBiggerServer() then
        v16:Clone(script.MapBigger).Parent = workspace;
    elseif v11.IsTsunamiServer() then
        v16:Clone(script.MapTsunami).Parent = workspace;
    else
        v16:Clone(script.Map).Parent = workspace;
    end;
    v16:Add(v10.observeTag("HideInEaster", function(v23)
        local l_Parent_0 = v23.Parent;
        v23.Parent = script;
        return function()
            pcall(function()
                v23.Parent = l_Parent_0;
            end);
        end;
    end, {
        workspace, 
        script
    }));
    v6:Activate("Blink");
    v9:Update();
    v7:UpdateOST();
    v6:Run("EasterEvent", "GrassRecolor");
    v16:Add(function()
        v6:Stop("EasterEvent", "GrassRecolor");
    end);
    v6:Run("EasterEvent", "WallBottomRecolor");
    v16:Add(function()
        v6:Stop("EasterEvent", "WallBottomRecolor");
    end);
    v16:Add(v10.observeTag("EasterEventBunny", function(v25)
        local v26 = v12.new();
        local l_Parent_1 = v25.Parent;
        local v28 = v26:Clone(script.Bunny);
        v28:ScaleTo(l_Parent_1:GetAttribute("Scale") or 1);
        v28.Parent = workspace;
        local l_Weld_0 = Instance.new("Weld");
        l_Weld_0.Part0 = v28.PrimaryPart;
        l_Weld_0.Part1 = v25;
        l_Weld_0.C0 = v28.PrimaryPart.PivotOffset;
        l_Weld_0.Parent = v28.PrimaryPart;
        local l_Animator_0 = v28.AnimationController.Animator;
        local v31 = l_Animator_0:LoadAnimation(script.BunnyIdle);
        local l_v31_0 = v31 ;
        (v26 or v16):Add(function()
            l_v31_0:Stop(0);
            l_v31_0:Destroy();
        end);
        local l_v31_1 = v31;
        l_v31_1.Priority = Enum.AnimationPriority.Idle;
        l_v31_1.Looped = true;
        l_v31_1:Play();
        local v34 = l_Animator_0:LoadAnimation(script.BunnyRun);
        local l_v34_0 = v34 ;
        (v26 or v16):Add(function()
            l_v34_0:Stop(0);
            l_v34_0:Destroy();
        end);
        local l_v34_1 = v34;
        l_v34_1.Priority = Enum.AnimationPriority.Action;
        l_v34_1.Looped = true;
        local v37 = l_Animator_0:LoadAnimation(script.BunnyAttack);
        (v26 or v16):Add(function()
            v37:Stop(0);
            v37:Destroy();
        end);
        v31 = v37;
        v31.Priority = Enum.AnimationPriority.Action4;
        v31.Looped = false;
        v26:Add(v10.observeAttribute(l_Parent_1, "Moving", function(v38)
            if v38 then
                l_v34_1:Play();
            else
                l_v34_1:Stop();
            end;
            return nil;
        end));
        v34 = nil;
        v26:Add(v10.observeAttribute(l_Parent_1, "Jumping", function(v39)
            if v34 then
                v34:Destroy();
                v34 = nil;
            end;
            if not v39 then
                v31:Stop(0);
                l_Weld_0.Enabled = true;
                if v28.PrimaryPart then
                    v28.PrimaryPart.Anchored = false;
                end;
                return nil;
            else
                l_v34_1:Stop();
                v31:Play();
                local v40 = v26:Extend();
                v34 = v40;
                local l_l_Parent_1_Attribute_0 = l_Parent_1:GetAttribute("JumpTarget");
                if not l_l_Parent_1_Attribute_0 then
                    return nil;
                else
                    l_Weld_0.Enabled = false;
                    v28.PrimaryPart.Anchored = true;
                    local l_Position_0 = v28:GetPivot().Position;
                    local v43 = math.clamp(((v5.getAnimalCFrame(l_l_Parent_1_Attribute_0).Position - l_Position_0) * Vector3.new(1, 0, 1, 0)).Magnitude / 20, 0, 1) * 4 + 1;
                    local v44 = 0;
                    v40:Add(l_RunService_0.PreRender:Connect(function(v45)
                        v44 = v44 + v45;
                        if v44 < 0.7666666666666667 then
                            return;
                        else
                            local v46 = math.clamp((v44 - 0.7666666666666667) / 0.5666666666666667, 0, 1);
                            local l_Position_1 = v5.getAnimalCFrame(l_l_Parent_1_Attribute_0, {
                                top = true
                            }).Position;
                            local v48 = l_Position_0.X + (l_Position_1.X - l_Position_0.X) * v46;
                            local v49 = l_Position_0.Z + (l_Position_1.Z - l_Position_0.Z) * v46;
                            local v50 = nil;
                            v50 = if v46 <= 0.47058823529411764 then math.sin(v46 / 0.47058823529411764 * 3.141592653589793 * 0.5) * v43 else math.cos((v46 - 0.47058823529411764) / 0.5294117647058824 * 3.141592653589793 * 0.5) * v43;
                            local v51 = Vector3.new(v48, l_Position_0.Y + v50, v49);
                            local v52 = (l_Position_1 - l_Position_0) * Vector3.new(1, 0, 1, 0);
                            if v52.Magnitude > 0.01 then
                                v28:PivotTo(CFrame.lookAt(v51, v51 + v52.Unit));
                            else
                                v28:PivotTo(CFrame.new(v51));
                            end;
                            if v46 >= 0.95 then
                                v5.playBurst(script.Burst, l_l_Parent_1_Attribute_0, {
                                    l_ReplicatedStorage_0.Sounds.Events.Easter.Hit
                                });
                                v28:Destroy();
                                v40:Destroy();
                                v34 = nil;
                            end;
                            return;
                        end;
                    end));
                    v40:Add(function()
                        l_Weld_0.Enabled = true;
                        if v28.PrimaryPart then
                            v28.PrimaryPart.Anchored = false;
                        end;
                    end);
                    return nil;
                end;
            end;
        end));
        v26:Add(function()
            if v34 then
                v34:Destroy();
                v34 = nil;
            end;
        end);
        return v26:WrapClean();
    end, {
        workspace
    }));
    return nil;
end;
v4.OnStop = function(_)
    v16:Destroy();
end;
v4.OnLoad = function(_)
    v15.OnClientEvent:Connect(function(_)

    end);
end;
return v4;