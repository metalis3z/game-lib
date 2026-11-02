local runs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local ti = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)

script.Parent:WaitForChild("Origin")
local startCFrame = script.Parent.Origin.CFrame
local endCFrame = startCFrame * CFrame.Angles(0,0,math.rad(180))

ts:Create(script.Parent.Origin, ti, {CFrame = endCFrame}):Play()