-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Music = SoundService:WaitForChild("Music");
local v1 = {
    Songs = { {
            Id = 136201737083208,
            Name = "Calm City Dusk"
        }, {
            Id = 132927496550531,
            Name = "Calm Your Nervous System"
        }, {
            Id = 127943663927537,
            Name = "Morning Calm Lofi"
        }, {
            Id = 117972143920617,
            Name = "Calm Lofi Breathing"
        }, {
            Id = 73937379612481,
            Name = "Calm Wind"
        }, {
            Id = 84653329499532,
            Name = "LoFi Study Calm"
        }, {
            Id = 84678159837679,
            Name = "Work Mode Calm LoFi"
        }, {
            Id = 98376971192620,
            Name = "Keep Calm Lofi"
        }, {
            Id = 99941875310924,
            Name = "Gentle Night"
        }, {
            Id = 106201266806621,
            Name = "Calm Brew"
        } },
    _currentSound = nil,
    _playing = false,
    _lastSongIndex = nil,
    _crossfadeThread = nil
};

local function pickNextSong(p2) -- Line: 30
    local v3 = #p2.Songs;

    if v3 == 0 then
        return nil;
    end;

    if v3 == 1 then
        return 1;
    end;

    local v4;

    repeat
        v4 = math.random(1, v3);
    until v4 ~= p2._lastSongIndex;

    return v4;
end;

local function fadeIn(p5, p6, p7) -- Line: 50
    -- upvalues: TweenService (copy)
    p5.Volume = 0;
    p5:Play();
    local v8 = TweenService:Create(p5, TweenInfo.new(p6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Volume = p7
    });
    v8:Play();

    return v8;
end;

local function fadeOut(p9, p10) -- Line: 62
    -- upvalues: TweenService (copy)
    local v11 = TweenService:Create(p9, TweenInfo.new(p10, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Volume = 0
    });
    v11:Play();

    return v11;
end;

local function crossfadeToNext(u12) -- Line: 71
    -- upvalues: pickNextSong (copy), Music (copy), SoundService (copy), fadeOut (copy), fadeIn (copy), crossfadeToNext (copy)
    if u12._playing == false then
        return;
    end;

    local _currentSound = u12._currentSound;
    local v13 = pickNextSong(u12);

    if v13 == nil then
        warn("[MusicController] No songs available");

        return;
    end;

    u12._lastSongIndex = v13;
    local v14 = u12.Songs[v13];
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://" .. v14.Id;
    Sound.Name = v14.Name;
    Sound.SoundGroup = Music;
    Sound.Looped = false;
    Sound.Parent = SoundService;
    u12._currentSound = Sound;

    if _currentSound then
        fadeOut(_currentSound, 5).Completed:Once(function() -- Line: 100
            -- upvalues: _currentSound (copy)
            _currentSound:Destroy();
        end);
    end;

    fadeIn(Sound, 7, 0.35);
    u12._crossfadeThread = task.spawn(function() -- Line: 108
        -- upvalues: Sound (copy), u12 (copy), crossfadeToNext (ref)
        while Sound.TimeLength == 0 do
            task.wait(0.5);
        end;

        local v15 = math.max(Sound.TimeLength - 5, 0);

        while Sound.TimePosition < v15 and Sound.Playing do
            task.wait(1);
        end;

        if u12._playing and u12._currentSound == Sound then
            crossfadeToNext(u12);
        end;
    end);
end;

function v1.StartMusic(p16) -- Line: 128
    -- upvalues: crossfadeToNext (copy)
    if p16._playing then
        return;
    end;

    p16._playing = true;
    crossfadeToNext(p16);
end;

function v1.StopMusic(p17) -- Line: 137
    -- upvalues: fadeOut (copy)
    if p17._playing == false then
        return;
    end;

    p17._playing = false;

    if p17._crossfadeThread then
        task.cancel(p17._crossfadeThread);
        p17._crossfadeThread = nil;
    end;

    if p17._currentSound then
        local _currentSound = p17._currentSound;
        p17._currentSound = nil;
        fadeOut(_currentSound, 2).Completed:Once(function() -- Line: 154
            -- upvalues: _currentSound (copy)
            _currentSound:Destroy();
        end);
    end;
end;

return v1;