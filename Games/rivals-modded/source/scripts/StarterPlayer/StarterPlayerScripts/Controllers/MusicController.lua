-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Equipment"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"));
local u1 = EventLibrary.IS_ACTIVE and (EventLibrary.EVENT_DETAILS.LOBBY_MUSIC or "Default") or "Default";
local u2 = EventLibrary.IS_ACTIVE and EventLibrary.EVENT_DETAILS.LOBBY_MUSIC_MUFFLED or "DefaultMuffled";
local u3 = {
    [""] = { "", 1 },
    Default = { "rbxassetid://17697682466", 1 },
    DefaultMuffled = { "rbxassetid://17733314783", 1 },
    Spooky = { "rbxassetid://100081814360953", 1 },
    SpookyMuffled = { "rbxassetid://86062306109271", 0.5 },
    Festive = { "rbxassetid://82135261819112", 1 },
    FestiveMuffled = { "rbxassetid://96771526359691", 1 },
    Tropical = { "rbxassetid://120824068504773", 1 },
    TropicalMuffled = { "rbxassetid://114306049661290", 1 },
    Obby = { "rbxassetid://91718252417630", 1 },
    Spleef = { "rbxassetid://91718252417630", 1 },
    ZombieTower = { "rbxassetid://120087790552326", 1 }
};
local u4 = {};
u4.__index = u4;

function u4._new() -- Line: 34
    -- upvalues: u4 (copy), u3 (copy)
    local v5 = setmetatable({}, u4);
    v5.LocalFighter = nil;
    v5._volume = 0.5;
    v5._sound_name = "";
    v5._sound_info = u3[""];
    v5._is_tweening = false;
    v5._sound = Instance.new("Sound");
    v5._next_sound = Instance.new("Sound");
    v5._volume_multiplier = 1;
    v5._duel_subject_connections = {};
    v5:_Init();

    return v5;
end;

function u4.SetSoundID(p6, p7, p8) -- Line: 57
    -- upvalues: u3 (copy)
    assert(not p7 or u3[p7], "Argument 1 invalid, expected a string or nil");
    local v9 = not p8 or typeof(p8) == "number";
    assert(v9, "Argument 2 invalid, expected a number or nil");

    if p7 == p6._sound_name then
        return;
    end;

    p6._sound_name = p7 or "";
    p6._sound_info = u3[p6._sound_name];

    -- The place owner's replacement for this track (ServerStorage.SoundOverrides).
    if p6._sound_info and p6._sound_info[1] ~= "" then
        p6._sound_info = { require(ReplicatedStorage.Modules.SoundOverrides).Get(p6._sound_info[1]), p6._sound_info[2] };
    end;
    p6._volume_multiplier = p8 or 1;
    task.spawn(p6._TweenSoundID, p6);
end;

function u4.SetVolume(p10, p11) -- Line: 72
    local v12 = typeof(p11) == "number";
    assert(v12, "Argument 1 invalid, expected a number");
    p10._volume = p11;
    p10:_UpdateVolume();
end;

