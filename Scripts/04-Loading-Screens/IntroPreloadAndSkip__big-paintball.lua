-- Reference copy for study. Game: BIG Paintball! Classic (big-paintball)
-- Original: ReplicatedFirst/Intro/Intro.client.luau  (client, 501 lines)
-- Categories: loading-screen 27.5, ui-animation 13.8
-- What it does: Well-commented intro: removes default screen, hides core UI, preloads logo + intro sound with a 2 s cap, logo pop-in tween, loading dots, save confirmation, ban/warning notice, skip support, then restores game GUIs.

--[[

	Re-designed late November 2020 by Preston
	
	The loading sequence and intro animation. Preloads assets, confirms save, displays ban timers, and has a cute little animation.
	
	The goal here VS the original intro is:
		- Faster (get into the game as QUICK as POSSIBLE)
		- Cleaner
		- Make use of GUIs instead of 3D objects
		- Scale across all resolutions/devices (ie. button sizes, text size)
		- Display bans/warnings
		- Little text as possible (avoiding localization)
		- Removal of acronyms
		
--]]


--- Settings
local _AUTOSKIP = false --- Skip the intro during real sessions
local _STUDIOSKIP = false --- Skip the intro during studio sessions

--- References
local runService = game:GetService("RunService")
local contentProvider = game:GetService("ContentProvider")
local isStudio = runService:IsStudio()
local _SKIP = (isStudio and _STUDIOSKIP or _AUTOSKIP)

