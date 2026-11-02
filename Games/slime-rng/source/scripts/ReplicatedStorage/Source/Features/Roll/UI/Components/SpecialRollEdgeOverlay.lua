-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SpecialRollEdgeOverlay, time of decompilation: Sun May  3 10:11:50 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local SpecialRollUtils = require(ReplicatedStorage.Source.Features.Roll.SpecialRollUtils)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local UIGradient = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGradient)
local t1 = {
	golden = Color3.fromRGB(255, 202, 76),
	diamond = Color3.fromRGB(98, 241, 255),
	void = Color3.fromRGB(154, 84, 255)
}
local numberSequence = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.45),
	NumberSequenceKeypoint.new(0.35, 0.78),
	NumberSequenceKeypoint.new(1, 1)
})

local function getActiveSpecialRollColor() -- line: 24
	-- upvalues: SpecialRollUtils (copy), RollSlice (copy), t1 (copy)
	local v11 = SpecialRollUtils.getHighestPriorityActiveKind(RollSlice.activeSpecialRolls())

	if not v11 then
		return Color3.fromRGB(255, 255, 255)
	end

	return t1[v11] or Color3.fromRGB(255, 255, 255)
end

return function() -- line: 33
	-- upvalues: Vide (copy), SpecialRollUtils (copy), RollSlice (copy), RunService (copy), Frame (copy), getActiveSpecialRollColor (copy), UIGradient (copy), numberSequence (copy)
	local v12 = Vide.source(0)
	local v13 = Vide.spring(v12, 0.24, 0.8)
	local v14 = Vide.source(0)

	Vide.effect(function() -- line: 38
		-- upvalues: SpecialRollUtils (copy), RollSlice (copy), v12 (copy)
		local v16 = SpecialRollUtils.getHighestPriorityActiveKind(RollSlice.activeSpecialRolls()) ~= nil

		v12(not v16 and 0 or 1)
	end)

	local connection = RunService.Heartbeat:Connect(function() -- line: 44
		-- upvalues: v13 (copy), v14 (copy)
		if v13() <= 0.001 then
			v14(0)

			return
		end

		v14((math.sin(os.clock() * 3.141592653589793 * 2 * 1.6) * 0.5 + 0.5) * 0.035)
	end)

	Vide.cleanup(function() -- line: 54
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	return Frame({
		Name = "SpecialRollEdgeOverlay",
		Size = UDim2.fromScale(1.3, 1.3),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 2,
		Visible = function() --[[ Visible ]] -- line: 65
			-- upvalues: v13 (copy)
			return v13() > 0.001
		end,
		Frame({
			Name = "TopGlow",
			Size = function() --[[ Size ]] -- line: 71
				-- upvalues: v14 (copy)
				return UDim2.fromScale(1, 0.3 + v14())
			end,
			BackgroundColor3 = function() --[[ BackgroundColor3 ]] -- line: 74
				-- upvalues: getActiveSpecialRollColor (copy)
				return getActiveSpecialRollColor()
			end,
			BackgroundTransparency = function() --[[ BackgroundTransparency ]] -- line: 77
				-- upvalues: v13 (copy)
				return 1 - 0.42 * v13()
			end,
			BorderSizePixel = 0,
			UIGradient({
				Rotation = 90,
				Transparency = numberSequence
			})
		}),
		Frame({
			Name = "BottomGlow",
			Size = function() --[[ Size ]] -- line: 90
				-- upvalues: v14 (copy)
				return UDim2.fromScale(1, 0.3 + v14())
			end,
			Position = function() --[[ Position ]] -- line: 93
				-- upvalues: v14 (copy)
				local v17 = 0.3 + v14()

				return UDim2.fromScale(0, 1 - v17)
			end,
			BackgroundColor3 = function() --[[ BackgroundColor3 ]] -- line: 97
				-- upvalues: getActiveSpecialRollColor (copy)
				return getActiveSpecialRollColor()
			end,
			BackgroundTransparency = function() --[[ BackgroundTransparency ]] -- line: 100
				-- upvalues: v13 (copy)
				return 1 - 0.42 * v13()
			end,
			BorderSizePixel = 0,
			UIGradient({
				Rotation = -90,
				Transparency = numberSequence
			})
		}),
		Frame({
			Name = "LeftGlow",
			Size = function() --[[ Size ]] -- line: 113
				-- upvalues: v14 (copy)
				return UDim2.fromScale(0.3 + v14(), 1)
			end,
			BackgroundColor3 = function() --[[ BackgroundColor3 ]] -- line: 116
				-- upvalues: getActiveSpecialRollColor (copy)
				return getActiveSpecialRollColor()
			end,
			BackgroundTransparency = function() --[[ BackgroundTransparency ]] -- line: 119
				-- upvalues: v13 (copy)
				return 1 - 0.42 * v13()
			end,
			BorderSizePixel = 0,
			UIGradient({
				Rotation = 0,
				Transparency = numberSequence
			})
		}),
		Frame({
			Name = "RightGlow",
			Size = function() --[[ Size ]] -- line: 132
				-- upvalues: v14 (copy)
				return UDim2.fromScale(0.3 + v14(), 1)
			end,
			Position = function() --[[ Position ]] -- line: 135
				-- upvalues: v14 (copy)
				local v18 = 0.3 + v14()

				return UDim2.fromScale(1 - v18, 0)
			end,
			BackgroundColor3 = function() --[[ BackgroundColor3 ]] -- line: 139
				-- upvalues: getActiveSpecialRollColor (copy)
				return getActiveSpecialRollColor()
			end,
			BackgroundTransparency = function() --[[ BackgroundTransparency ]] -- line: 142
				-- upvalues: v13 (copy)
				return 1 - 0.42 * v13()
			end,
			BorderSizePixel = 0,
			UIGradient({
				Rotation = 180,
				Transparency = numberSequence
			})
		})
	})
end
