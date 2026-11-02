--TIMELINE RUNTIME V1 BY CRAZYBLOX

--------TERMS AND CONDITIONS:
--This script is open source and falls under the Creative Commons (CC BY-SA 4.0) license.
--In essence, this is free to use/edit/share etc, but you MUST credit, disclose changes, share and maintain the same license/T&C's.
--A good place to credit Crazyblox (The author of this script) is within your work's publicly accessible credits, such as your games description.

local Timelines = script.Parent:FindFirstChild("Timelines")
if not Timelines then
	error("Did not found timelimes")
end
local random = Random.new()
local letters = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}

function getRandomLetter()
	return letters[random:NextInteger(1,#letters)]
end

function getRandomString(length, includeCapitals)
	local length = length or 10
	local str = ''
	for i=1,length do
		local randomLetter = getRandomLetter()
		if includeCapitals and random:NextNumber() > .5 then
			randomLetter = string.upper(randomLetter)
		end
		str = str .. randomLetter
	end
	return str
end

local ClonedTimelines = script.Parent:WaitForChild("Timelines") --no cheating
local FolderToCreate = Instance.new("Folder")
FolderToCreate.Parent = game.ServerStorage.TimelineHolder
FolderToCreate.Name = getRandomString(15)
ClonedTimelines.Parent = FolderToCreate
local Timelines = ClonedTimelines
local Timelines = ClonedTimelines
local Lib = workspace.Multiplayer.GetMapVals:Invoke()
local TweenService = game:GetService("TweenService")
local TimelinePlayer = require(game.ReplicatedStorage.SharedModules:WaitForChild("TimelinePlayer"))

--to be used later...
local MapCamera = Instance.new("ObjectValue")
MapCamera.Name = "MapCamera"
MapCamera.Parent = workspace.Multiplayer:WaitForChild("Map").Settings
local LocalMapCamera = Instance.new("ObjectValue")
LocalMapCamera.Name = "LocalMapCamera"
LocalMapCamera.Parent = MapCamera

------------TIMELINE WRAPPER
--Validates a Timeline
local function ValidateIsTimeline(Timeline)
	if Timeline:IsA("Configuration") then
		if
			Timeline:GetAttribute("Trigger_Delay")
			or Timeline:GetAttribute("Trigger_Button")
			or Timeline:GetAttribute("Trigger_Timeline")
			or Timeline:GetAttribute("Trigger_Touch")
			or Timeline:GetAttribute("Trigger_Dormant")
			or Timeline:GetAttribute("LocalTrigger_Touch")
		then
			return true
		end
	end
end

--Validates an XFrame
local function ValidateIsXFrame(XFrame)
	if XFrame:IsA("ObjectValue") then
		if
			typeof(XFrame:GetAttribute("XFrame_Function")) == "string"
			and typeof(XFrame:GetAttribute("XFrame_Timestamp")) == "number"
		then
			return true
		end
	end
end

local function Conditional(XFrame : ObjectValue)
	local Inst = XFrame.Value
	local Operator = XFrame:GetAttribute("RelationalOperator")
	local val = true
	local function Com(Oper, Val, AttVal) --uh
		if Oper == "==" and Val ~= AttVal then return false
		elseif Oper == "~=" and Val == AttVal then return false	
		elseif Oper == "<" and Val >= AttVal then return false
		elseif Oper == "<=" and Val > AttVal then return false	
		elseif Oper == ">" and Val <= AttVal then return false	
		elseif Oper == ">=" and Val < AttVal then return false
		else return true
		end
	end
	for AttName, AttValue in XFrame:GetAttributes() do
		if val == true then
			if AttName:find("Property_") then
				local t = nil
				local s, e = pcall(function()
					t = Inst[AttName:sub(10)]
				end)
				if s then
					if Com(Operator, Inst[AttName:sub(10)],AttValue) == false then
						val = false
						break
					end
				end
			elseif AttName:find("Attribute_") then
				local t = nil
				local s, e = pcall(function()
					t = Inst[AttName:sub(11)]
				end)
				if s then
					if Com(Operator, Inst[AttName:sub(11)],AttValue) == false then
						val = false
						break
					end
				end
			end
		end
	end
	return val
end

--Gets duration of Timeline
local function GetTimelineDuration(Timeline)
	local FurthestPointInTime = 0
	for _, Keyframe in pairs(Timeline:GetChildren()) do
		local KeyframeEndPoint = 0
		local Time_Position, Time_Duration =
			Keyframe:GetAttribute("XFrame_Timestamp"), Keyframe:GetAttribute("XFrame_Length") or 0
		if typeof(Time_Position) == "number" then
			if typeof(Time_Duration) == "number" then
				local TweenRepeatCount = Keyframe:GetAttribute("Tween_RepeatCount") or 0
				if TweenRepeatCount == -1 then
					TweenRepeatCount = math.huge
				end
				local TweenRepeatMultiplier = 1 + TweenRepeatCount
				KeyframeEndPoint = Time_Position
					+ ((Time_Duration * TweenRepeatMultiplier) * (Keyframe:GetAttribute("Tween_Reverses") and 2 or 1))
			else
				KeyframeEndPoint = Time_Position
			end
		end
		if KeyframeEndPoint > FurthestPointInTime then
			FurthestPointInTime = KeyframeEndPoint
		end
	end
	return FurthestPointInTime
end

--Executes all XFrames within Timeline
local function PlayTimeline(Timeline, Player)
	local Loop = Timeline:GetAttribute("RepeatOnCompletion")
	local MultipleTouches = Timeline:GetAttribute("Touch_AllowMultiple")
	local TimelineDuration = GetTimelineDuration(Timeline)
	local TimelineDelay = Timeline:GetAttribute("Trigger_Delay")
	if typeof(TimelineDelay) == "number" and TimelineDelay > 0 then
		task.wait(TimelineDelay)
	end
	repeat
		for _, Keyframe in pairs(Timeline:GetDescendants()) do
			if ValidateIsXFrame(Keyframe) then
				local Time_Position = Keyframe:GetAttribute("XFrame_Timestamp")
				local Time_Duration = Keyframe:GetAttribute("XFrame_Length") or 0
				if
					typeof(Time_Position) == "number"
					and typeof(Keyframe:GetAttribute("XFrame_Function")) == "string"
				then
					local Conditional_Timeline = (Keyframe:GetAttribute("XFrame_Function") == "Conditional") and (Keyframe:FindFirstChild("Conditional_Timeline"))
					if Conditional_Timeline then
						local DidItWork = Conditional(Keyframe)
						if DidItWork then
							local TimelineToRun = Keyframe.Conditional_Timeline.Value
							if TimelineToRun:GetAttribute("Trigger_Dormant") ~= nil and TimelineToRun:GetAttribute("Trigger_Dormant") == true then
								PlayTimeline(TimelineToRun, Player)
							end
						end
					else
						task.delay(Time_Position, function()
							TimelinePlayer.PerformXFrame(script.Parent, Keyframe, Player)
						end)
					end
				end
			end
		end
		task.wait(TimelineDuration)
	until Loop ~= true or MultipleTouches == true
	for _, c in pairs(Timelines:GetDescendants()) do
		if ValidateIsTimeline(c) then
			if c:GetAttribute("Trigger_Timeline") == Timeline.Name then
				task.spawn(PlayTimeline, c)
			end
		end
	end
end

--Timeline Listeners
--Button Listener
Lib.Button:Connect(function(p, bNo)
	for _, Timeline in pairs(Timelines:GetDescendants()) do
		if ValidateIsTimeline(Timeline) then
			local TimelineTrigger, ButtonTrigger =
				Timeline:GetAttribute("Trigger_Timeline"), Timeline:GetAttribute("Trigger_Button")
			if not (typeof(TimelineTrigger) == "string" and TimelineTrigger ~= "") then
				if ButtonTrigger == bNo then
					task.spawn(PlayTimeline, Timeline)
				end
			end
		end
	end
end)

local Debounces = {}
local DebounceTickListener = {}
--Extra Timeline Listeners
local AllObjects = script.Parent:GetDescendants()
for _, Timeline in pairs(Timelines:GetDescendants()) do
	if ValidateIsTimeline(Timeline) then
		local TimelineTrigger, ButtonTrigger, TouchTrigger, DelayTrigger, LocalTrigger_Touch =
			Timeline:GetAttribute("Trigger_Timeline"),
			Timeline:GetAttribute("Trigger_Button"),
			Timeline:GetAttribute("Trigger_Touch"),
			Timeline:GetAttribute("Trigger_Delay"),
			Timeline:GetAttribute("LocalTrigger_Touch")
		local Touch_Debounce = Timeline:GetAttribute("Touch_Debounce")
		local otherTouchThing = Timeline:GetAttribute("MultipleTouches")
		if typeof(Touch_Debounce) == "number" and Touch_Debounce ~= nil then
			Debounces[Timeline] = Touch_Debounce
			DebounceTickListener[Timeline] = tick()
		elseif otherTouchThing ~= nil then
			Debounces[Timeline] = 0
			DebounceTickListener[Timeline] = tick()
		end
		if (typeof(TouchTrigger) == "string" and TouchTrigger ~= "") or (typeof(LocalTrigger_Touch) == "string" and LocalTrigger_Touch ~= "") then
			local AllowedToRun = true
			local IsClient = false
			if LocalTrigger_Touch ~= nil then
				IsClient = true
			end
			if typeof(TimelineTrigger) == "string" and TimelineTrigger ~= "" then
				AllowedToRun = false
			end
			if typeof(ButtonTrigger) == "number" and ButtonTrigger > 0 then
				AllowedToRun = false
			end
			if AllowedToRun == true and IsClient == false then
				local TouchListenerCount = 0
				local MaxTouchListeners = 10
				local PlayerDebounce = {}
				local TouchedOnce = false
				local TouchAllowMultiple = Timeline:GetAttribute("Touch_AllowMultiple")
				for _, Object in pairs(AllObjects) do
					if Object:IsA("BasePart") and Object.Name == TouchTrigger then
						if TouchListenerCount < MaxTouchListeners then
							TouchListenerCount += 1
							Object.Touched:Connect(function(hit)
								if (TouchedOnce == false or Debounces[Timeline] ~= nil and DebounceTickListener[Timeline] ~= nil) then
									local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
									if Player == nil then
										return
									end
									if Player and not PlayerDebounce[tostring(Player.UserId)] or (Debounces[Timeline] ~= nil and DebounceTickListener[Timeline] ~= nil and tick() - DebounceTickListener[Timeline] >= Debounces[Timeline]) then
										PlayerDebounce[tostring(Player.UserId)] = true
										TouchedOnce = true
										Debounces[Timeline] = Touch_Debounce
										DebounceTickListener[Timeline] = tick()
										task.spawn(PlayTimeline, Timeline, TouchAllowMultiple and Player)
									end
								end
							end)
						end
					end
				end
			end
			if AllowedToRun == true and IsClient == true then
				local TouchListenerCount = 0
				local MaxTouchListeners = 10
				local PlayerDebounce = {}
				local TouchedOnce = false
				local TouchAllowMultiple = Timeline:GetAttribute("Touch_AllowMultiple")
				for _, Object in pairs(AllObjects) do
					if Object:IsA("BasePart") and Object.Name == LocalTrigger_Touch then
						if TouchListenerCount < MaxTouchListeners then
							TouchListenerCount += 1
							Object.Touched:Connect(function(hit)
								local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
								if Player == nil then
									return
								end
								if Player ~= nil and (Debounces[Timeline] ~= nil and DebounceTickListener[Timeline] ~= nil and tick() - DebounceTickListener[Timeline] >= Debounces[Timeline]) then
									PlayerDebounce[tostring(Player.UserId)] = true
									TouchedOnce = true
									Debounces[Timeline] = Touch_Debounce
									DebounceTickListener[Timeline] = tick()
									--task.spawn(PlayTimeline, Timeline, TouchAllowMultiple and Player)
									local part = Timeline:Clone()
									part.Parent = Object
									if part:FindFirstChildWhichIsA("ObjectValue"):FindFirstChild("Conditional_Timeline") then
										local Con = part:FindFirstChildWhichIsA("ObjectValue").Conditional_Timeline.Value:Clone()
										Con.Parent = Object
										part:FindFirstChildWhichIsA("ObjectValue").Conditional_Timeline.Value = Con
									end
									game.ReplicatedStorage.Remote.TimelineEvents.ClientTouched:FireClient(Player, part)
								end
							end)
						end
					end
				end	
			end
		else
			if typeof(DelayTrigger) == "number" then
				local AllowedToRun = true
				local IsCon = false
				for index, item in pairs(Timelines:GetDescendants()) do
					if item:IsA("ObjectValue") and item.Name == "Conditional_Timeline" and item.Value == Timeline then
						IsCon = true
					end
				end
				if typeof(TimelineTrigger) == "string" and TimelineTrigger ~= "" then
					AllowedToRun = false
				end
				if typeof(ButtonTrigger) == "number" and ButtonTrigger > 0 then
					AllowedToRun = false
				end
				if typeof(TouchTrigger) == "string" and TouchTrigger ~= "" then
					AllowedToRun = false
				end
				if AllowedToRun == true and IsCon == false then
					task.spawn(PlayTimeline, Timeline)
				end
			end
		end
	end
end