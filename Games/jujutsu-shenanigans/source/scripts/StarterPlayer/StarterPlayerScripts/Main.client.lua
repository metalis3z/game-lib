--!nolint

local TouchGui: ScreenGui
local loadStart = tick()

local Player = game.Players.LocalPlayer


Player:WaitForChild('LoadedData')


--// Services \\--

local MarketService = game.MarketplaceService
local RNS = game["Run Service"]
local StarterGui = game.StarterGui
local UIS = game.UserInputService
local RS = game.ReplicatedStorage



--// Variables \\--

local Punching = false
local Blocking = false



--// Remotes \\--

local Remotes = RS.Remotes


local ComRemotes = Remotes.Comunicator

local Comunicator = ComRemotes.Set
local Getter = ComRemotes.Get


local PSE = Remotes.Commands.Set


local CombatRemotes = Remotes.Combat

local CombatSet = CombatRemotes.Set
local CombatGet = CombatRemotes.Get



--// Modules \\--

local RPModules = RS.Modules

local DestroyAmbient = require(RPModules.DestroyAmbient)

--// Player \\--

local gameSettings = UserSettings().GameSettings

local Mouse = Player:GetMouse()

local TouchControlFrame: Frame
local JumpButton: ImageButton
local PunchButton: ImageButton
local DashButton: ImageButton
local BlockButton: ImageButton
local SpecialButton: ImageButton
local ConfigFolder = Player:FindFirstChild('Configuration') or Player:WaitForChild('Configuration', 10)
local ShiftlockConfig: BoolValue = ConfigFolder:FindFirstChild('Shiftlock') or ConfigFolder:WaitForChild('Shiftlock', 10)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local Camera = workspace.CurrentCamera


local PSCfgFolder = Player:FindFirstChild('Commands') or Player:WaitForChild('Commands', 10)
local Cons = {}


shared.IsConsole = UIS.GamepadEnabled == true
shared.IsMobile = UIS.TouchEnabled == true


local PlayerGui = Player.PlayerGui

local EmoteWheel = PlayerGui:WaitForChild('Emotes', 5):WaitForChild('ImageLabel', 5)
local settingsmenus = PlayerGui:WaitForChild('Menus', 5).Settings
local Psmenus = PlayerGui:WaitForChild('Menus', 5).Private
local Shp = PlayerGui:WaitForChild('Menus', 5):WaitForChild('Shop', 5)
local CosmeticsMenu = PlayerGui:WaitForChild('Cosmetics', 5):WaitForChild('Frame', 5)
local AnnouncementGui = script:FindFirstChild('Announcement') or script:WaitForChild('Announcement', 5)


local function Shiftlock()
	if not Character:HasTag('CantRotate') then
		Humanoid.AutoRotate = false
		HumRP.CFrame = CFrame.new(HumRP.Position, Vector3.new(Camera.CFrame.LookVector.X * 900000, HumRP.Position.Y, Camera.CFrame.LookVector.Z * 900000))
		Camera.CFrame = Camera.CFrame * CFrame.new(1.75, 0 ,0)
	end
end

local lastShiftlock
if shared.IsConsole or shared.IsMobile then
	lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
end


Player:GetPropertyChangedSignal('Character'):Connect(function()
	Punching, Blocking = false, false

	if not Player or not Player.Parent then return end

	Character = Player.Character

	if not Character or not Character.Parent then Player.CharacterAdded:Wait() end

	Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
	HumRP = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)


	if lastShiftlock then
		lastShiftlock:Disconnect()
		lastShiftlock = nil
	end

	if shared.IsConsole or shared.IsMobile then
		lastShiftlock = RNS.RenderStepped:Connect(Shiftlock)
	end
end)

workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function()
	Camera = workspace.CurrentCamera
end)



--// Configuration \\--

local ClickSound = script.Click
local GreenSquareId, RedSquareId, notBoolId = 12343172777, 12343172715, 14795471064
local TogglesYScale = .35

local LiveOParams = OverlapParams.new()
LiveOParams.FilterType = Enum.RaycastFilterType.Include
LiveOParams.FilterDescendantsInstances = { workspace.Live }

local MapRParams = RaycastParams.new()
MapRParams.FilterType = Enum.RaycastFilterType.Include
MapRParams.FilterDescendantsInstances = { workspace.Map }
MapRParams.RespectCanCollide = true



--// Functions \\--

local function getPSBoolImg(ConfigName)
	if PSCfgFolder[ConfigName].Value then
		return GreenSquareId
	else
		return RedSquareId
	end
end

local function getConfigValue(ConfigName)
	return PSCfgFolder[ConfigName].Value
end

