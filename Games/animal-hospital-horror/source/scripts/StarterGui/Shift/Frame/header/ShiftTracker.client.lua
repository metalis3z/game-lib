local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local Position = script.Parent.Position
local Size = script.Parent.Size

local function Update() --[[ Update | Line: 5 | Upvalues: Lib (copy), Size (copy), Position (copy) ]]
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 1
	}):Play()
	task.wait(1)
	script.Parent.Size = UDim2.new(Size.X.Scale * 2, 0, Size.Y.Scale * 2, 0)
	script.Parent.Position = UDim2.new(Position.X.Scale, 0, Position.Y.Scale + 0.8, 0)
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 0,
		BackgroundTransparency = 0
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 0
	}):Play()
	task.wait(2)
	script.Parent:WaitForChild("text").Text = "Shift " .. game.Players:GetAttribute("Night")
	task.wait(3)
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 1,
		BackgroundTransparency = 1
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 1
	}):Play()
	task.wait(1)
	script.Parent.Size = Size
	script.Parent.Position = Position
	Lib.TS:Create(script.Parent:WaitForChild("text"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		TextTransparency = 0,
		BackgroundTransparency = 0
	}):Play()
	Lib.TS:Create(script.Parent:WaitForChild("text"):WaitForChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Linear), {
		Transparency = 0
	}):Play()
end

local updating = false
local function SafeUpdate()
	if updating then return end
	updating = true
	Update()
	updating = false
end

game.Players:GetAttributeChangedSignal("Night"):Connect(SafeUpdate)
Lib.Inject("UpdateShiftTracker", SafeUpdate)