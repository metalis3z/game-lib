local t = {}
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

game:GetService("GuiService")

local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v1 = nil
local v2 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

if v2 then
	v1 = PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
end

local t2 = {}
local t3 = {
	UDim2.new(-0.4169, 0, 0.715, 0),
	UDim2.new(-0.165, 0, -0.165, 0),
	UDim2.new(0.715, 0, -0.4169, 0),
	UDim2.new(-1.1077, 0, -0.0396, 0),
	UDim2.new(-0.858, 0, -0.858, 0),
	UDim2.new(-0.0396, 0, -1.1077, 0)
}

local function GetNextSlot() --[[ GetNextSlot | Line: 153 | Upvalues: t2 (copy), t3 (copy) ]]
	local t = {}

	for k, v in pairs(t2) do
		t[v.Slot] = true
	end

	for i = 1, #t3 do
		if not t[i] then
			return i
		end
	end

	return nil
end

local function ConnectButton(p1, p2) --[[ ConnectButton | Line: 170 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]
	local Button = v1.Button;

	(v1.Connections or {}).Pressed = Button.MouseButton1Down:connect(function(p12, p22) --[[ Line: 175 | Upvalues: p2 (copy), p1 (copy), Button (copy) ]]
		p2(p1, Enum.UserInputState.Begin, nil)
		Button:FindFirstChild("title")
	end)

	local function inputBeganHandler(p12) --[[ inputBeganHandler | Line: 184 | Upvalues: p2 (copy), p1 (copy), Button (copy) ]]
		p2(p1, Enum.UserInputState.Begin, p12)
		Button.ImageColor3 = Button.BorderColor3

		local title = Button:FindFirstChild("title")

		if not title then
			return
		end

		title.TextColor3 = Button.BorderColor3
	end

	local function inputChangedHandler(p12) --[[ inputChangedHandler | Line: 196 | Upvalues: p2 (copy), p1 (copy) ]]
		p2(p1, Enum.UserInputState.Change, p12)
	end

	local function inputEndedHandler(p12) --[[ inputEndedHandler | Line: 202 | Upvalues: p2 (copy), p1 (copy), Button (copy) ]]
		p2(p1, Enum.UserInputState.End, p12)
		Button.ImageColor3 = Button.BackgroundColor3

		local title = Button:FindFirstChild("title")

		if not title then
			return
		end

		title.TextColor3 = Button.BackgroundColor3
	end

	local function mouseLeaveHandler() --[[ mouseLeaveHandler | Line: 215 | Upvalues: Button (copy) ]]
		Button.ImageColor3 = Button.BackgroundColor3

		local title = Button:FindFirstChild("title")

		if not title then
			return
		end

		title.TextColor3 = Button.BackgroundColor3
	end

	Button.MouseLeave:Connect(mouseLeaveHandler)
end

local function DisconnectButton(p1) --[[ DisconnectButton | Line: 225 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1.Connections then
		return
	end

	for k, v in pairs(v1.Connections) do
		if v then
			v:Disconnect()
		end
	end

	v1.Connections = {}
end

local function newDefaultButton(p1, p2) --[[ newDefaultButton | Line: 237 | Upvalues: t3 (copy) ]]
	local ImageButton = Instance.new("ImageButton")

	ImageButton.Name = p1 .. "Button"
	ImageButton.BackgroundTransparency = 1
	ImageButton.Size = UDim2.new(0.75, 0, 0.75, 0)
	ImageButton.Image = "rbxassetid://5713982324"
	ImageButton.ImageTransparency = 0.5
	ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageButton.BorderColor3 = Color3.fromRGB(125, 125, 125)

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0.5, 0)
	UICorner.Parent = ImageButton
	ImageButton.Position = t3[p2]

	return ImageButton
end

local function BindButton(p1, p2) --[[ BindButton | Line: 260 | Upvalues: t2 (copy), DisconnectButton (copy), GetNextSlot (copy), newDefaultButton (copy), v1 (ref), ConnectButton (copy) ]]
	local v12 = t2[p1]
	local v2, v3

	if v12 then
		print("is Data")

		if v12.Connections then
			print("is Connections")
			DisconnectButton(p1)
		end

		if v12.Slot then
			print("is Slot")
			v2 = v12.Slot
		else
			v2 = GetNextSlot()
		end

		if v12.Button then
			print("is Button")
			v3 = v12.Button
			v3.ImageColor3 = v3.BackgroundColor3

			local title = v3:FindFirstChild("title")

			if title then
				title.TextColor3 = v3.BackgroundColor3
			end
		else
			v3 = newDefaultButton(p1, v2)
		end
	else
		local v6 = GetNextSlot()

		v3, v2 = newDefaultButton(p1, v6), v6
	end

	v3.Parent = v1
	t2[p1] = {
		Name = p1,
		Button = v3,
		Slot = v2,
		Connections = {}
	}
	ConnectButton(p1, p2)
end

local function UnbindButton(p1) --[[ UnbindButton | Line: 301 | Upvalues: t2 (copy), DisconnectButton (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	DisconnectButton(p1)

	if v1.Button then
		v1.Button:Destroy()
	end

	t2[p1] = nil
end

local function DisableButton(p1) --[[ DisableButton | Line: 314 | Upvalues: t2 (copy), DisconnectButton (copy) ]]
	DisconnectButton(p1)

	local Button = t2[p1].Button

	Button.ImageColor3 = Button.BackgroundColor3

	local title = Button:FindFirstChild("title")

	if not title then
		return
	end

	title.TextColor3 = Button.BackgroundColor3
end

local function FixDefaultJumpButton() --[[ FixDefaultJumpButton | Line: 327 | Upvalues: v1 (ref) ]]
	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0.5, 0)
	UICorner.Parent = v1
end

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = v1
t.Archivable = ContextActionService.Archivable
t.ClassName = ContextActionService.ClassName
t.Name = ContextActionService.Name
t.Parent = ContextActionService.Parent
t.LocalToolEquipped = ContextActionService.LocalToolEquipped
t.LocalToolUnequipped = ContextActionService.LocalToolUnequipped
function t.BindAction(p1, p2, p3, p4, ...) --[[ BindAction | Line: 347 | Upvalues: ContextActionService (copy), v2 (copy), BindButton (copy) ]]
	ContextActionService:BindAction(p2, p3, false, ...)

	if not (p4 and v2) then
		return
	end

	BindButton(p2, p3)
end
function t.BindActionAtPriority(p1, p2, p3, p4, p5, ...) --[[ BindActionAtPriority | Line: 354 | Upvalues: ContextActionService (copy), v2 (copy), BindButton (copy) ]]
	ContextActionService:BindActionAtPriority(p2, p3, false, p5, ...)

	if not (p4 and v2) then
		return
	end

	BindButton(p2, p3)
end
function t.UnbindAction(p1, p2) --[[ UnbindAction | Line: 361 | Upvalues: ContextActionService (copy), v2 (copy), t2 (copy), DisconnectButton (copy) ]]
	ContextActionService:UnbindAction(p2)

	if not v2 then
		return
	end

	local v1 = t2[p2]

	if not v1 then
		return
	end

	DisconnectButton(p2)

	if v1.Button then
		v1.Button:Destroy()
	end

	t2[p2] = nil
end
function t.DisableAction(p1, p2, p3) --[[ DisableAction | Line: 369 | Upvalues: ContextActionService (copy), v2 (copy), t2 (copy), DisconnectButton (copy) ]]
	ContextActionService:UnbindAction(p2)

	if not v2 then
		return
	end

	DisconnectButton(p2)

	local Button = t2[p2].Button

	Button.ImageColor3 = Button.BackgroundColor3

	local title = Button:FindFirstChild("title")

	if not title then
		return
	end

	title.TextColor3 = Button.BackgroundColor3
end
function t.SetTitle(p1, p2, p3) --[[ SetTitle | Line: 376 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	if not p3 then
		p3 = p2
	end

	local Button = v1.Button

	if not Button then
		return
	end

	local title = Button:FindFirstChild("title")

	if not title then
		local title2 = Instance.new("TextLabel")

		title2.Name = "title"
		title2.AnchorPoint = Vector2.new(0.5, 0.5)
		title2.Position = UDim2.new(0.5, 0, 0.5, 0)
		title2.BackgroundTransparency = 1
		title2.Size = UDim2.new(0.75, 0, 0.45, 0)
		title2.Font = Enum.Font.SourceSansBold
		title2.TextScaled = true
		title2.TextTransparency = 0.5
		title2.TextColor3 = Color3.new(255, 255, 255)
		title2.TextXAlignment = Enum.TextXAlignment.Center
		title2.TextYAlignment = Enum.TextYAlignment.Center
		title = title2
	end

	title.Visible = true
	title.Text = p3
	title.Parent = Button
end
function t.SetImage(p1, p2, p3) --[[ SetImage | Line: 404 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if v1 then
		v1.Button.Image = p3
	end
end
function t.SetPressedColor(p1, p2, p3) --[[ SetPressedColor | Line: 411 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	local Button = v1.Button

	if Button then
		print("Setting Pressed Color")
		Button.BorderColor3 = p3
	end
end
function t.SetReleasedColor(p1, p2, p3) --[[ SetReleasedColor | Line: 421 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	local Button = v1.Button

	if not Button then
		return
	end

	Button.ImageColor3 = p3
	Button.BackgroundColor3 = p3

	local title = Button:FindFirstChild("title")

	if not title then
		return
	end

	title.TextColor3 = p3
end
function t.MakeButtonSquare(p1, p2) --[[ MakeButtonSquare | Line: 435 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	local Button = v1.Button

	if not Button then
		return
	end

	local UICorner = Button:FindFirstChildOfClass("UICorner")

	if not UICorner then
		return
	end

	UICorner.CornerRadius = UDim.new(0, 0)
end
function t.MakeButtonRound(p1, p2, p3) --[[ MakeButtonRound | Line: 448 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	local Button = v1.Button

	if not Button then
		return
	end

	local UICorner = Button:FindFirstChildOfClass("UICorner")

	if not UICorner then
		Instance.new("UICorner", Button)
	end

	if not p3 then
		p3 = 0.5
	end

	UICorner.CornerRadius = UDim.new(p3, 0)
end
function t.GetButton(p1, p2) --[[ GetButton | Line: 465 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if v1 then
		return v1.Button
	end

	return nil
end

return t