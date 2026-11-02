-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeTilesContainer, time of decompilation: Sun May  3 10:11:38 2026 ]]
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)

require(ReplicatedStorage.Source.Features.Upgrades.UpgradeCounterUtils)

local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local UpgradeTree = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeTree)
local UpgradeHoverInfo = require(script.Parent.UpgradeHoverInfo)
local UpgradeTile = require(script.Parent.UpgradeTile)
local UpgradeUIUtils = require(script.Parent.UpgradeUIUtils)
local t1 = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.MouseButton2] = true,
	[Enum.UserInputType.MouseMovement] = true,
	[Enum.UserInputType.Touch] = true
}
local t2 = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.MouseButton2] = true,
	[Enum.UserInputType.Touch] = true
}
local t3 = {
	[Enum.KeyCode.ButtonL2] = true,
	[Enum.KeyCode.ButtonR2] = true
}

return function(p1, p2, p3, p4) -- line: 38
	-- upvalues: Vide (copy), Players (copy), UserInputService (copy), t1 (copy), UpgradeSlice (copy), t3 (copy), t2 (copy), UpgradeUIUtils (copy), RunService (copy), UpgradeTree (copy), UpgradeTile (copy), Frame (copy), UpgradeHoverInfo (copy)
	local v19 = Vide.source(UDim2.fromScale(0.5, 0.5))
	local v20 = Vide.spring(v19, 0.25, 0.5)
	local v21 = Vide.source(3.5)
	local vector2 = nil
	local connection = nil
	local u24 = nil
	local u25 = nil
	local zero = Vector2.zero
	local t4 = {
		[Enum.KeyCode.ButtonL2] = false,
		[Enum.KeyCode.ButtonR2] = false
	}

	local function touchIsInsideHoverInfo(vector2_2: Vector2) -- line: 58
		-- upvalues: Players (copy)
		local PlayerGui = Players.LocalPlayer.PlayerGui

		for _, v42 in (PlayerGui:GetGuiObjectsAtPosition(vector2_2.X, vector2_2.Y)) do
			local v43 = v42

			while v43 and v43 ~= PlayerGui do
				if v43.Name == "UpgradeHoverInfo" then
					return true
				end

				v43 = v43.Parent
			end
		end

		return false
	end

	local connection2 = UserInputService.InputBegan:Connect(function(input) -- line: 108
		-- upvalues: p4 (copy), UpgradeSlice (copy), t3 (copy), t4 (copy), t2 (copy), UpgradeUIUtils (copy), p3 (copy), touchIsInsideHoverInfo (copy), vector2 (ref), connection (ref), UserInputService (copy), u25 (ref), t1 (copy), u24 (ref), v19 (copy)
		if p4() == Enum.PreferredInput.Gamepad and (UpgradeSlice.shown() and t3[input.KeyCode]) then
			t4[input.KeyCode] = true

			return
		end

		if t2[input.UserInputType] then
			if input.UserInputType == Enum.UserInputType.Touch and UpgradeUIUtils.isTouchPreferred(p4()) and p3() ~= nil and not UpgradeSlice.moving() and not touchIsInsideHoverInfo(Vector2.new(input.Position.X, input.Position.Y)) then
				p3(nil)
			end

			vector2 = Vector2.new(input.Position.X, input.Position.Y)

			if connection then
				connection:Disconnect()
			end

			connection = UserInputService.InputChanged:Connect(function(input2) -- line: 80
				-- upvalues: vector2 (ref), u25 (ref), t1 (copy), UpgradeSlice (copy), u24 (ref), v19 (copy)
				if not vector2 or u25 ~= nil then
					return
				end

				if not t1[input2.UserInputType] then
					return
				end

				local vector2_3 = Vector2.new(input2.Position.X, input2.Position.Y)

				if UpgradeSlice.moving() then
					local v65 = vector2_3 - u24

					v19(v19() + UDim2.fromOffset(v65.X, v65.Y))
				elseif (Vector2.new(input2.Position.X, input2.Position.Y) - vector2).Magnitude > 10 then
					UpgradeSlice.moving(true)
				end

				u24 = vector2_3
			end)
		end
	end)
	local connection3 = UserInputService.TouchPinch:Connect(function(_, p6, _, p8) -- line: 130
		-- upvalues: u25 (ref), vector2 (ref), UpgradeSlice (copy), v21 (copy)
		if p8 == Enum.UserInputState.Begin then
			u25 = p6
			vector2 = nil
			UpgradeSlice.moving(false)

			return
		end

		if p8 == Enum.UserInputState.Change and u25 ~= nil and u25 ~= 0 then
			local v50 = v21() * (p6 / u25)

			v21((math.clamp(v50, 1.5, 5)))
			u25 = p6

			return
		end

		if p8 == Enum.UserInputState.End or p8 == Enum.UserInputState.Cancel then
			u25 = nil
			UpgradeSlice.inputEndedTime(tick())
		end
	end)
	local connection4 = UserInputService.InputEnded:Connect(function(input) -- line: 150
		-- upvalues: t3 (copy), t4 (copy), t2 (copy), vector2 (ref), UpgradeSlice (copy), connection (ref)
		if t3[input.KeyCode] then
			t4[input.KeyCode] = false
		end

		if t2[input.UserInputType] then
			vector2 = nil
			UpgradeSlice.moving(false)
			UpgradeSlice.inputEndedTime(tick())

			if connection then
				connection:Disconnect()
				connection = nil
			end
		end
	end)
	local connection5 = UserInputService.InputChanged:Connect(function(input) -- line: 166
		-- upvalues: v21 (copy), zero (ref), t3 (copy), t4 (copy)
		if input.UserInputType == Enum.UserInputType.MouseWheel then
			local v53 = v21() + input.Position.Z * 0.3

			v21((math.clamp(v53, 1.5, 5)))

			return
		end

		if input.KeyCode == Enum.KeyCode.Thumbstick2 then
			zero = Vector2.new(input.Position.X, -input.Position.Y)

			return
		end

		if t3[input.KeyCode] then
			local v54 = math.max(input.Position.Z, input.Position.X, input.Position.Y)

			t4[input.KeyCode] = v54 > 0.05
		end
	end)
	local connection6 = RunService.Heartbeat:Connect(function(dt) -- line: 183
		-- upvalues: p4 (copy), UpgradeSlice (copy), zero (ref), t4 (copy), v19 (copy), vector2 (ref), v21 (copy)
		if p4() ~= Enum.PreferredInput.Gamepad or not UpgradeSlice.shown() then
			if zero ~= Vector2.zero then
				zero = Vector2.zero
			end

			t4[Enum.KeyCode.ButtonL2] = false
			t4[Enum.KeyCode.ButtonR2] = false

			return
		end

		local Magnitude = zero.Magnitude

		if Magnitude > 0.12 then
			local v57 = zero.Unit * ((Magnitude - 0.12) / 0.88)

			v19(v19() + UDim2.fromOffset(v57.X * 900 * dt, v57.Y * 900 * dt))
			UpgradeSlice.moving(true)
		elseif UpgradeSlice.moving() and not vector2 then
			UpgradeSlice.moving(false)
			UpgradeSlice.inputEndedTime(tick())
		end

		local v58 = (not t4[Enum.KeyCode.ButtonR2] and 0 or 1) - (not t4[Enum.KeyCode.ButtonL2] and 0 or 1)

		if v58 ~= 0 then
			local v59 = v21() + v58 * 1.8 * dt

			v21((math.clamp(v59, 1.5, 5)))
		end
	end)

	Vide.cleanup(function() -- line: 210
		-- upvalues: connection (ref), connection5 (copy), connection3 (copy), connection2 (copy), connection4 (copy), connection6 (copy)
		if connection then
			connection:Disconnect()
		end

		if connection5 then
			connection5:Disconnect()
		end

		if connection3 then
			connection3:Disconnect()
		end

		if connection2 then
			connection2:Disconnect()
		end

		if connection4 then
			connection4:Disconnect()
		end

		if connection6 then
			connection6:Disconnect()
		end
	end)

	local t5 = {}

	for _, v36 in UpgradeTree do
		for _, v38 in v36 do
			table.insert(t5, UpgradeTile(v38, p1, p2, p3, p4))
		end
	end

	return Frame({
		Position = v20,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = function() --[[ Size ]] -- line: 241
			-- upvalues: v21 (copy)
			return UDim2.fromScale(v21(), v21())
		end,
		Vide.create("UIAspectRatioConstraint")({
			AspectRatio = 1.86799501867995
		}),
		t5,
		UpgradeHoverInfo(p3, p1, p2, p4)
	})
end
