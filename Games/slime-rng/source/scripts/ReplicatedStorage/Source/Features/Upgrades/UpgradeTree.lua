-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: UpgradeTree, time of decompilation: Sun May  3 10:11:35 2026 ]]
local ImageLabel, UpgradeServiceUtils, ImageIds, sides, originDependency, t14, t89

do
	local TextLabel

	do
		local AddSuffix, enums, createSubIconOverlay, createRepeatedImageIcon

		do
			local createCountBadgeIcon, createMutatedEnemyIcon, createShinyEnemyIcon

			do
				local SlimeIcon

				do
					local ReplicatedStorage = game:GetService("ReplicatedStorage")

					AddSuffix = require(ReplicatedStorage.Source.Core.UI.AddSuffix)
					ImageLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.ImageLabel)
					TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
					SlimeIcon = require(ReplicatedStorage.Source.Features.App.Components.SlimeIcon)
					UpgradeServiceUtils = require(script.Parent.UpgradeServiceUtils)
					ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
				end

				enums = UpgradeServiceUtils.enums
				sides = UpgradeServiceUtils.enums.sides
				originDependency = UpgradeServiceUtils.enums.originDependency

				function createCountBadgeIcon(s1: string, s2: string, color3: Color3?) -- line: 179
					-- upvalues: ImageLabel (copy), TextLabel (copy)
					local t1 = {}
					local v385 = {
						Size = UDim2.fromScale(0.92, 0.92),
						Position = UDim2.fromScale(0.5, 0.5)
					} or {}

					local function v386() -- line: 123
						-- upvalues: ImageLabel (copy), s1 (copy), v385 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = s1,
							ScaleType = Enum.ScaleType.Fit,
							Size = v385.Size or UDim2.fromScale(1, 1),
							Position = v385.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = v385.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = v385.ImageColor3,
							ImageTransparency = v385.ImageTransparency,
							Rotation = v385.Rotation,
							ZIndex = v385.ZIndex or 2
						}) }
					end

					local v387 = {
						ZIndex = 3,
						Size = UDim2.fromScale(0.34, 0.34),
						Position = UDim2.fromScale(0.76, 0.27),
						TextColor3 = color3
					} or {}

					local function v388() -- line: 144
						-- upvalues: TextLabel (copy), s2 (copy), v387 (copy)
						return { TextLabel({
							Name = "UpgradeIconText",
							TextWrapped = true,
							Text = s2,
							Size = v387.Size or UDim2.fromScale(1, 1),
							Position = v387.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = v387.AnchorPoint or Vector2.new(0.5, 0.5),
							TextColor3 = v387.TextColor3,
							TextSize = v387.TextSize,
							Font = v387.Font,
							Rotation = v387.Rotation,
							Stroke = v387.Stroke or {},
							DropShadow = v387.DropShadow or {},
							ZIndex = v387.ZIndex or 2
						}) }
					end

					t1[1] = v386
					t1[2] = v388

					return function() -- line: 166
						-- upvalues: t1 (copy)
						local t2 = {}

						for _, v495 in t1 do
							for _, v497 in v495() do
								table.insert(t2, v497)
							end
						end

						return t2
					end
				end
				function createSubIconOverlay(s3: string, s4: string) -- line: 194
					-- upvalues: ImageLabel (copy)
					local t3 = {}
					local v392 = {
						Size = UDim2.fromScale(0.88, 0.88),
						Position = UDim2.fromScale(0.5, 0.5)
					} or {}

					local function v393() -- line: 123
						-- upvalues: ImageLabel (copy), s3 (copy), v392 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = s3,
							ScaleType = Enum.ScaleType.Fit,
							Size = v392.Size or UDim2.fromScale(1, 1),
							Position = v392.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = v392.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = v392.ImageColor3,
							ImageTransparency = v392.ImageTransparency,
							Rotation = v392.Rotation,
							ZIndex = v392.ZIndex or 2
						}) }
					end

					local v394 = {
						ZIndex = 3,
						Size = UDim2.fromScale(0.34, 0.34),
						Position = UDim2.fromScale(0.76, 0.27)
					} or {}

					local function v395() -- line: 123
						-- upvalues: ImageLabel (copy), s4 (copy), v394 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = s4,
							ScaleType = Enum.ScaleType.Fit,
							Size = v394.Size or UDim2.fromScale(1, 1),
							Position = v394.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = v394.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = v394.ImageColor3,
							ImageTransparency = v394.ImageTransparency,
							Rotation = v394.Rotation,
							ZIndex = v394.ZIndex or 2
						}) }
					end

					t3[1] = v393
					t3[2] = v395

					return function() -- line: 166
						-- upvalues: t3 (copy)
						local t4 = {}

						for _, v500 in t3 do
							for _, v502 in v500() do
								table.insert(t4, v502)
							end
						end

						return t4
					end
				end

				do
					local function createDoubleImageIcon(s5: string) -- line: 208
						-- upvalues: ImageLabel (copy)
						local t5 = {}
						local v398 = {
							Rotation = -10,
							Size = UDim2.fromScale(0.56, 0.56),
							Position = UDim2.fromScale(0.38, 0.62)
						} or {}

						local function v399() -- line: 123
							-- upvalues: ImageLabel (copy), s5 (copy), v398 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = s5,
								ScaleType = Enum.ScaleType.Fit,
								Size = v398.Size or UDim2.fromScale(1, 1),
								Position = v398.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = v398.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = v398.ImageColor3,
								ImageTransparency = v398.ImageTransparency,
								Rotation = v398.Rotation,
								ZIndex = v398.ZIndex or 2
							}) }
						end

						local v400 = {
							Rotation = 10,
							ZIndex = 3,
							Size = UDim2.fromScale(0.56, 0.56),
							Position = UDim2.fromScale(0.62, 0.38)
						} or {}

						local function v401() -- line: 123
							-- upvalues: ImageLabel (copy), s5 (copy), v400 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = s5,
								ScaleType = Enum.ScaleType.Fit,
								Size = v400.Size or UDim2.fromScale(1, 1),
								Position = v400.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = v400.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = v400.ImageColor3,
								ImageTransparency = v400.ImageTransparency,
								Rotation = v400.Rotation,
								ZIndex = v400.ZIndex or 2
							}) }
						end

						t5[1] = v399
						t5[2] = v401

						return function() -- line: 166
							-- upvalues: t5 (copy)
							local t6 = {}

							for _, v505 in t5 do
								for _, v507 in v505() do
									table.insert(t6, v507)
								end
							end

							return t6
						end
					end

					do
						local function createCloverBadgeIcon(p1: ((...any) -> ...any)) -- line: 224
							-- upvalues: ImageIds (copy), ImageLabel (copy)
							local t7 = {}
							local v404 = ImageIds.luckIcons[1]
							local v405 = {
								ZIndex = 4,
								Size = UDim2.fromScale(0.36, 0.36),
								Position = UDim2.fromScale(0.78, 0.22)
							} or {}

							local function v406() -- line: 123
								-- upvalues: ImageLabel (copy), v404 (copy), v405 (copy)
								return { ImageLabel({
									Name = "UpgradeIconImage",
									Image = v404,
									ScaleType = Enum.ScaleType.Fit,
									Size = v405.Size or UDim2.fromScale(1, 1),
									Position = v405.Position or UDim2.fromScale(0.5, 0.5),
									AnchorPoint = v405.AnchorPoint or Vector2.new(0.5, 0.5),
									ImageColor3 = v405.ImageColor3,
									ImageTransparency = v405.ImageTransparency,
									Rotation = v405.Rotation,
									ZIndex = v405.ZIndex or 2
								}) }
							end

							t7[1] = p1
							t7[2] = v406

							return function() -- line: 166
								-- upvalues: t7 (copy)
								local t8 = {}

								for _, v510 in t7 do
									for _, v512 in v510() do
										table.insert(t8, v512)
									end
								end

								return t8
							end
						end

						function createMutatedEnemyIcon(s6: string, b1: boolean?) -- line: 235
							-- upvalues: ImageLabel (copy), createCloverBadgeIcon (copy)
							local v409 = {
								Size = UDim2.fromScale(1.12, 1.12),
								Position = UDim2.fromScale(0.5, 0.5)
							} or {}

							local function v410() -- line: 123
								-- upvalues: ImageLabel (copy), s6 (copy), v409 (copy)
								return { ImageLabel({
									Name = "UpgradeIconImage",
									Image = s6,
									ScaleType = Enum.ScaleType.Fit,
									Size = v409.Size or UDim2.fromScale(1, 1),
									Position = v409.Position or UDim2.fromScale(0.5, 0.5),
									AnchorPoint = v409.AnchorPoint or Vector2.new(0.5, 0.5),
									ImageColor3 = v409.ImageColor3,
									ImageTransparency = v409.ImageTransparency,
									Rotation = v409.Rotation,
									ZIndex = v409.ZIndex or 2
								}) }
							end

							if b1 then
								return (createCloverBadgeIcon(v410))
							end

							return v410
						end
						function createShinyEnemyIcon(b2: boolean?) -- line: 244
							-- upvalues: ImageIds (copy), ImageLabel (copy), createCloverBadgeIcon (copy)
							local t9 = {}
							local enemyIcon = ImageIds.enemyIcon
							local v414 = {
								Size = UDim2.fromScale(1.12, 1.12),
								Position = UDim2.fromScale(0.5, 0.5)
							} or {}

							local function v415() -- line: 123
								-- upvalues: ImageLabel (copy), enemyIcon (copy), v414 (copy)
								return { ImageLabel({
									Name = "UpgradeIconImage",
									Image = enemyIcon,
									ScaleType = Enum.ScaleType.Fit,
									Size = v414.Size or UDim2.fromScale(1, 1),
									Position = v414.Position or UDim2.fromScale(0.5, 0.5),
									AnchorPoint = v414.AnchorPoint or Vector2.new(0.5, 0.5),
									ImageColor3 = v414.ImageColor3,
									ImageTransparency = v414.ImageTransparency,
									Rotation = v414.Rotation,
									ZIndex = v414.ZIndex or 2
								}) }
							end

							local shinyOverlay = ImageIds.shinyOverlay
							local v417 = {
								ZIndex = 3,
								Size = UDim2.fromScale(1.08, 1.08),
								Position = UDim2.fromScale(0.5, 0.5)
							} or {}

							local function v418() -- line: 123
								-- upvalues: ImageLabel (copy), shinyOverlay (copy), v417 (copy)
								return { ImageLabel({
									Name = "UpgradeIconImage",
									Image = shinyOverlay,
									ScaleType = Enum.ScaleType.Fit,
									Size = v417.Size or UDim2.fromScale(1, 1),
									Position = v417.Position or UDim2.fromScale(0.5, 0.5),
									AnchorPoint = v417.AnchorPoint or Vector2.new(0.5, 0.5),
									ImageColor3 = v417.ImageColor3,
									ImageTransparency = v417.ImageTransparency,
									Rotation = v417.Rotation,
									ZIndex = v417.ZIndex or 2
								}) }
							end

							t9[1] = v415
							t9[2] = v418

							local function v419() -- line: 166
								-- upvalues: t9 (copy)
								local t10 = {}

								for _, v515 in t9 do
									for _, v517 in v515() do
										table.insert(t10, v517)
									end
								end

								return t10
							end

							if b2 then
								return (createCloverBadgeIcon(v419))
							end

							return v419
						end
					end

					function createRepeatedImageIcon(s7: string, n1: number) -- line: 260
						-- upvalues: ImageLabel (copy)
						local t11 = {
							[1] = { UDim2.fromScale(0.5, 0.5) },
							[2] = {
								UDim2.fromScale(0.38, 0.58),
								UDim2.fromScale(0.62, 0.42)
							},
							[3] = {
								UDim2.fromScale(0.3, 0.58),
								UDim2.fromScale(0.5, 0.38),
								UDim2.fromScale(0.7, 0.58)
							}
						}
						local t12 = {
							[1] = 1,
							[2] = 0.8,
							[3] = 0.7
						}

						return function() -- line: 281
							-- upvalues: t11 (copy), n1 (copy), t12 (copy), s7 (copy), ImageLabel (copy)
							local t13 = {}
							local v519 = t11[math.clamp(n1, 1, 3)] or t11[1]
							local v520 = t12[math.clamp(n1, 1, 3)] or t12[1]

							for v521, v522 in v519 do
								local v523 = s7
								local v524 = {
									Size = UDim2.fromScale(v520, v520),
									Position = v522,
									ZIndex = 1 + v521
								} or {}

								table.insert(t13, (function() -- line: 123
									-- upvalues: ImageLabel (copy), v523 (copy), v524 (copy)
									return { ImageLabel({
										Name = "UpgradeIconImage",
										Image = v523,
										ScaleType = Enum.ScaleType.Fit,
										Size = v524.Size or UDim2.fromScale(1, 1),
										Position = v524.Position or UDim2.fromScale(0.5, 0.5),
										AnchorPoint = v524.AnchorPoint or Vector2.new(0.5, 0.5),
										ImageColor3 = v524.ImageColor3,
										ImageTransparency = v524.ImageTransparency,
										Rotation = v524.Rotation,
										ZIndex = v524.ZIndex or 2
									}) }
								end)()[1])
							end

							return t13
						end
					end

					t14 = {}

					do
						local t15 = {
							name = "Backpack",
							description = "Unlock the Backpack so you can manage slime equips."
						}
						local backpack = ImageIds.backpack
						local t16 = {}

						function t15.icon() -- line: 123
							-- upvalues: ImageLabel (copy), backpack (copy), t16 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = backpack,
								ScaleType = Enum.ScaleType.Fit,
								Size = t16.Size or UDim2.fromScale(1, 1),
								Position = t16.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t16.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t16.ImageColor3,
								ImageTransparency = t16.ImageTransparency,
								Rotation = t16.Rotation,
								ZIndex = t16.ZIndex or 2
							}) }
						end

						t15.dependency = originDependency
						t15.side = sides.origin
						t15.cost = {
							currency = "coins",
							amount = 100
						}
						t14.backpack = t15
					end

					do
						local t17 = {
							name = "Auto Roll",
							description = "",
							dependency = "backpack"
						}
						local autoRoll = ImageIds.autoRoll
						local t18 = {}

						function t17.icon() -- line: 123
							-- upvalues: ImageLabel (copy), autoRoll (copy), t18 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = autoRoll,
								ScaleType = Enum.ScaleType.Fit,
								Size = t18.Size or UDim2.fromScale(1, 1),
								Position = t18.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t18.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t18.ImageColor3,
								ImageTransparency = t18.ImageTransparency,
								Rotation = t18.Rotation,
								ZIndex = t18.ZIndex or 2
							}) }
						end

						t17.side = sides.top
						t17.cost = {
							currency = "coins",
							amount = 200
						}
						t14.autoRoll = t17
					end

					do
						local t19 = {
							name = "Roll Speed",
							dependency = "backpack",
							description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("rollSpeed", 1) - 1) * 100) }% faster rolls!`
						}
						local dice = ImageIds.dice
						local t20 = {}

						function t19.icon() -- line: 123
							-- upvalues: ImageLabel (copy), dice (copy), t20 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = dice,
								ScaleType = Enum.ScaleType.Fit,
								Size = t20.Size or UDim2.fromScale(1, 1),
								Position = t20.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t20.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t20.ImageColor3,
								ImageTransparency = t20.ImageTransparency,
								Rotation = t20.Rotation,
								ZIndex = t20.ZIndex or 2
							}) }
						end

						t19.side = sides.botRight
						t19.cost = {
							currency = "rollCurrency",
							amount = 25
						}
						t14.rollSpeed1 = t19
					end

					do
						local t21 = {
							name = "Faster Rolls",
							dependency = "rollSpeed1",
							description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("rollSpeed", 2) - 1) * 100) }% faster rolls!`
						}
						local dice = ImageIds.dice
						local t22 = {}

						function t21.icon() -- line: 123
							-- upvalues: ImageLabel (copy), dice (copy), t22 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = dice,
								ScaleType = Enum.ScaleType.Fit,
								Size = t22.Size or UDim2.fromScale(1, 1),
								Position = t22.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t22.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t22.ImageColor3,
								ImageTransparency = t22.ImageTransparency,
								Rotation = t22.Rotation,
								ZIndex = t22.ZIndex or 2
							}) }
						end

						t21.side = sides.botRight
						t21.cost = {
							currency = "rollCurrency",
							amount = 100
						}
						t14.rollSpeed2 = t21
					end

					do
						local t23 = {
							name = "Rapid Rolls",
							dependency = "rollSpeed2",
							description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("rollSpeed", 3) - 1) * 100) }% faster rolls!`
						}
						local dice = ImageIds.dice
						local t24 = {}

						function t23.icon() -- line: 123
							-- upvalues: ImageLabel (copy), dice (copy), t24 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = dice,
								ScaleType = Enum.ScaleType.Fit,
								Size = t24.Size or UDim2.fromScale(1, 1),
								Position = t24.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t24.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t24.ImageColor3,
								ImageTransparency = t24.ImageTransparency,
								Rotation = t24.Rotation,
								ZIndex = t24.ZIndex or 2
							}) }
						end

						t23.side = sides.botRight
						t23.cost = {
							currency = "rollCurrency",
							amount = 1000
						}
						t14.rollSpeed3 = t23
					end

					do
						local t25 = {
							name = "Quick Rolls",
							dependency = "rollSpeed3",
							description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("rollSpeed", 4) - 1) * 100) }% faster rolls!`
						}
						local dice = ImageIds.dice
						local t26 = {}

						function t25.icon() -- line: 123
							-- upvalues: ImageLabel (copy), dice (copy), t26 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = dice,
								ScaleType = Enum.ScaleType.Fit,
								Size = t26.Size or UDim2.fromScale(1, 1),
								Position = t26.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t26.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t26.ImageColor3,
								ImageTransparency = t26.ImageTransparency,
								Rotation = t26.Rotation,
								ZIndex = t26.ZIndex or 2
							}) }
						end

						t25.side = sides.bot
						t25.cost = {
							currency = "rollCurrency",
							amount = 3000
						}
						t14.rollSpeed4 = t25
					end

					do
						local t27 = {
							name = "Speed Rolls",
							dependency = "rollSpeed4",
							description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("rollSpeed", 5) - 1) * 100) }% faster rolls!`
						}
						local dice = ImageIds.dice
						local t28 = {}

						function t27.icon() -- line: 123
							-- upvalues: ImageLabel (copy), dice (copy), t28 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = dice,
								ScaleType = Enum.ScaleType.Fit,
								Size = t28.Size or UDim2.fromScale(1, 1),
								Position = t28.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t28.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t28.ImageColor3,
								ImageTransparency = t28.ImageTransparency,
								Rotation = t28.Rotation,
								ZIndex = t28.ZIndex or 2
							}) }
						end

						t27.side = sides.bot
						t27.cost = {
							currency = "rollCurrency",
							amount = 9000
						}
						t14.rollSpeed5 = t27
					end

					do
						local t29 = {
							name = "Lightning Rolls",
							dependency = "rollSpeed5",
							description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("rollSpeed", 6) - 1) * 100) }% faster rolls!`
						}
						local dice = ImageIds.dice
						local t30 = {}

						function t29.icon() -- line: 123
							-- upvalues: ImageLabel (copy), dice (copy), t30 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = dice,
								ScaleType = Enum.ScaleType.Fit,
								Size = t30.Size or UDim2.fromScale(1, 1),
								Position = t30.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t30.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t30.ImageColor3,
								ImageTransparency = t30.ImageTransparency,
								Rotation = t30.Rotation,
								ZIndex = t30.ZIndex or 2
							}) }
						end

						t29.side = sides.bot
						t29.cost = {
							currency = "rollCurrency",
							amount = 27000
						}
						t14.rollSpeed6 = t29
					end

					t14.extraRollChance1 = {
						name = "Extra Roll",
						dependency = "rollSpeed4",
						description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("extraRollChance", 1) * 100) }% chance for an extra roll column!`,
						icon = createDoubleImageIcon(ImageIds.dice),
						side = sides.botRight,
						cost = {
							currency = "rollCurrency",
							amount = 6000
						}
					}
					t14.extraRollChance2 = {
						name = "Bonus Column",
						dependency = "extraRollChance1",
						description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("extraRollChance", 2) * 100) }% chance for an extra roll column!`,
						icon = createDoubleImageIcon(ImageIds.dice),
						side = sides.botRight,
						cost = {
							currency = "rollCurrency",
							amount = 15000
						}
					}
					t14.extraRollChance3 = {
						name = "Column Surge",
						dependency = "extraRollChance2",
						description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("extraRollChance", 3) * 100) }% chance for an extra roll column!`,
						icon = createDoubleImageIcon(ImageIds.dice),
						side = sides.bot,
						cost = {
							currency = "rollCurrency",
							amount = 35000
						}
					}

					local t31 = {
						name = "More Clovers",
						dependency = "rollSpeed1",
						description = `Clover rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("cloverRolls", 1) - 1) * 100) }% more often!`
					}
					local v44 = ImageIds.luckIcons[1]
					local t32 = {}

					function t31.icon() -- line: 123
						-- upvalues: ImageLabel (copy), v44 (copy), t32 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = v44,
							ScaleType = Enum.ScaleType.Fit,
							Size = t32.Size or UDim2.fromScale(1, 1),
							Position = t32.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t32.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t32.ImageColor3,
							ImageTransparency = t32.ImageTransparency,
							Rotation = t32.Rotation,
							ZIndex = t32.ZIndex or 2
						}) }
					end

					t31.side = sides.topRight
					t31.cost = {
						currency = "rollCurrency",
						amount = 125
					}
					t14.cloverRolls1 = t31
				end

				do
					local t33 = {
						name = "More Clovers II",
						dependency = "cloverRolls1",
						description = `Clover rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("cloverRolls", 2) - 1) * 100) }% more often!`
					}
					local v47 = ImageIds.luckIcons[2]
					local t34 = {}

					function t33.icon() -- line: 123
						-- upvalues: ImageLabel (copy), v47 (copy), t34 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = v47,
							ScaleType = Enum.ScaleType.Fit,
							Size = t34.Size or UDim2.fromScale(1, 1),
							Position = t34.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t34.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t34.ImageColor3,
							ImageTransparency = t34.ImageTransparency,
							Rotation = t34.Rotation,
							ZIndex = t34.ZIndex or 2
						}) }
					end

					t33.side = sides.topRight
					t33.cost = {
						currency = "rollCurrency",
						amount = 1500
					}
					t14.cloverRolls2 = t33

					local t35 = {
						name = "More Clovers III",
						dependency = "cloverRolls2",
						description = `Clover rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("cloverRolls", 3) - 1) * 100) }% more often!`
					}
					local v50 = ImageIds.luckIcons[3]
					local t36 = {}

					function t35.icon() -- line: 123
						-- upvalues: ImageLabel (copy), v50 (copy), t36 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = v50,
							ScaleType = Enum.ScaleType.Fit,
							Size = t36.Size or UDim2.fromScale(1, 1),
							Position = t36.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t36.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t36.ImageColor3,
							ImageTransparency = t36.ImageTransparency,
							Rotation = t36.Rotation,
							ZIndex = t36.ZIndex or 2
						}) }
					end

					t35.side = sides.botRight
					t35.cost = {
						currency = "rollCurrency",
						amount = 10000
					}
					t14.cloverRolls3 = t35
				end

				do
					local t37 = {
						name = "More Clovers IV",
						dependency = "cloverRolls3",
						description = `Clover rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("cloverRolls", 4) - 1) * 100) }% more often!`
					}
					local v53 = ImageIds.luckIcons[4]
					local t38 = {}

					function t37.icon() -- line: 123
						-- upvalues: ImageLabel (copy), v53 (copy), t38 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = v53,
							ScaleType = Enum.ScaleType.Fit,
							Size = t38.Size or UDim2.fromScale(1, 1),
							Position = t38.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t38.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t38.ImageColor3,
							ImageTransparency = t38.ImageTransparency,
							Rotation = t38.Rotation,
							ZIndex = t38.ZIndex or 2
						}) }
					end

					t37.side = sides.botRight
					t37.cost = {
						currency = "rollCurrency",
						amount = 70000
					}
					t14.cloverRolls4 = t37

					local t39 = {
						name = "More Clovers V",
						dependency = "cloverRolls4",
						description = `Clover rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("cloverRolls", 5) - 1) * 100) }% more often!`
					}
					local v56 = ImageIds.luckIcons[5]
					local t40 = {}

					function t39.icon() -- line: 123
						-- upvalues: ImageLabel (copy), v56 (copy), t40 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = v56,
							ScaleType = Enum.ScaleType.Fit,
							Size = t40.Size or UDim2.fromScale(1, 1),
							Position = t40.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t40.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t40.ImageColor3,
							ImageTransparency = t40.ImageTransparency,
							Rotation = t40.Rotation,
							ZIndex = t40.ZIndex or 2
						}) }
					end

					t39.side = sides.bot
					t39.cost = {
						currency = "rollCurrency",
						amount = 210000
					}
					t14.cloverRolls5 = t39
				end

				do
					local t41 = {
						name = "Bonus Chance",
						dependency = "rollSpeed1",
						description = `BONUS rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("bonusRolls", 1) - 1) * 100) }% more often!`
					}
					local bonusRoll = ImageIds.bonusRoll
					local t42 = {}

					function t41.icon() -- line: 123
						-- upvalues: ImageLabel (copy), bonusRoll (copy), t42 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = bonusRoll,
							ScaleType = Enum.ScaleType.Fit,
							Size = t42.Size or UDim2.fromScale(1, 1),
							Position = t42.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t42.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t42.ImageColor3,
							ImageTransparency = t42.ImageTransparency,
							Rotation = t42.Rotation,
							ZIndex = t42.ZIndex or 2
						}) }
					end

					t41.side = sides.bot
					t41.cost = {
						currency = "rollCurrency",
						amount = 300
					}
					t14.bonusRolls1 = t41

					local t43 = {
						name = "Bonus Chains",
						dependency = "bonusRolls1",
						description = `BONUS rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("bonusRolls", 2) - 1) * 100) }% more often!`
					}
					local bonusRoll2 = ImageIds.bonusRoll
					local t44 = {}

					function t43.icon() -- line: 123
						-- upvalues: ImageLabel (copy), bonusRoll2 (copy), t44 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = bonusRoll2,
							ScaleType = Enum.ScaleType.Fit,
							Size = t44.Size or UDim2.fromScale(1, 1),
							Position = t44.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = t44.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = t44.ImageColor3,
							ImageTransparency = t44.ImageTransparency,
							Rotation = t44.Rotation,
							ZIndex = t44.ZIndex or 2
						}) }
					end

					t43.side = sides.bot
					t43.cost = {
						currency = "rollCurrency",
						amount = 5000
					}
					t14.bonusRolls2 = t43
				end

				do
					local t47, t48, v71

					do
						local t45 = {
							name = "Bonus Frenzy",
							dependency = "bonusRolls2",
							description = `BONUS rolls happen { math.round((UpgradeServiceUtils.getUpgradeValue("bonusRolls", 3) - 1) * 100) }% more often!`
						}
						local bonusRoll = ImageIds.bonusRoll
						local t46 = {}

						function t45.icon() -- line: 123
							-- upvalues: ImageLabel (copy), bonusRoll (copy), t46 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = bonusRoll,
								ScaleType = Enum.ScaleType.Fit,
								Size = t46.Size or UDim2.fromScale(1, 1),
								Position = t46.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = t46.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = t46.ImageColor3,
								ImageTransparency = t46.ImageTransparency,
								Rotation = t46.Rotation,
								ZIndex = t46.ZIndex or 2
							}) }
						end

						t45.side = sides.botLeft
						t45.cost = {
							currency = "rollCurrency",
							amount = 10000
						}
						t14.bonusRolls3 = t45
						t47 = {
							name = "Loot",
							description = "Open loot upgrades and item drops.",
							dependency = "autoRoll",
							tree = "lootTree"
						}
						t48 = {}

						local coin = ImageIds.coin
						local v70 = {
							Size = UDim2.fromScale(0.62, 0.62),
							Position = UDim2.fromScale(0.42, 0.56)
						} or {}

						function v71() -- line: 123
							-- upvalues: ImageLabel (copy), coin (copy), v70 (copy)
							return { ImageLabel({
								Name = "UpgradeIconImage",
								Image = coin,
								ScaleType = Enum.ScaleType.Fit,
								Size = v70.Size or UDim2.fromScale(1, 1),
								Position = v70.Position or UDim2.fromScale(0.5, 0.5),
								AnchorPoint = v70.AnchorPoint or Vector2.new(0.5, 0.5),
								ImageColor3 = v70.ImageColor3,
								ImageTransparency = v70.ImageTransparency,
								Rotation = v70.Rotation,
								ZIndex = v70.ZIndex or 2
							}) }
						end
					end

					local currency = ImageIds.boosts.currency
					local v73 = {
						ZIndex = 3,
						Size = UDim2.fromScale(0.62, 0.62),
						Position = UDim2.fromScale(0.58, 0.44)
					} or {}

					local function v74() -- line: 123
						-- upvalues: ImageLabel (copy), currency (copy), v73 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = currency,
							ScaleType = Enum.ScaleType.Fit,
							Size = v73.Size or UDim2.fromScale(1, 1),
							Position = v73.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = v73.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = v73.ImageColor3,
							ImageTransparency = v73.ImageTransparency,
							Rotation = v73.Rotation,
							ZIndex = v73.ZIndex or 2
						}) }
					end

					t48[1] = v71
					t48[2] = v74

					function t47.icon() -- line: 166
						-- upvalues: t48 (copy)
						local t49 = {}

						for _, v426 in t48 do
							for _, v428 in v426() do
								table.insert(t49, v428)
							end
						end

						return t49
					end

					t47.side = sides.top
					t14.lootTree = t47

					local t50 = {
						name = "Player",
						description = "Open player mobility and utility upgrades.",
						dependency = "goldenRolls",
						tree = "playerTree"
					}
					local character = ImageIds.character
					local v77 = {
						Size = UDim2.fromScale(1.2, 1.2),
						Position = UDim2.fromScale(0.5, 0.45)
					} or {}

					function t50.icon() -- line: 123
						-- upvalues: ImageLabel (copy), character (copy), v77 (copy)
						return { ImageLabel({
							Name = "UpgradeIconImage",
							Image = character,
							ScaleType = Enum.ScaleType.Fit,
							Size = v77.Size or UDim2.fromScale(1, 1),
							Position = v77.Position or UDim2.fromScale(0.5, 0.5),
							AnchorPoint = v77.AnchorPoint or Vector2.new(0.5, 0.5),
							ImageColor3 = v77.ImageColor3,
							ImageTransparency = v77.ImageTransparency,
							Rotation = v77.Rotation,
							ZIndex = v77.ZIndex or 2
						}) }
					end

					t50.side = sides.bot
					t14.playerTree = t50
				end

				t14.slots2 = {
					name = "3 Slime Slots",
					description = "",
					dependency = "autoRoll",
					icon = createCountBadgeIcon(ImageIds.backpack, "3"),
					side = sides.topLeft,
					cost = {
						currency = "coins",
						amount = 750
					}
				}
				t14.slots3 = {
					name = "4 Slime Slots",
					description = "",
					dependency = "slots2",
					icon = createCountBadgeIcon(ImageIds.backpack, "4"),
					side = sides.topLeft,
					cost = {
						currency = "coins",
						amount = 5000
					}
				}
				t14.slots4 = {
					name = "5 Slime Slots",
					description = "",
					dependency = "slots3",
					icon = createCountBadgeIcon(ImageIds.backpack, "5"),
					side = sides.top,
					cost = {
						currency = "coins",
						amount = 250000
					}
				}
				t14.slots5 = {
					name = "6 Slime Slots",
					description = "",
					dependency = "slots4",
					icon = createCountBadgeIcon(ImageIds.backpack, "6"),
					side = sides.topRight,
					cost = {
						currency = "coins",
						amount = 10000000
					}
				}
				t14.slots6 = {
					name = "7 Slime Slots",
					description = "",
					dependency = "slots5",
					icon = createCountBadgeIcon(ImageIds.backpack, "7"),
					side = sides.topRight,
					cost = {
						currency = "coins",
						amount = 600000000
					}
				}
				t14.slimeTargetRange1 = {
					name = "Target Range I",
					dependency = "slots5",
					description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("slimeTargetRange", 1) - 1) * 100) }% more slime target range!`,
					icon = function() --[[ icon ]] -- line: 624
						-- upvalues: SlimeIcon (copy), ImageLabel (copy), ImageIds (copy)
						return {
							SlimeIcon({
								SlimeData = {
									id = "cat",
									level = 1,
									xp = 0
								},
								Size = UDim2.fromScale(0.9, 0.9),
								SizeConstraint = Enum.SizeConstraint.RelativeXX,
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5)
							}),
							ImageLabel({
								ImageTransparency = 0.5,
								ZIndex = 3,
								Image = ImageIds.ring,
								Size = UDim2.fromScale(1.2, 1.2),
								SizeConstraint = Enum.SizeConstraint.RelativeXX,
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								ImageColor3 = Color3.fromRGB(255, 85, 85)
							})
						}
					end,
					side = sides.top,
					cost = {
						currency = "coins",
						amount = 30000000
					}
				}
				t14.slimeTargetRange2 = {
					name = "Target Range II",
					dependency = "slimeTargetRange1",
					description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("slimeTargetRange", 2) - 1) * 100) }% more slime target range!`,
					icon = function() --[[ icon ]] -- line: 657
						-- upvalues: SlimeIcon (copy), ImageLabel (copy), ImageIds (copy)
						return {
							SlimeIcon({
								SlimeData = {
									id = "cat",
									level = 1,
									xp = 0
								},
								Size = UDim2.fromScale(0.9, 0.9),
								SizeConstraint = Enum.SizeConstraint.RelativeXX,
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5)
							}),
							ImageLabel({
								ImageTransparency = 0.5,
								ZIndex = 3,
								Image = ImageIds.ring,
								Size = UDim2.fromScale(1.2, 1.2),
								SizeConstraint = Enum.SizeConstraint.RelativeXX,
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								ImageColor3 = Color3.fromRGB(255, 85, 85)
							})
						}
					end,
					side = sides.topLeft,
					cost = {
						currency = "coins",
						amount = 450000000
					}
				}
				t14.slimeTargetRange3 = {
					name = "Target Range III",
					dependency = "slimeTargetRange2",
					description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("slimeTargetRange", 3) - 1) * 100) }% more slime target range!`,
					icon = function() --[[ icon ]] -- line: 690
						-- upvalues: SlimeIcon (copy), ImageLabel (copy), ImageIds (copy)
						return {
							SlimeIcon({
								SlimeData = {
									id = "cat",
									level = 1,
									xp = 0
								},
								Size = UDim2.fromScale(0.9, 0.9),
								SizeConstraint = Enum.SizeConstraint.RelativeXX,
								Position = UDim2.fromScale(0.5, 0.5),
								AnchorPoint = Vector2.new(0.5, 0.5)
							}),
							ImageLabel({
								ImageTransparency = 0.5,
								ZIndex = 3,
								Image = ImageIds.ring,
								Size = UDim2.fromScale(1.2, 1.2),
								SizeConstraint = Enum.SizeConstraint.RelativeXX,
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								ImageColor3 = Color3.fromRGB(255, 85, 85)
							})
						}
					end,
					side = sides.top,
					cost = {
						currency = "coins",
						amount = 8000000000
					}
				}
				t14.bigSlimes = {
					name = "Big Slimes",
					description = "Rare chance to roll big slimes!",
					dependency = "slots3",
					icon = function() --[[ icon ]] -- line: 723
						-- upvalues: SlimeIcon (copy)
						return { SlimeIcon({
							SlimeData = {
								id = "goopy",
								level = 1,
								xp = 0,
								mutations = {
									big = true
								}
							},
							Size = UDim2.fromScale(1, 1),
							SizeConstraint = Enum.SizeConstraint.RelativeXX,
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5)
						}) }
					end,
					side = sides.topLeft,
					cost = {
						currency = "coins",
						amount = 75000
					}
				}
				t14.hugeSlimes = {
					name = "Huge Slimes",
					description = "Extremely rare chance to roll huge slimes!",
					dependency = "bigSlimes",
					icon = function() --[[ icon ]] -- line: 745
						-- upvalues: SlimeIcon (copy)
						return { SlimeIcon({
							SlimeData = {
								id = "fin",
								level = 1,
								xp = 0,
								mutations = {
									huge = true
								}
							},
							Size = UDim2.fromScale(1, 1),
							SizeConstraint = Enum.SizeConstraint.RelativeXX,
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5)
						}) }
					end,
					side = sides.topLeft,
					cost = {
						currency = "coins",
						amount = 100000000
					}
				}
				t14.shinySlimes = {
					name = "Shiny Slimes",
					description = "Very rare chance to roll shiny slimes!",
					dependency = "bigSlimes",
					icon = function() --[[ icon ]] -- line: 767
						-- upvalues: SlimeIcon (copy)
						return { SlimeIcon({
							SlimeData = {
								id = "sunset",
								level = 1,
								xp = 0,
								mutations = {
									shiny = true
								}
							},
							Size = UDim2.fromScale(1, 1),
							SizeConstraint = Enum.SizeConstraint.RelativeXX,
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5)
						}) }
					end,
					side = sides.top,
					cost = {
						currency = "coins",
						amount = 3000000
					}
				}
				t14.invertedSlimes = {
					name = "Inverted Slimes",
					description = "Ultra rare chance to roll inverted slimes!",
					dependency = "shinySlimes",
					icon = function() --[[ icon ]] -- line: 789
						-- upvalues: SlimeIcon (copy)
						return { SlimeIcon({
							SlimeData = {
								id = "glo",
								level = 1,
								xp = 0,
								mutations = {
									inverted = true
								}
							},
							Size = UDim2.fromScale(1, 1),
							SizeConstraint = Enum.SizeConstraint.RelativeXX,
							Position = UDim2.fromScale(0.5, 0.5),
							AnchorPoint = Vector2.new(0.5, 0.5)
						}) }
					end,
					side = sides.topLeft,
					cost = {
						currency = "coins",
						amount = 1000000000
					}
				}
				t14.enemyCount2 = {
					name = "2 Enemies",
					description = "Increase active enemies to 2",
					dependency = "autoRoll",
					icon = createCountBadgeIcon(ImageIds.enemyIcon, "2", Color3.fromRGB(255, 214, 92)),
					side = sides.topRight,
					cost = {
						currency = "coins",
						amount = 100
					}
				}
				t14.enemyCount3 = {
					name = "3 Enemies",
					description = "Increase active enemies to 3",
					dependency = "enemyCount2",
					icon = createCountBadgeIcon(ImageIds.enemyIcon, "3", Color3.fromRGB(255, 214, 92)),
					side = sides.topRight,
					cost = {
						currency = "coins",
						amount = 3000
					}
				}

				local t51 = {
					name = "Goop",
					description = "Enemies can now drop goop! (Used to rebirth)",
					dependency = "enemyCount3"
				}
				local goop = ImageIds.goop
				local t52 = {}

				function t51.icon() -- line: 123
					-- upvalues: ImageLabel (copy), goop (copy), t52 (copy)
					return { ImageLabel({
						Name = "UpgradeIconImage",
						Image = goop,
						ScaleType = Enum.ScaleType.Fit,
						Size = t52.Size or UDim2.fromScale(1, 1),
						Position = t52.Position or UDim2.fromScale(0.5, 0.5),
						AnchorPoint = t52.AnchorPoint or Vector2.new(0.5, 0.5),
						ImageColor3 = t52.ImageColor3,
						ImageTransparency = t52.ImageTransparency,
						Rotation = t52.Rotation,
						ZIndex = t52.ZIndex or 2
					}) }
				end

				t51.side = sides.top
				t51.cost = {
					currency = "coins",
					amount = 10000000
				}
				t14.goop = t51

				local t53 = {
					name = "Goop Drip",
					dependency = "goop",
					description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("goopDropRate", 1) * 100) }% goop drop chance.`
				}
				local goop2 = ImageIds.goop
				local t54 = {}

				function t53.icon() -- line: 123
					-- upvalues: ImageLabel (copy), goop2 (copy), t54 (copy)
					return { ImageLabel({
						Name = "UpgradeIconImage",
						Image = goop2,
						ScaleType = Enum.ScaleType.Fit,
						Size = t54.Size or UDim2.fromScale(1, 1),
						Position = t54.Position or UDim2.fromScale(0.5, 0.5),
						AnchorPoint = t54.AnchorPoint or Vector2.new(0.5, 0.5),
						ImageColor3 = t54.ImageColor3,
						ImageTransparency = t54.ImageTransparency,
						Rotation = t54.Rotation,
						ZIndex = t54.ZIndex or 2
					}) }
				end

				t53.side = sides.top
				t53.cost = {
					currency = "coins",
					amount = 250000000
				}
				t14.goopDropRate1 = t53

				local t55 = {
					name = "Goop Flood",
					dependency = "goopDropRate1",
					description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("goopDropRate", 2) * 100) }% goop drop chance.`
				}
				local goop3 = ImageIds.goop
				local t56 = {}

				function t55.icon() -- line: 123
					-- upvalues: ImageLabel (copy), goop3 (copy), t56 (copy)
					return { ImageLabel({
						Name = "UpgradeIconImage",
						Image = goop3,
						ScaleType = Enum.ScaleType.Fit,
						Size = t56.Size or UDim2.fromScale(1, 1),
						Position = t56.Position or UDim2.fromScale(0.5, 0.5),
						AnchorPoint = t56.AnchorPoint or Vector2.new(0.5, 0.5),
						ImageColor3 = t56.ImageColor3,
						ImageTransparency = t56.ImageTransparency,
						Rotation = t56.Rotation,
						ZIndex = t56.ZIndex or 2
					}) }
				end

				t55.side = sides.top
				t55.cost = {
					currency = "coins",
					amount = 20000000000
				}
				t14.goopDropRate2 = t55
			end

			local t57 = {
				name = "Goop Chance",
				dependency = "goopDropRate2",
				description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("goopDropRate", 3) * 100) }% goop drop chance.`
			}
			local goop = ImageIds.goop
			local t58 = {}

			function t57.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goop (copy), t58 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goop,
					ScaleType = Enum.ScaleType.Fit,
					Size = t58.Size or UDim2.fromScale(1, 1),
					Position = t58.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t58.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t58.ImageColor3,
					ImageTransparency = t58.ImageTransparency,
					Rotation = t58.Rotation,
					ZIndex = t58.ZIndex or 2
				}) }
			end

			t57.side = sides.topLeft
			t57.cost = {
				currency = "coins",
				amount = 4000000000000
			}
			t14.goopDropRate3 = t57

			local t59 = {
				name = "Goop Chance",
				dependency = "goopDropRate3",
				description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("goopDropRate", 4) * 100) }% goop drop chance.`
			}
			local goop4 = ImageIds.goop
			local t60 = {}

			function t59.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goop4 (copy), t60 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goop4,
					ScaleType = Enum.ScaleType.Fit,
					Size = t60.Size or UDim2.fromScale(1, 1),
					Position = t60.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t60.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t60.ImageColor3,
					ImageTransparency = t60.ImageTransparency,
					Rotation = t60.Rotation,
					ZIndex = t60.ZIndex or 2
				}) }
			end

			t59.side = sides.top
			t59.cost = {
				currency = "coins",
				amount = 500000000000000
			}
			t14.goopDropRate4 = t59

			local t61 = {
				name = "Goop Chance",
				dependency = "goopDropRate4",
				description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("goopDropRate", 5) * 100) }% goop drop chance.`
			}
			local goop5 = ImageIds.goop
			local t62 = {}

			function t61.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goop5 (copy), t62 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goop5,
					ScaleType = Enum.ScaleType.Fit,
					Size = t62.Size or UDim2.fromScale(1, 1),
					Position = t62.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t62.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t62.ImageColor3,
					ImageTransparency = t62.ImageTransparency,
					Rotation = t62.Rotation,
					ZIndex = t62.ZIndex or 2
				}) }
			end

			t61.side = sides.top
			t61.cost = {
				currency = "coins",
				amount = 75000000000000000
			}
			t14.goopDropRate5 = t61

			local t63 = {
				name = "Goop Chance",
				dependency = "goopDropRate5",
				description = `{ math.round(UpgradeServiceUtils.getUpgradeValue("goopDropRate", 6) * 100) }% goop drop chance.`
			}
			local goop6 = ImageIds.goop
			local t64 = {}

			function t63.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goop6 (copy), t64 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goop6,
					ScaleType = Enum.ScaleType.Fit,
					Size = t64.Size or UDim2.fromScale(1, 1),
					Position = t64.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t64.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t64.ImageColor3,
					ImageTransparency = t64.ImageTransparency,
					Rotation = t64.Rotation,
					ZIndex = t64.ZIndex or 2
				}) }
			end

			t63.side = sides.topRight
			t63.cost = {
				currency = "coins",
				amount = 1E+19
			}
			t14.goopDropRate6 = t63
			t14.enemyCount4 = {
				name = "4 Enemies",
				description = "Increase active enemies to 4",
				dependency = "enemyCount3",
				icon = createCountBadgeIcon(ImageIds.enemyIcon, "4", Color3.fromRGB(255, 214, 92)),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 100000
				}
			}
			t14.bigEnemies = {
				name = "Big Enemies",
				description = "Enemies can rarely mutate into Big.",
				dependency = "enemyCount4",
				icon = createMutatedEnemyIcon(ImageIds.enemyBig),
				side = sides.botRight,
				cost = {
					currency = "coins",
					amount = 750000
				}
			}
			t14.bigEnemyChance1 = {
				name = "More Big Enemies",
				dependency = "hugeEnemies",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("bigEnemyChance", 1) - 1) * 100) }% more often.`,
				icon = createMutatedEnemyIcon(ImageIds.enemyBig, true),
				side = sides.botRight,
				cost = {
					currency = "coins",
					amount = 750000000000
				}
			}
			t14.shinyEnemies = {
				name = "Shiny Enemies",
				description = "Enemies can very rarely mutate into Shiny.",
				dependency = "bigEnemies",
				icon = createShinyEnemyIcon(),
				side = sides.botRight,
				cost = {
					currency = "coins",
					amount = 30000000
				}
			}
			t14.shinyEnemyChance1 = {
				name = "More Shiny Enemies",
				dependency = "bigEnemyChance1",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("shinyEnemyChance", 1) - 1) * 100) }% more often.`,
				icon = createShinyEnemyIcon(true),
				side = sides.botRight,
				cost = {
					currency = "coins",
					amount = 30000000000000
				}
			}
			t14.hugeEnemies = {
				name = "Huge Enemies",
				description = "Enemies can extremely rarely mutate into Huge.",
				dependency = "shinyEnemies",
				icon = createMutatedEnemyIcon(ImageIds.enemyHuge),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 1000000000
				}
			}
			t14.hugeEnemyChance1 = {
				name = "More Huge Enemies",
				dependency = "shinyEnemyChance1",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("hugeEnemyChance", 1) - 1) * 100) }% more often.`,
				icon = createMutatedEnemyIcon(ImageIds.enemyHuge, true),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 1000000000000000
				}
			}
			t14.invertedEnemies = {
				name = "Inverted Enemies",
				description = "Enemies can ultra rarely mutate into Inverted.",
				dependency = "hugeEnemies",
				icon = createMutatedEnemyIcon(ImageIds.enemyInverted),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 10000000000
				}
			}
			t14.invertedEnemyChance1 = {
				name = "More Inverted Enemies",
				dependency = "hugeEnemyChance1",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("invertedEnemyChance", 1) - 1) * 100) }% more often.`,
				icon = createMutatedEnemyIcon(ImageIds.enemyInverted, true),
				side = sides.top,
				cost = {
					currency = "coins",
					amount = 10000000000000000
				}
			}
			t14.enemyCount5 = {
				name = "5 Enemies",
				description = "Increase active enemies to 5",
				dependency = "enemyCount4",
				icon = createCountBadgeIcon(ImageIds.enemyIcon, "5", Color3.fromRGB(255, 214, 92)),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 5000000
				}
			}
			t14.enemySpawnSpeed1 = {
				name = "Enemy Rush I",
				dependency = "enemyCount5",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("enemySpawnSpeed", 1) - 1) * 100) }% faster enemy spawns!`,
				icon = createSubIconOverlay(ImageIds.enemyIcon, ImageIds.boosts.rollSpeed),
				side = sides.top,
				cost = {
					currency = "coins",
					amount = 15000000
				}
			}
			t14.enemySpawnSpeed2 = {
				name = "Enemy Rush II",
				dependency = "enemySpawnSpeed1",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("enemySpawnSpeed", 2) - 1) * 100) }% faster enemy spawns!`,
				icon = createSubIconOverlay(ImageIds.enemyIcon, ImageIds.boosts.rollSpeed),
				side = sides.top,
				cost = {
					currency = "coins",
					amount = 250000000
				}
			}
			t14.enemySpawnSpeed3 = {
				name = "Enemy Rush III",
				dependency = "enemySpawnSpeed2",
				description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("enemySpawnSpeed", 3) - 1) * 100) }% faster enemy spawns!`,
				icon = createSubIconOverlay(ImageIds.enemyIcon, ImageIds.boosts.rollSpeed),
				side = sides.top,
				cost = {
					currency = "coins",
					amount = 5000000000
				}
			}
			t14.enemyCount6 = {
				name = "6 Enemies",
				description = "Increase active enemies to 6",
				dependency = "enemyCount5",
				icon = createCountBadgeIcon(ImageIds.enemyIcon, "6", Color3.fromRGB(255, 214, 92)),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 400000000
				}
			}
			t14.enemyCount7 = {
				name = "7 Enemies",
				description = "Increase active enemies to 7",
				dependency = "enemyCount6",
				icon = createCountBadgeIcon(ImageIds.enemyIcon, "7", Color3.fromRGB(255, 214, 92)),
				side = sides.topRight,
				cost = {
					currency = "coins",
					amount = 50000000000
				}
			}
		end

		do
			local t65 = {
				name = "Golden Rolls",
				dependency = "backpack",
				description = `Every { AddSuffix(enums.luckRolls.golden[1]) } roll has 2x luck!`
			}
			local goldDice = ImageIds.goldDice
			local t66 = {}

			function t65.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goldDice (copy), t66 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goldDice,
					ScaleType = Enum.ScaleType.Fit,
					Size = t66.Size or UDim2.fromScale(1, 1),
					Position = t66.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t66.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t66.ImageColor3,
					ImageTransparency = t66.ImageTransparency,
					Rotation = t66.Rotation,
					ZIndex = t66.ZIndex or 2
				}) }
			end

			t65.side = sides.botLeft
			t65.cost = {
				currency = "coins",
				amount = 1000
			}
			t14.goldenRolls = t65

			local t67 = {
				name = "Extra Golden Rolls",
				dependency = "goldenRolls",
				description = `Golden roll every { AddSuffix(enums.luckRolls.golden[2]) } roll!`
			}
			local goldDice2 = ImageIds.goldDice
			local t68 = {}

			function t67.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goldDice2 (copy), t68 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goldDice2,
					ScaleType = Enum.ScaleType.Fit,
					Size = t68.Size or UDim2.fromScale(1, 1),
					Position = t68.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t68.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t68.ImageColor3,
					ImageTransparency = t68.ImageTransparency,
					Rotation = t68.Rotation,
					ZIndex = t68.ZIndex or 2
				}) }
			end

			t67.side = sides.botLeft
			t67.cost = {
				currency = "coins",
				amount = 50000
			}
			t14.goldenRolls2 = t67

			local t69 = {
				name = "Ultra Golden Rolls",
				dependency = "goldenRolls2",
				description = `Golden roll every { AddSuffix(enums.luckRolls.golden[3]) } roll!`
			}
			local goldDice3 = ImageIds.goldDice
			local t70 = {}

			function t69.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goldDice3 (copy), t70 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goldDice3,
					ScaleType = Enum.ScaleType.Fit,
					Size = t70.Size or UDim2.fromScale(1, 1),
					Position = t70.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t70.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t70.ImageColor3,
					ImageTransparency = t70.ImageTransparency,
					Rotation = t70.Rotation,
					ZIndex = t70.ZIndex or 2
				}) }
			end

			t69.side = sides.bot
			t69.cost = {
				currency = "coins",
				amount = 2000000
			}
			t14.goldenRolls3 = t69

			local t71 = {
				name = "Luckier Golden Rolls",
				description = "2.5x Luck on golden rolls!",
				dependency = "goldenRolls3"
			}
			local goldDice4 = ImageIds.goldDice
			local t72 = {}

			function t71.icon() -- line: 123
				-- upvalues: ImageLabel (copy), goldDice4 (copy), t72 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = goldDice4,
					ScaleType = Enum.ScaleType.Fit,
					Size = t72.Size or UDim2.fromScale(1, 1),
					Position = t72.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t72.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t72.ImageColor3,
					ImageTransparency = t72.ImageTransparency,
					Rotation = t72.Rotation,
					ZIndex = t72.ZIndex or 2
				}) }
			end

			t71.side = sides.bot
			t71.cost = {
				currency = "coins",
				amount = 100000000
			}
			t14.goldenRolls4 = t71

			local t73 = {
				name = "Diamond Rolls",
				dependency = "goldenRolls2",
				description = `Every { AddSuffix(enums.luckRolls.diamond[1]) } roll has 5x luck!`
			}
			local diamondDice = ImageIds.diamondDice
			local t74 = {}

			function t73.icon() -- line: 123
				-- upvalues: ImageLabel (copy), diamondDice (copy), t74 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = diamondDice,
					ScaleType = Enum.ScaleType.Fit,
					Size = t74.Size or UDim2.fromScale(1, 1),
					Position = t74.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t74.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t74.ImageColor3,
					ImageTransparency = t74.ImageTransparency,
					Rotation = t74.Rotation,
					ZIndex = t74.ZIndex or 2
				}) }
			end

			t73.side = sides.botLeft
			t73.cost = {
				currency = "coins",
				amount = 20000000
			}
			t14.diamondRolls = t73
		end

		do
			local t75 = {
				name = "Extra Diamond Rolls",
				dependency = "diamondRolls",
				description = `Diamond roll every { AddSuffix(enums.luckRolls.diamond[2]) } roll!`
			}
			local diamondDice = ImageIds.diamondDice
			local t76 = {}

			function t75.icon() -- line: 123
				-- upvalues: ImageLabel (copy), diamondDice (copy), t76 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = diamondDice,
					ScaleType = Enum.ScaleType.Fit,
					Size = t76.Size or UDim2.fromScale(1, 1),
					Position = t76.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t76.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t76.ImageColor3,
					ImageTransparency = t76.ImageTransparency,
					Rotation = t76.Rotation,
					ZIndex = t76.ZIndex or 2
				}) }
			end

			t75.side = sides.botLeft
			t75.cost = {
				currency = "coins",
				amount = 250000000
			}
			t14.diamondRolls2 = t75

			local t77 = {
				name = "Ultra Diamond Rolls",
				dependency = "diamondRolls2",
				description = `Diamond roll every { AddSuffix(enums.luckRolls.diamond[3]) } roll!`
			}
			local diamondDice2 = ImageIds.diamondDice
			local t78 = {}

			function t77.icon() -- line: 123
				-- upvalues: ImageLabel (copy), diamondDice2 (copy), t78 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = diamondDice2,
					ScaleType = Enum.ScaleType.Fit,
					Size = t78.Size or UDim2.fromScale(1, 1),
					Position = t78.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t78.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t78.ImageColor3,
					ImageTransparency = t78.ImageTransparency,
					Rotation = t78.Rotation,
					ZIndex = t78.ZIndex or 2
				}) }
			end

			t77.side = sides.bot
			t77.cost = {
				currency = "coins",
				amount = 5000000000
			}
			t14.diamondRolls3 = t77

			local t79 = {
				name = "Luckier Diamond Rolls",
				description = "6.5x Luck on diamond rolls!",
				dependency = "diamondRolls3"
			}
			local diamondDice3 = ImageIds.diamondDice
			local t80 = {}

			function t79.icon() -- line: 123
				-- upvalues: ImageLabel (copy), diamondDice3 (copy), t80 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = diamondDice3,
					ScaleType = Enum.ScaleType.Fit,
					Size = t80.Size or UDim2.fromScale(1, 1),
					Position = t80.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t80.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t80.ImageColor3,
					ImageTransparency = t80.ImageTransparency,
					Rotation = t80.Rotation,
					ZIndex = t80.ZIndex or 2
				}) }
			end

			t79.side = sides.bot
			t79.cost = {
				currency = "coins",
				amount = 50000000000
			}
			t14.diamondRolls4 = t79

			local t81 = {
				name = "Void Rolls",
				dependency = "diamondRolls2",
				description = `Every { AddSuffix(enums.luckRolls.void[1]) } roll has 50x luck!`
			}
			local voidDice = ImageIds.voidDice
			local t82 = {}

			function t81.icon() -- line: 123
				-- upvalues: ImageLabel (copy), voidDice (copy), t82 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = voidDice,
					ScaleType = Enum.ScaleType.Fit,
					Size = t82.Size or UDim2.fromScale(1, 1),
					Position = t82.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t82.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t82.ImageColor3,
					ImageTransparency = t82.ImageTransparency,
					Rotation = t82.Rotation,
					ZIndex = t82.ZIndex or 2
				}) }
			end

			t81.side = sides.topLeft
			t81.cost = {
				currency = "coins",
				amount = 15000000000
			}
			t14.voidRolls = t81

			local t83 = {
				name = "Extra Void Rolls",
				dependency = "voidRolls",
				description = `Void roll every { AddSuffix(enums.luckRolls.void[2]) } roll!`
			}
			local voidDice2 = ImageIds.voidDice
			local t84 = {}

			function t83.icon() -- line: 123
				-- upvalues: ImageLabel (copy), voidDice2 (copy), t84 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = voidDice2,
					ScaleType = Enum.ScaleType.Fit,
					Size = t84.Size or UDim2.fromScale(1, 1),
					Position = t84.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = t84.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = t84.ImageColor3,
					ImageTransparency = t84.ImageTransparency,
					Rotation = t84.Rotation,
					ZIndex = t84.ZIndex or 2
				}) }
			end

			t83.side = sides.botLeft
			t83.cost = {
				currency = "coins",
				amount = 150000000000
			}
			t14.voidRolls2 = t83
		end

		local t85 = {
			name = "Ultra Void Rolls",
			dependency = "voidRolls2",
			description = `Void roll every { AddSuffix(enums.luckRolls.void[3]) } roll!`
		}
		local voidDice = ImageIds.voidDice
		local t86 = {}

		function t85.icon() -- line: 123
			-- upvalues: ImageLabel (copy), voidDice (copy), t86 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = voidDice,
				ScaleType = Enum.ScaleType.Fit,
				Size = t86.Size or UDim2.fromScale(1, 1),
				Position = t86.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t86.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t86.ImageColor3,
				ImageTransparency = t86.ImageTransparency,
				Rotation = t86.Rotation,
				ZIndex = t86.ZIndex or 2
			}) }
		end

		t85.side = sides.bot
		t85.cost = {
			currency = "coins",
			amount = 3000000000000
		}
		t14.voidRolls3 = t85

		local t87 = {
			name = "Luckier Void Rolls",
			description = "65x Luck on void rolls!",
			dependency = "voidRolls3"
		}
		local voidDice3 = ImageIds.voidDice
		local t88 = {}

		function t87.icon() -- line: 123
			-- upvalues: ImageLabel (copy), voidDice3 (copy), t88 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = voidDice3,
				ScaleType = Enum.ScaleType.Fit,
				Size = t88.Size or UDim2.fromScale(1, 1),
				Position = t88.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t88.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t88.ImageColor3,
				ImageTransparency = t88.ImageTransparency,
				Rotation = t88.Rotation,
				ZIndex = t88.ZIndex or 2
			}) }
		end

		t87.side = sides.botLeft
		t87.cost = {
			currency = "coins",
			amount = 30000000000000
		}
		t14.voidRolls4 = t87
		t14.luck1 = {
			name = "Luck I",
			dependency = "goldenRolls",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 1) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[1], 1),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 1500
			}
		}
		t14.luck2 = {
			name = "Luck II",
			dependency = "luck1",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 2) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[1], 2),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 10000
			}
		}
		t14.luck3 = {
			name = "Luck III",
			dependency = "luck2",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 3) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[1], 3),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 100000
			}
		}
		t14.luck4 = {
			name = "Super Luck I",
			dependency = "luck3",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 4) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[2], 1),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 1000000
			}
		}
		t14.friendLuck1 = {
			name = "Friendly Luck I",
			dependency = "luck3",
			description = `Friend boost limit increased to { math.round((UpgradeServiceUtils.getUpgradeValue("friendLuck", 1))) }!`,
			icon = createSubIconOverlay(ImageIds.friend, ImageIds.luckIcons[2]),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 350000
			}
		}
		t14.friendLuck2 = {
			name = "Friendly Luck II",
			dependency = "friendLuck1",
			description = `Friend boost limit increased to { math.round((UpgradeServiceUtils.getUpgradeValue("friendLuck", 2))) }!`,
			icon = createSubIconOverlay(ImageIds.friend, ImageIds.luckIcons[2]),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 900000
			}
		}
		t14.friendLuck3 = {
			name = "Friendly Luck III",
			dependency = "friendLuck2",
			description = `Friend boost limit increased to { math.round((UpgradeServiceUtils.getUpgradeValue("friendLuck", 3))) }!`,
			icon = createSubIconOverlay(ImageIds.friend, ImageIds.luckIcons[3]),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 2000000
			}
		}
		t14.friendLuck4 = {
			name = "Friendly Luck IV",
			dependency = "friendLuck3",
			description = `Friend boost limit increased to { math.round((UpgradeServiceUtils.getUpgradeValue("friendLuck", 4))) }!`,
			icon = createSubIconOverlay(ImageIds.friend, ImageIds.luckIcons[4]),
			side = sides.top,
			cost = {
				currency = "coins",
				amount = 1000000000
			}
		}
		t14.friendLuck5 = {
			name = "Friendly Luck V",
			dependency = "friendLuck4",
			description = `Friend boost limit increased to { math.round((UpgradeServiceUtils.getUpgradeValue("friendLuck", 5))) }!`,
			icon = createSubIconOverlay(ImageIds.friend, ImageIds.luckIcons[5]),
			side = sides.top,
			cost = {
				currency = "coins",
				amount = 1000000000000
			}
		}
		t14.friendLuck6 = {
			name = "Friendly Luck VI",
			dependency = "friendLuck5",
			description = `Friend boost limit increased to { math.round((UpgradeServiceUtils.getUpgradeValue("friendLuck", 6))) }!`,
			icon = createSubIconOverlay(ImageIds.friend, ImageIds.luckIcons[5]),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 1000000000000000
			}
		}
		t14.friendLuckBoost1 = {
			name = "Friendly Boost I",
			dependency = "friendLuck3",
			description = `Each counted friend gives { UpgradeServiceUtils.getUpgradeValue("friendLuckBoost", 1) }x luck!`,
			icon = createSubIconOverlay(ImageIds.luckIcons[1], ImageIds.friend),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 7500000
			}
		}
		t14.friendLuckBoost2 = {
			name = "Friendly Boost II",
			dependency = "friendLuckBoost1",
			description = `Each counted friend gives { UpgradeServiceUtils.getUpgradeValue("friendLuckBoost", 2) }x luck!`,
			icon = createSubIconOverlay(ImageIds.luckIcons[2], ImageIds.friend),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 7500000000
			}
		}
		t14.friendLuckBoost3 = {
			name = "Friendly Boost III",
			dependency = "friendLuckBoost2",
			description = `Each counted friend gives { UpgradeServiceUtils.getUpgradeValue("friendLuckBoost", 3) }x luck!`,
			icon = createSubIconOverlay(ImageIds.luckIcons[3], ImageIds.friend),
			side = sides.top,
			cost = {
				currency = "coins",
				amount = 7500000000000
			}
		}
		t14.friendLuckBoost4 = {
			name = "Friendly Boost IV",
			dependency = "friendLuckBoost3",
			description = `Each counted friend gives { UpgradeServiceUtils.getUpgradeValue("friendLuckBoost", 4) }x luck!`,
			icon = createSubIconOverlay(ImageIds.luckIcons[4], ImageIds.friend),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 7500000000000000
			}
		}
		t14.luck5 = {
			name = "Super Luck II",
			dependency = "luck4",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 5) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[2], 2),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 5000000
			}
		}
		t14.luck6 = {
			name = "Super Luck III",
			dependency = "luck5",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 6) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[2], 3),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 25000000
			}
		}
		t14.luck7 = {
			name = "Ultra Luck I",
			dependency = "luck6",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 7) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[3], 1),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 125000000
			}
		}
		t14.luck8 = {
			name = "Ultra Luck II",
			dependency = "luck7",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 8) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[3], 2),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 625000000
			}
		}
		t14.luck9 = {
			name = "Ultra Luck III",
			dependency = "luck8",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 9) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[3], 3),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 3100000000
			}
		}
		t14.luck10 = {
			name = "Supreme Luck I",
			dependency = "luck9",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 10) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[4], 1),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 20000000000
			}
		}
		t14.luck11 = {
			name = "Supreme Luck II",
			dependency = "luck10",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 11) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[4], 2),
			side = sides.botLeft,
			cost = {
				currency = "coins",
				amount = 140000000000
			}
		}
		t14.luck12 = {
			name = "Supreme Luck III",
			dependency = "luck11",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 12) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[4], 3),
			side = sides.bot,
			cost = {
				currency = "coins",
				amount = 1000000000000
			}
		}
		t14.luck13 = {
			name = "Epic Luck I",
			dependency = "luck12",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 13) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[5], 1),
			side = sides.bot,
			cost = {
				currency = "coins",
				amount = 8000000000000
			}
		}
		t14.luck14 = {
			name = "Epic Luck II",
			dependency = "luck13",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 14) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[5], 2),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 64000000000000
			}
		}
		t14.luck15 = {
			name = "Epic Luck III",
			dependency = "luck14",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("luck", 15) - 1) * 100) }% more luck!`,
			icon = createRepeatedImageIcon(ImageIds.luckIcons[5], 3),
			side = sides.topLeft,
			cost = {
				currency = "coins",
				amount = 512000000000000
			}
		}
		t89 = {
			lootTree = {
				name = "Loot",
				description = "Open",
				tree = "main",
				icon = function() --[[ icon ]] -- line: 1545
					return {}
				end,
				dependency = originDependency,
				side = sides.origin
			}
		}

		local t90 = {
			name = "Coin Income I",
			dependency = "lootTree",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 1) - 1) * 100) }% more coins!`
		}
		local coin = ImageIds.coin
		local t91 = {}

		function t90.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin (copy), t91 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin,
				ScaleType = Enum.ScaleType.Fit,
				Size = t91.Size or UDim2.fromScale(1, 1),
				Position = t91.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t91.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t91.ImageColor3,
				ImageTransparency = t91.ImageTransparency,
				Rotation = t91.Rotation,
				ZIndex = t91.ZIndex or 2
			}) }
		end

		t90.side = sides.botLeft
		t90.cost = {
			currency = "coins",
			amount = 100000
		}
		t89.coinIncome1 = t90

		local t92 = {
			name = "Coin Income II",
			dependency = "coinIncome1",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 2) - 1) * 100) }% more coins!`
		}
		local coin2 = ImageIds.coin
		local t93 = {}

		function t92.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin2 (copy), t93 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin2,
				ScaleType = Enum.ScaleType.Fit,
				Size = t93.Size or UDim2.fromScale(1, 1),
				Position = t93.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t93.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t93.ImageColor3,
				ImageTransparency = t93.ImageTransparency,
				Rotation = t93.Rotation,
				ZIndex = t93.ZIndex or 2
			}) }
		end

		t92.side = sides.botLeft
		t92.cost = {
			currency = "coins",
			amount = 1000000
		}
		t89.coinIncome2 = t92

		local t94 = {
			name = "Coin Income III",
			dependency = "coinIncome2",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 3) - 1) * 100) }% more coins!`
		}
		local coin3 = ImageIds.coin
		local t95 = {}

		function t94.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin3 (copy), t95 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin3,
				ScaleType = Enum.ScaleType.Fit,
				Size = t95.Size or UDim2.fromScale(1, 1),
				Position = t95.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t95.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t95.ImageColor3,
				ImageTransparency = t95.ImageTransparency,
				Rotation = t95.Rotation,
				ZIndex = t95.ZIndex or 2
			}) }
		end

		t94.side = sides.botLeft
		t94.cost = {
			currency = "coins",
			amount = 10000000
		}
		t89.coinIncome3 = t94
	end

	do
		local t96 = {
			name = "Coin Income IV",
			dependency = "coinIncome3",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 4) - 1) * 100) }% more coins!`
		}
		local coin = ImageIds.coin
		local t97 = {}

		function t96.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin (copy), t97 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin,
				ScaleType = Enum.ScaleType.Fit,
				Size = t97.Size or UDim2.fromScale(1, 1),
				Position = t97.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t97.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t97.ImageColor3,
				ImageTransparency = t97.ImageTransparency,
				Rotation = t97.Rotation,
				ZIndex = t97.ZIndex or 2
			}) }
		end

		t96.side = sides.bot
		t96.cost = {
			currency = "coins",
			amount = 100000000
		}
		t89.coinIncome4 = t96

		local t98 = {
			name = "Coin Income V",
			dependency = "coinIncome4",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 5) - 1) * 100) }% more coins!`
		}
		local coin4 = ImageIds.coin
		local t99 = {}

		function t98.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin4 (copy), t99 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin4,
				ScaleType = Enum.ScaleType.Fit,
				Size = t99.Size or UDim2.fromScale(1, 1),
				Position = t99.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t99.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t99.ImageColor3,
				ImageTransparency = t99.ImageTransparency,
				Rotation = t99.Rotation,
				ZIndex = t99.ZIndex or 2
			}) }
		end

		t98.side = sides.botLeft
		t98.cost = {
			currency = "coins",
			amount = 1000000000
		}
		t89.coinIncome5 = t98

		local t100 = {
			name = "Coin Income VI",
			dependency = "coinIncome5",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 6) - 1) * 100) }% more coins!`
		}
		local coin5 = ImageIds.coin
		local t101 = {}

		function t100.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin5 (copy), t101 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin5,
				ScaleType = Enum.ScaleType.Fit,
				Size = t101.Size or UDim2.fromScale(1, 1),
				Position = t101.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t101.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t101.ImageColor3,
				ImageTransparency = t101.ImageTransparency,
				Rotation = t101.Rotation,
				ZIndex = t101.ZIndex or 2
			}) }
		end

		t100.side = sides.topLeft
		t100.cost = {
			currency = "coins",
			amount = 10000000000
		}
		t89.coinIncome6 = t100

		local t102 = {
			name = "Coin Income VII",
			dependency = "coinIncome6",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 7) - 1) * 100) }% more coins!`
		}
		local coin6 = ImageIds.coin
		local t103 = {}

		function t102.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin6 (copy), t103 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin6,
				ScaleType = Enum.ScaleType.Fit,
				Size = t103.Size or UDim2.fromScale(1, 1),
				Position = t103.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t103.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t103.ImageColor3,
				ImageTransparency = t103.ImageTransparency,
				Rotation = t103.Rotation,
				ZIndex = t103.ZIndex or 2
			}) }
		end

		t102.side = sides.topLeft
		t102.cost = {
			currency = "coins",
			amount = 100000000000
		}
		t89.coinIncome7 = t102

		local t104 = {
			name = "Coin Income VIII",
			dependency = "coinIncome7",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 8) - 1) * 100) }% more coins!`
		}
		local coin7 = ImageIds.coin
		local t105 = {}

		function t104.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin7 (copy), t105 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin7,
				ScaleType = Enum.ScaleType.Fit,
				Size = t105.Size or UDim2.fromScale(1, 1),
				Position = t105.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t105.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t105.ImageColor3,
				ImageTransparency = t105.ImageTransparency,
				Rotation = t105.Rotation,
				ZIndex = t105.ZIndex or 2
			}) }
		end

		t104.side = sides.botLeft
		t104.cost = {
			currency = "coins",
			amount = 1000000000000
		}
		t89.coinIncome8 = t104

		local t106 = {
			name = "Coin Income IX",
			dependency = "coinIncome8",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 9) - 1) * 100) }% more coins!`
		}
		local coin8 = ImageIds.coin
		local t107 = {}

		function t106.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin8 (copy), t107 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin8,
				ScaleType = Enum.ScaleType.Fit,
				Size = t107.Size or UDim2.fromScale(1, 1),
				Position = t107.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t107.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t107.ImageColor3,
				ImageTransparency = t107.ImageTransparency,
				Rotation = t107.Rotation,
				ZIndex = t107.ZIndex or 2
			}) }
		end

		t106.side = sides.topLeft
		t106.cost = {
			currency = "coins",
			amount = 10000000000000
		}
		t89.coinIncome9 = t106
	end

	do
		local t108 = {
			name = "Coin Income X",
			dependency = "coinIncome9",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 10) - 1) * 100) }% more coins!`
		}
		local coin = ImageIds.coin
		local t109 = {}

		function t108.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin (copy), t109 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin,
				ScaleType = Enum.ScaleType.Fit,
				Size = t109.Size or UDim2.fromScale(1, 1),
				Position = t109.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t109.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t109.ImageColor3,
				ImageTransparency = t109.ImageTransparency,
				Rotation = t109.Rotation,
				ZIndex = t109.ZIndex or 2
			}) }
		end

		t108.side = sides.top
		t108.cost = {
			currency = "coins",
			amount = 100000000000000
		}
		t89.coinIncome10 = t108

		local t110 = {
			name = "Coin Income XI",
			dependency = "coinIncome10",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 11) - 1) * 100) }% more coins!`
		}
		local coin9 = ImageIds.coin
		local t111 = {}

		function t110.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin9 (copy), t111 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin9,
				ScaleType = Enum.ScaleType.Fit,
				Size = t111.Size or UDim2.fromScale(1, 1),
				Position = t111.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t111.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t111.ImageColor3,
				ImageTransparency = t111.ImageTransparency,
				Rotation = t111.Rotation,
				ZIndex = t111.ZIndex or 2
			}) }
		end

		t110.side = sides.top
		t110.cost = {
			currency = "coins",
			amount = 1000000000000000
		}
		t89.coinIncome11 = t110

		local t112 = {
			name = "Coin Income XII",
			dependency = "coinIncome11",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 12) - 1) * 100) }% more coins!`
		}
		local coin10 = ImageIds.coin
		local t113 = {}

		function t112.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin10 (copy), t113 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin10,
				ScaleType = Enum.ScaleType.Fit,
				Size = t113.Size or UDim2.fromScale(1, 1),
				Position = t113.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t113.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t113.ImageColor3,
				ImageTransparency = t113.ImageTransparency,
				Rotation = t113.Rotation,
				ZIndex = t113.ZIndex or 2
			}) }
		end

		t112.side = sides.top
		t112.cost = {
			currency = "coins",
			amount = 10000000000000000
		}
		t89.coinIncome12 = t112

		local t114 = {
			name = "Coin Income XIII",
			dependency = "coinIncome12",
			description = `{ math.round((UpgradeServiceUtils.getUpgradeValue("coinIncome", 13) - 1) * 100) }% more coins!`
		}
		local coin11 = ImageIds.coin
		local t115 = {}

		function t114.icon() -- line: 123
			-- upvalues: ImageLabel (copy), coin11 (copy), t115 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin11,
				ScaleType = Enum.ScaleType.Fit,
				Size = t115.Size or UDim2.fromScale(1, 1),
				Position = t115.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = t115.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = t115.ImageColor3,
				ImageTransparency = t115.ImageTransparency,
				Rotation = t115.Rotation,
				ZIndex = t115.ZIndex or 2
			}) }
		end

		t114.side = sides.topRight
		t114.cost = {
			currency = "coins",
			amount = 1E+17
		}
		t89.coinIncome13 = t114

		local t116 = {
			name = "Overkill I",
			dependency = "coinIncome2",
			description = `Overkill enemies for up to { math.round(UpgradeServiceUtils.getUpgradeValue("overkill", 1) * 100) }% bonus coins.`
		}
		local t117 = {}
		local coin12 = ImageIds.coin
		local v178 = {
			Size = UDim2.fromScale(0.74, 0.74),
			Position = UDim2.fromScale(0.42, 0.58)
		} or {}

		local function v179() -- line: 123
			-- upvalues: ImageLabel (copy), coin12 (copy), v178 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin12,
				ScaleType = Enum.ScaleType.Fit,
				Size = v178.Size or UDim2.fromScale(1, 1),
				Position = v178.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v178.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v178.ImageColor3,
				ImageTransparency = v178.ImageTransparency,
				Rotation = v178.Rotation,
				ZIndex = v178.ZIndex or 2
			}) }
		end

		local damageIcon = ImageIds.damageIcon
		local v181 = {
			ZIndex = 3,
			Size = UDim2.fromScale(0.46, 0.46),
			Position = UDim2.fromScale(0.7, 0.28)
		} or {}

		local function v182() -- line: 123
			-- upvalues: ImageLabel (copy), damageIcon (copy), v181 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = damageIcon,
				ScaleType = Enum.ScaleType.Fit,
				Size = v181.Size or UDim2.fromScale(1, 1),
				Position = v181.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v181.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v181.ImageColor3,
				ImageTransparency = v181.ImageTransparency,
				Rotation = v181.Rotation,
				ZIndex = v181.ZIndex or 2
			}) }
		end

		t117[1] = v179
		t117[2] = v182

		function t116.icon() -- line: 166
			-- upvalues: t117 (copy)
			local t118 = {}

			for _, v431 in t117 do
				for _, v433 in v431() do
					table.insert(t118, v433)
				end
			end

			return t118
		end

		t116.side = sides.bot
		t116.cost = {
			currency = "coins",
			amount = 2000000
		}
		t89.overkill1 = t116
	end

	do
		local t119 = {
			name = "Overkill II",
			dependency = "overkill1",
			description = `Overkill enemies for up to { math.round(UpgradeServiceUtils.getUpgradeValue("overkill", 2) * 100) }% bonus coins.`
		}
		local t120 = {}
		local coin = ImageIds.coin
		local v186 = {
			Size = UDim2.fromScale(0.74, 0.74),
			Position = UDim2.fromScale(0.42, 0.58)
		} or {}

		local function v187() -- line: 123
			-- upvalues: ImageLabel (copy), coin (copy), v186 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin,
				ScaleType = Enum.ScaleType.Fit,
				Size = v186.Size or UDim2.fromScale(1, 1),
				Position = v186.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v186.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v186.ImageColor3,
				ImageTransparency = v186.ImageTransparency,
				Rotation = v186.Rotation,
				ZIndex = v186.ZIndex or 2
			}) }
		end

		local damageIcon = ImageIds.damageIcon
		local v189 = {
			ZIndex = 3,
			Size = UDim2.fromScale(0.46, 0.46),
			Position = UDim2.fromScale(0.7, 0.28)
		} or {}

		local function v190() -- line: 123
			-- upvalues: ImageLabel (copy), damageIcon (copy), v189 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = damageIcon,
				ScaleType = Enum.ScaleType.Fit,
				Size = v189.Size or UDim2.fromScale(1, 1),
				Position = v189.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v189.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v189.ImageColor3,
				ImageTransparency = v189.ImageTransparency,
				Rotation = v189.Rotation,
				ZIndex = v189.ZIndex or 2
			}) }
		end

		local v191 = {
			TextSize = 20,
			ZIndex = 3,
			Size = UDim2.fromScale(0.36, 0.22),
			Position = UDim2.fromScale(0.5, 0.88)
		} or {}
		local s8 = "II"

		local function v193() -- line: 144
			-- upvalues: TextLabel (copy), s8 (copy), v191 (copy)
			return { TextLabel({
				Name = "UpgradeIconText",
				TextWrapped = true,
				Text = s8,
				Size = v191.Size or UDim2.fromScale(1, 1),
				Position = v191.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v191.AnchorPoint or Vector2.new(0.5, 0.5),
				TextColor3 = v191.TextColor3,
				TextSize = v191.TextSize,
				Font = v191.Font,
				Rotation = v191.Rotation,
				Stroke = v191.Stroke or {},
				DropShadow = v191.DropShadow or {},
				ZIndex = v191.ZIndex or 2
			}) }
		end

		t120[1] = v187
		t120[2] = v190
		t120[3] = v193

		function t119.icon() -- line: 166
			-- upvalues: t120 (copy)
			local t121 = {}

			for _, v436 in t120 do
				for _, v438 in v436() do
					table.insert(t121, v438)
				end
			end

			return t121
		end

		t119.side = sides.botRight
		t119.cost = {
			currency = "coins",
			amount = 15000000
		}
		t89.overkill2 = t119

		local t122 = {
			name = "Overkill III",
			dependency = "overkill2",
			description = `Overkill enemies for up to { math.round(UpgradeServiceUtils.getUpgradeValue("overkill", 3) * 100) }% bonus coins.`
		}
		local t123 = {}
		local coin13 = ImageIds.coin
		local v197 = {
			Size = UDim2.fromScale(0.74, 0.74),
			Position = UDim2.fromScale(0.42, 0.58)
		} or {}

		local function v198() -- line: 123
			-- upvalues: ImageLabel (copy), coin13 (copy), v197 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin13,
				ScaleType = Enum.ScaleType.Fit,
				Size = v197.Size or UDim2.fromScale(1, 1),
				Position = v197.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v197.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v197.ImageColor3,
				ImageTransparency = v197.ImageTransparency,
				Rotation = v197.Rotation,
				ZIndex = v197.ZIndex or 2
			}) }
		end

		local damageIcon2 = ImageIds.damageIcon
		local v200 = {
			ZIndex = 3,
			Size = UDim2.fromScale(0.46, 0.46),
			Position = UDim2.fromScale(0.7, 0.28)
		} or {}

		local function v201() -- line: 123
			-- upvalues: ImageLabel (copy), damageIcon2 (copy), v200 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = damageIcon2,
				ScaleType = Enum.ScaleType.Fit,
				Size = v200.Size or UDim2.fromScale(1, 1),
				Position = v200.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v200.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v200.ImageColor3,
				ImageTransparency = v200.ImageTransparency,
				Rotation = v200.Rotation,
				ZIndex = v200.ZIndex or 2
			}) }
		end

		local v202 = {
			TextSize = 18,
			ZIndex = 3,
			Size = UDim2.fromScale(0.42, 0.22),
			Position = UDim2.fromScale(0.5, 0.88)
		} or {}
		local s9 = "III"

		local function v204() -- line: 144
			-- upvalues: TextLabel (copy), s9 (copy), v202 (copy)
			return { TextLabel({
				Name = "UpgradeIconText",
				TextWrapped = true,
				Text = s9,
				Size = v202.Size or UDim2.fromScale(1, 1),
				Position = v202.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v202.AnchorPoint or Vector2.new(0.5, 0.5),
				TextColor3 = v202.TextColor3,
				TextSize = v202.TextSize,
				Font = v202.Font,
				Rotation = v202.Rotation,
				Stroke = v202.Stroke or {},
				DropShadow = v202.DropShadow or {},
				ZIndex = v202.ZIndex or 2
			}) }
		end

		t123[1] = v198
		t123[2] = v201
		t123[3] = v204

		function t122.icon() -- line: 166
			-- upvalues: t123 (copy)
			local t124 = {}

			for _, v441 in t123 do
				for _, v443 in v441() do
					table.insert(t124, v443)
				end
			end

			return t124
		end

		t122.side = sides.bot
		t122.cost = {
			currency = "coins",
			amount = 60000000
		}
		t89.overkill3 = t122
	end

	local t140, t141, v261

	do
		local t131, t132, v231

		do
			local t125 = {
				name = "Overkill IV",
				dependency = "overkill3",
				description = `Overkill enemies for up to { math.round(UpgradeServiceUtils.getUpgradeValue("overkill", 4) * 100) }% bonus coins.`
			}
			local t126 = {}
			local coin = ImageIds.coin
			local v208 = {
				Size = UDim2.fromScale(0.74, 0.74),
				Position = UDim2.fromScale(0.42, 0.58)
			} or {}

			local function v209() -- line: 123
				-- upvalues: ImageLabel (copy), coin (copy), v208 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = coin,
					ScaleType = Enum.ScaleType.Fit,
					Size = v208.Size or UDim2.fromScale(1, 1),
					Position = v208.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v208.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = v208.ImageColor3,
					ImageTransparency = v208.ImageTransparency,
					Rotation = v208.Rotation,
					ZIndex = v208.ZIndex or 2
				}) }
			end

			local damageIcon = ImageIds.damageIcon
			local v211 = {
				ZIndex = 3,
				Size = UDim2.fromScale(0.46, 0.46),
				Position = UDim2.fromScale(0.7, 0.28)
			} or {}

			local function v212() -- line: 123
				-- upvalues: ImageLabel (copy), damageIcon (copy), v211 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = damageIcon,
					ScaleType = Enum.ScaleType.Fit,
					Size = v211.Size or UDim2.fromScale(1, 1),
					Position = v211.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v211.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = v211.ImageColor3,
					ImageTransparency = v211.ImageTransparency,
					Rotation = v211.Rotation,
					ZIndex = v211.ZIndex or 2
				}) }
			end

			local v213 = {
				TextSize = 18,
				ZIndex = 3,
				Size = UDim2.fromScale(0.42, 0.22),
				Position = UDim2.fromScale(0.5, 0.88)
			} or {}
			local s10 = "IV"

			local function v215() -- line: 144
				-- upvalues: TextLabel (copy), s10 (copy), v213 (copy)
				return { TextLabel({
					Name = "UpgradeIconText",
					TextWrapped = true,
					Text = s10,
					Size = v213.Size or UDim2.fromScale(1, 1),
					Position = v213.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v213.AnchorPoint or Vector2.new(0.5, 0.5),
					TextColor3 = v213.TextColor3,
					TextSize = v213.TextSize,
					Font = v213.Font,
					Rotation = v213.Rotation,
					Stroke = v213.Stroke or {},
					DropShadow = v213.DropShadow or {},
					ZIndex = v213.ZIndex or 2
				}) }
			end

			t126[1] = v209
			t126[2] = v212
			t126[3] = v215

			function t125.icon() -- line: 166
				-- upvalues: t126 (copy)
				local t127 = {}

				for _, v446 in t126 do
					for _, v448 in v446() do
						table.insert(t127, v448)
					end
				end

				return t127
			end

			t125.side = sides.botRight
			t125.cost = {
				currency = "coins",
				amount = 850000000
			}
			t89.overkill4 = t125

			local t128 = {
				name = "Overkill V",
				dependency = "overkill4",
				description = `Overkill enemies for up to { math.round(UpgradeServiceUtils.getUpgradeValue("overkill", 5) * 100) }% bonus coins.`
			}
			local t129 = {}
			local coin14 = ImageIds.coin
			local v219 = {
				Size = UDim2.fromScale(0.74, 0.74),
				Position = UDim2.fromScale(0.42, 0.58)
			} or {}

			local function v220() -- line: 123
				-- upvalues: ImageLabel (copy), coin14 (copy), v219 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = coin14,
					ScaleType = Enum.ScaleType.Fit,
					Size = v219.Size or UDim2.fromScale(1, 1),
					Position = v219.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v219.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = v219.ImageColor3,
					ImageTransparency = v219.ImageTransparency,
					Rotation = v219.Rotation,
					ZIndex = v219.ZIndex or 2
				}) }
			end

			local damageIcon3 = ImageIds.damageIcon
			local v222 = {
				ZIndex = 3,
				Size = UDim2.fromScale(0.46, 0.46),
				Position = UDim2.fromScale(0.7, 0.28)
			} or {}

			local function v223() -- line: 123
				-- upvalues: ImageLabel (copy), damageIcon3 (copy), v222 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = damageIcon3,
					ScaleType = Enum.ScaleType.Fit,
					Size = v222.Size or UDim2.fromScale(1, 1),
					Position = v222.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v222.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = v222.ImageColor3,
					ImageTransparency = v222.ImageTransparency,
					Rotation = v222.Rotation,
					ZIndex = v222.ZIndex or 2
				}) }
			end

			local v224 = {
				TextSize = 18,
				ZIndex = 3,
				Size = UDim2.fromScale(0.42, 0.22),
				Position = UDim2.fromScale(0.5, 0.88)
			} or {}
			local s11 = "V"

			local function v226() -- line: 144
				-- upvalues: TextLabel (copy), s11 (copy), v224 (copy)
				return { TextLabel({
					Name = "UpgradeIconText",
					TextWrapped = true,
					Text = s11,
					Size = v224.Size or UDim2.fromScale(1, 1),
					Position = v224.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v224.AnchorPoint or Vector2.new(0.5, 0.5),
					TextColor3 = v224.TextColor3,
					TextSize = v224.TextSize,
					Font = v224.Font,
					Rotation = v224.Rotation,
					Stroke = v224.Stroke or {},
					DropShadow = v224.DropShadow or {},
					ZIndex = v224.ZIndex or 2
				}) }
			end

			t129[1] = v220
			t129[2] = v223
			t129[3] = v226

			function t128.icon() -- line: 166
				-- upvalues: t129 (copy)
				local t130 = {}

				for _, v451 in t129 do
					for _, v453 in v451() do
						table.insert(t130, v453)
					end
				end

				return t130
			end

			t128.side = sides.topRight
			t128.cost = {
				currency = "coins",
				amount = 20000000000
			}
			t89.overkill5 = t128
			t131 = {
				name = "Overkill VI",
				dependency = "overkill5",
				description = `Overkill enemies for up to { math.round(UpgradeServiceUtils.getUpgradeValue("overkill", 6) * 100) }% bonus coins.`
			}
			t132 = {}

			local coin15 = ImageIds.coin
			local v230 = {
				Size = UDim2.fromScale(0.74, 0.74),
				Position = UDim2.fromScale(0.42, 0.58)
			} or {}

			function v231() -- line: 123
				-- upvalues: ImageLabel (copy), coin15 (copy), v230 (copy)
				return { ImageLabel({
					Name = "UpgradeIconImage",
					Image = coin15,
					ScaleType = Enum.ScaleType.Fit,
					Size = v230.Size or UDim2.fromScale(1, 1),
					Position = v230.Position or UDim2.fromScale(0.5, 0.5),
					AnchorPoint = v230.AnchorPoint or Vector2.new(0.5, 0.5),
					ImageColor3 = v230.ImageColor3,
					ImageTransparency = v230.ImageTransparency,
					Rotation = v230.Rotation,
					ZIndex = v230.ZIndex or 2
				}) }
			end
		end

		local damageIcon = ImageIds.damageIcon
		local v233 = {
			ZIndex = 3,
			Size = UDim2.fromScale(0.46, 0.46),
			Position = UDim2.fromScale(0.7, 0.28)
		} or {}

		local function v234() -- line: 123
			-- upvalues: ImageLabel (copy), damageIcon (copy), v233 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = damageIcon,
				ScaleType = Enum.ScaleType.Fit,
				Size = v233.Size or UDim2.fromScale(1, 1),
				Position = v233.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v233.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v233.ImageColor3,
				ImageTransparency = v233.ImageTransparency,
				Rotation = v233.Rotation,
				ZIndex = v233.ZIndex or 2
			}) }
		end

		local v235 = {
			TextSize = 18,
			ZIndex = 3,
			Size = UDim2.fromScale(0.42, 0.22),
			Position = UDim2.fromScale(0.5, 0.88)
		} or {}
		local s12 = "VI"

		local function v237() -- line: 144
			-- upvalues: TextLabel (copy), s12 (copy), v235 (copy)
			return { TextLabel({
				Name = "UpgradeIconText",
				TextWrapped = true,
				Text = s12,
				Size = v235.Size or UDim2.fromScale(1, 1),
				Position = v235.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v235.AnchorPoint or Vector2.new(0.5, 0.5),
				TextColor3 = v235.TextColor3,
				TextSize = v235.TextSize,
				Font = v235.Font,
				Rotation = v235.Rotation,
				Stroke = v235.Stroke or {},
				DropShadow = v235.DropShadow or {},
				ZIndex = v235.ZIndex or 2
			}) }
		end

		t132[1] = v231
		t132[2] = v234
		t132[3] = v237

		function t131.icon() -- line: 166
			-- upvalues: t132 (copy)
			local t133 = {}

			for _, v456 in t132 do
				for _, v458 in v456() do
					table.insert(t133, v458)
				end
			end

			return t133
		end

		t131.side = sides.botRight
		t131.cost = {
			currency = "coins",
			amount = 400000000000
		}
		t89.overkill6 = t131

		local t134 = {
			name = "Offline Loot I",
			description = "10% more offline loot!",
			dependency = "coinIncome1"
		}
		local t135 = {}
		local coin = ImageIds.coin
		local v241 = {
			Size = UDim2.fromScale(0.74, 0.74),
			Position = UDim2.fromScale(0.42, 0.58)
		} or {}

		local function v242() -- line: 123
			-- upvalues: ImageLabel (copy), coin (copy), v241 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin,
				ScaleType = Enum.ScaleType.Fit,
				Size = v241.Size or UDim2.fromScale(1, 1),
				Position = v241.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v241.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v241.ImageColor3,
				ImageTransparency = v241.ImageTransparency,
				Rotation = v241.Rotation,
				ZIndex = v241.ZIndex or 2
			}) }
		end

		local goop = ImageIds.goop
		local v244 = {
			ZIndex = 3,
			Size = UDim2.fromScale(0.46, 0.46),
			Position = UDim2.fromScale(0.7, 0.28)
		} or {}

		local function v245() -- line: 123
			-- upvalues: ImageLabel (copy), goop (copy), v244 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = goop,
				ScaleType = Enum.ScaleType.Fit,
				Size = v244.Size or UDim2.fromScale(1, 1),
				Position = v244.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v244.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v244.ImageColor3,
				ImageTransparency = v244.ImageTransparency,
				Rotation = v244.Rotation,
				ZIndex = v244.ZIndex or 2
			}) }
		end

		t135[1] = v242
		t135[2] = v245

		function t134.icon() -- line: 166
			-- upvalues: t135 (copy)
			local t136 = {}

			for _, v461 in t135 do
				for _, v463 in v461() do
					table.insert(t136, v463)
				end
			end

			return t136
		end

		t134.side = sides.topLeft
		t134.cost = {
			currency = "coins",
			amount = 1500000
		}
		t89.offlineLootAmount1 = t134

		local t137 = {
			name = "Offline Loot II",
			description = "25% more offline loot!",
			dependency = "offlineLootAmount1"
		}
		local t138 = {}
		local coin16 = ImageIds.coin
		local v249 = {
			Size = UDim2.fromScale(0.74, 0.74),
			Position = UDim2.fromScale(0.42, 0.58)
		} or {}

		local function v250() -- line: 123
			-- upvalues: ImageLabel (copy), coin16 (copy), v249 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin16,
				ScaleType = Enum.ScaleType.Fit,
				Size = v249.Size or UDim2.fromScale(1, 1),
				Position = v249.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v249.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v249.ImageColor3,
				ImageTransparency = v249.ImageTransparency,
				Rotation = v249.Rotation,
				ZIndex = v249.ZIndex or 2
			}) }
		end

		local goop7 = ImageIds.goop
		local v252 = {
			ZIndex = 3,
			Size = UDim2.fromScale(0.46, 0.46),
			Position = UDim2.fromScale(0.7, 0.28)
		} or {}

		local function v253() -- line: 123
			-- upvalues: ImageLabel (copy), goop7 (copy), v252 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = goop7,
				ScaleType = Enum.ScaleType.Fit,
				Size = v252.Size or UDim2.fromScale(1, 1),
				Position = v252.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v252.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v252.ImageColor3,
				ImageTransparency = v252.ImageTransparency,
				Rotation = v252.Rotation,
				ZIndex = v252.ZIndex or 2
			}) }
		end

		local v254 = {
			TextSize = 20,
			ZIndex = 3,
			Size = UDim2.fromScale(0.36, 0.22),
			Position = UDim2.fromScale(0.5, 0.88)
		} or {}
		local s13 = "II"

		local function v256() -- line: 144
			-- upvalues: TextLabel (copy), s13 (copy), v254 (copy)
			return { TextLabel({
				Name = "UpgradeIconText",
				TextWrapped = true,
				Text = s13,
				Size = v254.Size or UDim2.fromScale(1, 1),
				Position = v254.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v254.AnchorPoint or Vector2.new(0.5, 0.5),
				TextColor3 = v254.TextColor3,
				TextSize = v254.TextSize,
				Font = v254.Font,
				Rotation = v254.Rotation,
				Stroke = v254.Stroke or {},
				DropShadow = v254.DropShadow or {},
				ZIndex = v254.ZIndex or 2
			}) }
		end

		t138[1] = v250
		t138[2] = v253
		t138[3] = v256

		function t137.icon() -- line: 166
			-- upvalues: t138 (copy)
			local t139 = {}

			for _, v466 in t138 do
				for _, v468 in v466() do
					table.insert(t139, v468)
				end
			end

			return t139
		end

		t137.side = sides.topLeft
		t137.cost = {
			currency = "coins",
			amount = 1000000000
		}
		t89.offlineLootAmount2 = t137
		t140 = {
			name = "Offline Loot III",
			description = "50% more offline loot!",
			dependency = "offlineLootAmount2"
		}
		t141 = {}

		local coin17 = ImageIds.coin
		local v260 = {
			Size = UDim2.fromScale(0.74, 0.74),
			Position = UDim2.fromScale(0.42, 0.58)
		} or {}

		function v261() -- line: 123
			-- upvalues: ImageLabel (copy), coin17 (copy), v260 (copy)
			return { ImageLabel({
				Name = "UpgradeIconImage",
				Image = coin17,
				ScaleType = Enum.ScaleType.Fit,
				Size = v260.Size or UDim2.fromScale(1, 1),
				Position = v260.Position or UDim2.fromScale(0.5, 0.5),
				AnchorPoint = v260.AnchorPoint or Vector2.new(0.5, 0.5),
				ImageColor3 = v260.ImageColor3,
				ImageTransparency = v260.ImageTransparency,
				Rotation = v260.Rotation,
				ZIndex = v260.ZIndex or 2
			}) }
		end
	end

	local goop = ImageIds.goop
	local v263 = {
		ZIndex = 3,
		Size = UDim2.fromScale(0.46, 0.46),
		Position = UDim2.fromScale(0.7, 0.28)
	} or {}

	local function v264() -- line: 123
		-- upvalues: ImageLabel (copy), goop (copy), v263 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = goop,
			ScaleType = Enum.ScaleType.Fit,
			Size = v263.Size or UDim2.fromScale(1, 1),
			Position = v263.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v263.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = v263.ImageColor3,
			ImageTransparency = v263.ImageTransparency,
			Rotation = v263.Rotation,
			ZIndex = v263.ZIndex or 2
		}) }
	end

	local v265 = {
		TextSize = 18,
		ZIndex = 3,
		Size = UDim2.fromScale(0.42, 0.22),
		Position = UDim2.fromScale(0.5, 0.88)
	} or {}
	local s14 = "III"

	local function v267() -- line: 144
		-- upvalues: TextLabel (copy), s14 (copy), v265 (copy)
		return { TextLabel({
			Name = "UpgradeIconText",
			TextWrapped = true,
			Text = s14,
			Size = v265.Size or UDim2.fromScale(1, 1),
			Position = v265.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v265.AnchorPoint or Vector2.new(0.5, 0.5),
			TextColor3 = v265.TextColor3,
			TextSize = v265.TextSize,
			Font = v265.Font,
			Rotation = v265.Rotation,
			Stroke = v265.Stroke or {},
			DropShadow = v265.DropShadow or {},
			ZIndex = v265.ZIndex or 2
		}) }
	end

	t141[1] = v261
	t141[2] = v264
	t141[3] = v267

	function t140.icon() -- line: 166
		-- upvalues: t141 (copy)
		local t142 = {}

		for _, v471 in t141 do
			for _, v473 in v471() do
				table.insert(t142, v473)
			end
		end

		return t142
	end

	t140.side = sides.botLeft
	t140.cost = {
		currency = "coins",
		amount = 1000000000000
	}
	t89.offlineLootAmount3 = t140

	local t143 = {
		name = "Offline Loot IV",
		description = "75% more offline loot!",
		dependency = "offlineLootAmount3"
	}
	local t144 = {}
	local coin = ImageIds.coin
	local v271 = {
		Size = UDim2.fromScale(0.74, 0.74),
		Position = UDim2.fromScale(0.42, 0.58)
	} or {}

	local function v272() -- line: 123
		-- upvalues: ImageLabel (copy), coin (copy), v271 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = coin,
			ScaleType = Enum.ScaleType.Fit,
			Size = v271.Size or UDim2.fromScale(1, 1),
			Position = v271.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v271.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = v271.ImageColor3,
			ImageTransparency = v271.ImageTransparency,
			Rotation = v271.Rotation,
			ZIndex = v271.ZIndex or 2
		}) }
	end

	local goop8 = ImageIds.goop
	local v274 = {
		ZIndex = 3,
		Size = UDim2.fromScale(0.46, 0.46),
		Position = UDim2.fromScale(0.7, 0.28)
	} or {}

	local function v275() -- line: 123
		-- upvalues: ImageLabel (copy), goop8 (copy), v274 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = goop8,
			ScaleType = Enum.ScaleType.Fit,
			Size = v274.Size or UDim2.fromScale(1, 1),
			Position = v274.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v274.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = v274.ImageColor3,
			ImageTransparency = v274.ImageTransparency,
			Rotation = v274.Rotation,
			ZIndex = v274.ZIndex or 2
		}) }
	end

	local v276 = {
		TextSize = 18,
		ZIndex = 3,
		Size = UDim2.fromScale(0.42, 0.22),
		Position = UDim2.fromScale(0.5, 0.88)
	} or {}
	local s15 = "IV"

	local function v278() -- line: 144
		-- upvalues: TextLabel (copy), s15 (copy), v276 (copy)
		return { TextLabel({
			Name = "UpgradeIconText",
			TextWrapped = true,
			Text = s15,
			Size = v276.Size or UDim2.fromScale(1, 1),
			Position = v276.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v276.AnchorPoint or Vector2.new(0.5, 0.5),
			TextColor3 = v276.TextColor3,
			TextSize = v276.TextSize,
			Font = v276.Font,
			Rotation = v276.Rotation,
			Stroke = v276.Stroke or {},
			DropShadow = v276.DropShadow or {},
			ZIndex = v276.ZIndex or 2
		}) }
	end

	t144[1] = v272
	t144[2] = v275
	t144[3] = v278

	function t143.icon() -- line: 166
		-- upvalues: t144 (copy)
		local t145 = {}

		for _, v476 in t144 do
			for _, v478 in v476() do
				table.insert(t145, v478)
			end
		end

		return t145
	end

	t143.side = sides.botLeft
	t143.cost = {
		currency = "coins",
		amount = 1000000000000000
	}
	t89.offlineLootAmount4 = t143

	local t146 = {
		name = "Offline Loot V",
		description = "100% more offline loot!",
		dependency = "offlineLootAmount4"
	}
	local t147 = {}
	local coin18 = ImageIds.coin
	local v282 = {
		Size = UDim2.fromScale(0.74, 0.74),
		Position = UDim2.fromScale(0.42, 0.58)
	} or {}

	local function v283() -- line: 123
		-- upvalues: ImageLabel (copy), coin18 (copy), v282 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = coin18,
			ScaleType = Enum.ScaleType.Fit,
			Size = v282.Size or UDim2.fromScale(1, 1),
			Position = v282.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v282.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = v282.ImageColor3,
			ImageTransparency = v282.ImageTransparency,
			Rotation = v282.Rotation,
			ZIndex = v282.ZIndex or 2
		}) }
	end

	local goop9 = ImageIds.goop
	local v285 = {
		ZIndex = 3,
		Size = UDim2.fromScale(0.46, 0.46),
		Position = UDim2.fromScale(0.7, 0.28)
	} or {}

	local function v286() -- line: 123
		-- upvalues: ImageLabel (copy), goop9 (copy), v285 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = goop9,
			ScaleType = Enum.ScaleType.Fit,
			Size = v285.Size or UDim2.fromScale(1, 1),
			Position = v285.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v285.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = v285.ImageColor3,
			ImageTransparency = v285.ImageTransparency,
			Rotation = v285.Rotation,
			ZIndex = v285.ZIndex or 2
		}) }
	end

	local v287 = {
		TextSize = 18,
		ZIndex = 3,
		Size = UDim2.fromScale(0.42, 0.22),
		Position = UDim2.fromScale(0.5, 0.88)
	} or {}
	local s16 = "V"

	local function v289() -- line: 144
		-- upvalues: TextLabel (copy), s16 (copy), v287 (copy)
		return { TextLabel({
			Name = "UpgradeIconText",
			TextWrapped = true,
			Text = s16,
			Size = v287.Size or UDim2.fromScale(1, 1),
			Position = v287.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = v287.AnchorPoint or Vector2.new(0.5, 0.5),
			TextColor3 = v287.TextColor3,
			TextSize = v287.TextSize,
			Font = v287.Font,
			Rotation = v287.Rotation,
			Stroke = v287.Stroke or {},
			DropShadow = v287.DropShadow or {},
			ZIndex = v287.ZIndex or 2
		}) }
	end

	t147[1] = v283
	t147[2] = v286
	t147[3] = v289

	function t146.icon() -- line: 166
		-- upvalues: t147 (copy)
		local t148 = {}

		for _, v481 in t147 do
			for _, v483 in v481() do
				table.insert(t148, v483)
			end
		end

		return t148
	end

	t146.side = sides.topLeft
	t146.cost = {
		currency = "coins",
		amount = 1E+18
	}
	t89.offlineLootAmount5 = t146

	local t149 = {
		name = "Apple",
		description = "Unlock Apple as enemy loot.",
		dependency = "lootTree"
	}
	local t150 = {}
	local s17 = "rbxassetid://112699557887535"

	function t149.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s17 (copy), t150 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s17,
			ScaleType = Enum.ScaleType.Fit,
			Size = t150.Size or UDim2.fromScale(1, 1),
			Position = t150.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t150.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t150.ImageColor3,
			ImageTransparency = t150.ImageTransparency,
			Rotation = t150.Rotation,
			ZIndex = t150.ZIndex or 2
		}) }
	end

	t149.side = sides.top
	t149.cost = {
		currency = "coins",
		amount = 2000
	}
	t89.lootApple = t149
end

local t173

do
	local t151 = {
		name = "Carrot",
		description = "Unlock Carrot as enemy loot.",
		dependency = "lootApple"
	}
	local t152 = {}
	local s18 = "rbxassetid://134696857657707"

	function t151.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s18 (copy), t152 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s18,
			ScaleType = Enum.ScaleType.Fit,
			Size = t152.Size or UDim2.fromScale(1, 1),
			Position = t152.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t152.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t152.ImageColor3,
			ImageTransparency = t152.ImageTransparency,
			Rotation = t152.Rotation,
			ZIndex = t152.ZIndex or 2
		}) }
	end

	t151.side = sides.top
	t151.cost = {
		currency = "coins",
		amount = 10000
	}
	t89.lootCarrot = t151

	local t153 = {
		name = "Cherries",
		description = "Unlock Cherries as enemy loot.",
		dependency = "lootCarrot"
	}
	local t154 = {}
	local s19 = "rbxassetid://106679637897733"

	function t153.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s19 (copy), t154 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s19,
			ScaleType = Enum.ScaleType.Fit,
			Size = t154.Size or UDim2.fromScale(1, 1),
			Position = t154.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t154.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t154.ImageColor3,
			ImageTransparency = t154.ImageTransparency,
			Rotation = t154.Rotation,
			ZIndex = t154.ZIndex or 2
		}) }
	end

	t153.side = sides.topLeft
	t153.cost = {
		currency = "coins",
		amount = 50000
	}
	t89.lootCherries = t153

	local t155 = {
		name = "Grapes",
		description = "Unlock Grapes as enemy loot.",
		dependency = "lootCherries"
	}
	local t156 = {}
	local s20 = "rbxassetid://93890107403882"

	function t155.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s20 (copy), t156 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s20,
			ScaleType = Enum.ScaleType.Fit,
			Size = t156.Size or UDim2.fromScale(1, 1),
			Position = t156.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t156.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t156.ImageColor3,
			ImageTransparency = t156.ImageTransparency,
			Rotation = t156.Rotation,
			ZIndex = t156.ZIndex or 2
		}) }
	end

	t155.side = sides.botLeft
	t155.cost = {
		currency = "coins",
		amount = 500000
	}
	t89.lootGrapes = t155

	local t157 = {
		name = "Banana",
		description = "Unlock Banana as enemy loot.",
		dependency = "lootGrapes"
	}
	local t158 = {}
	local s21 = "rbxassetid://122787775415651"

	function t157.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s21 (copy), t158 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s21,
			ScaleType = Enum.ScaleType.Fit,
			Size = t158.Size or UDim2.fromScale(1, 1),
			Position = t158.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t158.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t158.ImageColor3,
			ImageTransparency = t158.ImageTransparency,
			Rotation = t158.Rotation,
			ZIndex = t158.ZIndex or 2
		}) }
	end

	t157.side = sides.topLeft
	t157.cost = {
		currency = "coins",
		amount = 5000000
	}
	t89.lootBanana = t157

	local t159 = {
		name = "Watermelon",
		description = "Unlock Watermelon as enemy loot.",
		dependency = "lootBanana"
	}
	local t160 = {}
	local s22 = "rbxassetid://98959521935651"

	function t159.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s22 (copy), t160 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s22,
			ScaleType = Enum.ScaleType.Fit,
			Size = t160.Size or UDim2.fromScale(1, 1),
			Position = t160.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t160.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t160.ImageColor3,
			ImageTransparency = t160.ImageTransparency,
			Rotation = t160.Rotation,
			ZIndex = t160.ZIndex or 2
		}) }
	end

	t159.side = sides.top
	t159.cost = {
		currency = "coins",
		amount = 75000000
	}
	t89.lootWatermelon = t159

	local t161 = {
		name = "Pizza",
		description = "Unlock Pizza as enemy loot.",
		dependency = "lootWatermelon"
	}
	local t162 = {}
	local s23 = "rbxassetid://116306393207375"

	function t161.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s23 (copy), t162 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s23,
			ScaleType = Enum.ScaleType.Fit,
			Size = t162.Size or UDim2.fromScale(1, 1),
			Position = t162.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t162.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t162.ImageColor3,
			ImageTransparency = t162.ImageTransparency,
			Rotation = t162.Rotation,
			ZIndex = t162.ZIndex or 2
		}) }
	end

	t161.side = sides.topRight
	t161.cost = {
		currency = "coins",
		amount = 1000000000
	}
	t89.lootPizza = t161

	local t163 = {
		name = "Chicken",
		description = "Unlock Chicken as enemy loot.",
		dependency = "lootPizza"
	}
	local t164 = {}
	local s24 = "rbxassetid://108578662930655"

	function t163.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s24 (copy), t164 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s24,
			ScaleType = Enum.ScaleType.Fit,
			Size = t164.Size or UDim2.fromScale(1, 1),
			Position = t164.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t164.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t164.ImageColor3,
			ImageTransparency = t164.ImageTransparency,
			Rotation = t164.Rotation,
			ZIndex = t164.ZIndex or 2
		}) }
	end

	t163.side = sides.topRight
	t163.cost = {
		currency = "coins",
		amount = 20000000000
	}
	t89.lootChicken = t163

	local t165 = {
		name = "Drumstick",
		description = "Unlock Drumstick as enemy loot.",
		dependency = "lootChicken"
	}
	local t166 = {}
	local s25 = "rbxassetid://103284786335739"

	function t165.icon() -- line: 123
		-- upvalues: ImageLabel (copy), s25 (copy), t166 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = s25,
			ScaleType = Enum.ScaleType.Fit,
			Size = t166.Size or UDim2.fromScale(1, 1),
			Position = t166.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t166.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t166.ImageColor3,
			ImageTransparency = t166.ImageTransparency,
			Rotation = t166.Rotation,
			ZIndex = t166.ZIndex or 2
		}) }
	end

	t165.side = sides.botRight
	t165.cost = {
		currency = "coins",
		amount = 500000000000
	}
	t89.lootDrumstick = t165

	local t167 = {
		name = "Luck Boost",
		description = "Unlock Luck Boost as enemy loot.",
		dependency = "lootTree"
	}
	local luck = ImageIds.boosts.luck
	local t168 = {}

	function t167.icon() -- line: 123
		-- upvalues: ImageLabel (copy), luck (copy), t168 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = luck,
			ScaleType = Enum.ScaleType.Fit,
			Size = t168.Size or UDim2.fromScale(1, 1),
			Position = t168.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t168.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t168.ImageColor3,
			ImageTransparency = t168.ImageTransparency,
			Rotation = t168.Rotation,
			ZIndex = t168.ZIndex or 2
		}) }
	end

	t167.side = sides.botRight
	t167.cost = {
		currency = "coins",
		amount = 4000
	}
	t89.lootLuck = t167

	local t169 = {
		name = "Currency Boost",
		description = "Unlock Currency Boost as enemy loot.",
		dependency = "lootLuck"
	}
	local currency = ImageIds.boosts.currency
	local t170 = {}

	function t169.icon() -- line: 123
		-- upvalues: ImageLabel (copy), currency (copy), t170 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = currency,
			ScaleType = Enum.ScaleType.Fit,
			Size = t170.Size or UDim2.fromScale(1, 1),
			Position = t170.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t170.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t170.ImageColor3,
			ImageTransparency = t170.ImageTransparency,
			Rotation = t170.Rotation,
			ZIndex = t170.ZIndex or 2
		}) }
	end

	t169.side = sides.bot
	t169.cost = {
		currency = "coins",
		amount = 25000
	}
	t89.lootCurrency = t169

	local t171 = {
		name = "Roll Speed Boost",
		description = "Unlock Roll Speed Boost as enemy loot.",
		dependency = "lootLuck"
	}
	local rollSpeed = ImageIds.boosts.rollSpeed
	local t172 = {}

	function t171.icon() -- line: 123
		-- upvalues: ImageLabel (copy), rollSpeed (copy), t172 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = rollSpeed,
			ScaleType = Enum.ScaleType.Fit,
			Size = t172.Size or UDim2.fromScale(1, 1),
			Position = t172.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t172.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t172.ImageColor3,
			ImageTransparency = t172.ImageTransparency,
			Rotation = t172.Rotation,
			ZIndex = t172.ZIndex or 2
		}) }
	end

	t171.side = sides.botRight
	t171.cost = {
		currency = "coins",
		amount = 100000
	}
	t89.lootRollSpeed = t171
	t173 = {
		name = "Ultra Luck Boost",
		description = "Unlock Ultra Luck Boost as enemy loot.",
		dependency = "lootRollSpeed"
	}

	local ultraLuck = ImageIds.boosts.ultraLuck
	local t174 = {}

	function t173.icon() -- line: 123
		-- upvalues: ImageLabel (copy), ultraLuck (copy), t174 (copy)
		return { ImageLabel({
			Name = "UpgradeIconImage",
			Image = ultraLuck,
			ScaleType = Enum.ScaleType.Fit,
			Size = t174.Size or UDim2.fromScale(1, 1),
			Position = t174.Position or UDim2.fromScale(0.5, 0.5),
			AnchorPoint = t174.AnchorPoint or Vector2.new(0.5, 0.5),
			ImageColor3 = t174.ImageColor3,
			ImageTransparency = t174.ImageTransparency,
			Rotation = t174.Rotation,
			ZIndex = t174.ZIndex or 2
		}) }
	end
end

t173.side = sides.botRight
t173.cost = {
	currency = "coins",
	amount = 1000000
}
t89.lootUltraLuck = t173

local t175 = {
	playerTree = {
		name = "Player",
		description = "Open",
		tree = "main",
		icon = function() --[[ icon ]] -- line: 2094
			return {}
		end,
		dependency = originDependency,
		side = sides.origin
	}
}
local t176 = {
	name = "Walk Speed I",
	description = "Move Faster!",
	dependency = "playerTree"
}
local character = ImageIds.character
local v332 = {
	Size = UDim2.fromScale(1.2, 1.2),
	Position = UDim2.fromScale(0.5, 0.45)
} or {}

function t176.icon() -- line: 123
	-- upvalues: ImageLabel (copy), character (copy), v332 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = character,
		ScaleType = Enum.ScaleType.Fit,
		Size = v332.Size or UDim2.fromScale(1, 1),
		Position = v332.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = v332.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = v332.ImageColor3,
		ImageTransparency = v332.ImageTransparency,
		Rotation = v332.Rotation,
		ZIndex = v332.ZIndex or 2
	}) }
end

t176.side = sides.topRight
t176.cost = {
	currency = "coins",
	amount = 30000
}
t175.walkSpeed1 = t176

local t177 = {
	name = "Walk Speed II",
	description = "Move Even Faster!",
	dependency = "walkSpeed1"
}
local character2 = ImageIds.character
local v335 = {
	Size = UDim2.fromScale(1.2, 1.2),
	Position = UDim2.fromScale(0.5, 0.45)
} or {}

function t177.icon() -- line: 123
	-- upvalues: ImageLabel (copy), character2 (copy), v335 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = character2,
		ScaleType = Enum.ScaleType.Fit,
		Size = v335.Size or UDim2.fromScale(1, 1),
		Position = v335.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = v335.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = v335.ImageColor3,
		ImageTransparency = v335.ImageTransparency,
		Rotation = v335.Rotation,
		ZIndex = v335.ZIndex or 2
	}) }
end

t177.side = sides.botRight
t177.cost = {
	currency = "coins",
	amount = 225000
}
t175.walkSpeed2 = t177

local t178 = {
	name = "Walk Speed III",
	description = "Move Even Faster!",
	dependency = "walkSpeed2"
}
local character3 = ImageIds.character
local v338 = {
	Size = UDim2.fromScale(1.2, 1.2),
	Position = UDim2.fromScale(0.5, 0.45)
} or {}

function t178.icon() -- line: 123
	-- upvalues: ImageLabel (copy), character3 (copy), v338 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = character3,
		ScaleType = Enum.ScaleType.Fit,
		Size = v338.Size or UDim2.fromScale(1, 1),
		Position = v338.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = v338.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = v338.ImageColor3,
		ImageTransparency = v338.ImageTransparency,
		Rotation = v338.Rotation,
		ZIndex = v338.ZIndex or 2
	}) }
end

t178.side = sides.topRight
t178.cost = {
	currency = "coins",
	amount = 2000000
}
t175.walkSpeed3 = t178

local t179 = {
	name = "Teleporter",
	description = "Unlock the Teleporter menu.",
	dependency = "walkSpeed2"
}
local teleporter = ImageIds.teleporter
local t180 = {}

function t179.icon() -- line: 123
	-- upvalues: ImageLabel (copy), teleporter (copy), t180 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = teleporter,
		ScaleType = Enum.ScaleType.Fit,
		Size = t180.Size or UDim2.fromScale(1, 1),
		Position = t180.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = t180.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = t180.ImageColor3,
		ImageTransparency = t180.ImageTransparency,
		Rotation = t180.Rotation,
		ZIndex = t180.ZIndex or 2
	}) }
end

t179.side = sides.top
t179.cost = {
	currency = "coins",
	amount = 1000000
}
t175.teleporter = t179

local t181 = {
	name = "Magnet I",
	description = "Attract nearby loot!",
	dependency = "walkSpeed2"
}
local autoCollect = ImageIds.passes.autoCollect
local t182 = {}

function t181.icon() -- line: 123
	-- upvalues: ImageLabel (copy), autoCollect (copy), t182 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = autoCollect,
		ScaleType = Enum.ScaleType.Fit,
		Size = t182.Size or UDim2.fromScale(1, 1),
		Position = t182.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = t182.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = t182.ImageColor3,
		ImageTransparency = t182.ImageTransparency,
		Rotation = t182.Rotation,
		ZIndex = t182.ZIndex or 2
	}) }
end

t181.side = sides.bot
t181.cost = {
	currency = "coins",
	amount = 500000
}
t175.magnet1 = t181

local t183 = {
	name = "Magnet II",
	description = "Range increased!",
	dependency = "magnet1"
}
local autoCollect2 = ImageIds.passes.autoCollect
local t184 = {}

function t183.icon() -- line: 123
	-- upvalues: ImageLabel (copy), autoCollect2 (copy), t184 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = autoCollect2,
		ScaleType = Enum.ScaleType.Fit,
		Size = t184.Size or UDim2.fromScale(1, 1),
		Position = t184.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = t184.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = t184.ImageColor3,
		ImageTransparency = t184.ImageTransparency,
		Rotation = t184.Rotation,
		ZIndex = t184.ZIndex or 2
	}) }
end

t183.side = sides.botRight
t183.cost = {
	currency = "coins",
	amount = 500000000
}
t175.magnet2 = t183

local t185 = {
	name = "Magnet III",
	description = "Range increased!",
	dependency = "magnet2"
}
local autoCollect3 = ImageIds.passes.autoCollect
local t186 = {}

function t185.icon() -- line: 123
	-- upvalues: ImageLabel (copy), autoCollect3 (copy), t186 (copy)
	return { ImageLabel({
		Name = "UpgradeIconImage",
		Image = autoCollect3,
		ScaleType = Enum.ScaleType.Fit,
		Size = t186.Size or UDim2.fromScale(1, 1),
		Position = t186.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = t186.AnchorPoint or Vector2.new(0.5, 0.5),
		ImageColor3 = t186.ImageColor3,
		ImageTransparency = t186.ImageTransparency,
		Rotation = t186.Rotation,
		ZIndex = t186.ZIndex or 2
	}) }
end

t185.side = sides.topRight
t185.cost = {
	currency = "coins",
	amount = 500000000000
}
t175.magnet3 = t185

local t187 = {
	main = t14,
	lootTree = t89,
	playerTree = t175
}

for v352, v353 in t187 do
	for v354, v355 in v353 do
		v355.id = v354

		local v356, v357 = (function(t188: {[any]: any}, s26: string) --[[ calcCoords ]] -- line: 2181
			-- upvalues: UpgradeServiceUtils (copy), originDependency (copy)
			local v486 = UpgradeServiceUtils.enums.coords[t188[s26].side]
			local n2 = 0

			while t188[s26].dependency ~= originDependency do
				s26 = t188[s26].dependency
				v486 += UpgradeServiceUtils.enums.coords[t188[s26].side]
				n2 += 1
			end

			return v486, n2
		end)(v353, v354)

		v355.coords = v356
		v355.layers = v357
		v355.parentTree = v352
	end
end

return t187
