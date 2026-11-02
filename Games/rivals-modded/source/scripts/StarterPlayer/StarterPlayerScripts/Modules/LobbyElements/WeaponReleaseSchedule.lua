-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local MatchmakingCountdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.MatchmakingCountdown);
local Notifications = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Notifications);
local LooseWeaponDisplay = require(Players.LocalPlayer.PlayerScripts.Modules.LooseWeaponDisplay);
local SendChat = require(Players.LocalPlayer.PlayerScripts.Modules.Functions.SendChat);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 21
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._loose_weapon_displays = {};
    v3._celebration_hash = 0;
    v3._celebration_queued = false;
    v3:_Init();

    return v3;
end;

function u1.GetLastReleasedWeapon(p4) -- Line: 37
    -- upvalues: ShopLibrary (copy)
    local _, v5 = ShopLibrary:GetUpcomingWeapon();
    local v6 = v5 and v5 - 1 or #ShopLibrary.OwnableWeaponReleaseSchedule;

    return ShopLibrary.OwnableWeaponReleaseSchedule[v6], v6;
end;

function u1.Refresh(p7, p8) -- Line: 44
    -- upvalues: ShopLibrary (copy), Utility (copy)
    local UpcomingWeapon = ShopLibrary:GetUpcomingWeapon();
    local LastReleasedWeapon = p7:GetLastReleasedWeapon();
    local v9 = not UpcomingWeapon or ShopLibrary:GetTimeUntilWeaponRelease(LastReleasedWeapon) > -259200;
    local v10 = v9 and LastReleasedWeapon and LastReleasedWeapon or (UpcomingWeapon or LastReleasedWeapon);

    for _, v in pairs(p7._loose_weapon_displays) do
        v:SetLocked(not v9);

        if v.CurrentWeapon ~= v10 then
            v:ChangeWeapon(v10);
        end;

        if v9 then
            v:SetProximityPromptData("NEW WEAPON", "View");
        else
            v:SetProximityPromptData("COMING SOON", function() -- Line: 60
                -- upvalues: v (copy), Utility (ref), ShopLibrary (ref)
                return not v.CurrentWeapon and "" or Utility:TimeFormat2(ShopLibrary:GetTimeUntilWeaponRelease(v.CurrentWeapon));
            end);
        end;
    end;

    if p8 and v9 then
        task.delay(3, p7._PlayCelebration, p7);
    end;
end;

function u1.Update(p11, p12) -- Line: 71
    for _, v in pairs(p11._loose_weapon_displays) do
        v:Update(p12);
    end;
end;

function u1._EnableParticles(p13, p14) -- Line: 81
    -- upvalues: Utility (copy)
    for i in pairs(p13._loose_weapon_displays) do
        if p14 then
            Utility:PlayParticles(i.Particles.Emit);
            Utility:CreateSound("rbxassetid://120776960987657", 0.75, 1, i.Particles, true, 15);
            Utility:CreateSound("rbxassetid://75616400922980", 1, 1, i.Particles, true, 15);
        end;

        for _, child in pairs(i.Particles.Attachment:GetChildren()) do
            child.Enabled = p14;
        end;
    end;
end;

function u1._PlayCelebration(u15) -- Line: 95
    -- upvalues: TeleportService (copy), FighterController (copy), MatchmakingCountdown (copy)
    if TeleportService:GetTeleportSetting("PlayedWeaponReleaseCelebration") then
        return;
    end;

    local v16 = FighterController.LocalFighter and not FighterController.LocalFighter:Get("IsInDuel") and not FighterController.LocalFighter:Get("IsInShootingRange");

    if v16 and not MatchmakingCountdown:IsVisible() then
        TeleportService:SetTeleportSetting("PlayedWeaponReleaseCelebration", true);
        u15._celebration_queued = false;
        u15._celebration_hash = u15._celebration_hash + 1;
        local _celebration_hash = u15._celebration_hash;
        u15:_EnableParticles(true);
        task.delay(10, function() -- Line: 115
            -- upvalues: u15 (copy), _celebration_hash (copy)
            if u15._celebration_hash ~= _celebration_hash then
                return;
            end;

            u15:_EnableParticles(false);
        end);

        return true;
    end;

    u15._celebration_queued = true;
end;

function u1._RefreshLoop(p17) -- Line: 126
    -- upvalues: ShopLibrary (copy), SendChat (copy), Notifications (copy)
    while true do
        local UpcomingWeapon = ShopLibrary:GetUpcomingWeapon();

        if not UpcomingWeapon then
            break;
        end;

        wait(ShopLibrary:GetTimeUntilWeaponRelease(UpcomingWeapon));
        p17:Refresh();
        p17:_PlayCelebration();
        task.defer(SendChat, {
            Text = "[SERVER] A new weapon has been officially released - The <font weight=\"900\">" .. UpcomingWeapon .. "</font>! Check out the Weapons page to learn more!",
            Color = Color3.fromRGB(100, 255, 50)
        });
        task.defer(Notifications.Play, Notifications, "New Weapon", "The " .. UpcomingWeapon .. " has released!", {
            Name = UpcomingWeapon
        }, nil, nil, "rbxassetid://128960987577700");
        wait(259200);
        p17:Refresh();
    end;
end;

function u1._ModelAdded(p18, p19) -- Line: 147
    -- upvalues: LooseWeaponDisplay (copy)
    p18._loose_weapon_displays[p19] = LooseWeaponDisplay.new(p19:WaitForChild("LooseWeaponDisplay"));
    p18:Refresh();
end;

function u1._HookLocalFighter(u20) -- Line: 152
    -- upvalues: FighterController (copy), MatchmakingCountdown (copy)
    local v21 = FighterController:WaitForLocalFighter();

    local function play_queued_celebration() -- Line: 155
        -- upvalues: u20 (copy)
        if u20._celebration_queued then
            u20:_PlayCelebration();
        end;
    end;

    MatchmakingCountdown.VisibilityChanged:Connect(play_queued_celebration);
    v21:GetDataChangedSignal("IsInShootingRange"):Connect(play_queued_celebration);
    v21:GetDataChangedSignal("IsInDuel"):Connect(play_queued_celebration);

    if u20._celebration_queued then
        u20:_PlayCelebration();
    end;
end;

function u1._Init(u22) -- Line: 167
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyWeaponReleaseSchedule"):Connect(function(p23) -- Line: 168
        -- upvalues: u22 (copy)
        u22:_ModelAdded(p23);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyWeaponReleaseSchedule")) do
        task.defer(u22._ModelAdded, u22, v);
    end;

    u22:Refresh(true);
    task.defer(u22._HookLocalFighter, u22);
    task.defer(u22._RefreshLoop, u22);
end;

return u1._new();