--!strict
-- LOCAL
local InputObjects = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local components = modules.Parent.Controllers.UI.Components
local Fusion = require(packages.Fusion)


-- OBJECTS
InputObjects.items = {
	
	["ItemSelector"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local ItemSelector = require(components.ItemSelector)
		return ItemSelector(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			canAnyUserBeAddedToPicker = inputConfig.canAnyUserBeAddedToPicker,
			displayServerPlayersInPicker = inputConfig.displayServerPlayersInPicker,
			displayQualifiersInPicker = inputConfig.displayQualifiersInPicker,
			pickerGetter = inputConfig.pickerGetter,
			presetGetter = (inputConfig :: any).presetGetter,
			itemsGetter = (inputConfig :: any).itemsGetter,
			maxItems = inputConfig.maxItems,
			limitPickerToOneItem = inputConfig.limitPickerToOneItem,
			sharedCustomUsers = (inputConfig :: any).sharedCustomUsers,
			onOpen = (inputConfig :: any).onOpen,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
			itemToEntry = (inputConfig :: any).itemToEntry,
			entryToKey = (inputConfig :: any).entryToKey,
			hydrateEntry = (inputConfig :: any).hydrateEntry,
			addFlow = (inputConfig :: any).addFlow,
			autoOpen = (inputConfig :: any).autoOpen,
		})
	end,

	["TextInput"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local TextInput = require(components.TextInput)
		return TextInput(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			validationStatus = (inputConfig :: any).validationStatus,
			filterText = inputConfig.filterText,
			mustBeStringSafe = (inputConfig :: any).mustBeStringSafe,
			preventWhitespaces = inputConfig.preventWhitespaces,
			firstArgValue = (inputConfig :: any).firstArgValue,
			verifier = (inputConfig :: any).verifier,
			limitTextLength = inputConfig.limitTextLength,
			clearTextOnFocus = inputConfig.clearTextOnFocus,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

	["NumberInput"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		-- Explicit useSlider wins either way (false forces plain input even with min+max set)
		local wantsSlider = if inputConfig.useSlider ~= nil
			then inputConfig.useSlider == true
			else (inputConfig.min ~= nil and inputConfig.max ~= nil)
		if wantsSlider then
			local NumberSlider = require(components.NumberSlider)
			return NumberSlider(scope, {
				title = inputConfig.title,
				default = inputConfig.default,
				value = inputConfig.value,
				min = inputConfig.min,
				max = inputConfig.max,
				step = inputConfig.step or 0.1,
				logarithmic = inputConfig.logarithmic,
				labelSize = inputConfig.labelSize,
				labelTextSize = inputConfig.labelTextSize,
			})
		end
		local NumberInput = require(components.NumberInput)
		return NumberInput(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			min = inputConfig.min,
			max = inputConfig.max,
			step = inputConfig.step,
			allowEmpty = inputConfig.allowEmpty,
			placeholderText = inputConfig.placeholderText,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

	["DurationSelector"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local DurationSelector = require(components.DurationSelector)
		return DurationSelector(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

	["ColorPicker"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local ColorPicker = require(components.ColorPicker)
		return ColorPicker(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
			slidersHeight = inputConfig.slidersHeight,
		})
	end,

	["Toggle"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local Toggle = require(components.Toggle)
		return Toggle(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

	["Options"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
			local Options = require(components.Options)
		return Options(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			optionsArray = inputConfig.optionsArray,
			optionsDisplayArray = (inputConfig :: any).optionsDisplayArray,
			optionCommands = (inputConfig :: any).optionCommands,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

	["ActionButton"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local ActionButton = require(components.ActionButton)
		return ActionButton(scope, {
			title = inputConfig.title,
			buttonText = (inputConfig :: any).buttonText,
			buttonIcon = (inputConfig :: any).buttonIcon,
			onActivate = (inputConfig :: any).onActivate,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

	["InputFields"] = function(scope: Fusion.Scope, inputConfig: InputConfig)
		local InputFields = require(components.InputFields)
		return InputFields(scope, {
			title = inputConfig.title,
			default = inputConfig.default,
			value = inputConfig.value,
			validationStatus = (inputConfig :: any).validationStatus,
			maxItems = inputConfig.maxItems,
			filterText = inputConfig.filterText,
			firstArgValue = (inputConfig :: any).firstArgValue,
			labelSize = inputConfig.labelSize,
			labelTextSize = inputConfig.labelTextSize,
		})
	end,

}


-- TYPES
export type InputType = keyof<typeof(InputObjects.items)>
export type InputConfig = {
	inputType: InputType?,
	title: string?,
	default: any?, -- also used as type reference for output
	firstArgValue: Fusion.Value<any>?, -- forwarded to TextInput for targetUserId derivation
	validationStatus: Fusion.Value<boolean?>?, -- text-check status reported back up to RunPage's run gate
	filterText: boolean?, -- run through VerifyUtil.filterTextAsync on focus lost
	maxItems: number?, -- max selected items (ItemSelector) or max fields (InputFields)
	useSlider: boolean?, -- force slider even without min/max
	allowEmpty: boolean?, -- NumberInput commits nil when the field is empty
	placeholderText: string?, -- NumberInput placeholder while the field is empty
	min: number?,
	max: number?,
	step: number?,
	logarithmic: boolean?, -- geometric slider scale (more resolution at the low end)
	pickerGetter: ((...any) -> ({any}))?, -- returns items for ItemSelector picker
	presetGetter: ((...any) -> ({any}))?, -- returns preset PickerItems (injected as "preset" category)
	displayServerPlayersInPicker: boolean?, -- show live server players in picker (ignored if pickerGetter set)
	displayQualifiersInPicker: boolean?, -- show qualifiers like All/Others/Me (ignored if pickerGetter set)
	canAnyUserBeAddedToPicker: boolean?, -- allow adding any Roblox user by id/name
	limitPickerToOneItem: boolean?,
	itemToEntry: ((item: any) -> any)?,
	entryToKey: ((entry: any) -> string?)?,
	hydrateEntry: ((entry: any) -> any?)?,
	itemsGetter: ((scope: any) -> any)?,
	preventWhitespaces: boolean?,
	optionsArray: {string}?,
	optionsDisplayArray: {string}?,
	optionCommands: {[string]: string}?,
	value: Fusion.Value<any>?,
	labelSize: UDim2?,
	labelTextSize: number?,
	limitTextLength: number?,
	clearTextOnFocus: boolean?,
	slidersHeight: number?,
	buttonText: Fusion.UsedAs<string>?,
	buttonIcon: Fusion.UsedAs<string>?,
	onActivate: (() -> ())?,
}


-- RETURN
return InputObjects