local function SpawnHitbox(Params)
	if RNS:IsStudio() then
		task.spawn(function()
			local HitboxVisualizer = RS.Assets.Effects.Hitbox:Clone()
			HitboxVisualizer.Parent = workspace.Thrown
			HitboxVisualizer.Size = Params.Size
			HitboxVisualizer.CFrame = Params.Instance.CFrame * Params.Offset
			game.Debris:AddItem(HitboxVisualizer, .1)
		end)
	end
end

local function Hitbox(Params)
	local returnValue = nil

	SpawnHitbox(Params)

	local hitparts = workspace:GetPartBoundsInBox(Params.Instance.CFrame * Params.Offset, Params.Size, LiveOParams)
	if #hitparts > 0 then
		for i, Part: Part? in hitparts do
			if Part and Part.Parent and Part.Parent ~= Character and Part.Parent:FindFirstChild('Humanoid') and Part.Parent.Humanoid.Health > 0 then
				if Params.Method == 'Single' then
					returnValue = Part.Parent
				else
					if returnValue == nil then
						returnValue = { [Part.Parent] = Part.Parent }
					else
						if returnValue[Part.Parent] == nil then
							returnValue[Part.Parent] = Part.Parent
						end
					end
				end
			end
		end
	end

	return returnValue
end

local function raycast(origin, direction)
	return workspace:Raycast(origin, direction, MapRParams)
end

local function CheckDownslam()
	if raycast(HumRP.Position, Vector3.new(0,-4,0), MapRParams) then
		return false
	else
		return true
	end
end

local function checkCharacterAvailability()
	return Character ~= nil and Character.Parent ~= nil and HumRP ~= nil and HumRP.Parent ~= nil and Humanoid ~= nil and Humanoid.Parent ~= nil and Humanoid.Health > 0 and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead
end

local function Punch()
	if not HumRP:FindFirstChild('ThrowableWeld') then
		local ThrowableDetected = false

		local hitparts = workspace:GetPartBoundsInBox(HumRP.CFrame * CFrame.new(0, 0, -3.5), Vector3.new(1, 1, 1) * 7, Oparams)
		if #hitparts > 0 then
			for _, Part: Part in hitparts do
				if Part and Part:HasTag('Throwable') then
					ThrowableDetected = true

					Part.CanCollide = false
					task.delay(1.517, function()
						Part.CanCollide = true
					end)

					CombatSet:FireServer('Throwable', { Stage = 'Grab', Throwable = Part })

					break
				end
			end
		end

		if ThrowableDetected == false then
			Punching = true
		end
	else
		CombatSet:FireServer('Throwable', { Stage = 'Throw' })
	end
end

local function Special()
	if not Character or not Character.Parent or not HumRP or not HumRP.Parent then return end
	
	local CurrentMoveset = Player.Configuration.Moveset.Value
	local CharacterFold = script.Character
	
	local AbilitiesHandlerFolder = Remotes.AbilitiesHandler
	
	--local tool : Tool = CharacterFold[CurrentMoveset]:FindFirstChildOfClass('Tool')

	local AbilitieRemote_Set = AbilitiesHandlerFolder.Set
	local AbilitieRemote_Get = AbilitiesHandlerFolder.Get
	
	if Player:WaitForChild("Moveset"):FindFirstChild(CurrentMoveset) then
		AbilitieRemote_Get:InvokeServer(CurrentMoveset)
	else
		--AbilitieRemote_Get:InvokeServer()
	end
end

