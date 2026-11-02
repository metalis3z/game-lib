local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- UI References
local CodesGui = script.Parent
local Frame = CodesGui:FindFirstChild("Frame")
local EnterBox = Frame and Frame:FindFirstChild("Box")
local Redeem = Frame and Frame:FindFirstChild("Redeem")
local PopSound = script:FindFirstChild("pop")

-- State
local ClickDB = false
local FrameOpen = false

-- RemoteEvent for codes (assume exists in ReplicatedStorage)
local CodeEvent = ReplicatedStorage.Remotes:FindFirstChild("codeEvent")

-- Helper: Show Roblox notification
local function showNotification(title, text, duration)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = duration or 3
		})
	end)
end

-- Helper: Button animation
local function buttonAnimation(Button, enablePress)
	local isHovering = false
	local normalX, normalY = Button.Size.X.Scale, Button.Size.Y.Scale
	local enterX, enterY = normalX + 0.007, normalY + 0.007
	local pressX, pressY = normalX - 0.025, normalY - 0.005

	Button.MouseEnter:Connect(function()
		isHovering = true
		Button:TweenSize(UDim2.new(enterX, 0, enterY, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, true)
	end)
	Button.MouseLeave:Connect(function()
		isHovering = false
		Button:TweenSize(UDim2.new(normalX, 0, normalY, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, true)
	end)
	if enablePress then
		Button.MouseButton1Down:Connect(function()
			Button:TweenSize(UDim2.new(pressX, 0, pressY, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, true)
		end)
		Button.MouseButton1Up:Connect(function()
			if not isHovering then
				Button:TweenSize(UDim2.new(normalX, 0, normalY, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, true)
			else
				Button:TweenSize(UDim2.new(enterX, 0, enterY, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, true)
			end
		end)
	end
end

-- Main: Handle code redemption
local function redeemCode()
	if not EnterBox.Text or EnterBox.Text == "" then
		showNotification("Error", "Please enter a code!", 3)
		return
	end
	
	-- Send code to server for validation
	CodeEvent:FireServer(EnterBox.Text)
	-- Keep the text in the box for user convenience
end

-- UI: Toggle Frame visibility
local function toggleFrame()
	if ClickDB then return end
	ClickDB = true
	if PopSound then PopSound:Play() end
	Frame.Visible = not FrameOpen
	if not FrameOpen then
		FrameOpen = true
		Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.12, true)
	else
		FrameOpen = false
		Frame.Position = UDim2.new(0.5, 0, 0.4, 0)
	end
	task.wait(0.15)
	ClickDB = false
end

-- Main connection
if CodeEvent then
	-- Setup redeem button
	Redeem.Activated:Connect(function()
		if not ClickDB then
			ClickDB = true
			redeemCode()
			task.wait(0.15)
			ClickDB = false
		end
	end)
	buttonAnimation(Redeem, true)
	
	-- Also allow Enter key to redeem
	EnterBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			redeemCode()
		end
	end)
end