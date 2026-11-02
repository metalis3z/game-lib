--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local RunService = game:GetService("RunService")
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Pressable = require(frontend.Components.Pressable)
local Children = Fusion.Children


-- CONFIG

local ANSWER_COLORS = {
	Color3.fromRGB(220, 30, 30),
	Color3.fromRGB(220, 93, 29),
	Color3.fromRGB(188, 161, 23),
	Color3.fromRGB(107, 186, 22),
	Color3.fromRGB(19, 179, 46),
	Color3.fromRGB(20, 197, 197),
	Color3.fromRGB(24, 120, 255),
	Color3.fromRGB(101, 24, 255),
	Color3.fromRGB(217, 24, 255),
	Color3.fromRGB(255, 24, 128),
}
local DID_NOT_VOTE_COLOR = Color3.fromRGB(175, 175, 175)
local BAR_TWEEN_TIME = 2
local BAR_STAGGER = 0.1


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type ResultRow = {
	answer: string,
	votes: number,
	percentage: number,
}
type Props = {
	mode: string, -- "voting" or "results"
	preview: boolean?,
	options: {string}?,
	results: {ResultRow}?,
	votedIndex: Fusion.Value<number?>?,
	endTime: number?,
	onVote: ((index: number) -> ())?,
	colorSeed: string?,
	layoutOrder: number?,
}


-- HELPERS
local function quartOut(progress: number): number
	local inverted = 1 - progress
	return 1 - inverted * inverted * inverted * inverted
end

local function shuffledPalette(seed: string?): {Color3}
	local palette = table.clone(ANSWER_COLORS)
	if seed == nil then
		return palette
	end
	local numericSeed = 0
	for index = 1, #seed do
		numericSeed = (numericSeed * 31 + string.byte(seed, index)) % 2147483647
	end
	local random = Random.new(numericSeed)
	for index = #palette, 2, -1 do
		local swapIndex = random:NextInteger(1, index)
		palette[index], palette[swapIndex] = palette[swapIndex], palette[index]
	end
	return palette
end

local function answerColor(palette: {Color3}, index: number): Color3
	return palette[((index - 1) % #palette) + 1]
end

local function makeVotingRow(scope: Scope, index: number, answer: string, color: Color3, votedIndex: Fusion.Value<number?>, interactive: boolean, onActivate: () -> ()): Instance
	local isChosen = scope:Computed(function(use)
		return use(votedIndex) == index
	end)
	return Pressable(scope, {
		name = "Option_" .. index,
		backgroundColor = Theme.Color.Neutral,
		layoutOrder = index,
		size = UDim2.new(1, 0, 0, 38),
		interactable = interactive,
		onActivate = onActivate,

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Theme.Color.Primary,
				Thickness = 2,
				Transparency = scope:Computed(function(use)
					return if use(isChosen) then 0 else 1
				end),
			},
			scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
			},
			scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.None,
				VerticalFlex = Enum.UIFlexAlignment.None,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
			},

			scope:New "Frame" {
				Name = "Dot",
				BackgroundColor3 = color,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(14, 14),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
				},
			},

			scope:New "TextLabel" {
				Name = "Label",
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), if use(isChosen) then Enum.FontWeight.Bold else use(Theme.FontWeight.Body))
				end),
				LayoutOrder = 2,
				Size = UDim2.new(1, -24, 1, 0),
				Text = answer,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Body,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
		},
	})
end

