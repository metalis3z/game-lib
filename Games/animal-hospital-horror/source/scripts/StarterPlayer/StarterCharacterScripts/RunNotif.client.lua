local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

game:GetService("CollectionService")
task.wait(1)

local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")
local Frame = Lib.UI.Get("Run"):WaitForChild("Frame")
local v2 = nil
local v3 = nil
local v4 = nil

local function check() --[[ check | Line: 11 | Upvalues: v2 (ref), Humanoid (copy), v1 (copy), v3 (ref), Frame (copy), Lib (copy), v4 (ref) ]]
	if v2 then
		return
	end

	v2 = true

	while v2 and (Humanoid.Health > 0 and (v1.Parent and not (v1:GetAttribute("Run") <= 0))) do
		if not v3 then
			Frame.Visible = true
			Frame.text.TextTransparency = 0
			Frame.text.UIStroke.Transparency = 0
			v3 = Lib.TS:Create(Frame.text, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
				TextTransparency = 1
			})
			v3:Play()
			v4 = Lib.TS:Create(Frame.text.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
				Transparency = 1
			})
			v4:Play()
		end

		task.wait(0.1)
	end

	if not v3 then
		return
	end

	v3:Cancel()
	v4:Cancel()
	Frame.Visible = false
	v3 = nil
end

v1:GetAttributeChangedSignal("Run"):Connect(check)