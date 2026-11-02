-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local l_CollectionService_0 = game:GetService("CollectionService");
local l_UserInputService_0 = game:GetService("UserInputService");
v0.KnifeThrown = Instance.new("BindableEvent");
v0.GunFired = script:WaitForChild("GunFired");
v0.ThrowKnife = function(_) --[[ Line: 9 ]] --[[ Name: ThrowKnife ]]
    -- upvalues: v0 (copy)
    v0.KnifeThrown:Fire();
end;
local function v7() --[[ Line: 14 ]] --[[ Name: GetWeaponIgnoreList ]]
    -- upvalues: l_CollectionService_0 (copy)
    local v4 = {
        game.Players.LocalPlayer.Character
    };
    for _, v6 in l_CollectionService_0:GetTagged("WeaponPassthrough") do
        table.insert(v4, v6);
    end;
    return v4;
end;
local function v13(v8) --[[ Line: 24 ]] --[[ Name: WeaponRaycast ]]
    -- upvalues: v7 (copy)
    local v9 = RaycastParams.new();
    local v10 = v7();
    v9.FilterDescendantsInstances = v10;
    local v11 = nil;
    while true do
        v11 = workspace:Raycast(v8.Origin, v8.Direction, v9);
        if v11 then
            local l_Instance_0 = v11.Instance;
            if l_Instance_0 and l_Instance_0.Transparency == 1 then
                table.insert(v10, l_Instance_0);
                v9.FilterDescendantsInstances = v10;
            else
                break;
            end;
        else
            break;
        end;
    end;
    return v11;
end;
v0.IsMouseLockEnabled = function(_) --[[ Line: 51 ]] --[[ Name: IsMouseLockEnabled ]]
    local l_MouseLock_0 = game.Players.LocalPlayer.PlayerScripts:FindFirstChild("MouseLock");
    if not l_MouseLock_0 then
        return false;
    else
        return l_MouseLock_0:GetAttribute("Enabled") == true;
    end;
end;
v0.GetTargetPosition = function(_, v17, v18) --[[ Line: 61 ]] --[[ Name: GetTargetPosition ]]
    -- upvalues: v13 (copy)
    local _ = game.Players.LocalPlayer;
    local v20 = workspace.CurrentCamera:ViewportPointToRay(v17, v18);
    local v21 = Ray.new(v20.Origin, v20.Direction * 300);
    local _ = nil;
    local v23 = v13(v21);
    if v23 and v23.Position then
        return (CFrame.new(v23.Position));
    else
        return (CFrame.new(v21.Origin + v21.Direction));
    end;
end;
v0.GetMouseTargetCFrame = function(_) --[[ Line: 79 ]] --[[ Name: GetMouseTargetCFrame ]]
    -- upvalues: l_UserInputService_0 (copy), v13 (copy)
    local l_LocalPlayer_1 = game.Players.LocalPlayer;
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    local l_X_0 = l_l_UserInputService_0_MouseLocation_0.X;
    local l_Y_0 = l_l_UserInputService_0_MouseLocation_0.Y;
    local l_MouseLock_1 = l_LocalPlayer_1.PlayerScripts:FindFirstChild("MouseLock");
    if l_MouseLock_1 and l_MouseLock_1:GetAttribute("Enabled") == true then
        local l_ViewportSize_0 = workspace.CurrentCamera.ViewportSize;
        l_X_0 = l_ViewportSize_0.X / 2;
        l_Y_0 = l_ViewportSize_0.Y / 2;
    end;
    local v31 = workspace.CurrentCamera:ViewportPointToRay(l_X_0, l_Y_0);
    local v32 = Ray.new(v31.Origin, v31.Direction * 300);
    local _ = nil;
    local v34 = v13(v32);
    if v34 and v34.Position then
        return (CFrame.new(v34.Position));
    else
        return (CFrame.new(v32.Origin + v32.Direction));
    end;
end;
return v0;