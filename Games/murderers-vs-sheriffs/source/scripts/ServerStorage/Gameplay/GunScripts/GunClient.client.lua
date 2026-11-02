-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Oracle

local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_WeaponService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("WeaponService"));
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_Parent_0 = script.Parent;
local _ = l_Parent_0:WaitForChild("Handle");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local _ = l_LocalPlayer_0.PlayerGui;
local l_Animations_0 = l_Parent_0:WaitForChild("Animations");
local v10 = nil;
local v11 = nil;
local v12 = nil;
local v13 = false;
local l_CantShoot_0 = script:WaitForChild("CantShoot");
local v15 = {
    Shoot = nil, 
    Reload = nil, 
    CustomHold = nil
};
local function v17() --[[ Line: 30 ]] --[[ Name: LoadAnimations ]]
    -- upvalues: v10 (ref), v15 (copy), l_Animations_0 (copy), l_Parent_0 (copy)
    local l_Animator_0 = v10:WaitForChild("Animator");
    v15.Shoot = l_Animator_0:LoadAnimation(l_Animations_0:WaitForChild("Shoot"));
    v15.Reload = l_Animator_0:LoadAnimation(l_Animations_0:WaitForChild("Reload"));
    if l_Parent_0:FindFirstChild("CustomHold") then
        v15.CustomHold = l_Animator_0:LoadAnimation(l_Parent_0:FindFirstChild("CustomHold"));
    end;