function u4._UpdateSoundGroups(p13, u14, u15) -- Line: 83
    -- upvalues: PlayerDataController (copy), SoundService (copy)
    local function get(p16) -- Line: 84
        -- upvalues: u14 (copy), u15 (copy), PlayerDataController (ref)
        if p16 == u14 then
            return u15;
        end;

        return PlayerDataController:GetSetting(p16);
    end;

    local Master = SoundService.Master;
    local v17;

    if u14 == "Master Volume" then
        v17 = u15;
    else
        v17 = PlayerDataController:GetSetting("Master Volume");
    end;

    Master.Volume = v17;
    local Music = SoundService.Master.Music;
    local v18;

    if u14 == "Music Volume" then
        v18 = u15;
    else
        v18 = PlayerDataController:GetSetting("Music Volume");
    end;

    Music.Volume = v18;
    local Other = SoundService.Master.Other;
    local v19;

    if u14 == "Other Volume" then
        v19 = u15;
    else
        v19 = PlayerDataController:GetSetting("Other Volume");
    end;

    Other.Volume = v19;
    local Finisher = SoundService.Master.Finisher;
    local v20;

    if u14 == "Finisher Volume" then
        v20 = u15;
    else
        v20 = PlayerDataController:GetSetting("Finisher Volume");
    end;

    Finisher.Volume = v20;
    local Emote = SoundService.Master.Emote;
    local v21;

    if u14 == "Emote Volume" then
        v21 = u15;
    else
        v21 = PlayerDataController:GetSetting("Emote Volume");
    end;

    Emote.Volume = v21;
    local FinisherFromOthers = SoundService.Master.Finisher.FinisherFromOthers;
    local v22;

    if u14 == "Mute Finishers From Others" then
        v22 = u15;
    else
        v22 = PlayerDataController:GetSetting("Mute Finishers From Others");
    end;

    FinisherFromOthers.Volume = v22 and 0 or 1;
    local EmoteFromOthers = SoundService.Master.Emote.EmoteFromOthers;

    if u14 ~= "Mute Emotes From Others" then
        u15 = PlayerDataController:GetSetting("Mute Emotes From Others");
    end;

    EmoteFromOthers.Volume = u15 and 0 or 1;
end;

function u4._GetCurrentEmoteInfo(p23) -- Line: 97
    -- upvalues: SpectateController (copy), Equipment (copy), CosmeticLibrary (copy)
    local v24 = SpectateController.CurrentSubject and SpectateController.CurrentSubject.Entity and SpectateController.CurrentSubject.Entity:GetCurrentEmote();

    if v24 then
        return v24.Info;
    end;

    local v25 = CosmeticLibrary.Cosmetics[Equipment.IsOpen and Equipment.EquipmentState.SelectedCosmetic];

    if v25 and v25.Type == "Emote" then
        return v25;
    end;
end;

function u4._GetVolume(p26) -- Line: 112
    local v27 = p26._sound_info[2];
    local v28 = p26:_GetCurrentEmoteInfo();

    return v27 * p26._volume_multiplier * p26._volume * (v28 and v28.IsAudioIntrusive and 0 or 1);
end;

function u4._TweenSoundID(u29) -- Line: 121
    -- upvalues: Utility (copy)
    if u29._is_tweening then
        return;
    end;

    u29._is_tweening = true;

    while u29._sound.SoundId ~= u29._sound_info[1] do
        local v30 = (u29._sound_name == "" or u29._sound.SoundId == "") and 0.25 or 2;
        u29._next_sound.SoundId = u29._sound_info[1];

        if u29._sound_name ~= "" then
            u29._next_sound:Play();
            u29._next_sound.TimePosition = u29._sound.TimePosition;
        end;

        local Volume = u29._sound.Volume;
        Utility:RenderstepForLoop(0, 100, v30, function(p31) -- Line: 140
            -- upvalues: u29 (copy), Volume (copy)
            local v32 = p31 / 100;
            u29._sound.Volume = (1 - v32) * Volume;
            u29._next_sound.Volume = v32 * u29:_GetVolume();
        end);
        u29._sound:Stop();
        local _next_sound = u29._next_sound;
        u29._next_sound = u29._sound;
        u29._sound = _next_sound;
    end;

    u29._is_tweening = false;
end;

function u4._UpdateVolume(p33) -- Line: 158
    if not p33._is_tweening then
        p33._sound.Volume = p33:_GetVolume();
    end;
end;

function u4._UpdateSoundID(p34) -- Line: 164
    -- upvalues: Equipment (copy), SpectateController (copy), u2 (copy), Pages (copy), u1 (copy)
    p34:SetSoundID((Equipment.IsOpen or SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject:Get("Status") == "GameOver") and u2 or (not (SpectateController.CurrentDuelSubject or (not p34.LocalFighter or p34.LocalFighter:Get("IsInShootingRange"))) and (Pages.PageSystem.CurrentPage and u2 or u1) or (SpectateController.CurrentDuelSubject and SpectateController.CurrentDuelSubject:Get("DuelMusic") or nil)));
