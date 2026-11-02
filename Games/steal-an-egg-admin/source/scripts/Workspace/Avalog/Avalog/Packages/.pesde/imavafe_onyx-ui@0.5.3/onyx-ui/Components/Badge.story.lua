-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Themer = require(Parent.Themer)
local Util = require(Parent.Util)
local scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek
local v1 = {
    Frame = require(Parent.Components.Frame),
    Badge = require(Parent.Components.Badge),
    Text = require(Parent.Components.Text)
}
local v2 = {}

function v2.story(v3) -- line 21 | captures: Fusion, Themer, Util, Children, peek, v1
    local v4 = Fusion.innerScope(v3.scope, Fusion, v1)
    local v5 = Themer.Theme:now()
    local v6 = v4:Value(0)
    local v7 = task.spawn(function() -- line 27 | captures: v6, peek
        while true do
            if task.wait(0.08) then
                if peek(v6) == 100 then
                    task.wait(3)
                    v6:set(1)
                else
                    v6:set(peek(v6) + 1)
                end
            else
                break
            end
        end
    end)
    v4:innerScope({
        function() -- line 39 | captures: v7
            task.cancel(v7)
        end
    })
    local v8 = {
        Parent = v3.target,
        ListEnabled = true
    }
    v8.ListPadding = v4:Computed(function(v9) -- line 47 | captures: v5
        return UDim.new(0, v9(v5.Spacing["0.5"]))
    end)
    local v10 = v4:Badge({ Content = { "Badge" } })
    local v11 = v4:Badge({
        Content = { "\238\128\129 PREMIUM" },
        Color = Util.Colors.Amber["500"]
    })
    local v12 = v4:Badge({
        Content = { "rbxassetid://103798699021677", "-50%" },
        Color = Util.Colors.Red["500"]
    })
    local v13 = v4:Badge({
        Content = { "rbxassetid://140490867216758", "LIMITED" },
        Color = Util.Colors.Red["500"]
    })
    local v14 = {}
    v14.Content = v4:Computed(function(v15) -- line 68 | captures: v6
        if v15(v6) >= 100 then
            return { "99+" }
        end
        return { v15(v6) }
    end)
    v14.Color = v5.Colors.Primary.Main
    local v16 = v4:Badge(v14)
    local v17 = {
        ListEnabled = true,
        ListHorizontalAlignment = Enum.HorizontalAlignment.Center,
        ListFillDirection = Enum.FillDirection.Horizontal
    }
    v17.ListPadding = v4:Computed(function(v18) -- line 81 | captures: v5
        return UDim.new(0, v18(v5.Spacing["0.25"]))
    end)
    v17[Children] = {
        v4:Text({ Text = "It's also proportional alongside text." }),
        v4:Badge({
            Content = { "rbxassetid://137979359742656", "TRUE" },
            Color = Util.Colors.Green["500"]
        })
    }
    v8[Children] = {
        v10,
        v11,
        v12,
        v13,
        v16,
        v4:Frame(v17)
    }
    v4:Frame(v8)
end

v2.fusion = Fusion
return v2
