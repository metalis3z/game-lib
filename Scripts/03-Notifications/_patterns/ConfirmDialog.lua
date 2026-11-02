--!strict
-- ConfirmDialog (clean pattern) - ModuleScript, client only.
-- A modal dialog that YIELDS until the player answers, so calling code reads top-to-bottom.
--
-- Credits / ideas taken from:
--   big-paintball          Message  (one call = OK message, Yes/No question, or 2 options; returns the answer)
--   work-at-a-pizza-place  Dialog + DialogBox (queue so two dialogs never overlap, gamepad A/B, timeout)
--
-- Usage (from a LocalScript):
--   local ConfirmDialog = require(game.ReplicatedStorage.ConfirmDialog)
--
--   if ConfirmDialog.Ask("Sell pet?", "Sell Golden Dragon for 500 coins?", "Sell", "Cancel") then
--       sellRemote:FireServer(petId)
--   end
--
--   ConfirmDialog.Message("Update", "New pets were added!")          -- one OK button, yields until closed
--   local pick = ConfirmDialog.Choose("Mode", "Pick a mode", {"Solo", "Duo", "Squad"})  -- returns index or nil
--
-- Keys: Enter / gamepad A = first button, Escape / gamepad B = cancel (returns false / nil).
-- Optional timeout: ConfirmDialog.Ask(title, msg, yes, no, 30)  -> returns false after 30s.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local ConfirmDialog = {}

local OPEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local CLOSE_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

type Ui = {
	gui: ScreenGui,
	shade: Frame,
	card: Frame,
	scale: UIScale,
	title: TextLabel,
	body: TextLabel,
	buttons: Frame,
}

local ui: Ui? = nil
local busy = false
local waiting: { thread } = {}

local function makeUi(): Ui
	local gui = Instance.new("ScreenGui")
	gui.Name = "ConfirmDialog"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 1000
	gui.Enabled = false
	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	local shade = Instance.new("Frame")
	shade.Size = UDim2.fromScale(1, 1)
	shade.BackgroundColor3 = Color3.new(0, 0, 0)
	shade.BackgroundTransparency = 0.45
	shade.Active = true -- blocks clicks to UI underneath
	shade.Parent = gui

	local card = Instance.new("Frame")
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.Position = UDim2.fromScale(0.5, 0.5)
	card.Size = UDim2.fromOffset(420, 0)
	card.AutomaticSize = Enum.AutomaticSize.Y
	card.BackgroundColor3 = Color3.fromRGB(32, 36, 46)
	card.Parent = shade
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(80, 90, 110)
	stroke.Thickness = 2
	stroke.Parent = card
	local pad = Instance.new("UIPadding")
	pad.PaddingTop, pad.PaddingBottom = UDim.new(0, 16), UDim.new(0, 16)
	pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 18), UDim.new(0, 18)
	pad.Parent = card
	local list = Instance.new("UIListLayout")
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Padding = UDim.new(0, 12)
	list.HorizontalAlignment = Enum.HorizontalAlignment.Center
	list.Parent = card
	local scale = Instance.new("UIScale")
	scale.Parent = card

	local title = Instance.new("TextLabel")
	title.LayoutOrder = 1
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, 0, 0, 30)
	title.Font = Enum.Font.GothamBlack
	title.TextSize = 24
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Parent = card

	local body = Instance.new("TextLabel")
	body.LayoutOrder = 2
	body.BackgroundTransparency = 1
	body.Size = UDim2.new(1, 0, 0, 20)
	body.AutomaticSize = Enum.AutomaticSize.Y
	body.TextWrapped = true
	body.RichText = true
	body.Font = Enum.Font.GothamMedium
	body.TextSize = 18
	body.TextColor3 = Color3.fromRGB(210, 215, 225)
	body.Parent = card

	local buttons = Instance.new("Frame")
	buttons.LayoutOrder = 3
	buttons.BackgroundTransparency = 1
	buttons.Size = UDim2.new(1, 0, 0, 44)
	buttons.Parent = card
	local row = Instance.new("UIListLayout")
	row.FillDirection = Enum.FillDirection.Horizontal
	row.HorizontalAlignment = Enum.HorizontalAlignment.Center
	row.SortOrder = Enum.SortOrder.LayoutOrder
	row.Padding = UDim.new(0, 10)
	row.Parent = buttons

	return { gui = gui, shade = shade, card = card, scale = scale, title = title, body = body, buttons = buttons }
