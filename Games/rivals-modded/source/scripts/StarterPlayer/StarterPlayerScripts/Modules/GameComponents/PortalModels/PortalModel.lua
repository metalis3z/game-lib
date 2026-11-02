-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Utility = require(ReplicatedStorage.Modules.Utility);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local Portal = require(script:WaitForChild("Portal"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 12
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Model = p2;
    v3.Portals = {};
    v3._item_id = v3.Model:GetAttribute("ItemID");
    v3._user_id = v3.Model:GetAttribute("UserID");
    v3._teleport_cooldowns = {};
    v3:_Init();

    return v3;
end;

function u1.GetPortal(p4, p5) -- Line: 31
    for i, v in pairs(p4.Portals) do
        if v.Model == p5 then
            return v, i;
        end;
    end;
end;

function u1.GetOtherPortal(p6, p7) -- Line: 39
    return p6.Portals[3 - p7.PortalNum];
end;

function u1.ArePortalsGrown(p8) -- Line: 43
    local v9 = p8.Portals[1] and (p8.Portals[1]:IsGrown() and p8.Portals[2]) and p8.Portals[2]:IsGrown();

    return v9;
end;

function u1.CanWarp(p10) -- Line: 48
    -- upvalues: Players (copy)
    return p10.Portals[1] and p10.Portals[2] and (not p10._user_id or p10._user_id == Players.LocalPlayer.UserId);
end;

function u1.Update(p11, p12) -- Line: 52
    for _, v in pairs(p11.Portals) do
        v:Update(p12);
    end;
end;

function u1.Destroy(u13) -- Line: 58
    for _, v in pairs(u13.Portals) do
        v:Destroy();
    end;

    pcall(function() -- Line: 63
        -- upvalues: u13 (copy)
        u13.Model:Destroy();
    end);
end;

function u1._Touched(p14, p15, p16) -- Line: 72
    -- upvalues: Players (copy), FighterController (copy), GameplayUtility (copy), Utility (copy), ReplicatedStorage (copy)
    if not (p14:CanWarp() and p14:ArePortalsGrown()) then
        return;
    end;

    local OtherPortal = p14:GetOtherPortal(p15);

    if not OtherPortal then
        return;
    end;

    local v17 = p16.AssemblyRootPart or p16;

    if p16.Parent ~= Players.LocalPlayer.Character or (tick() < (p14._teleport_cooldowns[p15.PortalNum][v17] or 0) or not (FighterController.LocalFighter and FighterController.LocalFighter:IsAlive())) then
        return;
    end;

    local RaycastWhitelist = GameplayUtility:GetRaycastWhitelist(Players.LocalPlayer:GetAttribute("EnvironmentID"));
    local v18 = Utility:Raycast(p15.Hitbox.Position, v17.Position, (p15.Hitbox.Position - v17.Position).Magnitude, RaycastWhitelist, Enum.RaycastFilterType.Include);

    if v18.Instance and not v18.Instance:IsDescendantOf(v17.Parent) then
        return;
    end;

    p14._teleport_cooldowns[p15.PortalNum][v17] = tick() + 0.25;
    p14._teleport_cooldowns[OtherPortal.PortalNum][v17] = tick() + 1;
    FighterController.LocalFighter.Entity:WarpTo(OtherPortal:GetTeleportCFrame());
    Utility:CreateSound("rbxassetid://86785771664692", 0.5, 1 + 0.1 * math.random(), p15.Hitbox.Position, true, 10);
    Utility:CreateSound("rbxassetid://81610952487049", 1, 1 + 0.1 * math.random(), OtherPortal.Hitbox.Position, true, 10);
    ReplicatedStorage.Remotes.Replication.Fighter.PlayMechanicsSound:FireServer("Warp");
    ReplicatedStorage.Remotes.Replication.Fighter.JustWarped:FireServer(p14._item_id, p15.PortalNum);
end;

function u1._UpdateVisuals(p19) -- Line: 106
    local v20 = p19:CanWarp();

    for _, v in pairs(p19.Portals) do
        v:UpdateVisuals(v20);
    end;
end;

function u1._ChildRemoved(p21, p22) -- Line: 114
    local Portal2, v23 = p21:GetPortal(p22);

    if not Portal2 then
        return;
    end;

    Portal2:Destroy();
    p21.Portals[v23] = nil;
    p21:_UpdateVisuals();
end;

function u1._ChildAdded(u24, p25) -- Line: 126
    -- upvalues: Portal (copy), Players (copy), Utility (copy)
    if not p25:IsA("Model") then
        return;
    end;

    u24:_ChildRemoved(p25);
    local u26 = Portal.new(p25);
    u24.Portals[u26.PortalNum] = u26;
    u24:_UpdateVisuals();
    u24._teleport_cooldowns[u26.PortalNum] = {};
    u26.Hitbox.Touched:Connect(function(p27) -- Line: 139
        -- upvalues: u24 (copy), u26 (copy)
        u24:_Touched(u26, p27);
    end);

    local function check_now() -- Line: 143
        -- upvalues: Players (ref), Utility (ref), u26 (copy), u24 (copy)
        for _, v in pairs(Players.LocalPlayer.Character and Players.LocalPlayer.Character:GetChildren() or {}) do
            if v:IsA("BasePart") and Utility:IsWithinPart(u26.Hitbox, v.Position, Vector3.new(1, 1, 1) * math.max(v.Size.X, v.Size.Y, v.Size.Z) * 1.4142135623730951) then
                u24:_Touched(u26, v);

                return;
            end;
        end;
    end;

    u26.FinishedGrowing:Connect(check_now);
    check_now();
end;

function u1._Init(u28) -- Line: 160
    u28.Model.ChildAdded:Connect(function(p29) -- Line: 161
        -- upvalues: u28 (copy)
        u28:_ChildAdded(p29);
    end);
    u28.Model.ChildRemoved:Connect(function(p30) -- Line: 165
        -- upvalues: u28 (copy)
        u28:_ChildRemoved(p30);
    end);
end;

return u1;