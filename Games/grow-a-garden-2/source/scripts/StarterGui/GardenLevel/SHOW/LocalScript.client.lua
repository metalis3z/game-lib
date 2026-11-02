--credit to leon games studio
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local t = {}
local t2 = {}
local TextLabel = script.Parent.Parent:WaitForChild("MainFrame"):WaitForChild("TextLabel")
local TextLabel2 = TextLabel:WaitForChild("TextLabel")

table.insert(t, (TweenService:Create(TextLabel, v1, {
	TextTransparency = 0
})))
table.insert(t, (TweenService:Create(TextLabel2, v1, {
	TextTransparency = 0
})))
table.insert(t, (TweenService:Create(TextLabel.UIStroke, v1, {
	Transparency = 0
})))
table.insert(t, (TweenService:Create(TextLabel2.UIStroke, v1, {
	Transparency = 0
})))
table.insert(t2, (TweenService:Create(TextLabel, v1, {
	TextTransparency = 1
})))
table.insert(t2, (TweenService:Create(TextLabel2, v1, {
	TextTransparency = 1
})))
table.insert(t2, (TweenService:Create(TextLabel.UIStroke, v1, {
	Transparency = 1
})))
table.insert(t2, (TweenService:Create(TextLabel2.UIStroke, v1, {
	Transparency = 1
})))
function UPD() --[[ UPD | Line: 32 ]] end