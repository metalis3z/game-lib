--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local ProfileBody = require(frontend.Components.ProfileBody)
local Children = Fusion.Children


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	userId: UsedAs<number>?,
	giverIdentity: ProfileBody.GiverIdentity?, -- set instead of userId for giver profiles; ProfileBody goes read-only
}


-- COMPONENT
return function(scope: Scope, props: Props)
	-- ProfileBody's floating AddRolePopup lands here. Giver mode has no popup but
	-- the slot stays unconditional so the page structure stays consistent
	local popupOverlay = scope:New "Frame" {
		Name = "PopupOverlay",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 100,
	}

	return scope:New "Frame" {
		Name = "ProfilePage",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		[Children] = {
			ProfileBody(scope, {
				userId = props.userId,
				giverIdentity = props.giverIdentity,
				popupParent = popupOverlay,
			}),
			popupOverlay,
		},
	}
end
