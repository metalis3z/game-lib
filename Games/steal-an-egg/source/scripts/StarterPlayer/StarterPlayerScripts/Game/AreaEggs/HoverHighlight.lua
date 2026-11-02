-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.Packages.Trove)

local t = {}

local function showHighlight(p1) --[[ showHighlight | Line: 18 ]]
	local AreaEggHover = Instance.new("Highlight")

	AreaEggHover.Name = "AreaEggHover"
	AreaEggHover.FillTransparency = 1
	AreaEggHover.OutlineTransparency = 1
	AreaEggHover.OutlineColor = Color3.fromRGB(255, 255, 255)
	AreaEggHover.DepthMode = Enum.HighlightDepthMode.Occluded
	AreaEggHover.Adornee = p1
	AreaEggHover.Parent = p1

	return AreaEggHover
end

function t.Bind(p1, p2, p3) --[[ Bind | Line: 34 | Upvalues: Asserts (copy), TweenService (copy) ]]
	Asserts.Model(p1)
	Asserts.Instance(p2)

	local v1 = nil

	p3:Connect(p2.PromptShown, function() --[[ Line: 39 | Upvalues: v1 (ref), p1 (copy), TweenService (ref) ]]
		local AreaEggHover

		if v1 == nil then
			local v12

			v12 = p1
			AreaEggHover = Instance.new("Highlight")
			AreaEggHover.Name = "AreaEggHover"
			AreaEggHover.FillTransparency = 1
			AreaEggHover.OutlineTransparency = 1
			AreaEggHover.OutlineColor = Color3.fromRGB(255, 255, 255)
			AreaEggHover.DepthMode = Enum.HighlightDepthMode.Occluded
			AreaEggHover.Adornee = p1
			AreaEggHover.Parent = p1
			v1 = AreaEggHover
			TweenService:Create(AreaEggHover, TweenInfo.new(0.15), {
				OutlineTransparency = 0
			}):Play()

			return
		end

		v1:Destroy()
		AreaEggHover = Instance.new("Highlight")
		AreaEggHover.Name = "AreaEggHover"
		AreaEggHover.FillTransparency = 1
		AreaEggHover.OutlineTransparency = 1
		AreaEggHover.OutlineColor = Color3.fromRGB(255, 255, 255)
		AreaEggHover.DepthMode = Enum.HighlightDepthMode.Occluded
		AreaEggHover.Adornee = p1
		AreaEggHover.Parent = p1
		v1 = AreaEggHover
		TweenService:Create(AreaEggHover, TweenInfo.new(0.15), {
			OutlineTransparency = 0
		}):Play()
	end)
	p3:Connect(p2.PromptHidden, function() --[[ Line: 46 | Upvalues: v1 (ref), TweenService (ref) ]]
		local v12 = v1

		v1 = nil

		if v12 ~= nil then
			local v2 = TweenService:Create(v12, TweenInfo.new(0.12), {
				OutlineTransparency = 1
			})

			v2.Completed:Once(function() --[[ Line: 53 | Upvalues: v12 (copy) ]]
				v12:Destroy()
			end)
			v2:Play()
		end
	end)
end

return t