-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Oracle

local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_WeaponService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("WeaponService"));
local l_Parent_0 = script.Parent;
local l_Handle_0 = l_Parent_0:WaitForChild("Handle");
local l_Events_0 = l_Parent_0:WaitForChild("Events");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local Config = require(game.ReplicatedStorage.Constants)
local Animations = Config.Animations.Gameplay.Knife
local Animation = Instance.new("Animation")
Animation.AnimationId = Animations.Dual.DualEquip
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v9 = Random.new();
local l_GameplayContext_0 = l_PlayerGui_0:WaitForChild("InputContext"):WaitForChild("GameplayContext");
local v11 = nil;
local v12 = nil;
local v13 = -0.85;
local v14
task.wait(1)
if l_Parent_0:GetAttribute("EquippedPerk") == "Sleight" then
	v14 = 2
else
	v14 = 2.5
end
local v15 = -v14;
local l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("ThrowSpeed");
local v17 = -1000;
v14 = v14 * l_l_Parent_0_Attribute_0;
local v18 = false;
local v19 = false;
local v20 = false;
local v21 = false;
local v22 = false;
local v23 = {
    Slash = nil, 
    Downstab = nil, 
    ThrowCharge = nil, 
    ThrowKnife = nil, 
    ThrowHold = nil
};
local v24 = {
    Throw = l_Parent_0:WaitForChild("Sounds"):WaitForChild("Throw")
};
local function v28() --[[ Line: 51 ]] --[[ Name: LoadAnimations ]]
    -- upvalues: l_Parent_0 (copy), v23 (copy), v12 (ref), l_ContentProvider_0 (copy)
    if l_Parent_0:FindFirstChild("DualEffect") then
        v23.Slash = v12:LoadAnimation(script:WaitForChild("Dual"):WaitForChild("DualSlash"));
        v23.Downstab = v12:LoadAnimation(script:WaitForChild("Dual"):WaitForChild("DualStab"));
    else
        v23.Slash = v12:LoadAnimation(script:WaitForChild("Slash"));
        v23.Downstab = v12:LoadAnimation(script:WaitForChild("Downstab"));
    end;
    v23.ThrowCharge = v12:LoadAnimation(script:WaitForChild("ThrowCharge"));
    v23.ThrowHold = v12:LoadAnimation(script:WaitForChild("ThrowHold"));
    v23.ThrowKnife = v12:LoadAnimation(script:WaitForChild("ThrowKnife"));
    local v25 = {};
    for _, v27 in v23 do
        if v27.Animation then
            table.insert(v25, v27.Animation.AnimationId);
        end;
    end;
    l_ContentProvider_0:PreloadAsync(v25);
end;
local _ = function() --[[ Line: 74 ]] --[[ Name: StopAnimations ]]
    -- upvalues: v23 (copy)
    for _, v30 in v23 do
        v30:Stop();
    end;
end;
local function _() --[[ Line: 81 ]] --[[ Name: isAutoStabEnabled ]]
    -- upvalues: l_UserInputService_0 (copy)
    local v32 = false;
    if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch then
        v32 = true;
    end;
    return v32;
