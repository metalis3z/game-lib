-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Children = Fusion.Children
local scoped = Fusion.scoped
local peek = Fusion.peek
local v1 = {
    Frame = require(Parent.Components.Frame),
    NumberSpinner = require(Parent.Components.NumberSpinner)
}
local v2 = {}

function v2.story(v3) -- line 17 | captures: Fusion, Children, peek, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = v4:Value(0)
    local v6 = v4:Value(0)
    local v7 = v4:Value(0)
    local v8 = task.spawn(function() -- line 24 | captures: v5
        while task.wait(1) do
            v5:set(math.random(1, 1000000))
        end
    end)
    local v9 = task.spawn(function() -- line 29 | captures: v6
        while task.wait(1) do
            v6:set(math.random(1, 10000) / 100)
        end
    end)
    local v10 = task.spawn(function() -- line 34 | captures: v7, peek
        while task.wait(1) do
            v7:set(peek(v7) + 1)
        end
    end)
    v4:innerScope({
        function() -- line 41 | captures: v8, v9, v10
            task.cancel(v8)
            task.cancel(v9)
            task.cancel(v10)
        end
    })
    local v11 = {
        Parent = v3.target,
        Size = UDim2.fromOffset(300, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ListEnabled = true
    }
    v11[Children] = {
        v4:NumberSpinner({ Value = v7 }),
        v4:NumberSpinner({
            Commas = true,
            Value = v5
        }),
        v4:NumberSpinner({
            Decimals = 2,
            Commas = true,
            Prefix = "$",
            Value = v6,
            Font = Enum.Font.FredokaOne
        })
    }
    v4:Frame(v11)
end

v2.fusion = Fusion
return v2
