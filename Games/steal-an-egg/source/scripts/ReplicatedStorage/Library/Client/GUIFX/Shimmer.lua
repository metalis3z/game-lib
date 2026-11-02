-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Functions = require(Library.Functions)

return function(p1, p2, p3, p4) --[[ Line: 6 | Upvalues: Assets (copy), Functions (copy) ]]
	local v1 = p2 or 1.75
	local v2 = p3 or 1
	local v3 = p1:FindFirstAncestorOfClass("ScreenGui") or p1:FindFirstAncestorOfClass("BillboardGui") or p1:FindFirstAncestorOfClass("SurfaceGui")

	if v3 then
		assert(v3)

		local v4 = Assets.UI.FRAMEWORK.GUIFX.Shimmer:Clone()
		local UIGradient = v4:FindFirstChild("UIGradient")

		v4.Parent = p1

		local function playShimmer() --[[ playShimmer | Line: 19 | Upvalues: UIGradient (copy), Functions (ref), v2 (copy) ]]
			UIGradient.Offset = Vector2.new(-1, 0)
			Functions.Tween(UIGradient, {
				Offset = Vector2.new(1, 0)
			}, { v2, "Quad", "InOut" })
		end

		local v5 = false

		task.spawn(function() --[[ Line: 26 | Upvalues: p4 (copy), playShimmer (copy), v5 (ref), p1 (copy), v3 (copy), v1 (copy) ]]
			if p4 then
				playShimmer()

				return
			end

			while not v5 and (p1 and p1.Parent) do
				if v3.Enabled then
					playShimmer()
				end

				task.wait(v1)
			end
		end)

		return function() --[[ Line: 38 | Upvalues: v4 (copy), v5 (ref) ]]
			if not v4 then
				v5 = true

				return
			end

			v4:Destroy()
			v5 = true
		end
	end

	return function() --[[ Line: 13 ]] end
end