--- Variables
local done = false
local playerGui
local sound
local gui
local gameGuis = {}
local _L
--
local frame
local logo
local dots
local fade
local enabledSkip = false
local skipUsed = false

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function Init()
	--- Remove default loading screen
	game.ReplicatedFirst:RemoveDefaultLoadingScreen()
	
	--- Change core GUI properties (remove topbar, chat, etc.)
	playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	playerGui:SetTopbarTransparency(0)
	game.StarterGui:SetCoreGuiEnabled("All", false)
	HideGameInterface()

	--- Deploy gui
	gui = script.Parent:WaitForChild("IntroGui")
	gui.Name = "__INTRO"
	gui.Parent = ((not _SKIP) and playerGui or nil)

	--- Wait for intro audio
	sound = script.Parent:WaitForChild("IntroSound")

	--- Wait for gui children
	frame = gui:WaitForChild("Frame")
	logo = frame:WaitForChild("Logo")
	dots = frame:WaitForChild("Dots")
	fade = frame:WaitForChild("Fade")

	--- Preload gui assets (and yield until done so)
	local loadSuccess = {}
	contentProvider:PreloadAsync({sound.SoundId, logo.Image}, function(id, status)
		table.insert(loadSuccess, {id, Enum.AssetFetchStatus.Success == status})
	end)

	local _t = tick()
	while (#loadSuccess < 2) and (tick() - _t < 2) do  runService.RenderStepped:Wait()  end --- max 2 seconds
	if #loadSuccess < 2 then
		warn("Intro error #2: Time exceeded for intro assets preload")
	end
end


function Intro()
	local function PlaySound()
		sound:Play()
	end

	--- Logo pop in
	local function LogoPopIn()
		local goalSize = logo.Size
		local startSize = UDim2.new(goalSize.X.Scale * 0.6, goalSize.X.Offset * 0.6, goalSize.Y.Scale * 0.6, goalSize.Y.Offset * 0.6)
		logo.ImageTransparency = 0.2
		logo.Size = startSize
		logo.Visible = true

		FastTween(logo, {Size = goalSize, ImageTransparency = 0}, {0.66, "Back", "Out"})
	end

	--- Loading dots pop in
	local function DotsPopIn()
		local goalPos = dots.Position
		dots.Position = UDim2.new(goalPos.X.Scale, goalPos.X.Offset, goalPos.Y.Scale + 0.05, goalPos.Y.Offset)
		dots.Visible = true

		FastTween(dots, {Position = goalPos}, {0.8, "Expo", "Out"})
	end


	PlaySound()
	LogoPopIn()
	DotsPopIn()
end


function Load()
	--[[
		
		Loading has 5 unique stages
		
		Stage 1:
			Wait for game:IsLoaded to return true (capped at waiting 1 second)
			
		Stage 2:
			Wait for character to load
			
		Stage 3:
			Wait for assets (skippable)
		
		Stage 4:
			Wait for player's save (or ban status)
		
		Stage 5:
			Wait for _L (framework init)
		
	--]]

	----------------------------------------------------------------

	local function Stage1()
		--- Wait for game to init (max yield is 1 second)
		local _t = tick()
		while not game:IsLoaded() and (tick() - _t < 1) do  runService.RenderStepped:Wait()  end
		if not game:IsLoaded() then
			warn("Intro error #1: Time exceeded for IsLoaded()")
		end
	end


	local function Stage2()
		local player = game.Players.LocalPlayer
		while ((not player) or (not player.Character) or (not player.Character:FindFirstChild("Humanoid"))) do
			runService.RenderStepped:Wait()
			print("Testing Stage 2")

		end
	end


	local function Stage3()
		if _SKIP then
			return
		end

		--- Skip button (if assets are taking too long to load)
		local skip = frame:WaitForChild("Skip")

		local function HideSkipButton()
			skipUsed = true
			FastTween(dots, {Position = UDim2.new(0.5, 0, 0.8, -5)}, {0.5, "Sine", "InOut"})
			skip.Visible = false
		end

		local function SkipButton()
			enabledSkip = true

			local cacheSize = skip.Size
			skip.Size = UDim2.new(skip.Size.X.Scale * 0.7, skip.Size.X.Offset * 0.7, skip.Size.Y.Scale * 0.7, skip.Size.Y.Offset * 0.7)
			skip.Visible = true
			FastTween(dots, {Position = UDim2.new(0.5, 0, 0.78, -15)}, {0.3, "Sine", "Out"})
			FastTween(skip, {Size = cacheSize}, {0.6, "Back", "Out"})
			print("Testing Stage 3")

			skip.MouseButton1Up:Connect(function()
				if not skipUsed then
					HideSkipButton()
				end
			end)
		end

		--- Load assets
		local _t = tick()
		local loadedAssets = false
		coroutine.wrap(function()
			pcall(function()
				--game:GetService("ContentProvider"):PreloadAsync({game.StarterGui, game.ReplicatedStorage, game.Workspace})
				loadedAssets = true
			end)
		end)()
		while (not loadedAssets) and (tick() - _t <= 10) and (not skipUsed) do
			if tick() - _t >= 3.5 and (not enabledSkip) then
				SkipButton()
			end
			runService.RenderStepped:Wait()
		end

		if enabledSkip and (not skipUsed) then
			HideSkipButton()
		end
	end

	local function Stage4()
		local saveWaitTick = tick()
		local confirmedSave, isBanned, bannedTimer
		local remote = game.Workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES"):WaitForChild("INTRO")

		--- Wait for save
		while (not confirmedSave) and (tick() - saveWaitTick) < 60 do
			--- Ask server if save is confirmed loaded
			confirmedSave, isBanned, bannedTimer = remote:InvokeServer(true)

			if isBanned then
				print("Player is banned")
				Banned(bannedTimer)
				return
			end

			--- Retry
			if not confirmedSave then
				print("Save not confirmed, retrying..")
				wait(0.5)
			end
		end

		if not confirmedSave then
			print("Save cannot be loaded, showing rejoin error.")
			Error()
			return
		end
		--Banned("Forever")
		print("Done with Stage 4")
	end



	local function Stage5()
		print("Starting Stage 5")
		local showingNotice = false
		local function ShowNotice()
			showingNotice = true
		end

		--- add back core gui
		game.StarterGui:SetCoreGuiEnabled("All", true)

		_G.IntroDone = true
		_L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
		print("Requiring Library")
		local _t = tick()
		while ( not _L.Loaded) do -- <-- there was a "not" near _L.Loaded
			if (not showingNotice) and (tick() - _t) >= 3 then
				print("Trying to show notice despite already having it at Stage 5")
				ShowNotice()
			end
			runService.RenderStepped:Wait()
		end
		print("Completed Stage 5")
	end

	----------------------------------------------------------------

	--- The little loading dots :)

	local stage = 0

	local function DotAnimation()
		local localStage = stage
		local dot = dots:FindFirstChild(stage + 1)
		coroutine.wrap(function()
			wait()
			while (stage == localStage and (not done)) do
				dot.Position = UDim2.new(dot.Position.X.Scale, dot.Position.X.Offset, math.sin(tick()*15)*0.1, 0)
				runService.RenderStepped:Wait()
			end
			FastTween(dot, {Position = UDim2.new(dot.Position.X.Scale, dot.Position.X.Offset, 0, 0)}, {0.2, "Sine", "Out"})
		end)()
	end

	local function AddDot()
		if _SKIP then
			return
		end

		stage += 1

		local dot = dots:FindFirstChild(stage)
		FastTween(dot, {BackgroundColor3 = Color3.fromRGB(253, 169, 33)}, {0.3, "Expo", "Out"})

		if stage <= 4 then
			DotAnimation()
		end
	end

	DotAnimation()

	----------------------------------------------------------------

	Stage1()  if done then return end  AddDot()
	Stage2()  if done then return end  AddDot()
	Stage3()  if done then return end  AddDot()
	Stage4()  if done then return end  AddDot()
	Stage5()  if done then return end  AddDot()
