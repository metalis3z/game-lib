-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Knit_0 = require(l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = l_Knit_0.CreateController({
    Name = "RebirthController"
});
v5.KnitInit = function(v6) --[[ Line: 13 ]] --[[ Name: KnitInit ]]
    v6.PlayerService = nil;
    v6.IsRequestInFlight = false;
    v6.PlayerGui = nil;
    v6.Extensions = nil;
    v6.RebirthVignete = nil;
    v6.RebirthPad = nil;
    v6.TouchPart = nil;
    v6.Hitbox = nil;
    v6.Light = nil;
    v6.Template = nil;
    v6.Billboard = nil;
    v6.MainBillboard = nil;
    v6.TouchDebounce = false;
    v6.PadBusy = false;
    v6.OriginalSize = nil;
    v6.OriginalCFrame = nil;
    v6.ShrinkCFrame = nil;
    v6.ShrinkSize = nil;
    v6.PureWhite = Color3.new(1, 1, 1);
    v6.PureGreen = Color3.fromRGB(0, 255, 0);
    v6.OriginalBrightness = 1;
    v6.ShrinkInfo = TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    v6.GrowInfo = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
    v6.FlashInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    v6.ReturnInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    v6.RebirthVigneteIn = nil;
    v6.RebirthVigneteOut = nil;
end;
v5.KnitStart = function(v7) --[[ Line: 50 ]] --[[ Name: KnitStart ]]
    -- upvalues: l_Knit_0 (copy)
    v7.PlayerService = l_Knit_0.GetService("PlayerService");
    v7.PlayerService.RebirthPerformed:Connect(function(v8, v9) --[[ Line: 53 ]]
        -- upvalues: v7 (copy)
        v7:_onRebirthPerformed(v8, v9);
    end);
    v7:_grabGuiRefs();
    v7:_grabWorldRefs();
    v7:_setupCachedTweens();
    v7:_bindPadTouch();
end;
v5._grabGuiRefs = function(v10) --[[ Line: 63 ]] --[[ Name: _grabGuiRefs ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    v10.PlayerGui = l_LocalPlayer_0:WaitForChild("PlayerGui");
    v10.Extensions = v10.PlayerGui:WaitForChild("Extensions");
    v10.RebirthVignete = v10.Extensions:WaitForChild("RebirthVignete");
end;
v5._grabWorldRefs = function(v11) --[[ Line: 69 ]] --[[ Name: _grabWorldRefs ]]
    v11.RebirthPad = workspace:WaitForChild("RebirthPad");
    v11.TouchPart = v11.RebirthPad:WaitForChild("TouchPart");
    v11.Hitbox = v11.RebirthPad:WaitForChild("Hitbox");
    v11.Light = v11.TouchPart:WaitForChild("PointLight");
    v11.Template = v11.TouchPart:WaitForChild("Template");
    v11.Billboard = v11.Template:WaitForChild("BillboardGui");
    v11.MainBillboard = v11.Template:WaitForChild("MainBillboard");
    v11.TouchPart.Anchored = true;
    v11.TouchPart.CanCollide = false;
    v11.TouchPart.CanTouch = true;
    v11.Hitbox.CanTouch = true;
    v11.Hitbox.CanCollide = false;
    v11.OriginalSize = v11.TouchPart.Size;
    v11.OriginalCFrame = v11.TouchPart.CFrame;
    v11.ShrinkCFrame = v11.OriginalCFrame - Vector3.new(0, 0.30000001192092896, 0, 0);
    v11.ShrinkSize = Vector3.new(v11.OriginalSize.X * 1.1, v11.OriginalSize.Y * 0.2, v11.OriginalSize.Z * 1.1);
    v11.OriginalBrightness = v11.Light.Brightness;
end;
v5._setupCachedTweens = function(v12) --[[ Line: 97 ]] --[[ Name: _setupCachedTweens ]]
    -- upvalues: l_TweenService_0 (copy)
    v12.RebirthVigneteIn = l_TweenService_0:Create(v12.RebirthVignete, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = 0.4
    });
    v12.RebirthVigneteOut = l_TweenService_0:Create(v12.RebirthVignete, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    });
end;
v5._bindPadTouch = function(v13) --[[ Line: 111 ]] --[[ Name: _bindPadTouch ]]
    if not v13.Hitbox then
        warn("[RebirthController] No Hitbox");
        return;
    else
        v13.Hitbox.Touched:Connect(function(v14) --[[ Line: 117 ]]
            -- upvalues: v13 (copy)
            v13:_onTouchPartTouched(v14);
        end);
        return;
    end;
end;
v5._safePlayPadSound = function(v15) --[[ Line: 122 ]] --[[ Name: _safePlayPadSound ]]
    if not v15.RebirthPad then
        return;
    else
        local l_FirstChildWhichIsA_0 = v15.RebirthPad:FindFirstChildWhichIsA("Sound", true);
        if l_FirstChildWhichIsA_0 then
            l_FirstChildWhichIsA_0:Play();
        end;
        return;
    end;
end;
v5._playRebirthPadAnimation = function(v17) --[[ Line: 133 ]] --[[ Name: _playRebirthPadAnimation ]]
    -- upvalues: l_TweenService_0 (copy)
    if v17.PadBusy or not v17.TouchPart then
        return;
    else
        v17.PadBusy = true;
        local v18 = l_TweenService_0:Create(v17.TouchPart, v17.ShrinkInfo, {
            Size = v17.ShrinkSize, 
            CFrame = v17.ShrinkCFrame
        });
        local v19 = l_TweenService_0:Create(v17.TouchPart, v17.GrowInfo, {
            Size = v17.OriginalSize, 
            CFrame = v17.OriginalCFrame
        });
        v18:Play();
        v18.Completed:Wait();
        v19:Play();
        task.delay(0.6, function() --[[ Line: 154 ]]
            -- upvalues: v17 (copy)
            v17.PadBusy = false;
        end);
        return;
    end;
end;
v5._playRebirthVFX = function(v20) --[[ Line: 159 ]] --[[ Name: _playRebirthVFX ]]
    -- upvalues: l_TweenService_0 (copy)
    v20:_safePlayPadSound();
    if v20.TouchPart then
        l_TweenService_0:Create(v20.TouchPart, v20.FlashInfo, {
            Color = v20.PureWhite
        }):Play();
        l_TweenService_0:Create(v20.TouchPart, v20.ReturnInfo, {
            Color = v20.PureGreen
        }):Play();
    end;
    if v20.Light then
        l_TweenService_0:Create(v20.Light, v20.FlashInfo, {
            Color = v20.PureWhite, 
            Brightness = v20.OriginalBrightness * 1.2
        }):Play();
        l_TweenService_0:Create(v20.Light, v20.ReturnInfo, {
            Color = v20.PureWhite, 
            Brightness = v20.OriginalBrightness
        }):Play();
    end;
    if v20.RebirthVigneteIn then
        v20.RebirthVigneteIn:Play();
    end;
    if v20.Billboard then
        v20.Billboard.Enabled = false;
    end;
    task.wait(0.25);
    if v20.RebirthVigneteOut then
        v20.RebirthVigneteOut:Play();
    end;
    task.delay(0.5, function() --[[ Line: 198 ]]
        -- upvalues: v20 (copy)
        if v20.Billboard then
            v20.Billboard.Enabled = true;
        end;
    end);
end;
v5._playRebirthHapticsSound = function(_) --[[ Line: 205 ]] --[[ Name: _playRebirthHapticsSound ]]
    local l_Haptics_0 = workspace:FindFirstChild("Haptics");
    local v23 = l_Haptics_0 and l_Haptics_0:FindFirstChild("Rebirth");
    if v23 and v23:IsA("Sound") then
        v23:Play();
    end;
end;
v5._flashCharacterHighlight = function(_) --[[ Line: 213 ]] --[[ Name: _flashCharacterHighlight ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_TweenService_0 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    else
        local l_Highlight_0 = l_Character_0:FindFirstChildOfClass("Highlight");
        if not l_Highlight_0 then
            return;
        else
            l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.25), {
                FillTransparency = 0
            }):Play();
            task.delay(0.45, function() --[[ Line: 229 ]]
                -- upvalues: l_Highlight_0 (copy), l_TweenService_0 (ref)
                if l_Highlight_0 and l_Highlight_0.Parent then
                    l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(1), {
                        FillTransparency = 1
                    }):Play();
                end;
            end);
            return;
        end;
    end;
