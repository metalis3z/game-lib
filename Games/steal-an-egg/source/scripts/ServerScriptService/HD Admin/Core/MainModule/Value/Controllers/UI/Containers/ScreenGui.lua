--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local ViewportGui = require(script.Parent.ViewportGui)
local EmotePreview = require(frontend.Config.EmotePreview)
local EmotePreviewModal = require(script.Parent.EmotePreviewModal)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	parent: UsedAs<Instance>?,
	menuVisible: Fusion.Value<boolean>?,
	onClose: (() -> ())?,
}


-- COMPONENT
return function(scope: Scope, props: Props)
	EmotePreview.init(scope)
	
	return scope:New "ScreenGui" {
		Name = "HDAdmin",
		Parent = props.parent,
		DisplayOrder = 20, -- sits in front of TopbarPlus
		ScreenInsets = Enum.ScreenInsets.None,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Enabled = true,

		[Children] = {
			ViewportGui(scope, {
				menuVisible = props.menuVisible,
				onClose = props.onClose,
			}),
			EmotePreviewModal(scope, {}),
		},
	}
end
