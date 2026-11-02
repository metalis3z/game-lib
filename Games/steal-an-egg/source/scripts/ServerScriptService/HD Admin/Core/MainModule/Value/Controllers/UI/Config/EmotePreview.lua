--!strict
-- LOCAL 
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)


-- TYPES
export type EmotePreviewState = { emoteId: number, emoteName: string?, animationId: number? }


-- STATE
-- This lives in its own high-DisplayOrder ScreenGui so it sits in front of notices
local EmotePreview = {}
local stateValue: Fusion.Value<EmotePreviewState?>? = nil


-- FUNCTIONS
function EmotePreview.init(scope: Fusion.Scope)
	stateValue = scope:Value(nil :: EmotePreviewState?)
end

function EmotePreview.getState(): Fusion.Value<EmotePreviewState?>?
	return stateValue
end

function EmotePreview.open(emoteId: number, emoteName: string?, animationId: number?)
	if stateValue then
		stateValue:set({ emoteId = emoteId, emoteName = emoteName, animationId = animationId })
	end
end

function EmotePreview.close()
	if stateValue then
		stateValue:set(nil)
	end
end


return EmotePreview