end;
local function _() --[[ Line: 85 ]] --[[ Name: isMouseLockEnabled ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_MouseLock_0 = l_LocalPlayer_0.PlayerScripts:FindFirstChild("MouseLock");
    if not l_MouseLock_0 then
        return false;
    else
        return l_MouseLock_0:GetAttribute("Enabled") == true;
    end;
end;
local function _() --[[ Line: 94 ]] --[[ Name: cancelThrow ]]
    -- upvalues: v23 (copy), v20 (ref), v19 (ref)
    v23.ThrowHold:Stop();
    v23.ThrowCharge:Stop();
    v20 = false;
    v19 = false;
end;
local function v41() --[[ Line: 102 ]] --[[ Name: stabKnife ]]
    -- upvalues: v18 (ref), v20 (ref), v22 (ref), v13 (ref), v15 (ref), v14 (ref), v23 (copy), v19 (ref), v21 (ref), v9 (copy), l_Events_0 (copy), l_RunService_0 (copy)
    if not v18 then
        return;
    elseif v20 then
        return;
    elseif v22 then
        return;
    elseif os.clock() - v13 < 0.85 then
        return;
    elseif os.clock() - v15 < v14 then
        return;
    else
        v23.ThrowHold:Stop();
        v23.ThrowCharge:Stop();
        v20 = false;
        v19 = false;
        for _, v38 in v23 do
            v38:Stop();
        end;
        v13 = os.clock();
        v21 = true;
        local v39 = {
            v23.Slash, 
            v23.Downstab
        };
        v39[v9:NextInteger(1, #v39)]:Play(0.1, 2, 1);
        l_Events_0.KnifeStabbed:FireServer();
        local v40 = 0;
        while v21 do
            v40 = v40 + l_RunService_0.PreSimulation:Wait();
            if v40 >= 1 then
                break;
            end;
        end;
        v21 = false;
        return;
    end;
end;
local function v43(v42) --[[ Line: 144 ]] --[[ Name: throwKnife ]]
    -- upvalues: v20 (ref), l_Events_0 (copy), l_Handle_0 (copy), v23 (copy)
    v20 = false;
    l_Events_0.KnifeThrown:FireServer(l_Handle_0.CFrame, v42);
    v23.ThrowHold:Stop(0);
    v23.ThrowCharge:Stop(0);
    v23.ThrowKnife:Play(0.1, 6, 1);
end;
local function v50() --[[ Line: 155 ]] --[[ Name: startThrowKnife ]]
    -- upvalues: v18 (ref), v22 (ref), v13 (ref), v15 (ref), v14 (ref), v11 (ref), v21 (ref), v19 (ref), v23 (copy), l_l_Parent_0_Attribute_0 (copy), l_RunService_0 (copy), l_UserInputService_0 (copy), l_LocalPlayer_0 (copy), v20 (ref), v43 (copy), l_WeaponService_0 (copy)
    if not v18 then
        return;
    elseif v22 then
        return;
    elseif os.clock() - v13 < 0.4 then
        return;
    elseif os.clock() - v15 < v14 then
        return;
    elseif v11.Health <= 0 then
        return;
    else
        v21 = false;
        v19 = true;
        v15 = os.clock();
        for _, v45 in v23 do
            v45:Stop();
        end;
        v23.ThrowCharge:Play(0.1, 2.5, 1 / l_l_Parent_0_Attribute_0);
        local v46 = false;
        local v47 = 0;
        while v19 and not v46 do
            v47 = v47 + l_RunService_0.PreSimulation:Wait();
            if l_l_Parent_0_Attribute_0 <= v47 then
                v46 = true;
                break;
            end;
        end;
        v19 = false;
        local v48 = l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch;
        if v46 then
            if v48 then
                local l_MouseLock_1 = l_LocalPlayer_0.PlayerScripts:FindFirstChild("MouseLock");
                if not (not not l_MouseLock_1 and l_MouseLock_1:GetAttribute("Enabled") == true) then
                    v20 = true;
                    v23.ThrowCharge:Stop();
                    v23.ThrowHold:Play();
                    return;
                end;
            end;
            v43(l_WeaponService_0:GetMouseTargetCFrame());
        end;
        return;
    end;
end;
local function v59(_) --[[ Line: 204 ]] --[[ Name: onUpdate ]]
    -- upvalues: l_UserInputService_0 (copy), l_LocalPlayer_0 (copy), v41 (copy)
    local v52 = false;
    if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch then
        v52 = true;
    end;
    if not v52 then
        return;
    else
        for _, v54 in game.Players:GetPlayers() do
            if v54 ~= l_LocalPlayer_0 then
                local l_Character_0 = v54.Character;
                if l_Character_0 and l_Character_0.Parent then
                    local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
                    if l_Humanoid_0 and l_Humanoid_0.Health > 0 then
                        local l_RootPart_0 = l_Humanoid_0.RootPart;
                        if l_RootPart_0 and l_RootPart_0.Parent then
                            local v58 = l_LocalPlayer_0:DistanceFromCharacter(l_RootPart_0.Position);
                            if v58 <= 7 and v58 > 0 then
                                v41();
                            end;
                        end;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
(function() --[[ Line: 235 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_LocalPlayer_0 (copy), v11 (ref), v12 (ref), v28 (copy), l_Parent_0 (copy), l_Handle_0 (copy), v13 (ref), v21 (ref), l_Events_0 (copy), v18 (ref), v19 (ref), v15 (ref), v14 (ref), v23 (copy), v20 (ref), v41 (copy), l_WeaponService_0 (copy), l_UserInputService_0 (copy), v43 (copy), l_GameplayContext_0 (copy), v50 (copy), v17 (ref), v22 (ref), l_RunService_0 (copy), v59 (copy), v24 (copy)
    task.wait(0.5);
    v11 = l_LocalPlayer_0.Character:WaitForChild("Humanoid");
    v12 = v11:WaitForChild("Animator");
    v28();
	local l_l_Parent_0_Attribute_1 = l_Parent_0:GetAttribute("EquippedPerk");
	while not l_l_Parent_0_Attribute_1 do
		l_l_Parent_0_Attribute_1 = l_Parent_0:GetAttribute("EquippedPerk");
		task.wait();
	end;
    l_Handle_0.Touched:Connect(function(v61) --[[ Line: 249 ]]
        -- upvalues: v13 (ref), v21 (ref), l_Events_0 (ref)
        if os.clock() - v13 > 0.85 then
            return;
        elseif not v21 then
            return;
        else
            l_Events_0.HandleTouched:FireServer(v61);
            return;
        end;
	end);

	local PlayedAnimation = l_LocalPlayer_0.Character.Humanoid:LoadAnimation(Animation)
    l_Parent_0.Equipped:Connect(function() --[[ Line: 259 ]]
        -- upvalues: v18 (ref), l_l_Parent_0_Attribute_1 (ref), v11 (ref)
		v18 = true;
		if l_Parent_0:FindFirstChild("DualEffect") then
			PlayedAnimation:Play() 
		end;
		if l_l_Parent_0_Attribute_1 == "Haste" then
            v11.WalkSpeed = 18;
            return;
        else
            v11.WalkSpeed = 17;
            return;
		end;
    end);
    l_Parent_0.Unequipped:Connect(function() --[[ Line: 268 ]]
        -- upvalues: v18 (ref), v21 (ref), v19 (ref), v15 (ref), v14 (ref), v23 (ref), v20 (ref), v11 (ref)
        v18 = false;
        v21 = false;
        if v19 then
            v15 = -v14;
        end;
		if l_Parent_0:FindFirstChild("DualEffect") then
			PlayedAnimation:Stop() 
		end
		v23.ThrowHold:Stop();
        v23.ThrowCharge:Stop();
        v20 = false;
        v19 = false;
        for _, v63 in v23 do
            v63:Stop();
        end;
		v11.WalkSpeed = 16;
    end);
    l_Parent_0.Activated:Connect(function() --[[ Line: 279 ]]
        -- upvalues: v41 (ref)
        v41();
    end);
    l_WeaponService_0.KnifeThrown.Event:Connect(function() --[[ Line: 283 ]]

    end);
    l_UserInputService_0.TouchTapInWorld:Connect(function(v64, v65) --[[ Line: 287 ]]
        -- upvalues: v20 (ref), l_WeaponService_0 (ref), v43 (ref)
        if not v64 or v65 then
            return;
        elseif not v20 then
            return;
        else
            local l_l_WeaponService_0_TargetPosition_0 = l_WeaponService_0:GetTargetPosition(v64.X, v64.Y);
            v43(l_l_WeaponService_0_TargetPosition_0);
            return;
        end;
    end);
    l_GameplayContext_0:WaitForChild("Throw").Pressed:Connect(function() --[[ Line: 298 ]]
        -- upvalues: v50 (ref)
        v50();
    end);
    l_UserInputService_0.InputBegan:Connect(function(v67, _) --[[ Line: 302 ]]
        -- upvalues: v18 (ref), v17 (ref)
        if not v18 then
            return;
        else
            if v67.UserInputType == Enum.UserInputType.MouseButton2 then
                v17 = os.clock();
            end;
            return;
        end;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v69) --[[ Line: 311 ]]
        -- upvalues: v18 (ref), v17 (ref), v50 (ref)
        if not v18 then
            return;
        else
            if v69.UserInputType == Enum.UserInputType.MouseButton2 and os.clock() - v17 <= 0.3 then
                v50();
            end;
            return;
        end;
    end);
    v22 = l_Parent_0:GetAttribute("Disabled") == true;
    l_Parent_0:GetAttributeChangedSignal("Disabled"):Connect(function() --[[ Line: 323 ]]
        -- upvalues: v22 (ref), l_Parent_0 (ref)
        v22 = l_Parent_0:GetAttribute("Disabled") == true;
    end);
    l_RunService_0.PreSimulation:Connect(v59);
    for _, v71 in v24 do
        v71.Parent = l_Handle_0;
    end;
end)();