end

local function getUi(): Ui
	if not ui or not ui.gui.Parent then
		ui = makeUi()
	end
	return ui :: Ui
end

local function makeButton(parent: Frame, text: string, order: number, primary: boolean, width: number): TextButton
	local b = Instance.new("TextButton")
	b.LayoutOrder = order
	b.Size = UDim2.new(width, -8, 1, 0)
	b.AutoButtonColor = true
	b.BackgroundColor3 = primary and Color3.fromRGB(60, 170, 90) or Color3.fromRGB(85, 92, 108)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Text = text
	b.Parent = parent
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
	return b
end

-- One dialog at a time: later callers wait in line (pizza-place Queue idea).
local function acquire()
	if busy then
		table.insert(waiting, coroutine.running())
		coroutine.yield()
	end
	busy = true
end

local function release()
	local nextThread = table.remove(waiting, 1)
	if nextThread then
		task.defer(nextThread) -- busy stays true, ownership passes to the next caller
	else
		busy = false
	end
end

-- Core: shows the dialog with `labels` buttons. Returns the 1-based index pressed, or nil on cancel/timeout.
local function run(titleText: string, bodyText: string, labels: { string }, cancelable: boolean, timeout: number?): number?
	acquire()
	local u = getUi()
	u.title.Text = titleText
	u.body.Text = bodyText
	for _, child in u.buttons:GetChildren() do
		if child:IsA("GuiButton") then
			child:Destroy()
		end
	end

	local result: number? = nil
	local done = Instance.new("BindableEvent")
	local connections: { RBXScriptConnection } = {}
	local finished = false

	local function finish(value: number?)
		if finished then
			return
		end
		finished = true
		result = value
		done:Fire()
	end

	local first: TextButton? = nil
	for i, label in labels do
		local b = makeButton(u.buttons, label, i, i == 1, 1 / #labels)
		if i == 1 then
			first = b
		end
		table.insert(connections, b.Activated:Connect(function()
			finish(i)
		end))
	end

	table.insert(connections, UserInputService.InputBegan:Connect(function(input, processed)
		if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.ButtonA then
			if not processed or input.KeyCode == Enum.KeyCode.ButtonA then
				finish(1)
			end
		elseif cancelable and (input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.ButtonB) then
			finish(nil)
		end
	end))

	if timeout then
		task.delay(timeout, finish, nil)
	end

	-- open
	u.gui.Enabled = true
	u.scale.Scale = 0.6
	TweenService:Create(u.scale, OPEN_INFO, { Scale = 1 }):Play()
	if UserInputService.GamepadEnabled and first then
		GuiService.SelectedObject = first
	end

	if not finished then
		done.Event:Wait()
	end
	done:Destroy()
	for _, c in connections do
		c:Disconnect()
	end

	-- close
	if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u.gui) then
		GuiService.SelectedObject = nil
	end
	local closeTween = TweenService:Create(u.scale, CLOSE_INFO, { Scale = 0.6 })
	closeTween:Play()
	closeTween.Completed:Wait()
	u.gui.Enabled = false

	release()
	return result
end

-- Yes/No. Returns true only if the first button was pressed.
function ConfirmDialog.Ask(title: string, message: string, yesText: string?, noText: string?, timeout: number?): boolean
	return run(title, message, { yesText or "Yes", noText or "No" }, true, timeout) == 1
end

-- Single OK button. Yields until closed.
function ConfirmDialog.Message(title: string, message: string, okText: string?)
	run(title, message, { okText or "OK" }, true, nil)
end

-- 2+ options. Returns the chosen index, or nil if cancelled / timed out.
function ConfirmDialog.Choose(title: string, message: string, options: { string }, timeout: number?): number?
	return run(title, message, options, true, timeout)
end

function ConfirmDialog.IsOpen(): boolean
	return busy
end

return ConfirmDialog
