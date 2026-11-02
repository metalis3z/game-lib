
local colorSequence = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
})

local function getTransparency()
	local v3 = workspace:GetServerTimeNow() % 5.9
	local v4 = if not (v3 < 2) then if not (v3 < 3) then if not (v3 < 3.9) then (1 - math.cos((v3 - 3.9) / 2 * 6.283185307179586 * 2)) * 0.5 else not ((v3 - 3) % 0.3 < 0.15) and 1 or 0 else 1 else (1 - math.cos(v3 / 2 * 6.283185307179586 * 2)) * 0.5

	return NumberSequence.new(v4)
end

return {
	simulate = function(_: number)
		return {
			main = colorSequence,
			mainTransparency = getTransparency()
		}
	end,
	apply = function(p1)
		local t1 = {}
		local UIGradient = p1:FindFirstChildWhichIsA("UIGradient")
		local v9 = if not UIGradient then nil else UIGradient.Color
		local v10 = if not UIGradient then nil else UIGradient.Transparency

		if not UIGradient then
			local UIGradient2 = Instance.new("UIGradient")

			UIGradient2.Rotation = 90
			UIGradient2.Parent = p1
			table.insert(t1, UIGradient2)
			UIGradient = UIGradient2
		end

		assert(UIGradient)

		return {
			main = UIGradient,
			cleanup = function()
				if v9 then
					UIGradient.Color = v9
				end

				if v10 then
					UIGradient.Transparency = v10
				end

				for _, v13 in t1 do
					v13:Destroy()
				end
			end
		}
	end
}
