-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Soundtrack_0 = game:GetService("SoundService").Soundtrack;
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local v4 = {
    Enum = {
        Phase1 = 1, 
        Phase2 = 2, 
        Phase3 = 3, 
        Chase = 4
    }
};
v4.__index = v4;
local _ = function(v5) --[[ Line: 21 ]] --[[ Name: tablelength ]]
    local v6 = 0;
    for _, _ in pairs(v5) do
        v6 = v6 + 1;
    end;
    return v6;
end;
local function v22(v10) --[[ Line: 31 ]] --[[ Name: ChangeThemeFormat ]]
    -- upvalues: l_Soundtrack_0 (copy)
    local v11 = {};
    for v12, v13 in pairs(v10) do
        local l_Sound_0 = Instance.new("Sound");
        l_Sound_0.Volume = 0;
        l_Sound_0.SoundId = v13.ID;
        l_Sound_0.Looped = true;
        l_Sound_0.Name = ("Theme%*"):format(v12);
        l_Sound_0.SoundGroup = l_Soundtrack_0;
        l_Sound_0.Parent = l_Soundtrack_0;
        table.insert(v11, {
            Distance = tonumber(v12), 
            Theme = l_Sound_0, 
            BPM = v13.BPM
        });
    end;
    table.sort(v11, function(v15, v16) --[[ Line: 50 ]]
        return v15.Distance > v16.Distance;
    end);
    local v17 = 1;
    local v18 = 0;
    for _, _ in pairs(v10) do
        v18 = v18 + 1;
    end;
    for v21 = v17, v18 do
        v11[v21].Phase = v21;
    end;
    return v11;
end;
local function _(v23, v24, v25) --[[ Line: 62 ]] --[[ Name: FadeOut ]]
    -- upvalues: l_TweenService_0 (copy)
    local v26 = l_TweenService_0:Create(v23, TweenInfo.new(v24), {
        Volume = 0
    });
    v26:Play();
    if v25 then
        v26.Completed:Once(function() --[[ Line: 68 ]]
            -- upvalues: v23 (copy)
            v23:Stop();
        end);
    end;
end;
local function _(v28, v29) --[[ Line: 74 ]] --[[ Name: FadeIn ]]
    -- upvalues: l_TweenService_0 (copy)
    l_TweenService_0:Create(v28, TweenInfo.new(v29), {
        Volume = 0.5
    }):Play();
end;
v4.GetPhase = function(v31) --[[ Line: 82 ]] --[[ Name: GetPhase ]]
    return v31.CurrentPhase;
end;
v4.SetPhase = function(v32, v33) --[[ Line: 86 ]] --[[ Name: SetPhase ]]
    v32.CurrentPhase = v33;
end;
v4.Play = function(v34, v35) --[[ Line: 90 ]] --[[ Name: Play ]]
    -- upvalues: v3 (copy)
    v34:SetPhase(v35);
    if v34.CurrentTheme then
        if v34.CurrentPhase < 4 then
            v3:StopTheme(tostring(v34.CurrentTheme), v34.FadeSpeed);
            v34:_Update();
        else
            v3:StopTheme(tostring(v34.CurrentTheme), v34.FadeSpeed);
        end;
    end;
    v34.CurrentTheme = v34.Themes[v35].Theme;
    v34.CurrentTheme.TimePosition = v34.CurrentPhase < 4 and v34.LastTimePosition % v34.CurrentTheme.TimeLength or 0;
    if v34.CurrentPhase < 4 then
        v3:PlayTheme(v34.CurrentTheme, {
            Priority = 5, 
            TimePosition = v34.CurrentTheme.TimePosition
        });
        return;
    else
        v3:PlayTheme(v34.CurrentTheme, {
            Priority = 5, 
            TweenTime = 0.25
        });
        return;
    end;
end;
v4.Stop = function(v36) --[[ Line: 119 ]] --[[ Name: Stop ]]
    -- upvalues: v3 (copy)
    if v36.CurrentTheme then
        v3:StopTheme(tostring(v36.CurrentTheme), v36.FadeSpeed);
    end;
end;
v4._Update = function(v37) --[[ Line: 126 ]] --[[ Name: _Update ]]
    v37.LastTimePosition = v37.CurrentTheme.TimePosition;
end;
v4.new = function(v38) --[[ Line: 132 ]] --[[ Name: new ]]
    -- upvalues: v22 (copy), v4 (copy)
    return (setmetatable({
        Themes = v22(v38), 
        CurrentPhase = 1, 
        FadeSpeed = 0.35, 
        Volume = 0.5, 
        LastTimePosition = 0, 
        CurrentTheme = nil
    }, v4));
end;
v4.Destroy = function(v39) --[[ Line: 149 ]] --[[ Name: Destroy ]]
    local l_pairs_0 = pairs;
    local v41 = v39.Themes or {};
    for v42, v43 in l_pairs_0(v41) do
        v43.Theme:Destroy();
        v39.Themes[v42] = nil;
    end;
    table.clear(v39);
    v39 = nil;
end;
return v4;