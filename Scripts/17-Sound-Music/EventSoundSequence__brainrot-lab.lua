-- Reference copy for study. Game: Brainrot Lab (brainrot-lab)
-- Original: StarterPlayer/StarterPlayerScripts/EventSoundHandler.client.lua
-- What it does: Server-triggered event stingers: plays a sequence of named sounds one after another (waiting on Ended) and syncs a full-screen white flash to one of them, using a token so overlapping flashes cancel cleanly.

--!strict
-- LOCATION: StarterPlayer/StarterPlayerScripts/EventSoundHandler
-- Client-side handler that plays event sound sequences for all players
-- Also triggers a smooth white flash transition when "Estalo" plays

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Get the sounds folder and remote
local soundsFolder = ReplicatedStorage:FindFirstChild("Eventos Sounds")
local eventRemotes = ReplicatedStorage:FindFirstChild("EventRemotes")

if not soundsFolder then
	warn("[EventSoundHandler] 'Eventos Sounds' folder not found in ReplicatedStorage")
	return
end

if not eventRemotes then
	warn("[EventSoundHandler] 'EventRemotes' folder not found in ReplicatedStorage")
	return
end

local playSoundRemote = eventRemotes:FindFirstChild("PlayEventSounds")
if not playSoundRemote then
	warn("[EventSoundHandler] 'PlayEventSounds' RemoteEvent not found")
	return
end

-- Create a local container for playing sounds
local soundContainer = Instance.new("Folder")
soundContainer.Name = "EventSoundPlayer"
soundContainer.Parent = game:GetService("SoundService")

-- Create the flash overlay GUI
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local flashGui = Instance.new("ScreenGui")
flashGui.Name = "EventFlashTransition"
flashGui.IgnoreGuiInset = true
flashGui.ResetOnSpawn = false
flashGui.DisplayOrder = 100
flashGui.Parent = playerGui

local flashFrame = Instance.new("Frame")
flashFrame.Name = "Flash"
flashFrame.Size = UDim2.fromScale(1, 1)
flashFrame.Position = UDim2.fromScale(0.5, 0.5)
flashFrame.AnchorPoint = Vector2.new(0.5, 0.5)
flashFrame.BackgroundColor3 = Color3.new(1, 1, 1)
flashFrame.BackgroundTransparency = 1
flashFrame.BorderSizePixel = 0
flashFrame.Parent = flashGui

-- Track active flash so we can cancel overlapping ones
local flashToken = 0

-- Play the white flash transition (~1 second total)
local function playFlash()
	flashToken += 1
	local myToken = flashToken

	-- Reset to fully transparent
	flashFrame.BackgroundTransparency = 1

	-- Fade in: 1 -> 0.15 over 0.25s
	local fadeIn = TweenService:Create(flashFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0.15 })
	fadeIn:Play()
	fadeIn.Completed:Wait()

	-- If a newer flash started, abort this one
	if myToken ~= flashToken then return end

	-- Hold briefly
	task.wait(0.25)

	if myToken ~= flashToken then return end

	-- Fade out: 0.15 -> 1 over 0.5s
	local fadeOut = TweenService:Create(flashFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { BackgroundTransparency = 1 })
	fadeOut:Play()
	fadeOut.Completed:Wait()

	-- Ensure fully transparent at the end
	flashFrame.BackgroundTransparency = 1
end

-- Helper: clone and play a sound by name, wait for it to finish
local function playSoundByName(soundName: string)
	local template = soundsFolder:FindFirstChild(soundName)
	if not template or not template:IsA("Sound") then
		warn("[EventSoundHandler] Sound not found: " .. soundName)
		return
	end

	local sound = template:Clone()
	sound.Parent = soundContainer
	sound:Play()

	-- Wait for the sound to finish
	sound.Ended:Wait()
	sound:Destroy()
end

-- Helper: play a sequence of sounds in order, with flash on "Estalo"
local function playSoundSequenceWithFlash(soundNames: {string})
	for _, name in ipairs(soundNames) do
		if name == "Estalo" then
			-- Trigger flash and play Estalo simultaneously
			task.spawn(playFlash)
			playSoundByName(name)
		else
			playSoundByName(name)
		end
	end
end

-- Listen for sound events from the server
playSoundRemote.OnClientEvent:Connect(function(eventKey: string, phase: string)
	if phase == "start" then
		if eventKey == "Aura Infinita" then
			-- Aura Infinita: play "Evento Aura Infinita" then "Estalo" (with flash)
			task.spawn(function()
				playSoundSequenceWithFlash({"Evento Aura Infinita", "Estalo"})
			end)
		else
			-- Other events: play "Todos eventos" then "Estalo" (with flash)
			task.spawn(function()
				playSoundSequenceWithFlash({"Todos eventos", "Estalo"})
			end)
		end
	elseif phase == "end" then
		-- End of any event: play "Estalo" (with flash)
		task.spawn(function()
			task.spawn(playFlash)
			playSoundByName("Estalo")
		end)
	end
end)

print("[EventSoundHandler] Initialized and listening for event sounds")