local function DashCheck()
	if not Character or not Character.Parent or not HumRP or not HumRP.Parent then return end

	local moveDirection = Camera.CFrame:VectorToObjectSpace(Humanoid.MoveDirection)

	local left = math.round(moveDirection.X) == -1
	local right = math.round(moveDirection.X) == 1
	local front = math.round(moveDirection.Z) == -1
	local back = math.round(moveDirection.Z) == 1

	local currDirection

	if front then
		currDirection = 'Front'
	elseif back then
		currDirection = 'Back'
	elseif left then
		currDirection = 'Left'
	elseif right then
		currDirection = 'Right'
	else
		currDirection = 'Front'
	end

	if front or (not left and not right and not back) then
		local DashVelocity = CombatGet:InvokeServer("CheckFrontDash")

		if DashVelocity ~= nil and DashVelocity ~= false then
			for _,Velocity in pairs(HumRP:GetChildren()) do
				if Velocity:IsA('BodyVelocity') and Velocity ~= DashVelocity then
					Velocity:Destroy()
				end
			end

			returnValue = Instance.new("BodyVelocity")
			returnValue.P = math.huge
			returnValue.MaxForce = Vector3.new(math.huge, 0, math.huge)
			returnValue.Parent = HumRP
			task.delay(0.7,function()
				returnValue:Destroy()
			end)

			task.spawn(function()
				shared.addshake(1)
			end)

			local Speed = 120

			local stopLoop = nil
			local stopDashConnection = nil

			local function stopDash()
				if stopDashConnection then
					stopDashConnection:Disconnect()
					stopDashConnection = nil
				end

				if stopLoop then
					stopLoop()
					stopLoop = nil
				end

				if returnValue then
					returnValue:Destroy()
					returnValue = nil
				end
			end


			stopDashConnection = Remotes.Combat.Set.OnClientEvent:Connect(function(Parameters)
				local Request = Parameters.Request

				if Request == "StopFrontDash" then
					stopDash()
				end
			end)

			stopLoop = shared.loop(function()
				if returnValue and returnValue.Parent then
					Speed *= 0.95
					returnValue.Velocity = HumRP.CFrame.LookVector * Speed
					gameSettings.RotationType = Enum.RotationType.CameraRelative
				else
					stopDash()
					gameSettings.RotationType = Enum.RotationType.MovementRelative
				end
			end)
		end

	elseif (left or right) and (not back) then
		local DashVelocity = CombatGet:InvokeServer('CheckSideDash', currDirection)

		if DashVelocity ~= nil and DashVelocity ~= false and not Character:HasTag("UsingBack") and not Character:HasTag("CantSideDash") then
			for _,BodyVelocity : BodyVelocity in pairs(HumRP:GetChildren()) do
				if BodyVelocity:IsA('BodyVelocity') and BodyVelocity ~= DashVelocity then
					BodyVelocity:Destroy()
				end
			end
			for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
				v:Stop()
			end
			local DashAnim = script:FindFirstChild("Dash".. currDirection)

			if DashAnim then
				local DashTrack = Humanoid.Animator:LoadAnimation(DashAnim)

				DashTrack:Play()
			end
			returnValue = Instance.new('BodyVelocity')
			returnValue.MaxForce = Vector3.new(math.huge, 0, math.huge)
			returnValue.P = math.huge
			returnValue.Parent = HumRP
			task.delay(0.485,function()
				returnValue:Destroy()
			end)


			local Rotation = 90
			local Speed = 180

			if right then
				Rotation = -90
			else
				Rotation = 90
			end

			local stopLoop = nil
			stopLoop = shared.loop(function()
				if Speed > 5 and returnValue and returnValue.Parent then
					Speed *= 0.91

					local LookVector = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
					HumRP.CFrame = CFrame.lookAlong(HumRP.Position, LookVector)
					returnValue.Velocity = (CFrame.lookAlong(HumRP.Position, LookVector) * CFrame.Angles(0, math.rad(Rotation), 0)).LookVector * Speed
				else
					stopLoop()
				end
			end)
		end

	elseif back and (not left and not right) then
		local DashVelocity = CombatGet:InvokeServer('CheckBackDash')
		Character:AddTag('UsingBack')
		if DashVelocity ~= nil and DashVelocity ~= false then
			for _,BodyVelocity : BodyVelocity in pairs(HumRP:GetChildren()) do
				if BodyVelocity:IsA('BodyVelocity') and BodyVelocity ~= DashVelocity then
					BodyVelocity:Destroy()
				end
			end

			Character:AddTag("CantPunch")

			local DashAnim = script:FindFirstChild("DashBack")

			if DashAnim then
				local DashTrack = Humanoid.Animator:LoadAnimation(DashAnim)

				DashTrack:Play()
				DashTrack.Stopped:Once(function()
					Character:RemoveTag("CantPunch")
				end)				
			end

			returnValue = Instance.new('BodyVelocity')
			returnValue.P = math.huge
			returnValue.MaxForce = Vector3.new(math.huge, 0, math.huge)
			returnValue.Parent = HumRP
			task.delay(1.017,function()
				returnValue:Destroy()
				Character:RemoveTag('UsingBack')
			end)

			task.spawn(function()
				shared.repfire('RockTrail', { parent = HumRP, size = .5, side = 2, t = 3, height = 5, spawnrate = .1, duration = .4 })
			end)



			local Rotation = 180
			local Speed = 150
			local BackSpeed = 150

			local stopLoop = nil
			stopLoop = shared.loop(function()
				if returnValue and returnValue.Parent then
					Speed *= 0.91

					if Speed <= 10 then
						if BackSpeed then
							Speed = (BackSpeed or 0) * 0.75
							BackSpeed = nil
						else
							DashVelocity = nil
						end
					end

					local LookVector = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
					HumRP.CFrame = CFrame.lookAlong(HumRP.Position, LookVector)
					returnValue.Velocity = (CFrame.lookAlong(HumRP.Position, LookVector) * CFrame.Angles(0, math.rad(Rotation), 0)).LookVector * Speed
				else
					stopLoop()
				end
			end)
		end
	end
end

local function getBoolConfigLabel(ConfigName)
	local ConfigObj: BoolValue = ConfigFolder:FindFirstChild(ConfigName)

	if ConfigObj then
		if ConfigObj.Value == true then
			return GreenSquareId
		else
			return RedSquareId
		end
	end
