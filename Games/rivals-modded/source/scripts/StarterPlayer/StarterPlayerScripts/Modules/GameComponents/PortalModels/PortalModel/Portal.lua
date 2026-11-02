-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PortalKeybindGui = Players.LocalPlayer.PlayerScripts.UserInterface.PortalKeybindGui;
local Portals = Players.LocalPlayer.PlayerScripts.Assets.Misc.Portals;
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy), Signal (copy), PortalKeybindGui (copy), Spring (copy)
    local v3 = setmetatable({}, u1);
    v3.FinishedGrowing = Signal.new();
    v3.Model = p2;
    v3.Hitbox = v3.Model:WaitForChild("Hitbox");
    v3.PortalNum = tonumber(v3.Model.Name);
    v3.Visual = v3:_GetPortalTemplate():Clone();
    v3.BigVisual = v3.Visual:WaitForChild("Big");
    v3.SmallVisual = v3.Visual:WaitForChild("Small");
    v3.Gui = PortalKeybindGui:Clone();
    v3._viewmodel_name = v3.Model:GetAttribute("ViewModelName");
    v3._owner_user_id = v3.Model:GetAttribute("OwnerUserID");
    v3._owner_team_id = v3.Model:GetAttribute("OwnerTeamID");
    v3._original_scale = v3.Visual:GetScale();
    v3._grow_start = nil;
    v3._spawn_delay = nil;
    v3._finished_growing = nil;
    v3._is_enabled = false;
    v3._established = false;
    v3._pivot_offset_spring = Spring.new(Vector3.new(0, 0, 0), 0.5, 25);
    v3._opened_hotel_door = false;
    v3:_Init();

    return v3;
end;

function u1.IsGrown(p4) -- Line: 53
    return p4._finished_growing;
end;

function u1.GetTeleportCFrame(p5) -- Line: 57
    -- upvalues: GameplayUtility (copy), Players (copy), Utility (copy)
    local CFrame2 = p5.Hitbox.CFrame;
    local v6 = CFrame2 * CFrame.new(0, 0, -4);
    local RaycastWhitelist = GameplayUtility:GetRaycastWhitelist(Players.LocalPlayer:GetAttribute("EnvironmentID"));
    local v7 = Utility:Raycast(CFrame2.Position, v6.Position, 4, RaycastWhitelist, Enum.RaycastFilterType.Include);

    return CFrame.new(v7.Position) * v6.Rotation;
end;

function u1.UpdateVisuals(u8, u9, u10) -- Line: 66
    -- upvalues: Utility (copy)
    task.defer(function() -- Line: 67
        -- upvalues: u9 (copy), u8 (copy), u10 (copy), Utility (ref)
        local v11 = u9 and u8._finished_growing;
        local v12;

        if v11 then
            v12 = u8.Visual;
        else
            v12 = nil;
        end;

        u8:_SafeParent(u8.BigVisual, v12);
        local v13;

        if v11 then
            v13 = nil;
        else
            v13 = u8.Visual;
        end;

        u8:_SafeParent(u8.SmallVisual, v13);

        if v11 and (not u8._opened_hotel_door and u8._viewmodel_name == "Hotel Bell") then
            u8._opened_hotel_door = true;
            task.defer(function() -- Line: 76
                -- upvalues: u8 (ref)
                u8.BigVisual.Screen.SurfaceGui.MainFrame:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Quint", 0.5, true);
            end);
        end;

        if u10 or v11 and not u8._is_enabled and not u8._established then
            u8._established = true;

            if u8._viewmodel_name == "Hotel Bell" then
                task.delay(0.1 + 0.1 * math.random(), Utility.CreateSound, Utility, "rbxassetid://109072275653492", 1, 1.25 + 0.25 * math.random(), u8.Hitbox, true, 10);
                Utility:CreateSound("rbxassetid://119325209237441", 0.5, 1 + 0.1 * math.random(), u8.Hitbox, true, 10);
            else
                Utility:CreateSound("rbxassetid://119325209237441", 0.75, 1 + 0.1 * math.random(), u8.Hitbox, true, 10);
            end;
        end;

        u8._is_enabled = u9;

        if not u8._is_enabled then
            u8:_ScaleTo(1);
        end;
    end);
end;

