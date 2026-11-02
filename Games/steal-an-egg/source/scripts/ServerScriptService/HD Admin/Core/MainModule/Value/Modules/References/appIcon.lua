local main = script:FindFirstAncestor("MainModule")
local Icon = require(main.Value.Modules.Objects.Icon)
local Icons = require(main.Value.Controllers.UI.Config.Icons)
local images = Icons.Topbar.Menu

return Icon.new()
	:setImage(images.deselected, "deselected")
	:setImage(images.selected, "selected")
	:setImageScale(images.deselectedScale, "deselected")
	:setImageScale(images.selectedScale, "selected")
	:autoDeselect(false)
	:setOrder(0)