end


--// icons \\--
task.delay(1, function()
	StarterGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor

	local isNewUI = game:GetService("GuiService").TopbarInset.Max.Y > 51
	local IconModule = RPModules['Icon']

	local Icon = require(IconModule)


	local CharactersIcon = Icon.new(true)
	CharactersIcon:setName("Characters")
	CharactersIcon:autoDeselect(true)
	CharactersIcon:setLabel("Characters")
	CharactersIcon:setImage(7992557358)
	CharactersIcon:bindEvent('selected', function(icon)

	end)
	CharactersIcon:bindEvent('deselected', function()

	end)

	local MovesetIcons = {}
	local sortedMovesetIcons = {
		Public = {},
		EarlyAccess = {},
		AdminOnly = {},
		OverPowerOnly = {}
	}
	for Name, Info in game.HttpService:JSONDecode(Player:GetAttribute('Characters')) do
		local Order = tonumber(Info.order)
		local imageId = tonumber(Info.icon)
		local isAdmin = Info.isAdmin
		local isOwerpowered = Info.overpowered
		local isEA = Info.isEA
		local Icon = Icon.new()
		task.spawn(function()
			Icon:setLabel(Name)
			Icon:setName(Name)
			Icon:setOrder(Order)
			Icon:setCornerRadius(0, 0, 'deselected')
			Icon:bindEvent("selected", function(icon)
				--ClickSound:Play()
				if not(Character:HasTag('Stunned')) then
					Comunicator:FireServer('SetMoveset', Name)
				end
			end)

			if isAdmin == true then
				sortedMovesetIcons.AdminOnly[Name] = Icon

				--[[Icon:modifyTheme({
					{"IconLabel", "TextColor3", Color3.fromRGB(255, 155, 14)},
				})]]
				
				Icon:modifyTheme({
					{"IconLabel", "TextColor3", Color3.fromRGB(57, 255, 2)},
				})

				if Getter:InvokeServer('CheckAdminChar') ~= true then
					Icon:setEnabled(false)
				end
			elseif isOwerpowered == true then
				sortedMovesetIcons.OverPowerOnly[Name] = Icon
				
				Icon:modifyTheme({
					{"IconLabel", "TextColor3", Color3.fromRGB(255, 155, 14)},
				})
				
				while Character and task.wait(0.35) do
					if Player.Configuration.OverPower.Value == false then
					    Icon:setEnabled(false)
				    else
					    Icon:setEnabled(true)
				    end
				end
				
				
			elseif isEA == true then
				sortedMovesetIcons.EarlyAccess[Name] = Icon

				if not MarketService:UserOwnsGamePassAsync(Player.UserId, shared.Passes['Early Access']) then 
					Icon:setEnabled(false)
				end
			else
				sortedMovesetIcons.Public[Name] = Icon
			end
		end)

		MovesetIcons[Name] = Icon
	end

	CharactersIcon:setDropdown(MovesetIcons)

	local SHIcon = Icon.new(true)
	SHIcon:setName('Shop')
	SHIcon:setLabel("$"..Player:WaitForChild("leaderstats", 2).Hidden.Money.Value)
	SHIcon:setImage(9405933217)
	SHIcon:bindEvent('deselected', function()
		Shp.Visible = false
	end)
	SHIcon:bindEvent('selected', function()
		Shp.Visible = true
	end)

	Player:WaitForChild("leaderstats", 2).Hidden.Money.Changed:Connect(function()
		SHIcon:setLabel("$"..Player:WaitForChild("leaderstats", 2).Hidden.Money.Value)
	end)

	local ConfigIcon = Icon.new(true)
	ConfigIcon:setName("Config")
	ConfigIcon:setImage(3687980595)
	ConfigIcon:bindEvent('selected', function()
		settingsmenus.Visible = true
	end)
	ConfigIcon:bindEvent('deselected', function()
		settingsmenus.Visible = false
	end)

	local EmoteIcon = Icon.new(true)
	EmoteIcon:setName('Emotes')
	EmoteIcon:setImage(11713358131)
	EmoteIcon:bindEvent('deselected', function()
		EmoteWheel.Visible = false
	end)
	EmoteIcon:bindEvent('selected', function()
		EmoteWheel.Visible = true
	end)

	if Getter:InvokeServer('IsPSOwner') == true then
		local privIcon = Icon.new(true)
		privIcon:setName('Private')
		privIcon:setImage(401280105)
		privIcon:bindEvent('deselected', function()
			Psmenus.Visible = false
		end)
		privIcon:bindEvent('selected', function()
			Psmenus.Visible = true
		end)
	end

	Comunicator.OnClientEvent:Connect(function(func, params)
		if func == 'HideAwkbar' then
			shared.triggerAwkbar(false)
		elseif func == 'ShowAwkbar' then
			shared.triggerAwkbar(true)
		elseif func == 'HideHotbar' then
			shared.triggerHotbar(false)

		elseif func == 'ShowHotbar' then
			shared.triggerHotbar(true)

		elseif func == 'ModifyHotbar' then
			for _, Button: Frame in PlayerGui.Hotbar.Hotbar:GetChildren() do
				if not Button:IsA('Frame') then continue end

				if Button.Base.ToolName.Text == params.ToolName then
					local property: TextLabel = Button.Base[params.Property]

					if params.Visible ~= nil then
						property.Visible = params.Visible
					else
						local defaultPropertyValue = property.Text
						local defaultPropertyVisibility = property.Visible

						Button.Base[params.Property].Text = params.Value
						property.Visible = true

						if params.Time then
							task.delay(params.Time, function()
								property.Text = defaultPropertyValue
								property.Visible = defaultPropertyVisibility
							end)
						end
					end
				end
			end

		elseif func == 'HideTopbar' then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

			PlayerGui.TopbarPlus.TopbarContainer.Visible = false

		elseif func == 'ShowTopbar' then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

			PlayerGui.TopbarPlus.TopbarContainer.Visible = true

		elseif func == 'TriggerJump' then
			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, params.Value)
		elseif func == 'GiveAdminChar' then
			for _, Icon in sortedMovesetIcons.AdminOnly do
				Icon:setEnabled(true)
			end

		elseif func == 'RemoveAdminChar' then
			for _, Icon in sortedMovesetIcons.AdminOnly do
				Icon:setEnabled(false)
			end

		elseif func == 'GiveEarlyAccessChar' then
			for _, Icon in sortedMovesetIcons.EarlyAccess do
				Icon:setEnabled(true)
			end

		elseif func == 'RemoveEarlyAccessChar' then
			for _, Icon in sortedMovesetIcons.EarlyAccess do
				Icon:setEnabled(false)
			end

		elseif func == 'SendNotification' then
			script.Noti:Play()
			StarterGui:SetCore('SendNotification', params)

		elseif func == 'Announcement' then
			local Announcement = AnnouncementGui:Clone()
			Announcement.Parent = Player.PlayerGui
			Announcement.Main.Text.Text = params.Msg
			Announcement.Main:TweenPosition(UDim2.fromScale(.5, .5))
			task.delay(10, function()
				Announcement.Main:TweenPosition(UDim2.fromScale(.5, .25))
			end)
			game.Debris:AddItem(Announcement, 10.5)

		elseif func == 'Mute' then
			local HideCount = 0
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
			PlayerGui.Chat.Frame:GetPropertyChangedSignal('Visible'):Connect(function()
				if PlayerGui.Chat.Frame.Visible == true then
					if HideCount == 3 then
						Comunicator:FireServer('Kick', { Msg = 'You were kicked for trying to unmute yourself.' })

						return
					end

					if Player:HasTag('Muted') == true then
						HideCount += 1

						StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
						PlayerGui.Chat.Frame.Visible = false
					end
				end
			end)

		elseif func == 'Unmute' then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

		elseif func == 'AddEmoteSlots' then
			EmoteWheel.Gamepass.Visible = false
			EmoteWheel.GamepassTwo.Visible = true
			for _,v in EmoteWheel.Emotes:GetChildren() do
				if v:HasTag('ExtraSlot') then
					v.Visible = true
				end
			end

		elseif func == 'AddSecondPage' then
			EmoteWheel.Switch.Visible = true

		elseif func == 'CanSpinEmote' then
			EmoteWheel.Spin.Text = '<font color="rgb(255, 255, 255)">CLAIM NEW EMOTE</font>\n<font size="16">PRESS ME!</font>'

		elseif func == 'ChangeKillForEmote' then
			EmoteWheel.Spin.Text = 'NEW EMOTE: <font color="rgb(255, 85, 85)">'..params..' KILLS</font>\n<font size="16">HOLD EMOTE DOWN TO CHANGE</font>'

		end
	end)


	shared.triggerEmoteIcon = function(Value)
		if Value == true then
			EmoteIcon:select()
		else
			EmoteIcon:deselect()
		end
	end

	local shiftlockIcon = configDropdown.Shiftock
	local moveBtnsIcon = configDropdown.MoveBtns
	local resetBtnsIcon = configDropdown.ResetBtns

	local function toggleNonKeyboardIcons()
		local currentValue = UIS.TouchEnabled == true or UIS.GamepadEnabled == true

		shiftlockIcon:setEnabled(currentValue)
		moveBtnsIcon:setEnabled(currentValue)
		resetBtnsIcon:setEnabled(currentValue)
	end

	toggleNonKeyboardIcons()
	UIS:GetPropertyChangedSignal('TouchEnabled'):Connect(function()
		toggleNonKeyboardIcons()

		if UIS.TouchEnabled == false then
			if TouchGui then
				TouchGui.Enabled = false
			end
		end	
	end)

	UIS:GetPropertyChangedSignal('GamepadEnabled'):Connect(function()
		toggleNonKeyboardIcons()

		if UIS.GamepadEnabled == true then
			if TouchGui then
				TouchGui.Enabled = false
			end
		end	
	end)

	UIS:GetPropertyChangedSignal('KeyboardEnabled'):Connect(function()
		toggleNonKeyboardIcons()

		if UIS.KeyboardEnabled == true then
			if TouchGui then
				TouchGui.Enabled = false
			end
		end	
	end)
