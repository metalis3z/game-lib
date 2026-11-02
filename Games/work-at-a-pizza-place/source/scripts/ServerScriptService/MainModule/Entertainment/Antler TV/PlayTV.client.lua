local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value
local screen = model.Screen.SurfaceGui.Screen

local videoCreator = house.Video.VideoCreator
local videoName = house.Video.VideoName
local videoClipsJSON = house.Video.VideoClips
local videoCurrentFrame = house.Video.VideoCurrentFrame

local videoClipsChanged
local frameChanged

local clips = nil
local Screens = {}

local function AddScreen(obj)
	if obj:FindFirstChild("Screen") and obj.Screen:FindFirstChild("SurfaceGui") then
		Screens[obj.Screen.SurfaceGui] = true
	end
end

local function RemoveScreen(obj)
	if obj:FindFirstChild("Screen") and obj.Screen:FindFirstChild("SurfaceGui") then
		if Screens[obj.Screen.SurfaceGui]  then
			Screens[obj.Screen.SurfaceGui] = nil
		end
	end
end


local function CollectTVs()
	for _,furniture in ipairs(house.Furniture:GetChildren()) do
		AddScreen(furniture)
	end
end





local function ShowClip(frame)
	
	if frame == -1 or clips == nil then return end
	
	for surfaceGui,_ in pairs(Screens) do

		if frame == 0 then
			surfaceGui.Screen.Image = ""
			surfaceGui.Caption.Visible = true
			surfaceGui.Caption.Text = "created by " .. videoCreator.Value
			surfaceGui.Title.Text = videoName.Value
			surfaceGui.Title.Visible = true
		else
			surfaceGui.Caption.Visible = true
			surfaceGui.Screen.Image = "rbxassetid://" .. clips[frame][1]
			surfaceGui.Caption.Text = clips[frame][3]
			surfaceGui.Title.Visible = false
		end
	end
	
	if clips[frame+1] then --preload next frame
		game:GetService("ContentProvider"):Preload("http://www.roblox.com/asset/?id=" .. clips[frame+1][1])
	end
end




		
videoClipsJSON:GetPropertyChangedSignal("Value"):connect(function()
	if videoClipsJSON.Value ~= "" then
		clips = game:GetService("HttpService"):JSONDecode(videoClipsJSON.Value)
		ShowClip(videoCurrentFrame.Value)
	end
end)
		
		--every frame
videoCurrentFrame:GetPropertyChangedSignal("Value"):connect(function()
	ShowClip(videoCurrentFrame.Value)
end)
		
		
		
		

house.Furniture.ChildAdded:connect(AddScreen)
house.Furniture.ChildRemoved:connect(RemoveScreen)

CollectTVs()

if videoClipsJSON.Value ~= "" then
	clips = game:GetService("HttpService"):JSONDecode(videoClipsJSON.Value)
	ShowClip(videoCurrentFrame.Value)
end
		
