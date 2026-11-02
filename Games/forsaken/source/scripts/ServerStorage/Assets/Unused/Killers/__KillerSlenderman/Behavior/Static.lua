-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Type = "Client"
};
local function _(v1) --[[ Line: 9 ]] --[[ Name: fetchSoundAsset ]]
    local l_FirstChild_0 = script.Parent.SFX:FindFirstChild(v1);
    if l_FirstChild_0 and l_FirstChild_0:IsA("Sound") then
        l_FirstChild_0:Play();
        return l_FirstChild_0;
    else
        return;
    end;
end;
v0.Start = function(v4, v5) --[[ Line: 17 ]] --[[ Name: Start ]]
    local l_Modules_0 = require(game.ReplicatedStorage.Initializer).Modules;
    local l_Network_0 = l_Modules_0.Network;
    local l_Util_0 = l_Modules_0.Util;
    local _ = l_Modules_0.Sounds;
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_Rig_0 = v5.Rig;
    local _ = script.Parent.SFX;
    local v14 = script.static:Clone();
    v14.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
    local v15 = {};
    local l_staticlight_0 = script.Parent.SFX:FindFirstChild("staticlight");
    local v17;
    if l_staticlight_0 and l_staticlight_0:IsA("Sound") then
        l_staticlight_0:Play();
        v17 = l_staticlight_0;
    else
        v17 = nil;
    end;
    v15.light = v17;
    l_staticlight_0 = script.Parent.SFX:FindFirstChild("staticmedium");
    if l_staticlight_0 and l_staticlight_0:IsA("Sound") then
        l_staticlight_0:Play();
        v17 = l_staticlight_0;
    else
        v17 = nil;
    end;
    v15.medium = v17;
    l_staticlight_0 = script.Parent.SFX:FindFirstChild("staticheavy");
    if l_staticlight_0 and l_staticlight_0:IsA("Sound") then
        l_staticlight_0:Play();
        v17 = l_staticlight_0;
    else
        v17 = nil;
    end;
    v15.heavy = v17;
    v4.staticSFX = v15;
    v15 = false;
    v17 = false;
    function l_staticlight_0() --[[ Line: 43 ]] --[[ Name: playerIsAlive ]]
        -- upvalues: l_Character_0 (copy)
        local v18 = l_Character_0.Parent == workspace.Players.Survivors;
        local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
        local v20 = l_Humanoid_0 and l_Character_0.Humanoid.Health > 0;
        return v18 and l_Humanoid_0 and v20;
    end;
    l_Network_0:SetConnection("SlendermanTeleported", "REMOTE_EVENT", function() --[[ Line: 50 ]]
        -- upvalues: v17 (ref), l_Character_0 (copy), l_Util_0 (copy), l_Rig_0 (copy), v15 (ref), v14 (copy), v4 (copy)
        if not v17 then
            local v21 = l_Character_0.Parent == workspace.Players.Survivors;
            local l_Humanoid_1 = l_Character_0:FindFirstChild("Humanoid");
            local v23 = l_Humanoid_1 and l_Character_0.Humanoid.Health > 0;
            if v21 and l_Humanoid_1 and v23 and l_Util_0:IsOnScreen(l_Rig_0) then
                v15 = true;
                v14.ImageTransparency = 0.16666666666666666;
                v4.staticSFX.light.Volume = 0.7692307692307693;
                v4.staticSFX.medium.Volume = 0.6955827937480333;
                v4.staticSFX.heavy.Volume = 0.3276800000000001;
                task.wait(0.1);
                v15 = false;
            end;
        end;
    end);
    local v24 = nil;
    v24 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 63 ]]
        -- upvalues: l_Character_0 (copy), v24 (ref), v15 (ref), v14 (copy), v17 (ref), v4 (copy)
        if not l_Character_0.Parent then
            v24:Disconnect();
            v24 = nil;
            return;
        elseif v15 then
            return;
        else
            local v25 = (l_Character_0:GetAttribute("Static") or 0) * (100 / (l_Character_0:GetAttribute("StaticResistance") or 100));
            v14.ImageTransparency = v17 and 0.25 or (125 - v25) / 125 + 0.25;
            v4.staticSFX.light.Volume = v17 and 0 or v25 / 130;
            v4.staticSFX.medium.Volume = v17 and 0 or math.sin(v25 / 130);
            v4.staticSFX.heavy.Volume = v17 and 0 or (v25 / 125) ^ 5;
            if v17 then
                return;
            else
                local l_CurrentCamera_0 = workspace.CurrentCamera;
                local v27 = v25 / 20 * 25;
                l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(0, 0, 0, 1 - math.random(0, v27) / 500, math.random(-v27, v27) / 2000, 0, math.random(-v27, v27) / 1500, 1, 0, 0, 0, 1 - math.random(0, v27) / 500);
                return;
            end;
        end;
    end);
    task.spawn(function() --[[ Line: 94 ]]
        -- upvalues: v14 (copy), l_Character_0 (copy), v17 (ref)
        while v14.Parent do
            if (l_Character_0:GetAttribute("Static") or 0) >= (l_Character_0:GetAttribute("StaticResistance") or 100) and not v17 then
                v17 = true;
                warn("oops you just died to slender but i didnt finish the gameover stuff yet so uhh");
                require(script.Parent.GameOver).Die();
            end;
            for v28 = 0, 2 do
                for v29 = 0, 2 do
                    if v29 ~= 2 or v28 ~= 2 then
                        v14.ImageRectOffset = Vector2.new(333 * v29, 250 * v28);
                        task.wait();
                    end;
                end;
            end;
        end;
    end);
end;
v0.Destroy = function(v30) --[[ Line: 115 ]] --[[ Name: Destroy ]]
    require(game.ReplicatedStorage.Initializer).Modules.Network:RemoveConnection("SlendermanTeleported");
    if v30.staticSFX then
        for _, v32 in pairs(v30.staticSFX) do
            v32:Destroy();
        end;
    end;
    v30.staticSFX = nil;
end;
return v0;