end)


workspace.Miscellaneous.Donations.a.CanQuery = true
local DonationsHolder = PlayerGui:WaitForChild('Donations')
DonationsHolder:WaitForChild('Small').Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.DonationsProducts["Small"])
end)
DonationsHolder:WaitForChild('Normal').Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.DonationsProducts["Normal"])
end)
DonationsHolder:WaitForChild('Big').Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.DonationsProducts["Big"])
end)
DonationsHolder:WaitForChild('VeryBig').Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.DonationsProducts["VeryBig"])
end)
DonationsHolder:WaitForChild('Huge').Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.DonationsProducts["Huge"])
end)
DonationsHolder:WaitForChild('Mega').Activated:Connect(function()
	MarketService:PromptProductPurchase(Player, shared.DonationsProducts["Mega"])
end)


local Keycodes = Enum.KeyCode
local UserInputTypes = Enum.UserInputType
local selectedFrame = nil
local combatKeybinds = {}

if UIS.KeyboardEnabled == true and UIS.GamepadEnabled == false and UIS.TouchEnabled == false then
	combatKeybinds.Punch = UserInputTypes.MouseButton1
	combatKeybinds.Dash = Keycodes.Q
	combatKeybinds.Block = Keycodes.F
	combatKeybinds.Special = Keycodes.R
