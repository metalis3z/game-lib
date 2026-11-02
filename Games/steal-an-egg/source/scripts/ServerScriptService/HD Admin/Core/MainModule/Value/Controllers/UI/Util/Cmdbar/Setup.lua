--!strict

--[[

	The command bar is only ever built for users who can actually access it. Its
	overlay, suggestions and keybinds are constructed lazily the first time
	the viewer is granted the "CommandBar" page permission, so the many players who
	can't open it never pay to load or build any of it

--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local CmdbarState = require(frontend.Config.CmdbarState)
local Permissions = require(frontend.Util.Permissions)
local InputController = require(modules.Parent.Controllers.InputController)


-- TYPES
type Scope = Fusion.Scope


-- FUNCTIONS
return function(scope: Scope, host: Instance)
	local canOpenCmdbar = Permissions.canViewPage(scope, "CommandBar")
	local built = false
	local function onAccessChanged()
		local canOpen = Fusion.peek(canOpenCmdbar)
		CmdbarState.canOpen:set(canOpen)
		if not canOpen then
			-- Force the bar closed if access is revoked while it is open
			CmdbarState.visible:set(false)
			return
		end
		if built then
			return
		end
		built = true
		local Cmdbar = require(frontend.Containers.Cmdbar)
		local bar = Cmdbar(scope, { visible = CmdbarState.visible })
		bar.Parent = host

		-- Sits under the panels and notices so their buttons still take presses while
		-- the bar is open. Anything that misses them lands here and closes it
		local backdrop = scope:New "TextButton" {
			Name = "CmdbarBackdrop",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			Size = UDim2.fromScale(1, 1),
			Text = "",
			TextColor3 = Color3.new(),
			TextSize = 1,
			Visible = CmdbarState.visible,
			ZIndex = 0,

			[Fusion.OnEvent "Activated"] = function()
				CmdbarState.setOpen(false)
			end,
		}
		backdrop.Parent = host

		InputController.onPressed(Enum.KeyCode.Quote, CmdbarState.toggle)
		InputController.onPressed(Enum.KeyCode.Semicolon, CmdbarState.toggle)
	end
	scope:Observer(canOpenCmdbar):onChange(onAccessChanged)
	onAccessChanged()
end
