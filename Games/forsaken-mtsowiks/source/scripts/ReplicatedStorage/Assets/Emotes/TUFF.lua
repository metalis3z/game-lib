-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.Util);
local _ = game:GetService("CollectionService");
return {
    DisplayName = "Who Wins", 
    Description = "'VS FICTION...", 
    Credits = "Made By: AndrewDotW3b & ms_d0ss", 
    RenderImage = "rbxassetid://80669217430800", 
    Price = 1000, 
    Exclusive = true, 
    Created = function(v3) --[[ Line: 15 ]] --[[ Name: Created ]]
        -- upvalues: v1 (copy)
        if not v1:GetSettingValue("EpilepsyMode") then
            local l_Character_0 = v3.Character;
            if not l_Character_0 then
                return;
            else
                local function v10(v5, v6) --[[ Line: 20 ]] --[[ Name: cloneAllChildren ]]
                    if v5 and v6 then
                        for _, v8 in ipairs(v5:GetChildren()) do
                            local v9 = v8:Clone();
                            v9.Parent = v6;
                            v9:SetAttribute("TUFFEmoteVFX", true);
                        end;
                    end;
                end;
                local l_Torso_0 = l_Character_0:FindFirstChild("Torso");
                local l_HumanoidRootPart_0 = l_Character_0:FindFirstChild("HumanoidRootPart");
                local v13 = {
                    l_Character_0:FindFirstChild("Left Arm"), 
                    l_Character_0:FindFirstChild("Right Arm"), 
                    l_Character_0:FindFirstChild("Left Leg"), 
                    l_Character_0:FindFirstChild("Right Leg")
                };
                local l_TorsoEffects_0 = script:FindFirstChild("TorsoEffects");
                if l_Torso_0 and l_TorsoEffects_0 and l_TorsoEffects_0:FindFirstChild("TorsoPart") then
                    v10(l_TorsoEffects_0.TorsoPart, l_Torso_0);
                end;
                local l_HRPEffects_0 = script:FindFirstChild("HRPEffects");
                if l_HumanoidRootPart_0 and l_HRPEffects_0 and l_HRPEffects_0:FindFirstChild("HRPPart") then
                    v10(l_HRPEffects_0.HRPPart, l_HumanoidRootPart_0);
                end;
                local l_ArmsNLegs_0 = script:FindFirstChild("ArmsNLegs");
                if l_ArmsNLegs_0 and l_ArmsNLegs_0:FindFirstChild("LimbPart") then
                    for _, v18 in ipairs(v13) do
                        if v18 then
                            v10(l_ArmsNLegs_0.LimbPart, v18);
                        end;
                    end;
                    return;
                end;
            end;
        else
            local l_HRPEffects_1 = script:FindFirstChild("HRPEffects");
            local l_HumanoidRootPart_1 = v3.Character:FindFirstChild("HumanoidRootPart");
            if l_HumanoidRootPart_1 and l_HRPEffects_1 then
                local v21 = l_HRPEffects_1.HRPPart.Floor:Clone();
                v21:SetAttribute("TUFFEmoteVFX", true);
                v21.Parent = l_HumanoidRootPart_1;
            end;
        end;
    end, 
    Destroyed = function(v22) --[[ Line: 68 ]] --[[ Name: Destroyed ]]
        local l_Character_1 = v22.Character;
        if not l_Character_1 then
            return;
        else
            for _, v25 in {
                l_Character_1:FindFirstChild("Torso"), 
                l_Character_1:FindFirstChild("HumanoidRootPart"), 
                l_Character_1:FindFirstChild("Left Arm"), 
                l_Character_1:FindFirstChild("Right Arm"), 
                l_Character_1:FindFirstChild("Left Leg"), 
                l_Character_1:FindFirstChild("Right Leg")
            } do
                if v25 then
                    for _, v27 in (v25:GetDescendants()) do
                        if (v27:IsA("Attachment") or v27:IsA("ParticleEmitter")) and v27:GetAttribute("TUFFEmoteVFX") then
                            v27:Destroy();
                        end;
                    end;
                end;
            end;
            return;
        end;
    end, 
    AssetID = "rbxassetid://114956186291981", 
    SFX = "rbxassetid://117520733630504", 
    SFXProperties = {
        Looped = true, 
        Volume = 0
    }, 
    SyncMusic = true, 
    SyncAnim = true
};