end;
v5._playSuccessEffects = function(v27) --[[ Line: 239 ]] --[[ Name: _playSuccessEffects ]]
    task.spawn(function() --[[ Line: 240 ]]
        -- upvalues: v27 (copy)
        v27:_playRebirthVFX();
    end);
    task.spawn(function() --[[ Line: 244 ]]
        -- upvalues: v27 (copy)
        v27:_playRebirthHapticsSound();
    end);
    task.spawn(function() --[[ Line: 248 ]]
        -- upvalues: v27 (copy)
        v27:_flashCharacterHighlight();
    end);
end;
v5._onTouchPartTouched = function(v28, v29) --[[ Line: 253 ]] --[[ Name: _onTouchPartTouched ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if v28.TouchDebounce then
        return;
    else
        local l_Character_1 = l_LocalPlayer_0.Character;
        if not l_Character_1 then
            return;
        elseif not v29 or not v29:IsDescendantOf(l_Character_1) then
            return;
        else
            local l_Humanoid_0 = l_Character_1:FindFirstChildOfClass("Humanoid");
            if not l_Humanoid_0 or l_Humanoid_0.Health <= 0 then
                return;
            else
                v28.TouchDebounce = true;
                task.spawn(function() --[[ Line: 274 ]]
                    -- upvalues: v28 (copy)
                    v28:_playRebirthPadAnimation();
                end);
                v28:RequestRebirth();
                task.delay(0.75, function() --[[ Line: 280 ]]
                    -- upvalues: v28 (copy)
                    v28.TouchDebounce = false;
                end);
                return;
            end;
        end;
    end;
end;
v5.RequestRebirth = function(v32) --[[ Line: 285 ]] --[[ Name: RequestRebirth ]]
    if v32.IsRequestInFlight then
        return;
    elseif not v32.PlayerService then
        return;
    else
        v32.IsRequestInFlight = true;
        local v33, v34, v35, v36 = pcall(function() --[[ Line: 296 ]]
            -- upvalues: v32 (copy)
            return v32.PlayerService:RequestRebirth();
        end);
        v32.IsRequestInFlight = false;
        if not v33 then
            warn("[RebirthController] RequestRebirth failed:", v34);
            return;
        elseif v34 then
            v32:_onRebirthRequestSucceeded(v35, v36);
            return;
        else
            v32:_onRebirthRequestFailed();
            return;
        end;
    end;
end;
v5._onRebirthPerformed = function(v37, _, _) --[[ Line: 314 ]] --[[ Name: _onRebirthPerformed ]]
    v37:_playSuccessEffects();
end;
v5._onRebirthRequestSucceeded = function(_, _, _) --[[ Line: 318 ]] --[[ Name: _onRebirthRequestSucceeded ]]

end;
v5._onRebirthRequestFailed = function(_) --[[ Line: 321 ]] --[[ Name: _onRebirthRequestFailed ]]

end;
return v5;