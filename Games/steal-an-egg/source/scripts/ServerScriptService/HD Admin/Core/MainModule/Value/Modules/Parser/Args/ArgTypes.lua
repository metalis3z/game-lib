local hd = script:FindFirstAncestor("HD Admin")
local modules = hd.Core.MainModule.Value.Modules
local UI = modules.Parent.Controllers.UI
local InputObjects = require(UI.Config.InputObjects)

export type ArgumentDetail = {
	inputObject: InputObjects.InputConfig?,
	arg: string?,
	mustCreateAliasOf: string?,
	aliasOf: string?,
	description: string?,
	playerArg: boolean?,
	hidden: boolean?, -- qualifier-style player args hidden from the normal arg list
	runForEachPlayer: boolean?,
	parse: any?,
	key: string?, -- Used for Arg.get(name)
	display: string?, -- The actual name shown within the UI, defaults to name
	default: any?,
	products: {string}?, -- non-default values need the changer to own one of these (first gets prompted)
	min: number?,
	max: number?,
	maxItems: number?,
	step: number?,
	useSlider: boolean?, -- false forces a number box even when min+max are set
	logarithmic: boolean?, -- geometric slider scale (more resolution at the low end)
	divAmount: number?,
	maxCharacters: number?,
	hasUpdatedParse: boolean?,
}

return {}