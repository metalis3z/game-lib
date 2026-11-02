-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AdminMenu, time of decompilation: Sun May  3 10:12:21 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local TextLabel = require(ReplicatedStorage.Source.Core.UI.Primitives.TextLabel)
local AdminServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminServiceClient)
local AdminUtils = require(ReplicatedStorage.Source.Features.Admin.AdminUtils)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local StylizedButton = require(ReplicatedStorage.Source.Features.App.Components.StylizedButton)
local StylizedFrame = require(ReplicatedStorage.Source.Features.App.Components.StylizedFrame)
local ScrollingFrame = require(ReplicatedStorage.Source.Core.UI.Primitives.ScrollingFrame)
local UICorner = require(ReplicatedStorage.Source.Core.UI.Primitives.UICorner)
local UIGridLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIGridLayout)
local UIListLayout = require(ReplicatedStorage.Source.Core.UI.Primitives.UIListLayout)
local UIPadding = require(ReplicatedStorage.Source.Core.UI.Primitives.UIPadding)

local function createInput(s1: string, s2: string?, uDim2: UDim2?) -- line: 54
	-- upvalues: Vide (copy), UIPadding (copy), UICorner (copy)
	return (Vide.create("TextBox")({
		Size = uDim2 or UDim2.fromOffset(220, 42),
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(28, 33, 45),
		BorderSizePixel = 0,
		Text = s2 or "",
		PlaceholderText = s1,
		PlaceholderColor3 = Color3.fromRGB(190, 205, 255),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 22,
		TextScaled = false,
		Font = Enum.Font.BuilderSansExtraBold,
		ClearTextOnFocus = false,
		TextEditable = true,
		MultiLine = false,
		TextStrokeTransparency = 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3,
		ClipsDescendants = true,
		UIPadding({
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10)
		}),
		UICorner({
			CornerRadius = UDim.new(0, 8)
		})
	}))
end
local function SectionCard(s3: string, n1: number, n2: number, p1) -- line: 88
	-- upvalues: StylizedFrame (copy), TextLabel (copy), Frame (copy)
	local t1 = {}

	if type(p1) == "table" then
		for _, v40 in p1 do
			table.insert(t1, v40)
		end
	elseif p1 ~= nil then
		table.insert(t1, p1)
	end

	return StylizedFrame({
		Theme = "DarkBlue",
		Size = UDim2.new(1, -8, 0, n2),
		LayoutOrder = n1,
		TextLabel({
			TextSize = 22,
			ZIndex = 3,
			Text = s3,
			Size = UDim2.new(1, -20, 0, 28),
			Position = UDim2.new(0.5, 0, 0, 10),
			AnchorPoint = Vector2.new(0.5, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 3
			},
			DropShadow = {}
		}),
		Frame({
			Size = UDim2.new(1, -20, 1, -48),
			Position = UDim2.new(0.5, 0, 1, -10),
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundTransparency = 1,
			t1
		})
	})
end
local function ResultBanner(p2, p3, n3: number) -- line: 125
	-- upvalues: StylizedFrame (copy), TextLabel (copy)
	return StylizedFrame({
		Theme = "Grey",
		Size = UDim2.new(1, -8, 0, 78),
		LayoutOrder = n3,
		TextLabel({
			Text = "RESULT",
			TextSize = 20,
			ZIndex = 3,
			Size = UDim2.new(1, -20, 0, 24),
			Position = UDim2.new(0.5, 0, 0, 10),
			AnchorPoint = Vector2.new(0.5, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 3
			}
		}),
		TextLabel({
			TextSize = 18,
			TextWrapped = true,
			ZIndex = 3,
			Text = p2,
			TextColor3 = p3,
			Size = UDim2.new(1, -20, 0, 28),
			Position = UDim2.new(0.5, 0, 1, -10),
			AnchorPoint = Vector2.new(0.5, 1),
			TextXAlignment = Enum.TextXAlignment.Left,
			Stroke = {
				Thickness = 2
			}
		})
	})
