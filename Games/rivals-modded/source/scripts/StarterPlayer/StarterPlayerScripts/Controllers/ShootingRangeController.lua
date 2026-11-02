-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local ShootingRangeDisplay = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ShootingRangeDisplay"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 16
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._enter_cooldown = 0;
    v2._exit_cooldown = 0;
    v2._shooting_range_displays = {};
    v2:_Init();

    return v2;
end;

function u1.Enter(p3, ...) -- Line: 32
    -- upvalues: Pages (copy), ReplicatedStorage (copy)
    Pages.PageSystem:CloseCurrentPage();
    ReplicatedStorage.Remotes.Misc.ShootingRangeEnter:FireServer(...);
end;

function u1.Leave(p4, p5) -- Line: 37
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.ShootingRangeLeave:FireServer(p5);
end;

function u1._TrashPromptAdded(p6, p7) -- Line: 45
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), Players (copy), ReplicatedStorage (copy)
    local ProximityPrompt = p7:WaitForChild("Primary"):WaitForChild("ProximityPrompt");
    local Close = p7:WaitForChild("MeshPart"):WaitForChild("Close");
    local Open = p7:WaitForChild("MeshPart"):WaitForChild("Open");
    local Lid = p7:WaitForChild("Lid");
    local u8 = nil;

    local function move_lid(p9) -- Line: 52
        -- upvalues: u8 (ref), TweenService (ref), Lid (copy), TweenInfo_new_ret (ref)
        if u8 then
            u8:Pause();
            u8:Destroy();
        end;

        u8 = TweenService:Create(Lid, TweenInfo_new_ret, {
            CFrame = p9
        });
        u8:Play();
    end;

    ProximityPrompt.PromptShown:Connect(function() -- Line: 62
        -- upvalues: move_lid (copy), Open (copy)
        move_lid(Open.WorldCFrame);
    end);
    ProximityPrompt.PromptHidden:Connect(function() -- Line: 66
        -- upvalues: move_lid (copy), Close (copy)
        move_lid(Close.WorldCFrame);
    end);
    ProximityPrompt.Triggered:Connect(function(p10) -- Line: 70
        -- upvalues: Players (ref), ReplicatedStorage (ref)
        if p10 == Players.LocalPlayer then
            ReplicatedStorage.Remotes.Misc.ShootingRangeTrashItems:FireServer();
        end;
    end);
end;

function u1._EntranceAdded(u11, p12) -- Line: 77
    -- upvalues: Players (copy), ShootingRangeDisplay (copy)
    p12.Touched:Connect(function(p13) -- Line: 78
        -- upvalues: u11 (copy), Players (ref)
        if tick() > u11._enter_cooldown and (p13 and (p13.AssemblyRootPart and (p13.AssemblyRootPart.Parent and Players:GetPlayerFromCharacter(p13.AssemblyRootPart.Parent) == Players.LocalPlayer))) then
            u11._enter_cooldown = tick() + 1;
            u11:Enter();
        end;
    end);
    u11._shooting_range_displays[p12] = ShootingRangeDisplay.new(p12);
end;

function u1._ExitAdded(u14, p15) -- Line: 88
    -- upvalues: Players (copy)
    p15.Touched:Connect(function(p16) -- Line: 89
        -- upvalues: u14 (copy), Players (ref)
        if tick() > u14._exit_cooldown and (p16 and (p16.AssemblyRootPart and (p16.AssemblyRootPart.Parent and Players:GetPlayerFromCharacter(p16.AssemblyRootPart.Parent) == Players.LocalPlayer))) then
            u14._exit_cooldown = tick() + 1;
            u14:Leave();
        end;
    end);
end;

function u1._HookLocalFighter(u17) -- Line: 97
    -- upvalues: FighterController (copy)
    local u18 = FighterController:WaitForLocalFighter();

    local function update_displays() -- Line: 100
        -- upvalues: u18 (copy), u17 (copy)
        local v19 = not u18:Get("IsInDuel") and not u18:Get("IsInShootingRange");

        for _, v in pairs(u17._shooting_range_displays) do
            v:SetEnabled(v19);
        end;
    end;

    u18:GetDataChangedSignal("IsInShootingRange"):Connect(update_displays);
    u18:GetDataChangedSignal("IsInDuel"):Connect(update_displays);
    update_displays();
end;

function u1._ShootingRangeVisuals(p20) -- Line: 113
    -- upvalues: CONSTANTS (copy), CollectionService (copy)
    local function object_added(p21) -- Line: 114
        -- upvalues: CONSTANTS (ref)
        local Doors = p21:WaitForChild("Doors");
        local Sign = p21:WaitForChild("Sign");

        if CONSTANTS.SHOOTING_RANGE_ACTIVE then
            task.defer(Doors.Destroy, Doors);

            return;
        end;

        task.defer(Sign.Destroy, Sign);
        Doors:PivotTo(Doors:GetPivot() + Vector3.new(0, 100, 0));
    end;

    CollectionService:GetInstanceAddedSignal("LobbyShootingRangeVisuals"):Connect(object_added);

    for _, v in pairs(CollectionService:GetTagged("LobbyShootingRangeVisuals")) do
        task.defer(object_added, v);
    end;
end;

function u1._Init(u22) -- Line: 133
    -- upvalues: CONSTANTS (copy), CollectionService (copy)
    task.defer(u22._ShootingRangeVisuals, u22);

    if not CONSTANTS.SHOOTING_RANGE_ACTIVE then
        return;
    end;

    CollectionService:GetInstanceAddedSignal("ShootingRangeEntrance"):Connect(function(p23) -- Line: 140
        -- upvalues: u22 (copy)
        u22:_EntranceAdded(p23);
    end);
    CollectionService:GetInstanceAddedSignal("ShootingRangeTrashPrompt"):Connect(function(p24) -- Line: 144
        -- upvalues: u22 (copy)
        u22:_TrashPromptAdded(p24);
    end);
    CollectionService:GetInstanceAddedSignal("ShootingRangeExit"):Connect(function(p25) -- Line: 148
        -- upvalues: u22 (copy)
        u22:_ExitAdded(p25);
    end);

    for _, v in pairs(CollectionService:GetTagged("ShootingRangeEntrance")) do
        task.defer(u22._EntranceAdded, u22, v);
    end;

    for _, v in pairs(CollectionService:GetTagged("ShootingRangeTrashCan")) do
        task.defer(u22._TrashPromptAdded, u22, v);
    end;

    for _, v in pairs(CollectionService:GetTagged("ShootingRangeExit")) do
        task.defer(u22._ExitAdded, u22, v);
    end;

    task.spawn(u22._HookLocalFighter, u22);
end;

return u1._new();