end


function ShowMessage()
	local notice = frame:WaitForChild("Notice")
	notice:WaitForChild("Frame")

	--- fade out the intro screen
	fade.Visible = true
	local tween = FastTween(fade, {Position = UDim2.new(0, 0, 0, 0)}, {0.7, "Linear"})
	tween.Completed:Wait()

	wait(.5) --- dramatic pause!!

	dots.Visible = false
	logo.Visible = false
	notice.Visible = true
	FastTween(fade, {Position = UDim2.new(0, 0, 1, 0)}, {0.7, "Linear"})

	return notice
end


function Error()
	done = true

	local notice = ShowMessage()
	notice.Frame.Button.Visible = true
	notice.Frame.Desc.Text = "An unknown error has occurred. Do you want to try re-joining?"
	notice.Frame.TimeLeft.Visible = false
	notice.Frame.Title.Text = "Error"

	local deb = false
	notice.Frame.Button.MouseButton1Down:Connect(function()
		if not deb then
			deb = true
			game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) --- force player to re-join
			deb = false
		end
	end)
end


function Banned(timer)
	done = true

	local notice = ShowMessage()
	notice.Frame.Button.Visible = false
	notice.Frame.Desc.Text = "You've been banned from playing on this account. If you believe this was an accident, appeal on our Discord."
	notice.Frame.TimeLeft.Visible = true
	notice.Frame.TimeLeft.Text = "Time Left: " .. (timer or "Forever")
	notice.Frame.Title.Text = "Banned"
end



function Revert()
	done = true

	for _, v in ipairs(gameGuis) do
		v.Enabled = true
	end

	--- fade out the intro screen
	fade.Visible = true
	local tween = FastTween(fade, {Position = UDim2.new(0, 0, 0, 0)}, {0.7, "Linear"})
	tween.Completed:Wait()

	--- bye bye + cleanup
	local tween = FastTween(frame, {Position = UDim2.new(0.5, 0, -2, 0)}, {1, "Quad", "Out"})
	tween.Completed:Wait()
	gui:Destroy()
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function HideGameInterface()
	local function Loop()
		for _, v in ipairs(playerGui:GetChildren()) do
			if v.ClassName == "ScreenGui" or v.ClassName == "BillboardGui" or v.ClassName == "SurfaceGui" then
				if v.Enabled and v.Name ~= "__INTRO" then
					table.insert(gameGuis, v)
					v.Enabled = false
				end		
			end
		end
	end

	--- Runs a constant loop looking for game guis and disabling them (while maintaining a cache)
	coroutine.wrap(function()
		while (not done) do
			Loop()
			runService.Heartbeat:Wait()
		end
	end)()
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- Function from _L
function FastTween(_entity, tweenGoals, tweenInfoRaw, delayTime)
	--- Allow for multipule instances
	if type(_entity) ~= "table" then  _entity = {_entity}  end

	--- Variables
	local tweens = {}

	--- iterate through each instance
	for _, entity in ipairs(_entity) do
		if tweenInfoRaw == nil then
			--- No tweenInfo provided. Use the default one!
			tweenInfoRaw = {
				1,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out,
			}
		else
			--- Check (2nd) tween arguments and fix/fill them
			if tweenInfoRaw[2] == nil then
				--- No easing style provided. Use default one!
				tweenInfoRaw[2] = Enum.EasingStyle.Sine

			elseif type(tweenInfoRaw[2]) == "string" then
				--- Easing style provided string not enum. Convert!
				if string.lower(tweenInfoRaw[2]) == "expo" then
					tweenInfoRaw[2] = Enum.EasingStyle.Exponential
				else
					tweenInfoRaw[2] = Enum.EasingStyle[tweenInfoRaw[2]]
				end
			end

			--- Check (3rd) tween arguments and fix/fill them
			if tweenInfoRaw[3] == nil then
				--- No easing direction provided. Use default one!
				tweenInfoRaw[3] = Enum.EasingDirection.InOut

			elseif type(tweenInfoRaw[3]) == "string" then
				--- Easing direction provided string not enum. Convert!
				tweenInfoRaw[3] = Enum.EasingDirection[tweenInfoRaw[3]]
			end
		end

		--- Create tween
		local tweenInfo = TweenInfo.new(unpack(tweenInfoRaw))
		local tweenGoals = tweenGoals
		local tween = game:GetService("TweenService"):Create(entity, tweenInfo, tweenGoals)

		coroutine.wrap(function()
			if delayTime then
				wait(delayTime)
			end

			--- Play tween
			tween:Play()
		end)()

		--- Add tween to list of tweens that will be returned
		table.insert(tweens, tween)
	end

	--
	return unpack(tweens)
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Init()

if not _SKIP then
	Intro()
end

Load()

if not done then
	Revert()
end
