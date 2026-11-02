-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 3, 
        Stackable = false, 
        Description = "Applies a pink tint to your screen with high contrast & disorients your screen if inflicted with Subspaced II or greater.\nEvery level of this status intensifies the effect, capping at Subspaced III.\nAlso makes you unable to hear chase & terror radius themes."
    }
};
local function _(v1) --[[ Line: 11 ]] --[[ Name: toggleChaseThemes ]]
    if game["Run Service"]:IsClient() then
        local l_Character_0 = game.Players.LocalPlayer.Character;
        if l_Character_0 then
            l_Character_0:SetAttribute("MuteChaseThemes", not v1);
        end;
    end;
end;
v0.Applied = function(v4) --[[ Line: 21 ]] --[[ Name: Applied ]]
    if game["Run Service"]:IsClient() and (not v4.Blur or not v4.ColorCorrection) then
        if not v4.Blur or not v4.ColorCorrection then
            for _, v6 in pairs(game.Lighting:GetChildren()) do
                if v6.ClassName:find("Effect") and not v6:GetAttribute("originalVal") and not v6.Name:find("SubspaceVFX") then
                    v6:SetAttribute("originalVal", v6.Enabled);
                    v6.Enabled = false;
                end;
            end;
            v4.Blur = Instance.new("BlurEffect");
            v4.Blur.Name = "SubspaceVFXBlur";
            v4.Blur.Size = 0;
            v4.Blur.Parent = game.Lighting;
            v4.ColorCorrection = Instance.new("ColorCorrectionEffect");
            v4.ColorCorrection.Name = "SubspaceVFXColorCorrection";
            v4.ColorCorrection:SetAttribute("IgnoredByInjuredSaturation", true);
            v4.ColorCorrection.Parent = game.Lighting;
        end;
        local l_FirstChild_0 = v4.Player.PlayerData.Settings:FindFirstChild("EpilepsyMode", true);
        local v8 = l_FirstChild_0 and l_FirstChild_0.Value;
        game.TweenService:Create(v4.Blur, TweenInfo.new(0.5), {
            Size = 4 * v4.Level
        }):Play();
        game.TweenService:Create(v4.ColorCorrection, TweenInfo.new(0.25), {
            Brightness = 1.125, 
            Contrast = 1 * v4.Level, 
            Saturation = -0.8, 
            TintColor = v8 and Color3.new(1, 0.75, 1) or Color3.new(1, 0.5, 1)
        }):Play();
        if v4.Level > 1 then
            local v9 = math.clamp(v4.Level * 80, 85, v8 and 250 or 500);
            local l_Unit_0 = Vector3.new(math.random(-40, 40), math.random(-20, 20), math.random(-0, 0)).Unit;
            do
                local l_v9_0 = v9;
                task.spawn(function() --[[ Line: 56 ]]
                    -- upvalues: v4 (copy), l_Unit_0 (copy), l_v9_0 (ref)
                    local v12 = 0.016;
                    while v4.Blur and v4.Blur.Parent do
                        local l_CurrentCamera_0 = workspace.CurrentCamera;
                        l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.Angles(math.rad(l_Unit_0.X * l_v9_0 * v12), math.rad(l_Unit_0.Y * l_v9_0 * v12), (math.rad(l_Unit_0.Z * l_v9_0 * v12)));
                        l_v9_0 = l_v9_0 - l_v9_0 * v12 * 1.25;
                        v12 = task.wait();
                    end;
                end);
            end;
        end;
    end;
    if game["Run Service"]:IsClient() then
        local l_Character_1 = game.Players.LocalPlayer.Character;
        if l_Character_1 then
            l_Character_1:SetAttribute("MuteChaseThemes", true);
        end;
    end;
end;
v0.Removed = function(v15) --[[ Line: 70 ]] --[[ Name: Removed ]]
    for _, v17 in pairs({
        v15.Blur, 
        v15.ColorCorrection
    }) do
        if v17:IsA("BlurEffect") then
            game.TweenService:Create(v17, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = 0
            }):Play();
        elseif v17:IsA("ColorCorrectionEffect") then
            game.TweenService:Create(v17, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Brightness = 0, 
                Contrast = 0, 
                Saturation = 0, 
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end;
        game.Debris:AddItem(v17, 1);
    end;
    v15.Blur = nil;
    v15.ColorCorrection = nil;
    if game["Run Service"]:IsClient() then
        local l_Character_2 = game.Players.LocalPlayer.Character;
        if l_Character_2 then
            l_Character_2:SetAttribute("MuteChaseThemes", false);
        end;
    end;
end;
return v0;