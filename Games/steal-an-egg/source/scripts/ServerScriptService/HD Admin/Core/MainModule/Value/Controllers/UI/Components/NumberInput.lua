--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)
local Children = Fusion.Children
local InputRow = require(script.Parent.InputRow)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	title: string?,
	default: any?,
	min: number?,
	max: number?,
	step: number?,
	allowEmpty: boolean?, -- empty field commits nil instead of snapping back
	placeholderText: string?, -- shown while the field is empty
	value: Fusion.Value<any>?,
	labelSize: UDim2?,
	labelTextSize: number?,
}


-- LOCAL FUNCTIONS
local function clampAndStep(n: number, minV: number?, maxV: number?, step: number?): number
	if step and step > 0 then
		local roundToNearest = require(modules.MathUtil.roundToNearest)
		n = roundToNearest(n, step)
	end
	if minV then n = math.max(n, minV) end
	if maxV then n = math.min(n, maxV) end
	return n
end


-- COMPONENT
return function(scope: Scope, props: Props)
	local title: string = props.title or ""
	local min: number? = props.min
	local max: number? = props.max
	local step: number? = props.step
	local allowDecimals: boolean = not step or step % 1 ~= 0

	local allowEmpty: boolean = props.allowEmpty == true

	local rawInitial = if props.value then Fusion.peek(props.value) else props.default
	local initialNum: number = tonumber(rawInitial) or 0
	initialNum = clampAndStep(initialNum, min, max, step)

	local isFocused: Fusion.Value<boolean> = scope:Value(false)
	local numValue: Fusion.Value<number> = scope:Value(initialNum)
	-- The value prop is a live Value so it's never nil itself, peek inside it
	local hasInitial = if allowEmpty then rawInitial ~= nil else (props.value ~= nil or props.default ~= nil)
	local textDisplay: Fusion.Value<string> = scope:Value(if hasInitial then tostring(initialNum) else "")
	local textBox: TextBox? = nil

	if props.value ~= nil then
		scope:Observer(props.value :: any):onChange(function()
			if Fusion.peek(isFocused) == true then return end
			local ext = tonumber(Fusion.peek(props.value :: any))
			if ext == nil then return end
			ext = clampAndStep(ext, min, max, step)
			if ext == Fusion.peek(numValue) then return end
			numValue:set(ext)
			textDisplay:set(tostring(ext))
		end)
	end

	local function filterInput(raw: string): string
		local isNeg = raw:sub(1, 1) == "-"
		local rest = if isNeg then raw:sub(2) else raw
		rest = rest:gsub("[^0-9%.]", "")
		if not allowDecimals then
			rest = rest:gsub("%.", "")
		else
			local dotIndex = rest:find("%.", 1, true)
			if dotIndex then
				rest = rest:sub(1, dotIndex) .. rest:sub(dotIndex + 1):gsub("%.", "")
			end
		end
		return if isNeg then "-" .. rest else rest
	end

	local function commit(raw: string)
		if allowEmpty and raw == "" then
			if props.value then props.value:set(nil) end
			textDisplay:set("")
			return
		end
		local number = tonumber(raw)
		if not number then
			local revertToEmpty = allowEmpty and props.value ~= nil and Fusion.peek(props.value :: any) == nil
			textDisplay:set(if revertToEmpty then "" else tostring(Fusion.peek(numValue)))
			return
		end
		number = clampAndStep(number, min, max, step)
		numValue:set(number)
		textDisplay:set(tostring(number))
		if props.value then props.value:set(number) end
	end

	textBox = scope:New "TextBox" {
		Name = "TextInput",
		AutoLocalize = false,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		FontFace = scope:Computed(function(use)
			return Font.new(use(Theme.Font.Body), use(Theme.FontWeight.Bold))
		end),
		PlaceholderColor3 = Theme.Color.NeutralContentDark,
		PlaceholderText = props.placeholderText or textDisplay,
		Size = UDim2.fromScale(1, 0),
		Text = textDisplay,
		TextColor3 = Theme.Color.BaseContent,
		TextSize = Theme.TextSize.Subtitle,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,

		[Fusion.OnEvent "Focused"] = function()
			isFocused:set(true)
		end,
		[Fusion.OnEvent "FocusLost"] = function()
			isFocused:set(false)
			commit(Fusion.peek(textDisplay))
		end,
		[Fusion.OnChange "Text"] = function(new: string)
			local filtered = filterInput(new)
			if filtered ~= new then
				local tb = textBox
				if tb then
					tb.Text = filtered
				end
			end
			textDisplay:set(filtered)
		end,
	} :: TextBox

	return InputRow(scope, {
		title = title,
		name = "NumberInput",
		labelSize = props.labelSize,
		labelTextSize = props.labelTextSize,
		clipsDescendants = true,
		strokeFocused = isFocused,

		[Children] = { textBox },
	})
end
