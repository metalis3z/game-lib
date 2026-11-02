-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Vendor = script.Parent.Parent.Parent:WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(script:WaitForChild("ScopeOutTooltip"))
local v3 = require(script:WaitForChild("ScopeLockTooltip"))
local v4 = require(script:WaitForChild("ScopeInTooltip"))
local v5 = require(script:WaitForChild("AltTooltip"))

local function HotkeyTooltip(v6) -- line 11 | captures: v1, v2, v3, v4, v5
    local v7
    if v6.IsAltDown then
        if v6.IsScopeParent then
            v7 = v1.createElement(v2, v6)
        elseif not v6.IsScope or v6.IsScopeLocked then
            if v6.IsScopable then
                v7 = v1.createElement(v4, v6)
            end
        else
            v7 = v1.createElement(v3, v6)
        end
    elseif v6.DisplayAltHotkey then
        v7 = v1.createElement(v5, v6)
    end
    local createFragment = v1.createFragment
    local v8 = { Tooltip = v7 }
    if v7 then
        local createElement = v1.createElement
        local v9 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 1, 0)
        }
        v9.LayoutOrder = v6.LayoutOrder and v6.LayoutOrder - 1 or 2
        v8.Spacer = createElement("Frame", v9)
    else
        v8.Spacer = v7
    end
    return createFragment(v8)
end

return HotkeyTooltip
