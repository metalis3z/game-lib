-- DialogModule.lua
local DialogModule = {}
DialogModule.__index = DialogModule

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local function getResponsesUI()
	return game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("dialog"):WaitForChild("dialogResponses")
end

local function safeFindSound(name)
	if script:FindFirstChild("sounds") then
		return script.sounds:FindFirstChild(name)
	end
	return nil
end

local TICK_SOUND = safeFindSound("tick")
local END_TICK_SOUND = safeFindSound("tick2")

-- Constructor
function DialogModule.new(npcName, npc, prompt, animation)
	local self = setmetatable({}, DialogModule)
	self.npcName = npcName or "NPC"
	self.npc = npc
	self.dialogs = {}
	self.dialogOption = 1
	self.npcGui = self.npc:WaitForChild("Head"):WaitForChild("gui")
	self.prompt = prompt

	-- internal state
	self._savedCamera = nil
	self._cameraLock = nil
	self._chaining = false
	self.active = false
	self.talking = false
	self._headGuiVisibility = nil
	self._lookAtConn = nil
	self._savedOrientation = nil
	self._idleTrack = nil
	self._hiddenPlayers = nil

	-- ensure response buttons exist
	local template = getResponsesUI():FindFirstChild("template")
	if template then
		for i = 1, 9 do
			local btn = template:Clone()
			btn.Parent = getResponsesUI()
			btn.Name = tostring(i)
		end
		template:Destroy()
	end

	local eventSignal = Instance.new("BindableEvent")
	self.responded = eventSignal.Event
	self.fireResponded = eventSignal

	-- optional animation passed explicitly to constructor
	if animation then
		local a = Instance.new("Animation")
		a.AnimationId = animation
		local humanoid = npc:FindFirstChild("Humanoid")
		if humanoid then
			local loaded = humanoid:LoadAnimation(a)
			loaded:Play()
		end
	end

	-- Disable collisions for this NPC's BaseParts (so NPC won't collide with player)
	for _, part in ipairs(self.npc:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end

	return self
end

-- Add one dialog entry
function DialogModule:addDialog(entry)
	if type(entry) == "string" then
		table.insert(self.dialogs, {text = entry, responses = {}})
	elseif type(entry) == "table" then
		local text = entry.text or entry[1] or ""
		local responses = entry.responses or entry[2] or {}
		table.insert(self.dialogs, {text = text, responses = responses})
	end
end

-- Set dialogs in bulk
function DialogModule:setDialogs(list)
	self.dialogs = {}
	for _, v in ipairs(list) do
		self:addDialog(v)
	end
end

function DialogModule:nextOption()
	self.dialogOption = math.min(#self.dialogs, self.dialogOption + 1)
	return self.dialogOption
end

local function turnProximityPromptsOn(yes)
	for _, p in CollectionService:GetTagged("NPCprompt") do
		if p:IsA("ProximityPrompt") then
			p.Enabled = yes
		end
	end
end

-- Hide other players locally: save previous transparency and restore later
function DialogModule:_hidePlayers()
	-- avoid re-saving if players are already hidden (prevents overwriting original values)
	if self._hiddenPlayers then return end
	self._hiddenPlayers = {}
	for _, pl in ipairs(Players:GetPlayers()) do
		local char = pl.Character
		if char then
			local saved = {}
			for _, obj in ipairs(char:GetDescendants()) do
				if obj:IsA("BasePart") then
					-- save numeric transparency fields
					saved[obj] = {Transparency = obj.Transparency, LocalTransparencyModifier = obj.LocalTransparencyModifier}
					pcall(function()
						if obj.LocalTransparencyModifier ~= nil then
							obj.LocalTransparencyModifier = 1
						else
							obj.Transparency = 1
						end
					end)
				elseif obj:IsA("Decal") or obj:IsA("Texture") then
					saved[obj] = {Transparency = obj.Transparency}
					pcall(function() obj.Transparency = 1 end)
				end
			end
			self._hiddenPlayers[pl] = saved
		end
	end
end

function DialogModule:_restorePlayers()
	if not self._hiddenPlayers then return end
	for pl, saved in pairs(self._hiddenPlayers) do
		for obj, vals in pairs(saved) do
			if obj and obj.Parent then
				pcall(function()
					if vals.LocalTransparencyModifier ~= nil then
						obj.LocalTransparencyModifier = vals.LocalTransparencyModifier
					end
					if vals.Transparency ~= nil then
						obj.Transparency = vals.Transparency
					end
				end)
			end
		end
	end
	self._hiddenPlayers = nil
end

function DialogModule:showGui()
	turnProximityPromptsOn(false)
	-- save and hide all Head GUI elements except the dialog label
	self._headGuiVisibility = self._headGuiVisibility or {}
	for _, c in ipairs(self.npcGui:GetChildren()) do
		if c:IsA("GuiObject") then
			self._headGuiVisibility[c] = c.Visible
			if c ~= self.npcGui.dialog then
				c.Visible = false
			else
				c.TextTransparency = 0
				if c.UIStroke then c.UIStroke.Transparency = 0 end
			end
		end
	end

	-- hide other players locally for focus
	self:_hidePlayers()
end

function DialogModule:hideGui(exitQuip, notActuallyAnExitQuip)
	self.active = false
	self.talking = true
	notActuallyAnExitQuip = notActuallyAnExitQuip or false

	-- if chaining, only hide buttons and keep camera/prompt state
	if self._chaining then
		local ui = getResponsesUI()
		for _, c in ipairs(ui:GetChildren()) do
			if c:IsA("GuiButton") then c.Visible = false end
		end
		return
	end

	turnProximityPromptsOn(not notActuallyAnExitQuip)

	-- disconnect camera lock
	if self._cameraLock then
		self._cameraLock:Disconnect()
		self._cameraLock = nil
	end

	self.talking = false
	local camera = workspace.CurrentCamera
	if notActuallyAnExitQuip then
		TweenService:Create(camera, TweenInfo.new(0.5), {FieldOfView = 65}):Play()
	else
		if self._savedCamera then
			local saved = self._savedCamera
			local tween = TweenService:Create(camera, TweenInfo.new(0.5), {CFrame = saved.CFrame, FieldOfView = saved.FieldOfView})
			tween:Play()
			tween.Completed:Connect(function()
				camera.CameraType = saved.CameraType
				self._savedCamera = nil
			end)
		else
			TweenService:Create(camera, TweenInfo.new(0.5), {FieldOfView = 70}):Play()
		end
	end

	-- hide response buttons
	local ui = getResponsesUI()
	for _, c in ipairs(ui:GetChildren()) do
		if c:IsA("GuiButton") then c.Visible = false end
	end

	if exitQuip then
		local dialogObject = self.npcGui.dialog
		dialogObject.Text = exitQuip
	end
	-- restore head GUI visibility
	if self._headGuiVisibility then
		for obj, vis in pairs(self._headGuiVisibility) do
			if obj and obj.Parent then
				obj.Visible = vis
			end
		end
		self._headGuiVisibility = nil
	end

	-- restore players visibility
	self:_restorePlayers()
	-- ensure hiddenPlayers cleared so future dialogs re-hide correctly
	self._hiddenPlayers = nil

	turnProximityPromptsOn(true)

	-- stop looking at player when dialog fully hidden
	if self._lookAtConn then
		self._lookAtConn:Disconnect()
		self._lookAtConn = nil
		-- restore saved orientation if available
		if self._savedOrientation and self.npc.PrimaryPart then
			self.npc.PrimaryPart.CFrame = self._savedOrientation
			self._savedOrientation = nil
		end
	end
end

function DialogModule:triggerDialog(player, questionNumber)
	self:showGui()
	if #self.dialogs == 0 then
		warn("No dialogs available for NPC: " .. tostring(self.npcName))
		return
	end

	local dialogNum = questionNumber or self.dialogOption
	local dialog = self.dialogs[dialogNum]
	if not dialog then return end

	local camera = workspace.CurrentCamera
	local cameraPart = self.npc:FindFirstChild("CameraPart")
	-- Start looking at player: rotate NPC to face player during dialog
	if player and player.Character and player.Character.PrimaryPart and not self._lookAtConn then
		-- save orientation
		if self.npc.PrimaryPart then
			self._savedOrientation = self.npc.PrimaryPart.CFrame
		end
		self._lookAtConn = RunService.Heartbeat:Connect(function()
			if not player or not player.Character or not player.Character.PrimaryPart then return end
			local targetPos = player.Character.PrimaryPart.Position
			local root = self.npc.PrimaryPart or self.npc:FindFirstChild("Torso") or self.npc:FindFirstChild("HumanoidRootPart")
			if root then
				local lookCFrame = CFrame.new(root.Position, Vector3.new(targetPos.X, root.Position.Y, targetPos.Z))
				root.CFrame = CFrame.new(root.Position, lookCFrame.LookVector + root.Position)
			end
		end)
	end
	if cameraPart then
		if not self._savedCamera then
			self._savedCamera = {CameraType = camera.CameraType, CFrame = camera.CFrame, FieldOfView = camera.FieldOfView}
			camera.CameraType = Enum.CameraType.Scriptable
		end
		TweenService:Create(camera, TweenInfo.new(0.5), {CFrame = cameraPart.CFrame, FieldOfView = 65}):Play()
		local newLock = RunService.Heartbeat:Connect(function()
			if camera and cameraPart then camera.CFrame = cameraPart.CFrame end
		end)
		if self._cameraLock then self._cameraLock:Disconnect() end
		self._cameraLock = newLock
	else
		TweenService:Create(camera, TweenInfo.new(0.5), {FieldOfView = 65}):Play()
	end

	task.spawn(function()
		self.talking = true
		local dialogObject = self.npcGui.dialog
		dialogObject.Visible = true
		dialogObject.Text = ""
		-- typewriter
		local current = ""
		for _, ch in ipairs(string.split(dialog.text, "")) do
			current = current .. ch
			dialogObject.Text = current
			if TICK_SOUND then TICK_SOUND:Play() end
			task.wait(0.02)
		end
		dialogObject.Text = dialog.text
		self.talking = false

		-- If there are no responses, the NPC finished speaking: reset state and restore UI/camera
		if not dialog.responses or #dialog.responses == 0 then
			-- short delay to let the final text appear
			task.wait(0.5)
			self:hideGui()
			return
		end

		-- responses (max 2)
		local ui = getResponsesUI()
		local maxResponses = math.min(2, #dialog.responses)
		local responseChosen = nil
		local keyboard = {Enum.KeyCode.One, Enum.KeyCode.Two}

		for i = 1, maxResponses do
			local resp = dialog.responses[i]
			local text = (type(resp) == "table") and (resp.text or resp[1] or "") or tostring(resp)
			local btn = ui[i]
			if btn then
				btn.text.Text = string.format("<font color='rgb(255,220,127)'>%d.)</font> [''%s'']", i, text)
				btn.Visible = true
				TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(btn.Size.X.Scale, 0, 0.35, 0)}):Play()

				local enterCon = btn.MouseEnter:Connect(function()
					TweenService:Create(btn, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(btn.Size.X.Scale * 1.05, 0, 0.4, 0)}):Play()
					if btn.text then TweenService:Create(btn.text, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.06,0,0.5,0)}):Play() end
					if END_TICK_SOUND then END_TICK_SOUND:Play() end
				end)

				local leaveCon = btn.MouseLeave:Connect(function()
					TweenService:Create(btn, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(btn.Size.X.Scale, 0, 0.35, 0)}):Play()
					if btn.text then TweenService:Create(btn.text, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.02,0,0.5,0)}):Play() end
				end)

				local chooseCon = btn.MouseButton1Down:Connect(function()
					if not self.active then return end
					-- quick click animation
					TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(btn.Size.X.Scale * 0.98,0,0.38,0)}):Play()
					self.active = false
					responseChosen = i
					self.fireResponded:Fire(i, dialogNum)
					if TICK_SOUND then TICK_SOUND:Play() end
					local chosen = dialog.responses[i]
					if type(chosen) == "table" and chosen.next then
						self._chaining = true
						task.spawn(function()
							task.wait(0.05)
							if self.dialogs[chosen.next] then
								self:triggerDialog(player, chosen.next)
							else
								warn("DialogModule: 'next' out of range for " .. tostring(self.npcName))
								self:hideGui()
							end
							self._chaining = false
						end)
					elseif type(chosen) == "table" and chosen.exitQuip then
						self:hideGui(chosen.exitQuip)
					else
						self:hideGui()
					end
				end)

				local keyCon
				keyCon = UserInputService.InputBegan:Connect(function(input, gp)
					if gp then return end
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local idx = table.find(keyboard, input.KeyCode)
						if idx and idx == i then
							if not self.active then return end
							self.active = false
							responseChosen = i
							self.fireResponded:Fire(i, dialogNum)
							if TICK_SOUND then TICK_SOUND:Play() end
							local chosen = dialog.responses[i]
							if type(chosen) == "table" and chosen.next then
								self._chaining = true
								task.spawn(function()
									task.wait(0.05)
									if self.dialogs[chosen.next] then
										self:triggerDialog(player, chosen.next)
									else
										warn("DialogModule: 'next' out of range for " .. tostring(self.npcName))
										self:hideGui()
									end
									self._chaining = false
								end)
							elseif type(chosen) == "table" and chosen.exitQuip then
								self:hideGui(chosen.exitQuip)
							else
								self:hideGui()
							end
						end
					end
				end)

				coroutine.wrap(function()
					repeat task.wait() until responseChosen ~= nil
					enterCon:Disconnect()
					leaveCon:Disconnect()
					chooseCon:Disconnect()
					if keyCon then keyCon:Disconnect() end
					btn.Visible = false
				end)()
			end
		end

		self.active = true
		-- proximity monitoring
		local range = 10
		while self.active do
			if not player or not player.Character or not player.Character.PrimaryPart or not self.npc.PrimaryPart then break end
			local distance = (player.Character.PrimaryPart.Position - self.npc.PrimaryPart.Position).Magnitude
			if distance > range then
				self:hideGui()
				break
			end
			task.wait()
		end
	end)
end

return DialogModule