elseif UIS.KeyboardEnabled == false and UIS.GamepadEnabled == true and UIS.TouchEnabled == false then
	combatKeybinds.Punch = Keycodes.ButtonB
	combatKeybinds.Dash = Keycodes.ButtonX
	combatKeybinds.Block = Keycodes.ButtonY
	combatKeybinds.Special = Keycodes.DPadLeft
end

UIS.InputBegan:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent and selectedFrame == nil then return end

	if input.UserInputType == combatKeybinds.Punch or input.KeyCode == combatKeybinds.Punch then
		Punch()
	elseif input.KeyCode == combatKeybinds.Dash then
		DashCheck()
	elseif input.KeyCode == combatKeybinds.Block then
		Blocking = true
	elseif input.KeyCode == combatKeybinds.Special then
		Special()
	elseif input.UserInputType == Enum.UserInputType.Touch and selectedFrame ~= nil then
		local lastMousePos = UIS:GetMouseLocation()
		local goalPos: UDim2 = selectedFrame.Position

		inputChanged = UIS.InputChanged:Connect(function(input)
			if not selectedFrame then if inputChanged then inputChanged:Disconnect() inputChanged = nil end return end

			if input.UserInputType == Enum.UserInputType.Touch then
				local MousePos = UIS:GetMouseLocation()

				selectedFrame.Position = UDim2.new(0, MousePos.X - 32, 0, MousePos.Y - 72)
			end
		end)
	elseif input.KeyCode == Enum.KeyCode.B then
		EmoteWheel.Visible = not EmoteWheel.Visible
	end
end)

UIS.InputEnded:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent then return end

	if input.UserInputType == combatKeybinds.Punch or input.KeyCode == combatKeybinds.Punch then
		Punching = false
	elseif input.KeyCode == combatKeybinds.Block then
		Blocking = false

		CombatSet:FireServer('Block', { Stage = false })
	elseif input.UserInputType == Enum.UserInputType.Touch and inputChanged ~= nil then
		inputChanged:Disconnect()
		inputChanged = nil
	end
end)



