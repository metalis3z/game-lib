-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local v4 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local v5 = l_Knit_0.CreateController({
    Name = "AuraPopupController"
});
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v7 = Random.new();
local l_sqrt_0 = math.sqrt;
local v9 = TweenInfo.new(0.25, Enum.EasingStyle.Back);
local v10 = TweenInfo.new(0.45);
v5.KnitInit = function(v11) --[[ Line: 21 ]] --[[ Name: KnitInit ]]
    v11.TrainingAreasService = nil;
    v11.PlayerGui = nil;
    v11.Hud = nil;
    v11.TickTemplate = nil;
    v11.TickPool = {};
    v11.TICK_POOL_MAX = 19;
    v11.LastTickX = 0.5;
    v11.LastTickY = 0.5;
    v11.MIN_TICK_DIST = 0.18;
    v11.HighestShakeTier = 0;
    v11.ShakeCarryTicks = 0;
    v11.TickSound = nil;
end;
v5.KnitStart = function(v12) --[[ Line: 41 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v12.TrainingAreasService = l_Knit_0.GetService("TrainingAreasService");
    v12:_grabRefs();
    v12:_bindSignals();
end;
v5._grabRefs = function(v13) --[[ Line: 48 ]] --[[ Name: _grabRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_ReplicatedStorage_0 (copy)
    v13.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v13.Hud = v13.PlayerGui:WaitForChild("Hud");
    v13.TickTemplate = v13.Hud:WaitForChild("TickTemplate");
    local l_Assets_0 = l_ReplicatedStorage_0:FindFirstChild("Assets");
    if l_Assets_0 then
        local l_Sounds_0 = l_Assets_0:FindFirstChild("Sounds");
        if l_Sounds_0 then
            v13.TickSound = l_Sounds_0:FindFirstChild("Tick");
        end;
    end;
end;
v5._bindSignals = function(v16) --[[ Line: 62 ]] --[[ Name: _bindSignals ]]
    v16.TrainingAreasService.Tick:Connect(function(v17, v18, v19, v20) --[[ Line: 63 ]]
        -- upvalues: v16 (copy)
        v16:_onTick(v17, v18, v19, v20);
    end);
end;
v5._getSpreadTickPosition = function(v21) --[[ Line: 68 ]] --[[ Name: _getSpreadTickPosition ]]
    -- upvalues: v7 (copy), l_sqrt_0 (copy)
    local v22 = 0;
    local v23 = nil;
    local v24 = nil;
    repeat
        v23 = v7:NextNumber(0.15, 0.85);
        v24 = v7:NextNumber(0.2, 0.7);
        local v25 = v23 - v21.LastTickX;
        local v26 = v24 - v21.LastTickY;
        local v27 = l_sqrt_0(v25 * v25 + v26 * v26);
        v22 = v22 + 1;
    until v21.MIN_TICK_DIST <= v27 or v22 >= 8;
    v21.LastTickX = v23;
    v21.LastTickY = v24;
    return v23, v24;
end;
v5._acquireTickGui = function(v28) --[[ Line: 92 ]] --[[ Name: _acquireTickGui ]]
    local v29 = table.remove(v28.TickPool);
    if v29 then
        v29.Visible = true;
        v29.GroupTransparency = 0;
        v29.Size = UDim2.fromScale(0, 0);
        v29.Rotation = 0;
        v29.Parent = v28.Hud;
        return v29;
    else
        local v30 = v28.TickTemplate:Clone();
        v30.Visible = true;
        v30.GroupTransparency = 0;
        v30.Size = UDim2.fromScale(0, 0);
        v30.Rotation = 0;
        v30.Parent = v28.Hud;
        return v30;
    end;
end;
v5._releaseTickGui = function(v31, v32) --[[ Line: 112 ]] --[[ Name: _releaseTickGui ]]
    if not v32 then
        return;
    else
        v32.Visible = false;
        v32.Parent = v31.Hud;
        if #v31.TickPool < v31.TICK_POOL_MAX then
            table.insert(v31.TickPool, v32);
            return;
        else
            v32:Destroy();
            return;
        end;
    end;
end;
v5._normalizeAmount = function(_, v34) --[[ Line: 127 ]] --[[ Name: _normalizeAmount ]]
    -- upvalues: v4 (copy)
    return v4.Normalize(v34);
end;
v5._getDisplayAmount = function(v35, v36) --[[ Line: 131 ]] --[[ Name: _getDisplayAmount ]]
    -- upvalues: l_LocalPlayer_0 (copy), v4 (copy)
    local v37 = v35:_normalizeAmount(v36);
    if not v37 then
        return nil;
    else
        local v38 = l_LocalPlayer_0:GetAttribute("CatchupMult") or 1;
        local v39 = false;
        if typeof(v38) == "number" then
            v39 = v38 > 1;
        end;
        if v39 then
            return v4.Divide(v37, 10) or v37;
        else
            return v37;
        end;
    end;
end;
v5._playTickSound = function(v40) --[[ Line: 147 ]] --[[ Name: _playTickSound ]]
    if v40.TickSound and v40.TickSound:IsA("Sound") then
        v40.TickSound:Play();
    end;
end;
v5._onTick = function(v41, v42, _, _, _) --[[ Line: 153 ]] --[[ Name: _onTick ]]
    -- upvalues: v4 (copy), l_TweenService_0 (copy), v9 (copy), v10 (copy)
    local v46 = v41:_normalizeAmount(v42);
    if not v46 or v4.IsZero(v46) then
        return;
    else
        local v47 = v41:_getDisplayAmount(v46);
        if not v47 then
            return;
        else
            local v48, v49 = v41:_getSpreadTickPosition();
            local v50 = v41:_acquireTickGui();
            v50.Position = UDim2.fromScale(v48, v49);
            v50.Count.Text = "+" .. v4.FormatNumber(v47) .. " Aura";
            v50.GroupTransparency = 0;
            v41:_playTickSound();
            l_TweenService_0:Create(v50, v9, {
                Size = UDim2.fromScale(0.25, 0.207), 
                Rotation = 0
            }):Play();
            task.delay(0.55, function() --[[ Line: 179 ]]
                -- upvalues: v50 (copy), l_TweenService_0 (ref), v10 (ref), v41 (copy)
                if not v50 or not v50.Parent then
                    return;
                else
                    local v51 = l_TweenService_0:Create(v50, v10, {
                        GroupTransparency = 1
                    });
                    v51:Play();
                    v51.Completed:Once(function() --[[ Line: 191 ]]
                        -- upvalues: v50 (ref), v41 (ref)
                        if v50 then
                            v41:_releaseTickGui(v50);
                        end;
                    end);
                    return;
                end;
            end);
            return;
        end;
    end;
end;
return v5;