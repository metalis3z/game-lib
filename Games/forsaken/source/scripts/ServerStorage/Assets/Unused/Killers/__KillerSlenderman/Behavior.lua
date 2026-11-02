-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Modules.Util);
v0.Abilities = {
    Disappear = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://71455375518024", 
        KeybindType = "AltAbility1", 
        Cooldown = function(v2) --[[ Line: 11 ]] --[[ Name: Cooldown ]]
            if v2.StoredInformation then
                return 8;
            else
                return 2;
            end;
        end, 
        Callback = function(v3, v4) --[[ Line: 12 ]] --[[ Name: Callback ]]
            if game["Run Service"]:IsServer() then
                if not v3.StoredInformation then
                    v3.StoredInformation = {};
                    for _, v6 in pairs(v3.Rig:GetDescendants()) do
                        if v6:IsA("BasePart") then
                            v3.StoredInformation[v6] = v6.Transparency;
                            game.TweenService:Create(v6, TweenInfo.new(0.2), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                    return "disappear";
                else
                    for v7, v8 in pairs(v3.StoredInformation) do
                        game.TweenService:Create(v7, TweenInfo.new(0.2), {
                            Transparency = v8
                        }):Play();
                    end;
                    v3.StoredInformation = nil;
                    task.delay(0.1, function() --[[ Line: 36 ]]
                        require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("SlendermanTeleported", "REMOTE_EVENT");
                    end);
                    return "appear";
                end;
            else
                if game["Run Service"]:IsClient() then
                    local l_Sprinting_0 = require(game.ReplicatedStorage.Initializer).CharacterSystems.Sprinting;
                    local l_Humanoid_0 = v3.Rig.Humanoid;
                    if v4 == "disappear" then
                        v3.StoredInformation = {
                            SprintSpeed = l_Sprinting_0.SprintSpeed, 
                            StaminaLoss = l_Sprinting_0.StaminaLoss, 
                            StaminaGain = l_Sprinting_0.StaminaGain, 
                            BaseSpeed = l_Humanoid_0:GetAttribute("BaseSpeed")
                        };
                        l_Sprinting_0:ChangeStat("SprintSpeed", v3.Config.InvisibleSprintSpeed);
                        l_Sprinting_0:ChangeStat("StaminaLoss", v3.Config.InvisibleStaminaLoss);
                        l_Sprinting_0:ChangeStat("StaminaGain", v3.Config.InvisibleStaminaGain);
                        l_Humanoid_0:SetAttribute("BaseSpeed", v3.Config.InvisibleSpeed);
                        task.spawn(function() --[[ Line: 67 ]]
                            -- upvalues: l_Humanoid_0 (copy), v3 (copy)
                            while task.wait() and l_Humanoid_0:GetAttribute("BaseSpeed") == v3.Config.InvisibleSpeed do
                                v3.Rig.Head.CanCollide = false;
                                v3.Rig.Torso.CanCollide = false;
                                v3.Rig.HumanoidRootPart.CanCollide = false;
                            end;
                            v3.Rig.Head.CanCollide = true;
                            v3.Rig.Torso.CanCollide = true;
                            v3.Rig.HumanoidRootPart.CanCollide = true;
                        end);
                        return;
                    elseif v4 == "appear" then
                        l_Sprinting_0:ChangeStat("SprintSpeed", v3.StoredInformation.SprintSpeed);
                        l_Sprinting_0:ChangeStat("StaminaLoss", v3.StoredInformation.StaminaLoss);
                        l_Sprinting_0:ChangeStat("StaminaGain", v3.StoredInformation.StaminaGain);
                        l_Humanoid_0:SetAttribute("BaseSpeed", v3.StoredInformation.BaseSpeed);
                        v3.StoredInformation = nil;
                    end;
                end;
                return;
            end;
        end
    }
};

v0.Created = function(_, v12) --[[ Line: 95 ]] --[[ Name: Created ]]
    local v13 = require(game.ReplicatedStorage.Initializer);
    for _, v15 in pairs(script:GetChildren()) do
        if v15:IsA("ModuleScript") then
            local v16 = require(v15);
            if v16.Type == "Server" and game["Run Service"]:IsServer() or v16.Type == "Client" and game["Run Service"]:IsClient() then
                v16.__index = v16;
                v13.RoundSystems[v15.Name] = setmetatable({}, v16);
                if v13.RoundSystems[v15.Name].Start then
                    v13.RoundSystems[v15.Name]:Start(v12);
                end;
            end;
        end;
    end;
end;

return v0;