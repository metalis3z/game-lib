local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Tween = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Tween"))
local Debug = require(game.ReplicatedStorage:WaitForChild("Debug"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

local Song = script:WaitForChild("Song")
local player = game.Players.LocalPlayer


local Location = "Outside"


local Season = game.ReplicatedStorage.GlobalData.Season.Value
local Holiday = game.ReplicatedStorage.GlobalData.Holiday.Value
local TimeOfDay = game.ReplicatedStorage.GlobalData.TimeOfDay.Value

local SavedSettings = Utility:SendData("GetSettings","PlayerChannel",10) or Utility:SendData("GetSettings","PlayerChannel",10) or {Music = "0.5",OldMusic = false}
local VolumeSetting = tonumber(SavedSettings.Music)
local OldMusic = SavedSettings.OldMusic
local ConfigChanged
local MusicModel = nil --stop outdoor song from playing when time of day changes while listening to music player


function GetTimeOfDaySoundTrack()
	if TimeOfDay == "Night" and Holiday == "Halloween" then
		return (OldMusic and 142748120) or 2514882365
	elseif TimeOfDay == "Night" and Holiday == "Christmas" then
		return (OldMusic and 4499024771) or 189636326
	elseif TimeOfDay == "Midday" and Holiday == "Christmas" then
		return (OldMusic and 907039772) or 326828757
	elseif TimeOfDay == "Night" and Holiday == "Thanksgiving" then
		return (OldMusic and 173607581) or 544210971
	elseif TimeOfDay == "Morning" and Holiday == "Thanksgiving" then
		return (OldMusic and 2099454924) or 544211227
	elseif TimeOfDay == "Midday" and Holiday == "Thanksgiving" then
		return (OldMusic and 173607633) or 544210707
	elseif TimeOfDay == "Afternoon" and Holiday == "Thanksgiving" then
		return (OldMusic and 173607522) or 544210876
	elseif TimeOfDay == "Night" and Season == "Winter" then
		return (OldMusic and 1159494309) or 988818408
	elseif TimeOfDay == "Midday" and Season == "Winter" then
		return (OldMusic and 907039772) or 326828757
	elseif TimeOfDay == "Night" and Season == "Spring" then
		return (OldMusic and 1159494309) or 988818408
	elseif TimeOfDay == "Morning" and Season == "Spring" then
		return (OldMusic and 938044888) or 374852921
	elseif TimeOfDay == "Midday" and Season == "Spring" then
		return (OldMusic and 681418426) or 2598113259
	elseif TimeOfDay == "Afternoon" and Season == "Spring" then
		return (OldMusic and 522040152) or 477731528
	elseif TimeOfDay == "Night" and Season == "Summer" then
		return (OldMusic and 173607581) or 5048052996
	elseif TimeOfDay == "Morning" and Season == "Summer" then
		return (OldMusic and 2099454924) or 1847853099
	elseif TimeOfDay == "Midday" and Season == "Summer" then
		return (OldMusic and 173607633) or 4578265965
	elseif TimeOfDay == "Afternoon" and Season == "Summer" then
		return (OldMusic and 173607522) or 1836842889
	elseif TimeOfDay == "Night" and Season == "Fall" then
		return (OldMusic and 500519114) or 151246486
	elseif TimeOfDay == "Afternoon" and Season == "Fall" then
		return (OldMusic and 1359047659) or 1836713392
	end
end



local lastSong = nil
local lastTimePosition = 0

function SetSong(songId,isTimeOfDaySoundTrack)
	
	--dont play the same song again
	if lastSong == songId then return end
	lastSong = songId
	
	if VolumeSetting > 0 then
	
	
		local completed = FadeMusic("Out",true)
	
			
		if completed then
			
			--save position when swiching song
			if not isTimeOfDaySoundTrack then
				lastTimePosition = Song.TimePosition 
			end
			
			
			Song:Stop()
			Song.SoundId = (songId and "http://www.roblox.com/asset/?id=" .. songId) or Song.SoundId --dont change song with there is no id
			Song:Play()
			
			if isTimeOfDaySoundTrack then
				Song.TimePosition = lastTimePosition
				lastTimePosition = 0
			end
			
			
				
			FadeMusic("In",false)
	
		end
	end
end


UIEvents.SliderMoved.Event:connect(function(window,object,volume)
	if window.Name == "Settings" and object and object.Parent and object.Parent.Parent.Name == "Music" then
	
		VolumeSetting = volume
		Song.Volume = Utility:ConvertScale(VolumeSetting,{0,1},{0,MAX_VOLUME})
		
		if volume > 0 then
			Song.Looped = true
			
			--if not playing, start current song imediatly
			if not Song.IsPlaying then
				Song.SoundId = "http://www.roblox.com/asset/?id=" .. lastSong
				Song:Play()
			end
		else
			Song.Looped = false --if there is no volume, let the song end
		end
		
		--if song is stopped
		
	end
end)


UIEvents.ToggleButtonPressed.Event:connect(function(window,button,state)
	local settingName = button.Parent.Name
		
	if settingName == "OldMusic" then
		OldMusic = state	
		SetSong(GetTimeOfDaySoundTrack(),true)
	
	end
end)


workspace.Main.LocationChanged.OnClientEvent:connect(function(zone,house)
	wait()
	print("location changed",zone)
	if zone and house then
		
		if  zone.Name == "Porch" and zone.Name == "Walkway" then return end
		
		
		--change job when stepping inside house
		if player.TeamColor ~= BrickColor.new("Medium stone grey") then
			Utility:SendData("ChangeJob","PlayerChannel",nil,"On Break")
		end
		
		
		if ConfigChanged then ConfigChanged:disconnect() ConfigChanged = nil end
		
		--set song
		Location = zone.Name
		for _,furniture in ipairs(house.Furniture:GetChildren()) do
			if furniture:FindFirstChild("MusicPlayer") and Utility.IsPointInsideBox(zone,furniture.MusicMarker.Position) then
				SetSong(furniture.Config.Value)
				MusicModel = furniture
				ConfigChanged = furniture.Config.Changed:connect(function()
					SetSong(furniture.Config.Value)
				end)
				return
			end
		end
		
		--else set outdoor song
		SetSong(GetTimeOfDaySoundTrack(),true)
		MusicModel = nil
		
		
	elseif zone and zone:FindFirstChild("SongId") then --shop
		Location = zone.Name
		SetSong(zone.SongId.Value)
	
	else
		Location = "Outside"
		SetSong(GetTimeOfDaySoundTrack(),true)
		MusicModel = nil
	end
	
end)

--detect when a music player is added to the room
workspace.Main.FurnitureAdded.OnClientEvent:connect(function(house,zone,furnitureObject,floorData,wallpaperData)
	--if not already listening to a music player,
	if ConfigChanged == nil and furnitureObject:FindFirstChild("MusicPlayer") and Utility.IsPointInsideBox(zone,furnitureObject.MusicMarker.Position) then
		ConfigChanged = furnitureObject.Config.Changed:connect(function()
			MusicModel = furnitureObject
			SetSong(furnitureObject.Config.Value)
		end)
	end
end)



MAX_VOLUME = .2
FADE_DURATION = 2

	
		
function FadeMusic(inOrOut,async)
	local finished = false
	local completed= false
	if inOrOut == "Out" then
		Tween(Song,"Volume","Number",Song.Volume,0,FADE_DURATION,"Linear","Out"):connect(function(_completed,object,propertyName)
			completed = _completed
			finished = true
		end)
	elseif inOrOut == "In" then
		Tween(Song,"Volume","Number",0,Utility:ConvertScale(VolumeSetting,{0,1},{0,MAX_VOLUME}),FADE_DURATION,"Linear","Out"):connect(function(_completed,object,propertyName)
			completed = _completed
			finished = true
		end)
	end
	
	while async and not finished do wait() end
	
	return completed	
end

workspace.Main.FadeMusic.OnClientEvent:connect(function(inOrOut) FadeMusic(inOrOut) end)
function workspace.Main.FadeMusic.FadeMusic.OnInvoke(inOrOut,async) FadeMusic(inOrOut,async) end





--search for music on boats
spawn(function()
	while true do
		local closest = nil
		local distance = 50
		local torso = player.Character:FindFirstChild("HumanoidRootPart")
		if VolumeSetting > 0 and Location == "Outside" and torso then
			for _,boat in ipairs(workspace.Boats:GetChildren()) do
				if boat:FindFirstChild("Base") and (boat.Base.Position-torso.Position).magnitude < distance then
					distance = (boat.Base.Position-torso.Position).magnitude
					closest = boat
				end
			end
			if closest then
				local song = closest.Base.Config.Value
				if song ~= 0 and lastSong ~= song then
					MusicModel = closest.Base
					SetSong(song,.6)
				end
			else
				SetSong(GetTimeOfDaySoundTrack(),true)
			end
		end	
	wait(2)
	end
end)





workspace.Main.TimeOfDayChanged.OnClientEvent:connect(function(timeOfDay)
	TimeOfDay = timeOfDay
	lastTimePosition = 0
	if MusicModel == nil then
		SetSong(GetTimeOfDaySoundTrack(),true)
	end
end)









SetSong(GetTimeOfDaySoundTrack(),true)