if UIS.TouchEnabled == true and UIS.GamepadEnabled == false and UIS.KeyboardEnabled == false then
	TouchGui = PlayerGui:FindFirstChild('TouchGui') or PlayerGui:WaitForChild('TouchGui', 10)
	local Buttons = {}

	TouchControlFrame = TouchGui:FindFirstChild('TouchControlFrame') or TouchGui:WaitForChild('TouchControlFrame', 10)
	JumpButton = TouchControlFrame:FindFirstChild('JumpButton') or TouchControlFrame:WaitForChild('JumpButton', 10)
	Buttons.Punch = script.MobileFrame.PunchButton
	Buttons.Dash = script.MobileFrame.DashButton
	Buttons.Block = script.MobileFrame.BlockButton
	Buttons.Special = script.MobileFrame.SpecialButton

	PunchButton = Buttons.Punch
	DashButton = Buttons.Dash
	BlockButton = Buttons.Block
    SpecialButton = Buttons.Special

	local function ResizeButtons()
		for _, Button: ImageButton in Buttons do
			Button.Parent = TouchControlFrame

			local minAxis = math.min(TouchControlFrame.AbsoluteSize.x, TouchControlFrame.AbsoluteSize.y)
			local isSmallScreen = minAxis <= 500
			local buttonSize = isSmallScreen and 70 or 120

			Button.Size = UDim2.new(0, buttonSize, 0, buttonSize)
			Button.Position = isSmallScreen and UDim2.new(1, -(buttonSize*1.5-10), 1, -buttonSize - 20 - ((buttonSize + 5) * Button.LayoutOrder)) or
				UDim2.new(1, -(buttonSize*1.5-10), 1, -buttonSize * 1.75 - ((buttonSize + 5) * Button.LayoutOrder))
		end
	end

	local ButtonsPositions = Getter:InvokeServer('GetButtonsPos')
	if ButtonsPositions ~= nil then
		if ButtonsPositions['Punch'] ~= nil then
			PunchButton.Position = UDim2.new(ButtonsPositions.Punch.Scale.X, ButtonsPositions.Punch.Offset.X, ButtonsPositions.Punch.Scale.Y, ButtonsPositions.Punch.Offset.Y)
		end

		if ButtonsPositions['Dash'] ~= nil then
			DashButton.Position = UDim2.new(ButtonsPositions.Dash.Scale.X, ButtonsPositions.Dash.Offset.X, ButtonsPositions.Dash.Scale.Y, ButtonsPositions.Dash.Offset.Y)
		end

		if ButtonsPositions['Block'] ~= nil then
			BlockButton.Position = UDim2.new(ButtonsPositions.Block.Scale.X, ButtonsPositions.Block.Offset.X, ButtonsPositions.Block.Scale.Y, ButtonsPositions.Block.Offset.Y)
		end
		
		if ButtonsPositions['Special'] ~= nil then
			BlockButton.Position = UDim2.new(ButtonsPositions.Special.Scale.X, ButtonsPositions.Special.Offset.X, ButtonsPositions.Special.Scale.Y, ButtonsPositions.Special.Offset.Y)
		end
	end

	ResizeButtons()
	TouchControlFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeButtons)


	PunchButton.MouseButton1Down:Connect(function()
		if Character:FindFirstChild('ChangingButtons') then
			selectedFrame = PunchButton
		else
			Punch()

			PunchButton.Image = 'rbxassetid://12253807149'
		end
	end)

	PunchButton.MouseButton1Up:Connect(function()
		Punching = false

		PunchButton.Image = 'rbxassetid://12252402662'

		if selectedFrame == PunchButton then
			selectedFrame = nil
		end
	end)
	
	SpecialButton.MouseButton1Down:Connect(function()
		if Character:FindFirstChild('ChangingButtons') then
			selectedFrame = DashButton
		else
			SpecialButton.Image = 'rbxassetid://10002492897'


			Special()
		end
	end)
	
	SpecialButton.MouseButton1Down:Connect(function()
		
		SpecialButton.Image = 'rbxassetid://10002492897'

		if selectedFrame == SpecialButton then
			selectedFrame = nil
		end
	end)


	DashButton.MouseButton1Down:Connect(function()
		if Character:FindFirstChild('ChangingButtons') then
			selectedFrame = DashButton
		else
			DashButton.Image = 'rbxassetid://12253813495'


			DashCheck()
		end
	end)

	DashButton.MouseButton1Up:Connect(function()
		DashButton.Image = 'rbxassetid://12252434969'

		if selectedFrame == DashButton then
			selectedFrame = nil
		end
	end)


	BlockButton.MouseButton1Down:Connect(function()
		if Character:FindFirstChild('ChangingButtons') then
			selectedFrame = BlockButton
		else
			Blocking = true

			BlockButton.Image = 'rbxassetid://12253793254'
		end
	end)

	BlockButton.MouseButton1Up:Connect(function()
		Blocking = false
		BlockButton.Image = 'rbxassetid://12252418253'

		CombatSet:FireServer('Block', { Stage = false })

		if selectedFrame == BlockButton then
			selectedFrame = nil
		end
	end)
end


RNS.Heartbeat:Connect(function()
	if Character ~= nil and Character:FindFirstChild('HumanoidRootPart') then
		if not Character:HasTag('Stunned') then
			if Punching == true and not Character:HasTag('Punching') and not Character:HasTag('Move Selected') then
				CombatSet:FireServer('Punch', { Uppercut = Humanoid.Jump, Downslam = CheckDownslam() })
			elseif Blocking == true and not Character:HasTag('Blocking') then
				CombatSet:FireServer('Block', { Stage = true })
			end
		end
	end
end)


