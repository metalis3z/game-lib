-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Vendor = Parent:WaitForChild("Vendor")
local UI = Parent:WaitForChild("UI")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Vendor:WaitForChild("Roact"))
local createElement = v2.createElement
local v3 = require(UI:WaitForChild("ImageLabel"))
local LoadingSpinner = v2.PureComponent:extend("LoadingSpinner")

function LoadingSpinner.init(v4) -- line 17 | captures: v2
    v4.instance = v2.createRef()
end

function LoadingSpinner.didMount(v5) -- line 21
    coroutine.wrap(function() -- line 22 | captures: v5
        v5.Running = true
        while v5.Running and v5.instance.current do
            local current = v5.instance.current
            current.Rotation = (current.Rotation + 12) % 360
            wait(0.01)
        end
    end)()
end

function LoadingSpinner.willUnmount(v6) -- line 32
    v6.Running = nil
end

function LoadingSpinner.render(v7) -- line 36 | captures: v1, v2, createElement, v3
    local Merge = v1.Merge
    local v8 = {}
    local v9 = v7.props or {}
    local v10 = {}
    v10[v2.Ref] = v7.instance
    v10.Image = "rbxassetid://1932255814"
    v10.AspectRatio = 1
    local v11 = Merge(v8, v9, v10)
    return createElement(v3, v11)
end

return LoadingSpinner
