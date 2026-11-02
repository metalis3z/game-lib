-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Container_0 = script.Parent:WaitForChild("Container"):WaitForChild("Mute"):WaitForChild("Container");
local l_Music_0 = game:GetService("SoundService"):WaitForChild("Music");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("AudioService"));
local l_MutedIcon_0 = l_Container_0:WaitForChild("Icon"):WaitForChild("MutedIcon");
local l_UnmutedIcon_0 = l_Container_0:WaitForChild("Icon"):WaitForChild("UnmutedIcon");

local function SetRadioVolume(v)
	for _, p in ipairs(l_Players_0:GetPlayers()) do
		local char = p.Character
		if char and char:FindFirstChild("Radio") then
			local s = char.Radio:FindFirstChild("SoundForRadio")
			if s then
				s.Volume = v
			end
		end
	end
end

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
		SetRadioVolume(0);
	else
		l_Music_0.Volume = 1;
		SetRadioVolume(1);
	end;
	l_MutedIcon_0.Visible = l_Music_0.Volume <= 0;
	l_UnmutedIcon_0.Visible = not (l_Music_0.Volume <= 0);
end;

l_MutedIcon_0.Visible = l_Music_0.Volume <= 0;
l_UnmutedIcon_0.Visible = not (l_Music_0.Volume <= 0);
l_Container_0:WaitForChild("Button").Activated:Connect(v8);

l_Players_0.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(char)
		task.wait(1)
		if l_Music_0.Volume <= 0 then
			SetRadioVolume(0)
		end
	end)
end)