if ConfigFolder['Awakening Music'].Value == false then
	for _, EnemyCharacter: Model in workspace.Live:GetChildren() do
		if EnemyCharacter:IsA('Model') then
			local EnemyHumRP = EnemyCharacter:FindFirstChild('HumanoidRootPart')
			if EnemyHumRP then
				local EnemyAwakeningMusic: Attachment = EnemyHumRP:FindFirstChild('AwakeningMusic')
				if EnemyAwakeningMusic then
					for _, Sound: Sound in EnemyAwakeningMusic:GetChildren() do
						Sound:Destroy()
					end
				end
			end
		end
	end
end

shared.detectAir = function(Params)
	local Char: Model = Params.Char
	local HumRP2: BasePart = Char:FindFirstChild('HumanoidRootPart')

	if not HumRP2 then return end

	local rayInstance, rayPosition, rayMaterial, rayNormal = nil
	local startTick = tick()
	local originalJustDown = Params.justdown

	while task.wait() do
		if HumRP2.Velocity.Magnitude < .1 and HumRP2.Velocity.Magnitude > 0 then
			Params.justdown = true
		else
			Params.justdown = originalJustDown
		end

		if not Params.justdown then
			rayInstance, rayPosition, rayMaterial, rayNormal = shared.ray({
				orig = HumRP2.Position, 
				dir = HumRP2.Velocity.Unit * 4
			})

		else
			rayInstance, rayPosition, rayMaterial, rayNormal = shared.ray({
				orig = HumRP2.Position,
				dir = Vector3.new(0, -38, 0, 0)
			})

		end

		if rayInstance or (HumRP2 and HumRP2.Parent and HumRP2.Parent:FindFirstChild("RagdollCancel")) then
			if rayInstance and Params.destroyables == true and (rayInstance.Parent.Name == 'Tree' or rayInstance.Parent.Parent.Name == 'Tree') and not rayInstance.Parent:HasTag('Destroyed') and not rayInstance.Parent.Parent:HasTag('Destroyed') then
				DestroyAmbient:Destroy(CFrame.lookAt(HumRP2.Position, HumRP2.Velocity.Unit), Vector3.new(1, 1, 1) * 18, false, HumRP2.Velocity.Unit * HumRP2.Velocity.Magnitude)
			else
				if tick() - startTick >= .25 or Params.ragdoll ~= true then
					return true, { Instance = rayInstance, Position = rayPosition, Material = rayMaterial, Normal = rayNormal; }
				end
			end
		end
	end
end

local MoveUsed: RBXScriptConnection
Getter.OnClientInvoke = function(Params)
	local Func = Params.Func

	if Func == "isDestroyed" then
		local Part: Part = Params.Part
		local Container = Part:FindFirstAncestorWhichIsA('Model')
		if Container:FindFirstChild('TreeRoot') then
			return Container:HasTag('Destroyed')
		else
			return false
		end

	elseif Func == 'GetCF' then
		if Params.Object == 'Camera' then
			return Camera.CFrame
		elseif Params.Object == 'MousePos' then
			return Mouse.Hit.Position
		else
			return Params.Object.CFrame
		end
	elseif Func == 'IsOnConsole' then
		return shared.IsConsole
	elseif Func == 'DetectAir' then
		return shared.detectAir(Params)
	elseif Func == 'MoveUsedTwice' then
		local returnValue = nil

		MoveUsed = RS.Bindables.MoveUsed.Event:Connect(function(MoveName: string)
			if MoveName == Params.MoveName then
				MoveUsed:Disconnect()
				MoveUsed = nil

				returnValue = true
			end
		end)

		local Start = time()
		repeat task.wait() until returnValue == true or (time() - Start) >= Params.Time

		if MoveUsed then
			MoveUsed:Disconnect()
			MoveUsed = nil
		end

		return returnValue
	elseif Func == 'Hitbox' then
		local returnValue = nil
		local timePassed = false


		if Params.Time == 'Once' then
			returnValue = Hitbox(Params)
		else
			local Start = time()
			local conection: RBXScriptConnection, canProceed = nil, false
			conection = RNS.RenderStepped:Connect(function()
				if not Character:FindFirstChild('cancelHitboxes') and time() - Start < Params.Time then
					returnValue = Hitbox(Params)

					if returnValue ~= nil then
						canProceed = true
					end
				else
					canProceed = true
				end
			end)

			repeat task.wait() until canProceed == true


			conection:Disconnect()
		end

		return returnValue
	end
end

game.SoundService.Sounds.Volume = tonumber(string.format("%.1f", math.clamp(ConfigFolder.Volume.Value, .1, 1)))

print('CLIENT LOADED '..tick() - loadStart)