-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OptionSlider, time of decompilation: Sun May  3 10:11:08 2026 ]]
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Button = require(ReplicatedStorage.Source.Core.UI.Primitives.Button)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIStroke = require(ReplicatedStorage.Source.Core.UI.Primitives.UIStroke)
local color3 = Color3.fromRGB(22, 22, 30)
local color3_2 = Color3.fromRGB(95, 95, 110)
local color3_3 = Color3.fromRGB(97, 211, 255)
local color3_4 = Color3.fromRGB(255, 255, 255)
local color3_5 = Color3.fromRGB(21, 21, 30)
local read = Vide.read

local function getCurrentIndex(t1: {[any]: any}, p1) -- line: 38
	for v17, v18 in t1 do
		if p1 == v18.value then
			return v17
		end
	end

	if type(p1) == "number" then
		local n1 = 1
		local n2 = 1e999

		for v21, v22 in t1 do
			if type(v22.value) == "number" then
				local v23 = math.abs(v22.value - p1)

				if v23 < n2 then
					n2 = v23
					n1 = v21
				end
			end
		end

		return n1
	end

	return 1
end

return function(t2: {[any]: any}) -- line: 73
	-- upvalues: read (copy), Vide (copy), UserInputService (copy), Frame (copy), color3 (copy), UICorner (copy), getCurrentIndex (copy), color3_3 (copy), color3_4 (copy), UIStroke (copy), color3_5 (copy), color3_2 (copy), Button (copy)
	local v27 = t2.ZIndex or 1
	local u28 = false

	Vide.cleanup(function() -- line: 85
		-- upvalues: u28 (ref)
		u28 = false
	end)

	local connection = UserInputService.InputEnded:Connect(function(input) -- line: 89
		-- upvalues: u28 (ref)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			u28 = false
		end
	end)

	Vide.cleanup(function() -- line: 98
		-- upvalues: connection (copy)
		connection:Disconnect()
	end)

	local t3 = {
		Frame({
			Name = "Track",
			Size = UDim2.fromScale(1.04, 0.32),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = color3,
			BackgroundTransparency = 0,
			ZIndex = v27,
			UICorner({
				CornerRadius = UDim.new(0, 999)
			}),
			Frame({
				BackgroundTransparency = 0,
				Name = "Fill",
				Size = function() --[[ Size ]] -- line: 119
					-- upvalues: read (copy), t2 (copy), getCurrentIndex (copy)
					local v32 = read(t2.Options) or {}
					local v33 = math.max(#(read(t2.Options) or {}), 1)

					if v33 <= 1 then
						return UDim2.fromScale(1, 1)
					end

					local v34 = getCurrentIndex(v32, read(t2.Value))

					return UDim2.fromScale((v34 - 1) / (v33 - 1), 1)
				end,
				BackgroundColor3 = color3_3,
				ZIndex = v27 + 1,
				UICorner({
					CornerRadius = UDim.new(0, 999)
				})
			})
		}),
		Frame({
			BackgroundTransparency = 0,
			Name = "Thumb",
			Size = UDim2.fromScale(0.7, 0.7),
			Position = function() --[[ Position ]] -- line: 142
				-- upvalues: read (copy), t2 (copy), getCurrentIndex (copy)
				local v35 = read(t2.Options) or {}
				local v36 = math.max(#(read(t2.Options) or {}), 1)
				local v37 = getCurrentIndex(v35, read(t2.Value))

				return UDim2.fromScale(if not (v36 <= 1) then (v37 - 1) / (v36 - 1) else 0, 0.5)
			end,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = color3_4,
			ZIndex = v27 + 3,
			Vide.create("UIAspectRatioConstraint")({
				AspectRatio = 1,
				DominantAxis = Enum.DominantAxis.Height
			}),
			UICorner({
				CornerRadius = UDim.new(1, 0)
			}),
			UIStroke({
				Thickness = 2,
				Color = color3_5
			})
		})
	}

	table.insert(t3, Vide.indexes(function() -- line: 170
		-- upvalues: read (copy), t2 (copy)
		return read(t2.Options) or {}
	end, function(p2, p3) -- line: 172
		-- upvalues: Frame (copy), v27 (copy), read (copy), t2 (copy), getCurrentIndex (copy), color3_3 (copy), color3_2 (copy), Vide (copy), UICorner (copy), Button (copy), u28 (ref)
		return Frame({
			Name = `SliderOption{ p3 }`,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = v27 + 2,
			Frame({
				BackgroundTransparency = 0,
				Name = "Marker",
				Size = UDim2.fromScale(0.26, 0.26),
				Position = function() --[[ Position ]] -- line: 183
					-- upvalues: p3 (copy), read (copy), t2 (copy)
					local fromScale = UDim2.fromScale
					local v41 = p3
					local v42 = math.max(#(read(t2.Options) or {}), 1)

					return fromScale(if not (v42 <= 1) then (v41 - 1) / (v42 - 1) else 0, 0.5)
				end,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = function() --[[ BackgroundColor3 ]] -- line: 187
					-- upvalues: getCurrentIndex (copy), read (copy), t2 (copy), p3 (copy), color3_3 (copy), color3_2 (copy)
					if getCurrentIndex(read(t2.Options) or {}, read(t2.Value)) >= p3 then
						return color3_3
					end

					return color3_2
				end,
				ZIndex = v27 + 2,
				Vide.create("UIAspectRatioConstraint")({
					AspectRatio = 1,
					DominantAxis = Enum.DominantAxis.Height
				}),
				UICorner({
					CornerRadius = UDim.new(1, 0)
				})
			}),
			Button({
				Name = "StepButton",
				Image = "",
				BackgroundTransparency = 1,
				HoverScale = 1.03,
				Size = function() --[[ Size ]] -- line: 208
					-- upvalues: read (copy), t2 (copy)
					local v43 = math.max(#(read(t2.Options) or {}), 1)

					return UDim2.fromScale(if not (v43 <= 1) then 1 / v43 else 1, 1)
				end,
				Position = function() --[[ Position ]] -- line: 212
					-- upvalues: read (copy), t2 (copy), p3 (copy)
					local v44 = math.max(#(read(t2.Options) or {}), 1)
					local v45 = if not (v44 <= 1) then (p3 - 0.5) / v44 else 0.5

					return UDim2.fromScale(v45, 0.5)
				end,
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = v27 + 4,
				OnDown = function() --[[ OnDown ]] -- line: 219
					-- upvalues: u28 (ref), t2 (copy), p2 (copy)
					u28 = true
					t2.OnChanged(p2().value)
				end,
				OnEnter = function() --[[ OnEnter ]] -- line: 223
					-- upvalues: u28 (ref), t2 (copy), p2 (copy)
					if u28 then
						t2.OnChanged(p2().value)
					end
				end,
				OnUp = function() --[[ OnUp ]] -- line: 228
					-- upvalues: u28 (ref)
					u28 = false
				end,
				Activated = function() --[[ Activated ]] -- line: 231
					-- upvalues: t2 (copy), p2 (copy)
					t2.OnChanged(p2().value)
				end
			})
		})
	end))

	return Frame({
		Name = "OptionSlider",
		Size = t2.Size or UDim2.fromOffset(260, 34),
		Position = t2.Position,
		AnchorPoint = t2.AnchorPoint,
		LayoutOrder = t2.LayoutOrder,
		BackgroundTransparency = 1,
		ZIndex = v27,
		t3
	})
end