function u1.Update(p14, p15) -- Line: 102
    p14:_Pivot();

    if p14._viewmodel_name == "Hotel Bell" then
        local Spin = p14.BigVisual.Part.SurfaceGui1.CanvasGroup.Spin;
        Spin.Rotation = Spin.Rotation + p15 * -90;
        local Spin2 = p14.BigVisual.Part.SurfaceGui2.CanvasGroup.Spin;
        Spin2.Rotation = Spin2.Rotation + p15 * -90;
    end;

    if not p14._is_enabled or p14._finished_growing then
        return;
    end;

    local v16;

    if p14._spawn_delay <= 0 then
        v16 = 1;
    else
        local v17 = (tick() - p14._grow_start) / p14._spawn_delay;
        v16 = math.clamp(v17, 0, 1);
    end;

    p14:_ScaleTo((v16 * 0.75 + 0.25) * (v16 < 1 and 3 or 1));

    if v16 < 1 then
        return;
    end;

    p14._finished_growing = true;
    p14.FinishedGrowing:Fire();
    local v18 = p14._spawn_delay <= 0.01;

    if not v18 then
        p14._pivot_offset_spring.Value = Vector3.new(0, 0, -3);
    end;

    p14:UpdateVisuals(p14._is_enabled, not v18);
end;

function u1.Destroy(u19) -- Line: 135
    pcall(function() -- Line: 136
        -- upvalues: u19 (copy)
        u19.Model:Destroy();
    end);
    pcall(function() -- Line: 140
        -- upvalues: u19 (copy)
        u19.Visual:Destroy();
    end);
    u19.FinishedGrowing:Destroy();
end;

function u1._GetPortalTemplate(p20) -- Line: 151
    -- upvalues: Portals (copy)
    return (Portals:FindFirstChild((p20.Model:GetAttribute("ViewModelName"))) or Portals.Default)[p20.PortalNum];
end;

function u1._Pivot(p21) -- Line: 158
    p21.Visual:PivotTo(p21.Model:GetPivot() * CFrame.new(p21._pivot_offset_spring.Value));
end;

function u1._SafeParent(p22, u23, u24) -- Line: 162
    pcall(function() -- Line: 163
        -- upvalues: u23 (copy), u24 (copy)
        u23.Parent = u24;
    end);
end;

function u1._ScaleTo(p25, p26) -- Line: 168
    local Parent = p25.BigVisual.Parent;
    local Parent2 = p25.SmallVisual.Parent;
    p25:_SafeParent(p25.BigVisual, p25.Visual);
    p25:_SafeParent(p25.SmallVisual, p25.Visual);
    p25.Visual:ScaleTo(p25._original_scale * p26);
    p25:_SafeParent(p25.BigVisual, Parent);
    p25:_SafeParent(p25.SmallVisual, Parent2);
end;

function u1._InitializeGrowing(p27) -- Line: 181
    p27._grow_start = tick();
    p27._spawn_delay = p27.Model:GetAttribute("SpawnDelay") or 0;
    p27._finished_growing = false;
    p27:UpdateVisuals(p27._is_enabled);
end;

function u1._Setup(p28) -- Line: 188
    -- upvalues: DuelLibrary (copy), Players (copy), Utility (copy)
    local TeamColor = DuelLibrary:GetTeamColor(p28._owner_team_id, nil, "PadColor");

    for _, descendant in pairs(p28.Visual:GetDescendants()) do
        if descendant:HasTag("ColorThis") then
            local v29 = descendant:GetAttribute("ColorThisMultiplier") or 1;
            local Color3_new_ret = Color3.new(TeamColor.R * v29, TeamColor.G * v29, TeamColor.B * v29);

            if descendant:IsA("BasePart") then
                descendant.Color = Color3_new_ret;
            elseif descendant:IsA("Frame") then
                descendant.BackgroundColor3 = Color3_new_ret;
            elseif descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3_new_ret;
            end;
        end;

        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;

    p28.Gui.Parent = p28.Visual.Primary;

    if p28._owner_user_id == Players.LocalPlayer.UserId then
        p28.Gui.CanvasGroup.Keybind:SetAttribute("InputName", p28.PortalNum == 1 and "Shoot" or "Aim");
        p28.Gui.CanvasGroup.Keybind:AddTag("UIKeybindContainer");
    end;

    p28.Visual.PrimaryPart = p28.Visual.Primary;
    p28.BigVisual.WorldPivot = p28.Visual.WorldPivot;
    p28.SmallVisual.WorldPivot = p28.Visual.WorldPivot;
    p28.Visual.Parent = p28.Model;
    Utility:CreateSound("rbxassetid://114274252176516", 0.5, 0.95 + 0.1 * math.random(), p28.Visual.Primary, true).Looped = true;
end;

function u1._Init(u30) -- Line: 228
    u30.Model:GetAttributeChangedSignal("SpawnDelay"):Connect(function() -- Line: 229
        -- upvalues: u30 (copy)
        u30:_InitializeGrowing();
    end);
    u30.Model:GetAttributeChangedSignal("RegrowHash"):Connect(function() -- Line: 233
        -- upvalues: u30 (copy)
        u30:_InitializeGrowing();
    end);
    u30:_Setup();
    u30:_Pivot();
    u30:_InitializeGrowing();
end;

return u1;