end;

function u4._DuelSubjectChanged(u35) -- Line: 173
    -- upvalues: SpectateController (copy)
    u35:_UpdateSoundID();

    if not SpectateController.CurrentDuelSubject then
        return;
    end;

    local _duel_subject_connections = u35._duel_subject_connections;
    local DataChangedSignal = SpectateController.CurrentDuelSubject:GetDataChangedSignal("DuelMusic");
    table.insert(_duel_subject_connections, DataChangedSignal:Connect(function() -- Line: 180
        -- upvalues: u35 (copy)
        u35:_UpdateSoundID();
    end));
end;

function u4._HookLocalFighter(u36) -- Line: 185
    -- upvalues: FighterController (copy)
    u36.LocalFighter = FighterController:WaitForLocalFighter();
    u36.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 188
        -- upvalues: u36 (copy)
        u36:_UpdateSoundID();
    end);
    u36.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 192
        -- upvalues: u36 (copy)
        u36:_UpdateSoundID();
    end);
    u36:_UpdateSoundID();
end;

function u4._Setup(p37) -- Line: 199
    -- upvalues: SoundService (copy)
    p37._sound.Name = "Music";
    p37._sound.Looped = true;
    p37._sound.SoundGroup = SoundService.Master.Music;
    p37._sound.Parent = script;
    p37._next_sound.Name = "NextMusic";
    p37._next_sound.Looped = true;
    p37._next_sound.SoundGroup = SoundService.Master.Music;
    p37._next_sound.Parent = script;
end;

function u4._Init(u38) -- Line: 211
    -- upvalues: SpectateController (copy), Equipment (copy), Pages (copy), PlayerDataController (copy)
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 212
        -- upvalues: u38 (copy)
        u38:_DuelSubjectChanged();
    end);
    SpectateController.DuelSubjectStatusChanged:Connect(function() -- Line: 216
        -- upvalues: u38 (copy)
        u38:_UpdateSoundID();
    end);
    SpectateController.SubjectEmoteStatusChanged:Connect(function() -- Line: 220
        -- upvalues: u38 (copy)
        u38:_UpdateVolume();
    end);
    Equipment.Opened:Connect(function() -- Line: 224
        -- upvalues: u38 (copy)
        u38:_UpdateSoundID();
        u38:_UpdateVolume();
    end);
    Equipment.CustomizingStateChanged:Connect(function() -- Line: 229
        -- upvalues: u38 (copy)
        u38:_UpdateVolume();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 233
        -- upvalues: u38 (copy)
        u38:_UpdateSoundID();
        u38:_UpdateVolume();
    end);
    PlayerDataController:GetSettingChangedSignal("Master Volume"):Connect(function() -- Line: 238
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController:GetSettingChangedSignal("Music Volume"):Connect(function() -- Line: 242
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController:GetSettingChangedSignal("Other Volume"):Connect(function() -- Line: 246
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController:GetSettingChangedSignal("Finisher Volume"):Connect(function() -- Line: 250
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController:GetSettingChangedSignal("Emote Volume"):Connect(function() -- Line: 254
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController:GetSettingChangedSignal("Mute Finishers From Others"):Connect(function() -- Line: 258
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController:GetSettingChangedSignal("Mute Emotes From Others"):Connect(function() -- Line: 262
        -- upvalues: u38 (copy)
        u38:_UpdateSoundGroups();
    end);
    PlayerDataController.SettingsSliderChanged:Connect(function(p39, p40) -- Line: 266
        -- upvalues: u38 (copy)
        if p39 == "Master Volume" or p39 == "Music Volume" then
            u38:_UpdateSoundGroups(p39, p40);
        end;
    end);
    u38:_Setup();
    u38:_UpdateVolume();
    u38:_DuelSubjectChanged();
    task.spawn(u38._HookLocalFighter, u38);
    task.defer(u38._UpdateSoundGroups, u38);
end;

return u4._new();