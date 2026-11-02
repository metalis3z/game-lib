local t = {}
local TweenService = game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local Lib = require(game.ReplicatedStorage.Lib)
local Effects = Instance.new("ScreenGui")

Effects.Name = "Effects"
Effects.ResetOnSpawn = false
Effects.DisplayOrder = 999
Effects.Parent = PlayerGui

local v1 = Random.new()

function t.Sparkles(p1, p2, p3, p4) --[[ Sparkles | Line: 14 | Upvalues: v1 (copy) ]]
	script.Frame.BackgroundColor3 = p2

	local v12 = UDim2.new(0, p3, 0, p4 - 38)
	local t = {}

	for i = 1, v1:NextInteger(3, 7) do
		local v2 = script.Frame:Clone()

		v2.Position = v12

		local v3 = if v1:NextInteger(1, 2) == 1 then 1 else -1

		t[v2] = UDim2.new(v3 * v1:NextNumber(0, 0.005), 0, v1:NextNumber(0.001, 0.0075), 0)
		v2.BackgroundTransparency = v1:NextNumber(0, 0.25)
		v2.Parent = p1
	end

	local v4 = UDim2.new(0, 0, 0.0005)

	repeat
		local v5 = nil

		for v6, v7 in next, t do
			v5 = true
			v6.Position = v6.Position - v7
			v6.BackgroundTransparency = v6.BackgroundTransparency - 0.001
			t[v6] = v7 - v4

			if v6.BackgroundTransparency <= 0 then
				t[v6] = nil
				v6:Destroy()
				game["Run Service"].RenderStepped:wait()
			end
		end

		game["Run Service"].RenderStepped:wait()
	until not v5
end
function t.WiggleLabel(p1, p2, p3) --[[ WiggleLabel | Line: 46 | Upvalues: Lib (copy) ]]
	p1.TextColor3 = p3
	p1.Rotation = 8
	Lib.Import("Functional").RealWait(0.3)
	p1.Rotation = -8
	Lib.Funciotnal.RealWait(0.3)
	p1.Rotation = 0
	p1.TextColor3 = p2
end
function t.FromZeroGrow(p1, p2, p3, p4, p5) --[[ FromZeroGrow | Line: 56 ]]
	local v1 = if p5 then p5 else p1.Size

	p1.Size = UDim2.new()
	p1.Visible = true
	p1:TweenSize(v1, "Out", p2 or "Quad", p3 or 1, false, nil)
end
function EmojiStream(p1, p2, p3, p4) --[[ EmojiStream | Line: 65 | Upvalues: Lib (copy), v1 (copy), Effects (copy), TweenService (copy) ]]
	for i = 1, p2 do
		Lib.Functional.RealWait(v1:NextNumber(0.025, 0.1))

		local v12 = script.emoji:Clone()

		v12.Text = p1[v1:NextInteger(1, #p1)]
		v12.Position = p3 + UDim2.new(0, v1:NextInteger(-30, 30), 0, v1:NextInteger(-30, 30))
		v12.Parent = Effects

		local v2 = TweenService:Create(v12, TweenInfo.new(v1:NextNumber(1, 1.5)), {
			Position = p4
		})

		v2.Completed:Connect(function() --[[ Line: 75 | Upvalues: Lib (ref), v12 (copy), v2 (copy) ]]
			Lib.Functional.RealWait(0.1)
			v12:Destroy()
			v2:Destroy()
		end)
		v2:Play()
	end
end
function t.EmojiStream(p1, p2, p3, p4) --[[ EmojiStream | Line: 97 ]]
	local AbsolutePosition = p3.AbsolutePosition
	local v1 = UDim2.new(0, AbsolutePosition.X, 0, AbsolutePosition.Y)
	local AbsolutePosition2 = p4.AbsolutePosition

	EmojiStream(p1, p2, v1, (UDim2.new(0, AbsolutePosition2.X, 0, AbsolutePosition2.Y)))
end

return t