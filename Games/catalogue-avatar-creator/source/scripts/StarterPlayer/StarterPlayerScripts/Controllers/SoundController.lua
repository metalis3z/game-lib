-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Sounds = ReplicatedStorage:WaitForChild("Sounds");
local Events = script.Parent.Parent:WaitForChild("Events");
local MusicController = require(script.MusicController);
local u1 = {
    ButtonHoverSoundsEnabled = true,
    ButtonClickSoundsEnabled = true
};

local function applyProperties(u2, p3) -- Line: 13
    for i, v in p3 do
        local success, result = pcall(function() -- Line: 15
            -- upvalues: u2 (copy), i (copy), v (copy)
            u2[i] = v;
        end);

        if success == false then
            warn("error during applying properties:", result);
        end;
    end;
end;

function u1.PlaySound(p4, p5, p6, p7) -- Line: 25
    -- upvalues: u1 (copy), Sounds (copy), applyProperties (copy), SoundService (copy)
    if typeof(p4) == "string" then
        if p4 == "HOVER" and not u1.ButtonHoverSoundsEnabled then
            return;
        end;

        if p4 == "CLICK" and not u1.ButtonClickSoundsEnabled then
            return;
        end;
    end;

    local v8 = nil;

    if typeof(p4) == "string" then
        p4 = Sounds:WaitForChild(p4);
    elseif typeof(p4) ~= "Instance" or p4:IsA("Sound") ~= true then
        p4 = v8;
    end;

    local u9 = p4:Clone();

    if p6 then
        applyProperties(u9, p6);
    end;

    local v10 = not u9.SoundGroup and SoundService:FindFirstChild("UI");

    if v10 then
        u9.SoundGroup = v10;
    end;

    if p7 then
        u9.Parent = p7;
    else
        u9.Parent = SoundService;
    end;

    u9:Play();
    u9.Ended:Once(function() -- Line: 62
        -- upvalues: u9 (ref)
        u9:Destroy();
    end);

    return u9;
end;

task.spawn(function() -- Line: 71, Name: initialize
    -- upvalues: Events (copy), SoundService (copy), u1 (copy), MusicController (copy)
    local GetSetting = Events:WaitForChild("GetSetting");

    if not GetSetting:GetAttribute("bound") then
        GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    local v11 = GetSetting:Invoke({ "Audio", "UIVolume" });
    local v12 = GetSetting:Invoke({ "Audio", "MusicVolume" });
    local v13 = GetSetting:Invoke({ "Audio", "SFXVolume" });
    local UI = SoundService:FindFirstChild("UI");
    local Music = SoundService:FindFirstChild("Music");
    local SFX = SoundService:FindFirstChild("SFX");

    if UI and v11 then
        UI.Volume = v11 / 100;
    end;

    if Music and v12 then
        Music.Volume = v12 / 100;
    end;

    if SFX and v13 then
        SFX.Volume = v13 / 100;
    end;

    local v14 = GetSetting:Invoke({ "Audio", "EnableButtonHoverSounds" });
    local v15 = GetSetting:Invoke({ "Audio", "EnableButtonClickSounds" });

    if v14 ~= nil then
        u1.ButtonHoverSoundsEnabled = v14;
    end;

    if v15 ~= nil then
        u1.ButtonClickSoundsEnabled = v15;
    end;

    MusicController:StartMusic();
end);

return u1;