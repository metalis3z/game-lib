-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RareRollCutscene, time of decompilation: Sun May  3 10:11:48 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local Vide = require(ReplicatedStorage.Packages.Vide)
local ConfettiSequence = require(ReplicatedStorage.Source.Core.UI.Components.ConfettiSequence)
local ParticleEmitter2D = require(ReplicatedStorage.Source.Core.UI.Components.ParticleEmitter2D)
local AutoScaledFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.AutoScaledFrame)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local RareRollCutsceneVisuals = require(ReplicatedStorage.Source.Features.Roll.RareRollCutsceneVisuals)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local RarityTiers = require(ReplicatedStorage.Source.Game.Items.RarityTiers)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local v19 = 0.5 + RareRollCutsceneVisuals.duration
local color3 = Color3.fromRGB(77, 77, 77)
local color3_2 = Color3.fromRGB(28, 12, 8)

local function formatWithCommas(n1: number) -- line: 55
	local str = tostring((math.max(1, (math.floor(n1)))))

	repeat
		local count

		str, count = string.gsub(str, "^(%-?%d+)(%d%d%d)", "%1,%2")
	until count == 0

	return str
end
local function RareRollCutsceneContent() -- line: 83
	-- upvalues: Vide (copy), formatWithCommas (copy), SoundController (copy), Sounds (copy), RollSlice (copy), RunService (copy), InventoryServiceUtils (copy), Slimes (copy), RarityTiers (copy), Mutations (copy), RareRollCutsceneVisuals (copy), Players (copy), v19 (copy), AutoScaledFrame (copy), Frame (copy), ParticleEmitter2D (copy), ConfettiSequence (copy), TextLabel (copy), color3_2 (copy), color3 (copy), UIListLayout (copy)
	local v31 = Vide.source(UDim2.fromScale(1, 1))
	local v32 = Vide.spring(v31, 0.4, 1)
	local v33 = Vide.source(1)
	local v34 = Vide.spring(v33, 0.5, 1)

	v33(0)

	local v35 = Vide.source(false)
	local v36 = Vide.source(0)
	local v37 = Vide.source(1)
	local v38 = Vide.source(93.6)
	local v39 = Vide.spring(v38, 0.55, 0.9)
	local v40 = Vide.source(`<font size="{ 130 }">1 / { formatWithCommas(1) }</font>`)
	local v41 = Vide.source(false)
	local v42 = Vide.source(1)
	local v43 = Vide.spring(v42, 0.45, 1)
	local v44 = Vide.source(0.72)
	local v45 = Vide.spring(v44, 0.55, 0.9)
	local v46 = Vide.source(0)
	local v47 = Vide.source(false)
	local v48 = Vide.source(1)
	local v49 = Vide.spring(v48, 0.5, 1)
	local v50 = Vide.source(-84)
	local v51 = Vide.spring(v50, 0.55, 0.9)
	local v52 = Vide.source("")
	local v53 = Vide.source("")
	local v54 = Vide.source(ColorSequence.new(Color3.fromRGB(255, 255, 255)))
	local v55 = Vide.source(0)

	SoundController:Play(Sounds.misc.cutsceneStart)

	local Sound = SoundController:GetSound(Sounds.ui.rollTick)

	Vide.effect(function() -- line: 117
		-- upvalues: v40 (copy), v37 (copy), v39 (copy), formatWithCommas (copy)
		local v57 = v40
		local v58 = v37()

		v57(`<font size="{ math.max(1, (math.round((v39())))) }">1 / { formatWithCommas(v58) }</font>`)
	end)
	Vide.effect(function() -- line: 121
		-- upvalues: RollSlice (copy), v33 (copy), RunService (copy), Sound (copy), Vide (copy)
		local v59 = RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil

		v33(not v59 and 1 or 0)

		local v60 = not v59 and 0 or 0.3
		local v61 = not v59 and 70 or 30
		local CurrentCamera = workspace.CurrentCamera
		local connection = RunService.Heartbeat:Connect(function(dt: number) -- line: 128
			-- upvalues: Sound (copy), v60 (copy), CurrentCamera (copy), v61 (copy)
			Sound.Volume = math.lerp(Sound.Volume, v60, dt)
			CurrentCamera.FieldOfView = math.lerp(CurrentCamera.FieldOfView, v61, dt * 1.2)
		end)

		Vide.cleanup(function() -- line: 133
			-- upvalues: connection (copy), v59 (copy), Sound (copy), v60 (copy), CurrentCamera (copy), v61 (copy)
			connection:Disconnect()

			if not v59 then
				Sound.Volume = v60
				CurrentCamera.FieldOfView = v61
			end
		end)
	end)
	Vide.effect(function() -- line: 142
		-- upvalues: RollSlice (copy), v41 (copy), v42 (copy), v37 (copy), v38 (copy), v44 (copy), v46 (copy), InventoryServiceUtils (copy), RunService (copy), Vide (copy)
		local v64 = RollSlice.rareRollCutsceneData()

		if v64 == nil then
			v41(false)
			v42(1)
			v37(1)
			v38(93.6)
			v44(0.72)
			v46(0)

			return
		end

		local v65 = math.max(1, (math.ceil(1 / InventoryServiceUtils.getVisualOdds({
			level = 1,
			xp = 0,
			id = v64.id,
			mutations = v64.mutations
		}))))
		local elapsed = os.clock()
		local thread = nil
		local thread2 = nil
		local u69 = false
		local connection = nil

		connection = RunService.Heartbeat:Connect(function() -- line: 162
			-- upvalues: elapsed (copy), v41 (copy), v42 (copy), v44 (copy), v38 (copy), u69 (ref), thread2 (ref), v65 (copy), v37 (copy), v46 (copy), thread (ref), connection (ref)
			local v79 = os.clock() - elapsed - 0.9

			if v79 < 0 then
				v41(false)
				v42(1)
				v44(0.72)
				v38(93.6)

				return
			end

			v41(true)
			v42(0)

			if not u69 then
				u69 = true
				v44(1.18)
				v38(153.4)
				thread2 = task.delay(0.12, function() -- line: 179
					-- upvalues: v44 (copy), v38 (copy)
					v44(1)
					v38(130)
				end)
			end

			local v80 = math.clamp(v79 / 3.5, 0, 1)
			local v81 = if not (v80 <= 0) then if not (v80 >= 1) then 2 ^ (v80 * 10 - 10) else 1 else 0
			local v82 = math.max(1, (math.floor((v65 - 1) * v81 + 1)))

			v37(v82)

			local v83 = 1 - v80
			local v84 = math.abs((math.sin(v79 * 16))) * 0.18 * v83 + 1

			v44(v84)
			v38(v84 * 130)
			v46(math.sin(v79 * 11) * 1.8 * v83)

			if v80 >= 1 then
				v37(v65)
				v44(1.75)
				v38(227.5)
				v46(0)

				if thread then
					task.cancel(thread)
				end

				thread = task.delay(0.22, function() -- line: 204
					-- upvalues: v44 (copy), v38 (copy)
					v44(1)
					v38(130)
				end)
				connection:Disconnect()
			end
		end)
		Vide.cleanup(function() -- line: 212
			-- upvalues: connection (ref), thread2 (ref), thread (ref)
			connection:Disconnect()

			if thread2 then
				task.cancel(thread2)
				thread2 = nil
			end

			if thread then
				task.cancel(thread)
				thread = nil
			end
		end)
	end)
	Vide.effect(function() -- line: 225
		-- upvalues: RollSlice (copy), v55 (copy), Vide (copy)
		if RollSlice.rareRollCutsceneData() == nil then
			return
		end

		local thread = task.delay(5.4, function() -- line: 231
			-- upvalues: v55 (copy)
			v55(v55() + 1)
		end)

		Vide.cleanup(function() -- line: 235
			-- upvalues: thread (ref)
			if thread then
				task.cancel(thread)
				thread = nil
			end
		end)
	end)
	Vide.effect(function() -- line: 243
		-- upvalues: RollSlice (copy), v47 (copy), v48 (copy), v50 (copy), v52 (copy), v53 (copy), Slimes (copy), InventoryServiceUtils (copy), RarityTiers (copy), Mutations (copy), v54 (copy), Vide (copy)
		local v72 = RollSlice.rareRollCutsceneData()

		if v72 == nil then
			v47(false)
			v48(1)
			v50(-84)
			v52("")
			v53("")

			return
		end

		local v73 = Slimes.getSlime(v72.id)
		local v74 = InventoryServiceUtils.getVisualOdds({
			level = 1,
			xp = 0,
			id = v72.id,
			mutations = v72.mutations
		})
		local v75 = RarityTiers.getTier(v74)

		v47(false)
		v48(1)
		v50(-84)
		v52(string.upper(Mutations.getDisplayName(v73.name, v72.mutations)))
		v53(string.upper(v75.name))
		v54(v75.gradient)

		local thread = task.delay(7.4, function() -- line: 266
			-- upvalues: v47 (copy), v48 (copy), v50 (copy)
			v47(true)
			v48(0)
			v50(0)
		end)

		Vide.cleanup(function() -- line: 272
			-- upvalues: thread (ref)
			if thread then
				task.cancel(thread)
				thread = nil
			end
		end)
	end)
	Vide.effect(function() -- line: 280
		-- upvalues: v33 (copy), RareRollCutsceneVisuals (copy), Players (copy), RollSlice (copy), v19 (copy)
		task.spawn(function() -- line: 281
			-- upvalues: v33 (copy), RareRollCutsceneVisuals (copy), Players (copy), RollSlice (copy)
			task.wait(0.5)
			v33(1)
			RareRollCutsceneVisuals.play(Players.LocalPlayer.Character:GetPivot().Position, RollSlice.rareRollCutsceneData())
		end)
		task.delay(v19, function() -- line: 290
			-- upvalues: RollSlice (copy)
			RollSlice.actions.finishRareRollCutscene()
		end)
	end)

	return AutoScaledFrame({
		Name = "RareRollCutscene",
		Size = UDim2.fromOffset(1500, 800),
		ZIndex = 99999,
		Frame({
			Name = "Vignette",
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1.3, 1.3),
			BackgroundColor3 = Color3.fromRGB(8, 10, 12),
			BackgroundTransparency = v34,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}),
		Frame({
			Name = "Content",
			Size = v32,
			ZIndex = 2,
			ParticleEmitter2D({
				UIName = "StarsEmitter",
				Texture = "rbxassetid://13275495915",
				Rate = 5,
				Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
				UISize = UDim2.fromScale(1, 1),
				Size = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(0.15, 0.4),
					NumberSequenceKeypoint.new(0.85, 0.4),
					NumberSequenceKeypoint.new(1, 0)
				}),
				Lifetime = NumberRange.new(0.75, 2),
				Enabled = v35,
				Burst = v36,
				Rotation = NumberRange.new(0, 360),
				RotSpeed = NumberRange.new(-90, 90)
			}),
			ConfettiSequence({
				Name = "RevealConfetti",
				Preset = "sideCannons",
				ZIndex = 100000,
				Trigger = v55
			}),
			TextLabel({
				Name = "OddsCounter",
				BackgroundTransparency = 1,
				TextScaled = false,
				TextSize = 100,
				RichText = true,
				Visible = v41,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.82),
				Size = function() --[[ Size ]] -- line: 346
					-- upvalues: v45 (copy)
					local v77 = v45()

					return UDim2.fromOffset(546 * v77, 96 * v77)
				end,
				Text = v40,
				TextColor3 = Color3.fromRGB(255, 247, 176),
				FontFace = Font.fromEnum(Enum.Font.FredokaOne),
				Rotation = v46,
				TextTransparency = v43,
				Stroke = {
					Thickness = 4,
					Color = Color3.fromRGB(58, 24, 8),
					Transparency = v43
				},
				DropShadow = {
					Transparency = function() --[[ Transparency ]] -- line: 365
						-- upvalues: v43 (copy)
						return (math.min(1, 0.2 + v43() * 0.8))
					end,
					Offset = UDim2.fromOffset(0, 6)
				},
				Gradient = {
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 233, 122)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 64))
					})
				}
			}),
			Frame({
				Name = "SlimeRevealInfo",
				Visible = v47,
				AnchorPoint = Vector2.new(0.5, 0),
				Position = function() --[[ Position ]] -- line: 384
					-- upvalues: v51 (copy)
					return UDim2.new(0.5, 0, 0.085, v51())
				end,
				Size = UDim2.fromScale(0.7, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ZIndex = 100000,
				TextLabel({
					Name = "SlimeName",
					BackgroundTransparency = 1,
					TextScaled = true,
					ZIndex = 100001,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = UDim2.new(1, 0, 0, 90),
					Text = v52,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.fromEnum(Enum.Font.FredokaOne),
					TextTransparency = v49,
					Stroke = {
						Thickness = 3,
						Color = color3_2,
						Transparency = v49
					},
					DropShadow = {
						Transparency = function() --[[ Transparency ]] -- line: 410
							-- upvalues: v49 (copy)
							return (math.min(1, 0.25 + v49() * 0.75))
						end,
						Offset = UDim2.fromOffset(0, 5)
					}
				}),
				TextLabel({
					Name = "Rarity",
					BackgroundTransparency = 1,
					TextScaled = true,
					ZIndex = 100001,
					LayoutOrder = 2,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = UDim2.new(1, 0, 0, 50),
					Text = v53,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					FontFace = Font.fromEnum(Enum.Font.FredokaOne),
					TextTransparency = v49,
					Stroke = {
						Thickness = 3,
						Color = color3,
						Transparency = v49
					},
					Gradient = {
						Rotation = 90,
						Color = v54
					}
				}),
				UIListLayout({
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					Padding = UDim.new(0, 6)
				})
			})
		})
	})
end

return function() -- line: 451
	-- upvalues: Vide (copy), RollSlice (copy), RareRollCutsceneContent (copy)
	return Vide.show(function() -- line: 452
		-- upvalues: RollSlice (copy)
		return RollSlice.rareRollCutsceneShown() or RollSlice.rareRollCutsceneData() ~= nil
	end, function() -- line: 454
		-- upvalues: RareRollCutsceneContent (copy)
		return RareRollCutsceneContent(), 0.3
	end)
end
