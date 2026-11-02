--credit to quartz games studio
local t = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local v1 = Random.new()

TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)
require(game.Players.LocalPlayer.PlayerScripts.Controllers.BlockSmashController)

local t2 = {}

function t.StopWobble(p1, p2) --[[ StopWobble | Line: 14 | Upvalues: t2 (copy) ]]
	local v1 = t2[p2]

	if not v1 then
		return
	end

	v1.Connection:Disconnect()

	if p2.Parent then
		p2:PivotTo(v1.StartPivot)
	end

	t2[p2] = nil
end
function t.ScaleUp(p1, p2, p3, p4, p5) --[[ ScaleUp | Line: 25 | Upvalues: t (copy), RunService (copy), TweenService (copy) ]]
	t:StopWobble(p2)

	local v2 = p5 or Enum.EasingStyle.Exponential
	local v3, v4 = p2:GetBoundingBox()
	local v5 = v3.Position.Y - v4.Y / 2
	local v6 = p2:GetScale()
	local v7 = os.clock()
	local v8 = nil

	v8 = RunService.Heartbeat:Connect(function() --[[ Line: 34 | Upvalues: p2 (copy), v8 (ref), v7 (copy), p4 (copy), TweenService (ref), v2 (ref), v6 (copy), p3 (copy), v5 (copy) ]]
		if p2.Parent then
			local v22 = math.clamp((os.clock() - v7) / p4, 0, 1)

			p2:ScaleTo(v6 + (p3 - v6) * TweenService:GetValue(v22, v2, Enum.EasingDirection.Out))

			local v3, v4 = p2:GetBoundingBox()

			p2:PivotTo(p2:GetPivot() + Vector3.new(0, v5 - (v3.Position.Y - v4.Y / 2), 0))

			if not (v22 >= 1) then
				return
			end
		end

		v8:Disconnect()
	end)
end
function t.Wobble(p1, p2, p3, p4) --[[ Wobble | Line: 53 | Upvalues: t (copy), v1 (copy), RunService (copy), t2 (copy) ]]
	t:StopWobble(p2)

	local v12 = p3 or 1
	local v2 = p4 or 0.5
	local v3, v4 = p2:GetBoundingBox()

	p2.WorldPivot = v3 * CFrame.new(0, -v4.Y / 2, 0)

	local v5 = p2:GetPivot()
	local v6 = os.clock()
	local v7 = v1:NextNumber(0, 6.283185307179586)
	local v8 = if v1:NextInteger(0, 1) == 0 then 1 else -1
	local v9 = nil

	v9 = RunService.Heartbeat:Connect(function() --[[ Line: 66 | Upvalues: p2 (copy), v9 (ref), t2 (ref), v6 (copy), v2 (ref), v12 (ref), v8 (copy), v5 (copy), v7 (copy) ]]
		if not p2.Parent then
			v9:Disconnect()
			t2[p2] = nil

			return
		end

		local v1 = os.clock() - v6
		local v3 = math.clamp(v1 / v2, 0, 1)
		local v4 = math.sin(v1 * 25) * 0.2617993877991494 * v12 * (1 - v3) * v8

		p2:PivotTo(v5 * CFrame.Angles(0, v7, 0) * CFrame.Angles(0, 0, v4) * CFrame.Angles(0, -v7, 0))

		if not (v3 >= 1) then
			return
		end

		p2:PivotTo(v5)
		v9:Disconnect()
		t2[p2] = nil
	end)
	t2[p2] = {
		Connection = v9,
		StartPivot = v5
	}
end
function t.ScaleUpInstant(p1, p2, p3) --[[ ScaleUpInstant | Line: 88 | Upvalues: t (copy) ]]
	t:StopWobble(p2)

	local v1, v2 = p2:GetBoundingBox()

	p2:ScaleTo(p3)

	local v4, v5 = p2:GetBoundingBox()

	p2:PivotTo(p2:GetPivot() + Vector3.new(0, v1.Position.Y - v2.Y / 2 - (v4.Position.Y - v5.Y / 2), 0))