local function makeResultRow(scope: Scope, index: number, row: ResultRow, color: Color3, elapsed: UsedAs<number>): Instance
	local delay = (index - 1) * BAR_STAGGER
	local eased = scope:Computed(function(use)
		local progress = math.clamp((use(elapsed) - delay) / BAR_TWEEN_TIME, 0, 1)
		return quartOut(progress)
	end)
	return scope:New "Frame" {
		Name = "Result_" .. index,
		BackgroundColor3 = Theme.Color.Neutral,
		LayoutOrder = index,
		Size = UDim2.new(1, 0, 0, 44),

		[Children] = {
			scope:New "UICorner" { CornerRadius = UDim.new(0, 6) },
			scope:New "UIPadding" {
				PaddingTop = UDim.new(0, 7),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
			},

			scope:New "TextLabel" {
				Name = "Label",
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Body))
				end),
				Size = UDim2.new(1, -60, 0, 16),
				Text = row.answer,
				TextColor3 = Theme.Color.BaseContent,
				TextSize = Theme.TextSize.Label,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			scope:New "TextLabel" {
				Name = "Votes",
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				FontFace = scope:Computed(function(use)
					return Font.new(use(Theme.Font.Body), Enum.FontWeight.Bold)
				end),
				Position = UDim2.new(1, 0, 0, 0),
				Size = UDim2.fromOffset(56, 16),
				Text = scope:Computed(function(use)
					return tostring(math.round(use(eased) * row.votes))
				end),
				TextColor3 = Theme.Color.NeutralContentMain,
				TextSize = Theme.TextSize.Label,
				TextXAlignment = Enum.TextXAlignment.Right,
			},

			scope:New "Frame" {
				Name = "Track",
				AnchorPoint = Vector2.new(0, 1),
				BackgroundColor3 = Theme.Color.NeutralContent,
				Position = UDim2.new(0, 0, 1, 0),
				Size = UDim2.new(1, 0, 0, 6),

				[Children] = {
					scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },

					scope:New "Frame" {
						Name = "Fill",
						BackgroundColor3 = color,
						Size = scope:Computed(function(use)
							return UDim2.new(use(eased) * row.percentage, 0, 1, 0)
						end),

						[Children] = {
							scope:New "UICorner" { CornerRadius = UDim.new(1, 0) },
						},
					},
				},
			},
		},
	}
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local rows: {any} = {
		scope:New "UIListLayout" {
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalFlex = Enum.UIFlexAlignment.None,
			VerticalFlex = Enum.UIFlexAlignment.None,
			Padding = UDim.new(0, 6),
		},
	}

	local palette = shuffledPalette(props.colorSeed)

	if props.mode == "voting" then
		local options = props.options or {}
		local votedIndex = props.votedIndex or scope:Value(nil :: number?)
		local endTime = props.endTime or (os.clock() + 20)
		local interactive = props.preview ~= true
		for index, answer in options do
			table.insert(rows, makeVotingRow(scope, index, answer, answerColor(palette, index), votedIndex, interactive, function()
				if os.clock() >= endTime then
					return
				end
				if props.onVote then
					props.onVote(index)
				end
			end))
		end

		local secondsLeft = scope:Value(math.max(math.ceil(endTime - os.clock()), 0))
		local countdownConnection = RunService.Heartbeat:Connect(function()
			secondsLeft:set(math.max(math.ceil(endTime - os.clock()), 0))
		end)
		table.insert(scope :: any, function()
			countdownConnection:Disconnect()
		end)
		table.insert(rows, scope:New "TextLabel" {
			Name = "Countdown",
			BackgroundTransparency = 1,
			FontFace = scope:Computed(function(use)
				return Font.new(use(Theme.Font.Body), Enum.FontWeight.Medium)
			end),
			LayoutOrder = 100,
			Size = UDim2.new(1, 0, 0, 16),
			Text = scope:Computed(function(use)
				local seconds = use(secondsLeft)
				return if seconds > 0 then `Ends in {seconds}s` else "Vote ended"
			end),
			TextColor3 = Theme.Color.NeutralContentDark,
			TextSize = Theme.TextSize.Small,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	else
		local results = props.results or {}
		-- One clock drives every bar, and it stops once the last stagger finishes
		local elapsed = scope:Value(0)
		local startClock = os.clock()
		local endElapsed = (#results) * BAR_STAGGER + BAR_TWEEN_TIME + 0.1
		local barConnection: RBXScriptConnection? = nil
		barConnection = RunService.Heartbeat:Connect(function()
			local now = os.clock() - startClock
			elapsed:set(now)
			if now > endElapsed and barConnection then
				barConnection:Disconnect()
				barConnection = nil
			end
		end)
		table.insert(scope :: any, function()
			if barConnection then
				barConnection:Disconnect()
				barConnection = nil
			end
		end)
		for index, row in results do
			local color = if index == #results then DID_NOT_VOTE_COLOR else answerColor(palette, index)
			table.insert(rows, makeResultRow(scope, index, row, color, elapsed))
		end
	end

	return scope:New "Frame" {
		Name = "VoteBody",
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder or 5,
		Size = UDim2.new(1, 0, 0, 0),

		[Children] = rows,
	}
end
