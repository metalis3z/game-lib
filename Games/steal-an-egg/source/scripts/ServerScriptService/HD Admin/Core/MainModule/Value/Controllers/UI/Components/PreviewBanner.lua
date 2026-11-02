--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Banner = require(frontend.Components.Banner)
local Remote = require(modules.Objects.Remote)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>


-- TYPES (props)
type Props = {
	size: UsedAs<UDim2>?,
	layoutOrder: UsedAs<number>?,
}


-- COMPONENT
return function(scope: Scope, props: Props?)
	local sizeProp = if props then props.size else nil
	local layoutOrderProp = if props then props.layoutOrder else nil
	local previewingRolesFuse: any = (scope :: any):Fuse("temp", "PreviewingRoles")
	local roleInfoFuse: any = (scope :: any):Fuse("everyone", "RoleInfo")

	local isPreviewing = scope:Computed(function(use)
		local list = use(previewingRolesFuse)
		return typeof(list) == "table" and #(list :: {any}) > 0
	end)

	local previewLabel = scope:Computed(function(use)
		local list = use(previewingRolesFuse)
		if typeof(list) ~= "table" or #(list :: {any}) == 0 then return "" end
		local roleInfo = use(roleInfoFuse)
		local quoted: {string} = {}
		for _, key in list :: {string} do
			local entry = if typeof(roleInfo) == "table" then (roleInfo :: any)[key] else nil
			local name = if typeof(entry) == "table" and typeof((entry :: any).name) == "string"
				then (entry :: any).name
				else key
			table.insert(quoted, `"{name}"`)
		end
		return `Previewing {table.concat(quoted, ", ")}`
	end)

	local function exitPreview()
		task.spawn(function()
			local clearRemote: any = Remote.get("ClearPreviewingRoles")
			if clearRemote then
				clearRemote:invokeServerAsync()
			end
		end)
	end

	-- No close X, exiting the preview is the only way out
	return Banner(scope, {
		name = "PreviewBanner",
		text = previewLabel,
		buttonLabel = "Exit",
		onButton = exitPreview,
		visible = isPreviewing,
		size = sizeProp,
		layoutOrder = layoutOrderProp,
	})
end