end
function t.PopupFadeEffect(p1, p2, p3, p4) --[[ PopupFadeEffect | Line: 100 | Upvalues: t (copy), TweenService (copy) ]]
	local v1 = p2:Clone()

	v1.Parent = game.Workspace
	v1:PivotTo(p2:GetPivot())
	t:ScaleUp(v1, p3, 0.5)

	local v2 = TweenInfo.new(p4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

	for k, v in pairs(v1:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = false

			local v3 = TweenService:Create(v, v2, {
				Transparency = 1
			})

			v3:Play()
			game.Debris:AddItem(v3, v2.Time)
		end
	end

	game.Debris:AddItem(v1, v2.Time)
end
function t.PlayPopVFX(p1, p2, p3) --[[ PlayPopVFX | Line: 120 ]]
	for k, v in pairs(p2.Main:GetDescendants()) do
		if v:IsA("ParticleEmitter") and v.Name == "Level" .. tostring(p3) then
			v:Emit(v:GetAttribute("EmitCount"))
		end
	end
end
function t.HighlightFlash(p1, p2, p3) --[[ HighlightFlash | Line: 129 | Upvalues: TweenService (copy) ]]
	local v1 = TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
	local Highlight = Instance.new("Highlight")

	Highlight.OutlineTransparency = 1
	Highlight.FillColor = Color3.new(255/255, 255/255, 255/255)
	Highlight.FillTransparency = 0
	Highlight.Parent = p2
	Highlight.Adornee = p2

	local v2 = TweenService:Create(Highlight, v1, {
		FillTransparency = 1
	})

	v2:Play()
	game.Debris:AddItem(v2, v1.Time)
	game.Debris:AddItem(Highlight, v1.Time)
end
function t.PlayHatchUpOne(p1, p2) --[[ PlayHatchUpOne | Line: 144 | Upvalues: t (copy) ]]
	t:ScaleUpInstant(p2, 2)
	t:PopupFadeEffect(p2, 3, 0.5)
	t:PlayPopVFX(p2, 1)
	t:HighlightFlash(p2, 0.5)
end
function t.PlayHatchUpTwo(p1, p2) --[[ PlayHatchUpTwo | Line: 154 | Upvalues: t (copy) ]]
	t:ScaleUpInstant(p2, 4)
	t:PopupFadeEffect(p2, 7, 0.5)
	t:PlayPopVFX(p2, 2)
	t:HighlightFlash(p2, 0.5)
end
function t.PlayHatchUpOneElastic(p1, p2) --[[ PlayHatchUpOneElastic | Line: 164 | Upvalues: t (copy) ]]
	t:ScaleUp(p2, 1.35, 1.2, Enum.EasingStyle.Elastic)
	task.spawn(function() --[[ Line: 167 | Upvalues: t (ref), p2 (copy) ]]
		task.wait(0.2)
		t:PopupFadeEffect(p2, 1.75, 0.5)
		t:PlayPopVFX(p2, 1)
		t:HighlightFlash(p2, 0.5)
	end)
end
function t.PlayHatchUpTwoElastic(p1, p2) --[[ PlayHatchUpTwoElastic | Line: 175 | Upvalues: t (copy) ]]
	t:ScaleUp(p2, 2, 1.2, Enum.EasingStyle.Elastic)
	task.spawn(function() --[[ Line: 178 | Upvalues: t (ref), p2 (copy) ]]
		task.wait(0.2)
		t:PopupFadeEffect(p2, 2.5, 0.5)
		t:PlayPopVFX(p2, 2)
		t:HighlightFlash(p2, 0.5)
	end)
end
function t.PlayHatchUpScale(p1, p2, p3, p4) --[[ PlayHatchUpScale | Line: 186 | Upvalues: t (copy) ]]
	t:ScaleUpInstant(p2, p3)
	t:PopupFadeEffect(p2, p3 * 1.5, 0.5)
	t:PlayPopVFX(p2, p4)
	t:HighlightFlash(p2, 0.5)
end
function t.NormalEffect(p1, p2) --[[ NormalEffect | Line: 196 | Upvalues: v1 (copy), t (copy) ]]
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)

	if math.random(1, 10) == 1 then
		task.wait(v1:NextNumber(0.5, 1.5))
		t:Wobble(p2, 0.7, 0.5)
	end

	task.wait(v1:NextNumber(0.5, 1.5))
end
function t.BigEffect(p1, p2) --[[ BigEffect | Line: 206 | Upvalues: v1 (copy), t (copy) ]]
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpOne(p2)

	if math.random(1, 10) == 1 then
		task.wait(v1:NextNumber(0.5, 1.5))
		t:Wobble(p2, 0.7, 0.5)
	end

	task.wait(v1:NextNumber(0.5, 1.5))
end
function t.HugeEffect(p1, p2) --[[ HugeEffect | Line: 220 | Upvalues: v1 (copy), t (copy) ]]
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpOne(p2)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpTwo(p2)
end
function t.NormalEffectMode2(p1, p2) --[[ NormalEffectMode2 | Line: 233 | Upvalues: v1 (copy), t (copy) ]]
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)

	if math.random(1, 10) == 1 then
		task.wait(v1:NextNumber(0.5, 1.5))
		t:Wobble(p2, 1, 0.5)
		task.wait(v1:NextNumber(0.5, 1.5))
		t:PlayHatchUpScale(p2, 1.5, 1)
		task.wait(v1:NextNumber(0.5, 1.5))
		t:Wobble(p2, 0.7, 0.5)
	end

	task.wait(v1:NextNumber(0.5, 1.5))
