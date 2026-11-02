-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FFlags = require(ReplicatedStorage.Library.Client.FFlags)
local ScreenResolution = require(script.Parent.ScreenResolution)
local t = {}
local t2 = {}

local function registerUpdater(p1, p2, p3, p4) --[[ registerUpdater | Line: 28 | Upvalues: t2 (copy), ScreenResolution (copy), FFlags (copy) ]]
	local UIGridLayout = p1:FindFirstChildOfClass("UIGridLayout")

	assert(if UIGridLayout == nil then false else true, "UIGridLayout not found in the provided container")

	local v2 = p1:FindFirstAncestorOfClass("ScreenGui")
	local UIPadding = p1:FindFirstChildOfClass("UIPadding")
	local v3 = if p1:IsA("ScrollingFrame") then p1 else p1:FindFirstAncestorOfClass("ScrollingFrame")
	local v4 = nil

	if p3 == true then
		for i, v in ipairs(p1:GetChildren()) do
			local UIAspectRatioConstraint = v:FindFirstChildOfClass("UIAspectRatioConstraint")

			if UIAspectRatioConstraint ~= nil then
				v4 = UIAspectRatioConstraint.AspectRatio

				break
			end
		end
	end

	if p2 == nil or #p2 == 0 then
		local function f5() --[[ Line: 55 ]] end

		t2[p1] = f5

		return f5
	end

	local v6 = table.clone(p2)

	table.sort(v6, function(p1, p2) --[[ Line: 61 ]]
		return p1.ResolutionThreshold < p2.ResolutionThreshold
	end)

	local function updateLayout() --[[ updateLayout | Line: 65 | Upvalues: ScreenResolution (ref), v6 (copy), p1 (copy), v3 (copy), UIPadding (copy), v2 (copy), p3 (copy), v4 (ref), UIGridLayout (copy), p4 (copy) ]]
		local v1 = ScreenResolution.GetScale()
		local v22 = nil

		for i, v in ipairs(v6) do
			if v1 < v.ResolutionThreshold then
				v22 = v

				break
			end
		end

		assert(v22 ~= nil, "No layout configuration matched the current resolution scale")

		local AbsoluteSize = p1.AbsoluteSize
		local v42 = v22.Padding or UDim2.new()

		if v22.ScalePaddingOffset == true then
			assert(v3 ~= nil, "Window-scaled AutoGridLayout padding requires a ScrollingFrame")

			local AbsoluteWindowSize = v3.AbsoluteWindowSize

			assert(if AbsoluteWindowSize.X > 0 then if AbsoluteWindowSize.Y > 0 then true else false else false, "AutoGridLayout scrolling window size must be greater than zero")
			v42 = UDim2.new(0, math.floor(v42.X.Scale * AbsoluteWindowSize.X + v42.X.Offset), 0, (math.floor(v42.Y.Scale * AbsoluteWindowSize.Y + v42.Y.Offset)))
		end

		local v17 = (AbsoluteSize.X - (if v3 == nil then 0 else v3.ScrollBarThickness) - (if UIPadding == nil then 0 else UIPadding.PaddingLeft.Offset + UIPadding.PaddingLeft.Scale * AbsoluteSize.X) - (if UIPadding == nil then 0 else UIPadding.PaddingRight.Offset + UIPadding.PaddingRight.Scale * AbsoluteSize.X)) / v22.PerRow - (v42.X.Offset + v42.X.Scale * AbsoluteSize.X)

		if v2 ~= nil then
			local Frame = v2:FindFirstChildOfClass("Frame")

			if Frame ~= nil then
				local TabControllerUIScale = Frame:FindFirstChild("TabControllerUIScale")

				if TabControllerUIScale ~= nil and TabControllerUIScale:IsA("UIScale") then
					v17 = v17 / TabControllerUIScale.Scale
				end
			end
		end

		local v18 = if p3 == true and v4 ~= nil then math.floor(v17 / v4) else v17
		local v21 = math.floor(v17)

		UIGridLayout.CellPadding = v42
		UIGridLayout.CellSize = UDim2.fromOffset(v21, v18)

		if v3 == nil then
			return
		end

		local sum = 0

		if UIPadding ~= nil then
			sum = sum + (UIPadding.PaddingBottom.Offset + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Scale * AbsoluteSize.Y + UIPadding.PaddingTop.Scale * AbsoluteSize.Y)
		end

		v3.CanvasSize = UDim2.new(0, UIGridLayout.AbsoluteContentSize.X, 0, UIGridLayout.AbsoluteContentSize.Y + sum + (p4 or 0))
	end

	local function f7() --[[ Line: 146 | Upvalues: updateLayout (copy), FFlags (ref) ]]
		updateLayout()

		if not FFlags.Get(FFlags.Keys.DoubleAutoResolution) then
			return
		end

		task.delay(0.1, updateLayout)
	end

	t2[p1] = f7

	return f7
end

function t.Register(p1, p2, p3, p4) --[[ Register | Line: 160 | Upvalues: registerUpdater (copy) ]]
	return registerUpdater(p1, p2, p3, p4)
end
function t.Update(p1) --[[ Update | Line: 169 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	assert(v1 ~= nil, "AutoGridLayout updater was not registered for the provided container")
	v1()
end

return setmetatable(t, {
	__call = function(p1, p2, p3, p4, p5) --[[ __call | Line: 176 | Upvalues: t (copy) ]]
		return t.Register(p2, p3, p4, p5)
	end
})