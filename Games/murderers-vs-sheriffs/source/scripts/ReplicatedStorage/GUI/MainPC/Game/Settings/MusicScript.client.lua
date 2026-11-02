-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Mute_0 = script.Parent:WaitForChild("Mute");
local l_Music_0 = game:GetService("SoundService"):WaitForChild("Music");
local _ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("AudioService"));
local l_MutedIcon_0 = l_Mute_0:WaitForChild("MutedIcon");
local l_UnmutedIcon_0 = l_Mute_0:WaitForChild("UnmutedIcon");
local function _() --[[ Line: 10 ]] --[[ Name: isMuted ]]
    return l_Music_0.Volume <= 0;
end;
local function _() --[[ Line: 14 ]] --[[ Name: updateMuteIcon ]]
    l_MutedIcon_0.Visible = l_Music_0.Volume <= 0;
    l_UnmutedIcon_0.Visible = not (l_Music_0.Volume <= 0);
end;
local function v8() --[[ Line: 19 ]] --[[ Name: onMuteToggled ]]
    if l_Music_0.Volume > 0 then
        l_Music_0.Volume = 0;
    else
        l_Music_0.Volume = 1;
    end;
    l_MutedIcon_0.Visible = l_Music_0.Volume <= 0;
    l_UnmutedIcon_0.Visible = not (l_Music_0.Volume <= 0);
end;
l_MutedIcon_0.Visible = l_Music_0.Volume <= 0;
l_UnmutedIcon_0.Visible = not (l_Music_0.Volume <= 0);
l_Mute_0:WaitForChild("Button").Activated:Connect(v8);