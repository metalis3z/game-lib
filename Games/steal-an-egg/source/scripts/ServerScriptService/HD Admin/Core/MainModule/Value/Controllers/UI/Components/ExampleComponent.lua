--!strict
-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local frontend = modules.Parent.Controllers.UI
local Fusion = require(packages.Fusion)
local Theme = require(frontend.Util.Theme)


-- TYPES
type Scope = Fusion.Scope
type UsedAs<T> = Fusion.UsedAs<T>
type Props = {
	example1: UsedAs<string>,
	example2: UsedAs<string>,
	example3: UsedAs<string>,
}


-- COMPONENT
return function (scope: Scope, props: Props)
    return scope:New "TextButton" {
        BackgroundColor3 = Theme.Color.Base,
        Text = props.example1
    }
end