end
local function buildContent() -- line: 157
	-- upvalues: Vide (copy), AdminUtils (copy), createInput (copy), AdminServiceClient (copy), StylizedButton (copy), ScrollingFrame (copy), UIListLayout (copy), ResultBanner (copy), SectionCard (copy), TextLabel (copy), Frame (copy), UIGridLayout (copy)
	local v44 = Vide.source("Server-wide tools live here.")
	local v45 = Vide.source(Color3.fromRGB(255, 255, 255))
	local v46 = Vide.source(AdminUtils.getServerLuckMultipliers()[1] or 2)
	local v47 = createInput("Duration in minutes", "15", UDim2.fromOffset(220, 42))
	local v48 = createInput("Multiplier", "2", UDim2.fromOffset(180, 42))
	local v49 = createInput("Duration in minutes", "15", UDim2.fromOffset(220, 42))
	local v50 = createInput("Countdown minutes", "10", UDim2.fromOffset(220, 42))
	local v51 = createInput("Title", "GLOBAL UPDATE", UDim2.fromOffset(300, 42))
	local v52 = createInput("Message", "An update is on the way.", UDim2.fromOffset(420, 42))
	local v53 = createInput("Announcement message", "Welcome to the server!", UDim2.fromOffset(420, 42))
	local v54_givePlayer = createInput("Player name", "", UDim2.fromOffset(180, 42))
	local v55_giveAmount = createInput("Amount", "1000", UDim2.fromOffset(120, 42))
	local v56_setPlayer = createInput("Player name", "", UDim2.fromOffset(180, 42))
	local v57_setAmount = createInput("Amount", "10000", UDim2.fromOffset(120, 42))
	local v58_globalAmount = createInput("Amount for all players", "10000", UDim2.fromOffset(180, 42))
	local v59_giveSlimePlayer = createInput("Player name", "", UDim2.fromOffset(180, 42))
	local v60_giveSlimeId = createInput("Slime ID (e.g. goopy)", "goopy", UDim2.fromOffset(140, 42))
	local v61_giveSlimeLevel = createInput("Level", "1", UDim2.fromOffset(80, 42))
	local v62_globalSlimeId = createInput("Slime ID (e.g. goopy)", "goopy", UDim2.fromOffset(140, 42))
	local v63_globalSlimeLevel = createInput("Level", "1", UDim2.fromOffset(80, 42))
	local t2 = {}

	for v54, v55 in AdminUtils.getServerLuckMultipliers() do
		table.insert(t2, StylizedButton({
			Theme = function() --[[ Theme ]] -- line: 178
				-- upvalues: v46 (copy), v55 (copy)
				if v46() == v55 then
					return "Green"
				end

				return "Grey"
			end,
			Text = `x{ v55 }`,
			LayoutOrder = v54,
			Size = UDim2.fromOffset(86, 48),
			Activated = function() --[[ Activated ]] -- line: 184
				-- upvalues: v46 (copy), v55 (copy)
				v46(v55)
			end
		}))
	end

	return ScrollingFrame({
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(),
		ScrollBarImageTransparency = 1,
		ScrollBarThickness = 0,
		UIListLayout({
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8)
		}),
		ResultBanner(v44, v45, 1),
		SectionCard("Server Luck", 2, 250, {
			TextLabel({
				Text = "Select a multiplier and duration to push to the whole server.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.new(1, 0, 0, 54),
				Position = UDim2.fromOffset(0, 28),
				BackgroundTransparency = 1,
				UIGridLayout({
					CellSize = UDim2.fromOffset(86, 48),
					CellPadding = UDim2.fromOffset(6, 6),
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					SortOrder = Enum.SortOrder.LayoutOrder
				}),
				t2
			}),
			Frame({
				Size = UDim2.fromOffset(220, 42),
				Position = UDim2.fromOffset(400, 120),
				BackgroundTransparency = 1,
				v47
			}),
			StylizedButton({
				Theme = "Green",
				Text = "Set Server Luck",
				Size = UDim2.fromOffset(170, 52),
				Position = UDim2.fromOffset(0, 150),
				Activated = function() --[[ Activated ]] -- line: 242
					-- upvalues: v47 (copy), v46 (copy), AdminServiceClient (copy), v44 (copy), v45 (copy)
					local Text = v47.Text
					local v61 = string.match(Text, "^%s*(.-)%s*$") or ""
					local v62

					if v61 == "" then
						v62 = nil
					else
						local num = tonumber(v61)

						v62 = if num ~= nil then math.floor(num) else nil
					end

					local t3 = {
						kind = "setServerLuck",
						multiplier = v46(),
						durationSeconds = if not v62 then nil else v62 * 60
					}
					local v65, v66 = AdminServiceClient:executeMiscAction(t3)
					local v67 = v44

					v45(if not v65 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v67(v66 or (not v65 and "Something went wrong." or "Done."))
				end
			}),
			StylizedButton({
				Theme = "Red",
				Text = "Clear Luck",
				Size = UDim2.fromOffset(120, 52),
				Position = UDim2.fromOffset(182, 150),
				Activated = function() --[[ Activated ]] -- line: 257
					-- upvalues: AdminServiceClient (copy), v44 (copy), v45 (copy)
					local t4 = {
						kind = "clearServerLuck"
					}
					local v69, v70 = AdminServiceClient:executeMiscAction(t4)
					local v71 = v44

					v45(if not v69 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v71(v70 or (not v69 and "Something went wrong." or "Done."))
				end
			})
		}),
		SectionCard("Admin Luck", 3, 205, {
			TextLabel({
				Text = "Set a real global luck multiplier for every server.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(180, 42),
				Position = UDim2.fromOffset(0, 42),
				BackgroundTransparency = 1,
				v48
			}),
			Frame({
				Size = UDim2.fromOffset(220, 42),
				Position = UDim2.fromOffset(194, 42),
				BackgroundTransparency = 1,
				v49
			}),
			StylizedButton({
				Theme = "Green",
				Text = "Set Admin Luck",
				Size = UDim2.fromOffset(170, 52),
				Position = UDim2.fromOffset(0, 104),
				Activated = function() --[[ Activated ]] -- line: 293
					-- upvalues: v48 (copy), v49 (copy), AdminServiceClient (copy), v44 (copy), v45 (copy)
					local Text = v48.Text
					local v73 = string.match(Text, "^%s*(.-)%s*$") or ""
					local v74 = if v73 ~= "" then tonumber(v73) else nil
					local Text2 = v49.Text
					local v76 = string.match(Text2, "^%s*(.-)%s*$") or ""
					local v77

					if v76 == "" then
						v77 = nil
					else
						local num = tonumber(v76)

						v77 = if num ~= nil then math.floor(num) else nil
					end

					local t5 = {
						kind = "setAdminLuck",
						multiplier = v74,
						durationSeconds = if not v77 then nil else v77 * 60
					}
					local v80, v81 = AdminServiceClient:executeMiscAction(t5)
					local v82 = v44

					v45(if not v80 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v82(v81 or (not v80 and "Something went wrong." or "Done."))
				end
			}),
			StylizedButton({
				Theme = "Red",
				Text = "Clear Admin Luck",
				Size = UDim2.fromOffset(170, 52),
				Position = UDim2.fromOffset(182, 104),
				Activated = function() --[[ Activated ]] -- line: 309
					-- upvalues: AdminServiceClient (copy), v44 (copy), v45 (copy)
					local t6 = {
						kind = "clearAdminLuck"
					}
					local v84, v85 = AdminServiceClient:executeMiscAction(t6)
					local v86 = v44

					v45(if not v84 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v86(v85 or (not v84 and "Something went wrong." or "Done."))
				end
			})
		}),
		SectionCard("Global Update Countdown", 4, 258, {
			Frame({
				Size = UDim2.fromOffset(300, 42),
				Position = UDim2.fromOffset(0, 0),
				BackgroundTransparency = 1,
				v51
			}),
			Frame({
				Size = UDim2.fromOffset(420, 42),
				Position = UDim2.fromOffset(0, 52),
				BackgroundTransparency = 1,
				v52
			}),
			Frame({
				Size = UDim2.fromOffset(220, 42),
				Position = UDim2.fromOffset(0, 104),
				BackgroundTransparency = 1,
				v50
			}),
			StylizedButton({
				Theme = "Blue",
				Text = "Start Countdown",
				Size = UDim2.fromOffset(170, 52),
				Position = UDim2.fromOffset(0, 164),
				Activated = function() --[[ Activated ]] -- line: 344
					-- upvalues: v50 (copy), v51 (copy), v52 (copy), AdminServiceClient (copy), v44 (copy), v45 (copy)
					local Text = v50.Text
					local v88 = string.match(Text, "^%s*(.-)%s*$") or ""
					local v89

					if v88 == "" then
						v89 = nil
					else
						local num = tonumber(v88)

						v89 = if num ~= nil then math.floor(num) else nil
					end

					local t7 = {
						kind = "startGlobalUpdateCountdown",
						title = v51.Text,
						message = v52.Text,
						durationSeconds = if not v89 then nil else v89 * 60
					}
					local v92, v93 = AdminServiceClient:executeMiscAction(t7)
					local v94 = v44

					v45(if not v92 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v94(v93 or (not v92 and "Something went wrong." or "Done."))
				end
			}),
			StylizedButton({
				Theme = "Red",
				Text = "Cancel Countdown",
				Size = UDim2.fromOffset(170, 52),
				Position = UDim2.fromOffset(182, 164),
				Activated = function() --[[ Activated ]] -- line: 360
					-- upvalues: AdminServiceClient (copy), v44 (copy), v45 (copy)
					local t8 = {
						kind = "cancelGlobalUpdateCountdown"
					}
					local v96, v97 = AdminServiceClient:executeMiscAction(t8)
					local v98 = v44

					v45(if not v96 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v98(v97 or (not v96 and "Something went wrong." or "Done."))
				end
			})
		}),
		SectionCard("Global Announcement", 5, 160, {
			TextLabel({
				Text = "Send a message to all players in the server.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(420, 42),
				Position = UDim2.fromOffset(0, 32),
				BackgroundTransparency = 1,
				v53
			}),
			StylizedButton({
				Theme = "Blue",
				Text = "Send Announcement",
				Size = UDim2.fromOffset(180, 52),
				Position = UDim2.fromOffset(0, 84),
				Activated = function()
					local Text = v53.Text
					local msg = string.match(Text, "^%s*(.-)%s*$") or ""
					if msg == "" then
						v44("Please enter a message.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					local t9 = {
						kind = "sendGlobalAnnouncement",
						message = msg
					}
					local v100, v101 = AdminServiceClient:executeMiscAction(t9)
					v45(if not v100 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v44(v101 or (not v100 and "Something went wrong." or "Announcement sent!"))
				end
			})
		}),
		SectionCard("Give Coins", 6, 160, {
			TextLabel({
				Text = "Give coins to a specific player.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(180, 42),
				Position = UDim2.fromOffset(0, 32),
				BackgroundTransparency = 1,
				v54_givePlayer
			}),
			Frame({
				Size = UDim2.fromOffset(120, 42),
				Position = UDim2.fromOffset(194, 32),
				BackgroundTransparency = 1,
				v55_giveAmount
			}),
			StylizedButton({
				Theme = "Green",
				Text = "Give Coins",
				Size = UDim2.fromOffset(150, 52),
				Position = UDim2.fromOffset(0, 84),
				Activated = function()
					local playerName = string.match(v54_givePlayer.Text, "^%s*(.-)%s*$") or ""
					local amount = tonumber(v55_giveAmount.Text)
					if playerName == "" then
						v44("Please enter a player name.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					if not amount or amount <= 0 then
						v44("Please enter a valid amount.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					local t10 = {
						kind = "giveCoins",
						targetPlayer = playerName,
						amount = amount
					}
					local ok, msg = AdminServiceClient:executeMiscAction(t10)
					v45(if not ok then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v44(msg or (not ok and "Something went wrong." or "Coins given!"))
				end
			})
		}),
		SectionCard("Set Coins", 7, 160, {
			TextLabel({
				Text = "Set a specific player's coins to a value.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(180, 42),
				Position = UDim2.fromOffset(0, 32),
				BackgroundTransparency = 1,
				v56_setPlayer
			}),
			Frame({
				Size = UDim2.fromOffset(120, 42),
				Position = UDim2.fromOffset(194, 32),
				BackgroundTransparency = 1,
				v57_setAmount
			}),
			StylizedButton({
				Theme = "Blue",
				Text = "Set Coins",
				Size = UDim2.fromOffset(150, 52),
				Position = UDim2.fromOffset(0, 84),
				Activated = function()
					local playerName = string.match(v56_setPlayer.Text, "^%s*(.-)%s*$") or ""
					local amount = tonumber(v57_setAmount.Text)
					if playerName == "" then
						v44("Please enter a player name.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					if not amount or amount < 0 then
						v44("Please enter a valid amount.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					local t11 = {
						kind = "setCoins",
						targetPlayer = playerName,
						amount = amount
					}
					local ok, msg = AdminServiceClient:executeMiscAction(t11)
					v45(if not ok then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v44(msg or (not ok and "Something went wrong." or "Coins set!"))
				end
			})
		}),
		SectionCard("Global Set Coins", 8, 130, {
			TextLabel({
				Text = "Set all players' coins to a specific value.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(180, 42),
				Position = UDim2.fromOffset(0, 32),
				BackgroundTransparency = 1,
				v58_globalAmount
			}),
			StylizedButton({
				Theme = "Red",
				Text = "Set All Coins",
				Size = UDim2.fromOffset(170, 52),
				Position = UDim2.fromOffset(0, 84),
				Activated = function()
					local amount = tonumber(v58_globalAmount.Text)
					if not amount or amount < 0 then
						v44("Please enter a valid amount.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					local t12 = {
						kind = "globalSetCoins",
						amount = amount
					}
					local ok, msg = AdminServiceClient:executeMiscAction(t12)
					v45(if not ok then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v44(msg or (not ok and "Something went wrong." or "All coins set!"))
				end
			})
		}),
		SectionCard("Give Slime", 9, 160, {
			TextLabel({
				Text = "Give a slime to a specific player.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(180, 42),
				Position = UDim2.fromOffset(0, 32),
				BackgroundTransparency = 1,
				v59_giveSlimePlayer
			}),
			Frame({
				Size = UDim2.fromOffset(140, 42),
				Position = UDim2.fromOffset(194, 32),
				BackgroundTransparency = 1,
				v60_giveSlimeId
			}),
			Frame({
				Size = UDim2.fromOffset(80, 42),
				Position = UDim2.fromOffset(344, 32),
				BackgroundTransparency = 1,
				v61_giveSlimeLevel
			}),
			StylizedButton({
				Theme = "Green",
				Text = "Give Slime",
				Size = UDim2.fromOffset(150, 52),
				Position = UDim2.fromOffset(0, 84),
				Activated = function()
					local playerName = string.match(v59_giveSlimePlayer.Text, "^%s*(.-)%s*$") or ""
					local slimeId = string.match(v60_giveSlimeId.Text, "^%s*(.-)%s*$") or ""
					local level = tonumber(v61_giveSlimeLevel.Text) or 1
					if playerName == "" then
						v44("Please enter a player name.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					if slimeId == "" then
						v44("Please enter a slime ID.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					local t13 = {
						kind = "giveSlime",
						targetPlayer = playerName,
						slimeId = slimeId,
						level = level
					}
					local ok, msg = AdminServiceClient:executeMiscAction(t13)
					v45(if not ok then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v44(msg or (not ok and "Something went wrong." or "Slime given!"))
				end
			})
		}),
		SectionCard("Global Give Slime", 10, 160, {
			TextLabel({
				Text = "Give a slime to all players in the server.",
				TextSize = 16,
				Size = UDim2.new(1, 0, 0, 22),
				TextXAlignment = Enum.TextXAlignment.Left,
				Stroke = {
					Thickness = 2
				}
			}),
			Frame({
				Size = UDim2.fromOffset(140, 42),
				Position = UDim2.fromOffset(0, 32),
				BackgroundTransparency = 1,
				v62_globalSlimeId
			}),
			Frame({
				Size = UDim2.fromOffset(80, 42),
				Position = UDim2.fromOffset(150, 32),
				BackgroundTransparency = 1,
				v63_globalSlimeLevel
			}),
			StylizedButton({
				Theme = "Red",
				Text = "Give to All",
				Size = UDim2.fromOffset(150, 52),
				Position = UDim2.fromOffset(0, 84),
				Activated = function()
					local slimeId = string.match(v62_globalSlimeId.Text, "^%s*(.-)%s*$") or ""
					local level = tonumber(v63_globalSlimeLevel.Text) or 1
					if slimeId == "" then
						v44("Please enter a slime ID.")
						v45(Color3.fromRGB(255, 120, 120))
						return
					end
					local t14 = {
						kind = "globalGiveSlime",
						slimeId = slimeId,
						level = level
					}
					local ok, msg = AdminServiceClient:executeMiscAction(t14)
					v45(if not ok then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(110, 255, 120))
					v44(msg or (not ok and "Something went wrong." or "Slime given to all!"))
				end
			})
		})
	})
end

return {
	menuId = "Admin",
	alwaysMounted = false,
	Component = function() --[[ Component ]] -- line: 370
		-- upvalues: AdminServiceClient (copy), Menu (copy), buildContent (copy)
		if not AdminServiceClient:isAdmin() then
			return nil
		end

		return Menu.Component({
			menuId = "Admin",
			Title = "Admin",
			buildContent()
		})
	end
}
