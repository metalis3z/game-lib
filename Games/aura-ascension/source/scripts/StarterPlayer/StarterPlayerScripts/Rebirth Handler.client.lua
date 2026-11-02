-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui", 1e999):WaitForChild("Extensions", 1e999):WaitForChild("RebirthVignete", 1e999);
local v4 = workspace:WaitForChild("RebirthPad", 1e999);
local v5 = v4:WaitForChild("TouchPart", 1e999);
local v6 = v5:WaitForChild("PointLight", 1e999);
local v7 = v4:WaitForChild("Hitbox", 1e999);
local _ = require(l_ReplicatedStorage_0.Frameworks["3D Billboard"]);
local v9 = v5:WaitForChild("Template", 1e999);
local v10 = v9:WaitForChild("BillboardGui", 1e999);
local _ = v9:WaitForChild("MainBillboard", 1e999);
v5.Anchored = true;
v5.CanCollide = false;
v5.CanTouch = true;
local l_Size_0 = v5.Size;
local l_CFrame_0 = v5.CFrame;
local v14 = l_CFrame_0 - Vector3.new(0, 0.30000001192092896, 0, 0);
local v15 = Vector3.new(l_Size_0.X * 1.1, l_Size_0.Y * 0.2, l_Size_0.Z * 1.1);
local v16 = Color3.new(1, 1, 1);
local v17 = Color3.fromRGB(0, 255, 0);
local l_Brightness_0 = v6.Brightness;
local v19 = TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local v20 = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
local v21 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v22 = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local v23 = l_TweenService_0:Create(v3, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    ImageTransparency = 0.4
});
local v24 = l_TweenService_0:Create(v3, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
    ImageTransparency = 1
});
local function _() --[[ Line: 52 ]] --[[ Name: safePlaySound ]]
    -- upvalues: v5 (copy)
    local l_Sound_0 = v5:FindFirstChildWhichIsA("Sound");
    if l_Sound_0 then
        l_Sound_0:Play();
    end;
end;
local function v28() --[[ Line: 57 ]] --[[ Name: playVFX ]]
    -- upvalues: v5 (copy), l_TweenService_0 (copy), v21 (copy), v16 (copy), v6 (copy), l_Brightness_0 (copy), v23 (copy), v10 (copy), v22 (copy), v17 (copy), v24 (copy)
    local l_Sound_1 = v5:FindFirstChildWhichIsA("Sound");
    if l_Sound_1 then
        l_Sound_1:Play();
    end;
    l_TweenService_0:Create(v5, v21, {
        Color = v16
    }):Play();
    l_TweenService_0:Create(v6, v21, {
        Color = v16, 
        Brightness = l_Brightness_0 * 1.2
    }):Play();
    v23:Play();
    v10.Enabled = false;
    l_TweenService_0:Create(v5, v22, {
        Color = v17
    }):Play();
    l_TweenService_0:Create(v6, v22, {
        Color = v16, 
        Brightness = l_Brightness_0
    }):Play();
    task.wait(0.25);
    v24:Play();
end;
local v29 = {};
local _ = function(_) --[[ Line: 79 ]] --[[ Name: tryRebirth ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    return l_ReplicatedStorage_0.Communication.RequestRebirth:InvokeServer();
end;
v7.Touched:Connect(function(v32) --[[ Line: 83 ]]
    -- upvalues: l_Players_0 (copy), v29 (copy), l_TweenService_0 (copy), v5 (copy), v19 (copy), v15 (copy), v14 (copy), v20 (copy), l_Size_0 (copy), l_CFrame_0 (copy), l_ReplicatedStorage_0 (copy), v28 (copy), v10 (copy)
    local l_Parent_0 = v32.Parent;
    if not l_Parent_0 then
        return;
    elseif not l_Parent_0:FindFirstChildOfClass("Humanoid") then
        return;
    else
        local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(l_Parent_0);
        if not l_l_Players_0_PlayerFromCharacter_0 then
            return;
        elseif l_l_Players_0_PlayerFromCharacter_0 ~= l_Players_0.LocalPlayer then
            return;
        else
            local l_UserId_0 = l_l_Players_0_PlayerFromCharacter_0.UserId;
            if v29[l_UserId_0] then
                return;
            else
                v29[l_UserId_0] = true;
                local v36 = l_TweenService_0:Create(v5, v19, {
                    Size = v15, 
                    CFrame = v14
                });
                local v37 = l_TweenService_0:Create(v5, v20, {
                    Size = l_Size_0, 
                    CFrame = l_CFrame_0
                });
                v36:Play();
                v36.Completed:Wait();
                local v38, v39 = l_ReplicatedStorage_0.Communication.RequestRebirth:InvokeServer();
                local l_v38_0 = v38;
                local _ = v39;
                v37:Play();
                if l_v38_0 then
                    task.spawn(v28);
                    v38 = workspace:FindFirstChild("Haptics");
                    v39 = v38 and v38:FindFirstChild("Rebirth");
                    if v39 and v39:IsA("Sound") then
                        v39:Play();
                    end;
                    local l_Character_0 = l_l_Players_0_PlayerFromCharacter_0.Character;
                    if l_Character_0 then
                        local l_Highlight_0 = l_Character_0:FindFirstChildOfClass("Highlight");
                        if l_Highlight_0 then
                            l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.25), {
                                FillTransparency = 0
                            }):Play();
                            task.delay(0.45, function() --[[ Line: 131 ]]
                                -- upvalues: l_TweenService_0 (ref), l_Highlight_0 (copy)
                                l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(1), {
                                    FillTransparency = 1
                                }):Play();
                            end);
                        end;
                    end;
                end;
                task.delay(0.5, function() --[[ Line: 139 ]]
                    -- upvalues: v10 (ref), v29 (ref), l_UserId_0 (copy)
                    v10.Enabled = true;
                    v29[l_UserId_0] = nil;
                end);
                return;
            end;
        end;
    end;
end);