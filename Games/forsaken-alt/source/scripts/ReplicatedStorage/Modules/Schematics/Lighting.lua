-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Network);
v0.Properties = {
    Ambient = Color3.fromRGB(0, 0, 0), 
    Brightness = 3, 
    ColorShift_Bottom = Color3.fromRGB(0, 0, 0), 
    ColorShift_Top = Color3.fromRGB(0, 0, 0), 
    EnvironmentDiffuseScale = 1, 
    EnvironmentSpecularScale = 1, 
    GlobalShadows = true, 
    OutdoorAmbient = Color3.fromRGB(70, 70, 70), 
    ShadowSoftness = 0.2, 
    ClockTime = workspace:GetAttribute("Testing") and 12 or 5.4, 
    GeographicLatitude = 0, 
    ExposureCompensation = workspace:GetAttribute("Testing") and 0 or 1.24, 
    FogColor = Color3.fromRGB(192, 192, 192), 
    FogEnd = 100000, 
    FogStart = 0
};
v0.SetAsCurrentLighting = function(_) --[[ Line: 26 ]] --[[ Name: SetAsCurrentLighting ]]
    -- upvalues: v0 (copy), v1 (copy)
    if game["Run Service"]:IsServer() then
        return;
    else
        v0:SetDefaultLighting();
        local v3 = v1:FireServerConnection("GetCurrentLighting", "REMOTE_FUNCTION");
        if v3 then
            v0:SetCustomLighting(v3);
        end;
        return;
    end;
end;
v0.SetCustomLighting = function(_, v5) --[[ Line: 37 ]] --[[ Name: SetCustomLighting ]]
    -- upvalues: v0 (copy), v1 (copy)
    if game["Run Service"]:IsServer() then
        if typeof(v5) == "Instance" and v5:IsA("Folder") then
            v5 = v5:Clone();
            v5.Name = "CurrentReplicatedLighting";
            v5.Parent = game.ReplicatedStorage;
        end;
        v0.CurrentLighting = v5;
        v1:FireAllClientConnection("SetCustomLighting", "REMOTE_EVENT", v5);
        return;
    elseif typeof(v5) == "Instance" and v5:IsA("Folder") then
        game.Lighting:ClearAllChildren();
        for _, v7 in pairs(v5:GetChildren()) do
            if v7:IsA("ModuleScript") then
                local v8 = require(v7);
                v0:SetCustomLighting(v8);
            else
                v7:Clone().Parent = game.Lighting;
            end;
        end;
        return;
    else
        local l_pairs_0 = pairs;
        local v10 = v5 or {};
        for v11, v12 in l_pairs_0(v10) do
            game.Lighting[v11] = v12;
        end;
        return;
    end;
end;
v0.SetDefaultLighting = function(_) --[[ Line: 69 ]] --[[ Name: SetDefaultLighting ]]
    -- upvalues: v0 (copy), v1 (copy)
    if game["Run Service"]:IsServer() then
        if typeof(v0.CurrentLighting) == "Instance" then
            v0.CurrentLighting:Destroy();
        end;
        v0.CurrentLighting = nil;
        v1:FireAllClientConnection("SetDefaultLighting", "REMOTE_EVENT");
        return;
    else
        v0:SetCustomLighting(v0.Properties);
        game.Lighting:ClearAllChildren();
        for _, v15 in pairs(script:GetChildren()) do
            v15:Clone().Parent = game.Lighting;
        end;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 91 ]] --[[ Name: Start ]]
    -- upvalues: v1 (copy), v0 (copy)
    if game["Run Service"]:IsServer() then
        v1:SetConnection("GetCurrentLighting", "REMOTE_FUNCTION", function(v17) --[[ Line: 96 ]]
            -- upvalues: v0 (ref)
            if v0.CurrentLighting then
                local v18 = v0.CurrentLighting:Clone();
                v18.Parent = v17.PlayerGui;
                game.Debris:AddItem(v18, 20);
                return v18;
            else
                return;
            end;
        end);
        return;
    else
        if game["Run Service"]:IsClient() then
            v1:SetConnection("SetCustomLighting", "REMOTE_EVENT", function(v19) --[[ Line: 108 ]]
                -- upvalues: v0 (ref)
                v0:SetCustomLighting(v19);
            end);
            v1:SetConnection("SetDefaultLighting", "REMOTE_EVENT", function() --[[ Line: 113 ]]
                -- upvalues: v0 (ref)
                v0:SetDefaultLighting();
            end);
            v0:SetDefaultLighting();
        end;
        return;
    end;
end;
return v0;