end
function t.BigEffectMode2(p1, p2) --[[ BigEffectMode2 | Line: 249 | Upvalues: v1 (copy), t (copy) ]]
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 1, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpScale(p2, 1.5, 1)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 1, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpScale(p2, 2, 2)

	if math.random(1, 10) == 1 then
		task.wait(v1:NextNumber(0.5, 1.5))
		t:Wobble(p2, 1.2, 0.75)
		task.wait(v1:NextNumber(0.5, 1.5))
		t:PlayHatchUpScale(p2, 3, 3)
		task.wait(v1:NextNumber(0.5, 1.5))
		t:Wobble(p2, 0.7, 0.5)
	end

	task.wait(v1:NextNumber(0.5, 1.5))
end
function t.HugeEffectMode2(p1, p2) --[[ HugeEffectMode2 | Line: 275 | Upvalues: v1 (copy), t (copy) ]]
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 1, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpScale(p2, 1.5, 1)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 0.7, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 1, 0.5)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpScale(p2, 2, 2)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 1.2, 0.75)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpScale(p2, 3, 3)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:Wobble(p2, 1.5, 0.75)
	task.wait(v1:NextNumber(0.5, 1.5))
	t:PlayHatchUpScale(p2, 4, 3)
	task.wait(v1:NextNumber(0.5, 1.5))
end
function t.HatchEgg(p1, p2, p3, p4, p5) --[[ HatchEgg | Line: 301 | Upvalues: t (copy) ]]
	local v1 = p5 or 1

	if p4 == "Instant" then
		task.spawn(function() --[[ Line: 306 | Upvalues: v1 (ref), p3 (copy), t (ref), p2 (copy) ]]
			if v1 == 1 then
				if p3 == "Normal" then
					t:NormalEffect(p2)

					return
				end

				if p3 == "Big" then
					t:BigEffect(p2)

					return
				end

				if p3 == "Huge" then
					t:HugeEffect(p2)
				end
			else
				if v1 ~= 2 then
					return
				end

				if p3 == "Normal" then
					t:NormalEffectMode2(p2)

					return
				end

				if p3 == "Big" then
					t:BigEffectMode2(p2)

					return
				end

				if p3 ~= "Huge" then
					return
				end

				t:HugeEffectMode2(p2)
			end
		end)
	end
end

return t