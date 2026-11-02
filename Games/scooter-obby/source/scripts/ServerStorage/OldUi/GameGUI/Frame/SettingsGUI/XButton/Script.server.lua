local button = script.Parent
local frame = script.Parent.Parent
local rs = game:GetService("ReplicatedStorage")
local ts = game:GetService("TweenService")
local ti = TweenInfo.new(.4, Enum.EasingStyle.Quad)
local up = UDim2.new(0.271, 0,0.296, 0)
local down = UDim2.new(0.271, 0,1.1, 0)

button.Activated:Connect(function()
	ts:Create(frame, ti, {Position = down}):Play()
end)