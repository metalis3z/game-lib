-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Children = require(script.Parent.PropMarkers.Children)
local ElementKind = require(script.Parent.ElementKind)
local Logging = require(script.Parent.Logging)
local Type = require(script.Parent.Type)
local v1 = require(script.Parent.GlobalConfig).get()

local function createElement(v2, v3, v4) -- line 37 | captures: Children, ElementKind, Logging, Type, v1
    if v1.typeChecks then
        local v5 = v2 ~= nil
        assert(v5, "`component` is required")
        local v6 = if typeof(v3) == "table" then true else v3 == nil
        assert(v6, "`props` must be a table or nil")
        local v7 = if typeof(v4) == "table" then true else v4 == nil
        assert(v7, "`children` must be a table or nil")
    end
    local v8 = if v3 == nil then {} else v3
    if v4 ~= nil then
        if v8[Children] ~= nil then
            Logging.warnOnce("The prop `Roact.Children` was defined but was overriden by the third parameter to createElement!\nThis can happen when a component passes props through to a child element but also uses the `children` argument:\n\n\tRoact.createElement(\"Frame\", passedProps, {\n\t\tchild = ...\n\t})\n\nInstead, consider using a utility function to merge tables of children together:\n\n\tlocal children = mergeTables(passedProps[Roact.Children], {\n\t\tchild = ...\n\t})\n\n\tlocal fullProps = mergeTables(passedProps, {\n\t\t[Roact.Children] = children\n\t})\n\n\tRoact.createElement(\"Frame\", fullProps)")
        end
        v8[Children] = v4
    end
    local v9 = ElementKind.fromComponent(v2)
    local v10 = {}
    v10[Type] = Type.Element
    v10[ElementKind] = v9
    v10.component = v2
    v10.props = v8
    if v1.elementTracing then
        v10.source = debug.traceback("", 2):sub(2)
    end
    return v10
end

return createElement
