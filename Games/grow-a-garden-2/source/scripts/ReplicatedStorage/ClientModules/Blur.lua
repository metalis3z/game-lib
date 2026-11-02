--credit to prince games studio
local t = {}
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local v1 = Lighting:FindFirstChild("Blur") or Instance.new("BlurEffect", Lighting)

function t.SetBlur(p1, p2) --[[ SetBlur | Line: 7 | Upvalues: TweenService (copy), v1 (copy) ]]
	local v12 = p2 or 0.3
	local v2 = TweenService:Create(v1, TweenInfo.new(v12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = p1
	})

	v2:Play()
	game.Debris:AddItem(v2, v12)
end

return t