end;
local function _() --[[ Line: 41 ]] --[[ Name: GetShotOriginCFrame ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not l_LocalPlayer_0.Character then
        return;
    else
        local l_GunRaycastAttachment_0 = l_LocalPlayer_0.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("GunRaycastAttachment");
        if not l_GunRaycastAttachment_0 then
            return;
        else
            return l_GunRaycastAttachment_0.WorldCFrame;
        end;
    end;
end;
local function _(v20) --[[ Line: 64 ]] --[[ Name: shootGun ]]
    -- upvalues: v13 (ref), l_LocalPlayer_0 (copy), l_Parent_0 (copy)
    if not v13 then
        return;
    else
        local v21;
        if not l_LocalPlayer_0.Character then
            v21 = nil;
        else
            local l_GunRaycastAttachment_1 = l_LocalPlayer_0.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("GunRaycastAttachment");
            v21 = if not l_GunRaycastAttachment_1 then nil else l_GunRaycastAttachment_1.WorldCFrame;
        end;
        l_Parent_0.Shoot:FireServer(v21, v20);
        return;
    end;
end;
local function v29(_) --[[ Line: 73 ]] --[[ Name: onUpdate ]]
	if not l_LocalPlayer_0.Character then
		l_CantShoot_0.Enabled = false
		return;
	end;
	if not l_LocalPlayer_0.Character:FindFirstChild("Head") then
		l_CantShoot_0.Enabled = false
		return;
	end;
	local v25 = RaycastParams.new()
	v25.FilterDescendantsInstances = {
		l_LocalPlayer_0.Character
	}
	local l_Position_0 = l_LocalPlayer_0.Character.Head.Position
	local v27 = v12.WorldPosition - l_Position_0
	local v28 = workspace:Raycast(l_Position_0, v27, v25)

	if v28 and v28.Instance then
		l_CantShoot_0.Enabled = true
		return;
	else
		l_CantShoot_0.Enabled = false
		return;
	end;
end;
(function() --[[ Line: 92 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_LocalPlayer_0 (copy), v10 (ref), v17 (copy), l_Parent_0 (copy), v13 (ref), l_l_LocalPlayer_0_Mouse_0 (copy), v15 (copy), l_UserInputService_0 (copy), l_WeaponService_0 (copy), l_ContentProvider_0 (copy), l_Animations_0 (copy), v12 (ref), v11 (ref), l_CantShoot_0 (copy), l_RunService_0 (copy), v29 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 then
        return;
    else
        v10 = l_Character_0:WaitForChild("Humanoid");
        v17();
        l_Parent_0.Equipped:Connect(function() --[[ Line: 100 ]]
            -- upvalues: v13 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v15 (ref)
            v13 = true;
            l_l_LocalPlayer_0_Mouse_0.Icon = "rbxassetid://79658449";
            if v15.CustomHold then
                v15.CustomHold:Play();
            end;
        end);
        l_Parent_0.Unequipped:Connect(function() --[[ Line: 107 ]]
            -- upvalues: v13 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v15 (ref)
            v13 = false;
            l_l_LocalPlayer_0_Mouse_0.Icon = "";
            if v15.CustomHold then
                v15.CustomHold:Stop();
            end;
        end);
        l_Parent_0.Activated:Connect(function() --[[ Line: 115 ]]
            -- upvalues: l_UserInputService_0 (ref), l_WeaponService_0 (ref), v13 (ref), l_LocalPlayer_0 (ref), l_Parent_0 (ref)
            if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch then
                return;
            else
                local l_l_WeaponService_0_MouseTargetCFrame_0 = l_WeaponService_0:GetMouseTargetCFrame();
                if not v13 then
                    return;
                else
                    local v32;
                    if not l_LocalPlayer_0.Character then
                        v32 = nil;
                    else
                        local l_GunRaycastAttachment_2 = l_LocalPlayer_0.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("GunRaycastAttachment");
                        v32 = if not l_GunRaycastAttachment_2 then nil else l_GunRaycastAttachment_2.WorldCFrame;
                    end;
                    l_Parent_0.Shoot:FireServer(v32, l_l_WeaponService_0_MouseTargetCFrame_0);
                    return;
                end;
            end;
        end);
        l_UserInputService_0.TouchTapInWorld:Connect(function(v34, v35) --[[ Line: 122 ]]
            -- upvalues: l_WeaponService_0 (ref), v13 (ref), l_LocalPlayer_0 (ref), l_Parent_0 (ref)
            if v35 then
                return;
            elseif l_WeaponService_0:IsMouseLockEnabled() then
                local l_l_WeaponService_0_MouseTargetCFrame_1 = l_WeaponService_0:GetMouseTargetCFrame();
                if not v13 then
                    return;
                else
                    local v37;
                    if not l_LocalPlayer_0.Character then
                        v37 = nil;
                    else
                        local l_GunRaycastAttachment_3 = l_LocalPlayer_0.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("GunRaycastAttachment");
                        v37 = if not l_GunRaycastAttachment_3 then nil else l_GunRaycastAttachment_3.WorldCFrame;
                    end;
                    l_Parent_0.Shoot:FireServer(v37, l_l_WeaponService_0_MouseTargetCFrame_1);
                    return;
                end;
            else
                local l_l_WeaponService_0_TargetPosition_0 = l_WeaponService_0:GetTargetPosition(v34.X, v34.Y);
                if not v13 then
                    return;
                else
                    local v40;
                    if not l_LocalPlayer_0.Character then
                        v40 = nil;
                    else
                        local l_GunRaycastAttachment_4 = l_LocalPlayer_0.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("GunRaycastAttachment");
                        v40 = if not l_GunRaycastAttachment_4 then nil else l_GunRaycastAttachment_4.WorldCFrame;
                    end;
                    l_Parent_0.Shoot:FireServer(v40, l_l_WeaponService_0_TargetPosition_0);
                    return;
                end;
            end;
        end);
        l_ContentProvider_0:PreloadAsync({
            l_Animations_0:WaitForChild("Shoot").AnimationId, 
            l_Animations_0:WaitForChild("Reload").AnimationId
        });
        v12 = l_Character_0:WaitForChild("HumanoidRootPart"):WaitForChild("GunRaycastAttachment");
        v11 = l_Character_0:WaitForChild("HumanoidRootPart"):WaitForChild("GunShoulderAttachment");
        l_CantShoot_0.Parent = l_Parent_0;
        l_RunService_0.PreSimulation:Connect(v29);
        v13 = game.Players:GetPlayerFromCharacter(l_Parent_0.Parent) ~= nil;
        return;
    end;
end)();