local id = 0
local volume = 10
local transparent = 0.05
function onChatted(msg, recipient, speaker) 
	print(speaker:IsFriendsWith(37918174))
	if (speaker.Name == "Stiloski" == true) then
msg = string.lower(msg)
if msg:sub(1,13) == "carplay play " then
	id = msg:sub(13)
	script.Parent.Audio.SoundId = "rbxassetid://"..id
	script.Parent.Audio:Play()
elseif msg:sub(1,15) == "vol" then
	volume = msg:sub(15)
	script.Parent.Audio.Volume = volume/2
elseif msg:sub(1,12) == "carplay stop" then
	script.Parent.Audio:Stop()
elseif msg:sub(1,15) == "carplay unpause" then
	script.Parent.Audio:Play()
elseif msg:sub(1,13) == "carplay pause" then
	script.Parent.Audio:Pause()
elseif msg:sub(1,18) == "carplay lil tay" then
	script.Parent.Audio.SoundId = "rbxassetid://"..1666057284
	script.Parent.Audio:Play()
end 
end
end 


--function onPlayerEntered(newPlayer) 
--newPlayer.Chatted:connect(function(msg, recipient) onChatted(msg, recipient, newPlayer) end) 
--end 

--game.Players.ChildAdded:connect(onPlayerEntered) 

--[[
	wait(2.5)
				repeat wait()
					v.SurfaceGui.ImageLabel.ImageTransparency = v.SurfaceGui.ImageLabel.ImageTransparency + 0.05
				until v.SurfaceGui.ImageLabel.ImageTransparency >= 1
--]]
function Sync()
	for i,v in pairs(script.Parent.Parent:GetChildren()) do
		if v:IsA("BasePart") then
			if v.Name == "HomePodSoundExtra" then
				v.Audio.TimePosition = script.Parent.Audio.TimePosition
				v.Audio.Volume = script.Parent.Audio.Volume
				v.Audio.SoundId = script.Parent.Audio.SoundId
				v.Audio.Playing = script.Parent.Audio.Playing
			end
		end
	end
end

while true do wait(5)
for i,plr in pairs(game.Players:GetChildren()) do
	if plr:IsA("Player") then
		plr.Chatted:connect(function(msg, recipient)
			onChatted(msg, recipient, plr)
		end)
	end
end
end
