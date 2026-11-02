-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Tool = script:FindFirstAncestorWhichIsA("Tool")
local Core = require(Tool.Core)
local UI = Tool:WaitForChild("UI")
local Vendor = Tool:WaitForChild("Vendor")
local v1 = require(Vendor:WaitForChild("Roact"))
local v2 = require(UI:WaitForChild("ToolManualWindow"))

local function ListenForManualWindowTrigger(v3, v4, v5) -- line 10 | captures: Core, v1, v2
    local HelpButton = v5:WaitForChild("HelpButton")
    local v6 = false
    local v7

    local function BeginHover() -- line 16 | captures: v6, HelpButton
        if not v6 then
            HelpButton.TextTransparency = 0
            HelpButton:WaitForChild("Background").BackgroundTransparency = 0
        end
    end

    local function EndHover() -- line 23 | captures: v6, HelpButton
        if not v6 then
            HelpButton.TextTransparency = 0.5
            HelpButton:WaitForChild("Background").BackgroundTransparency = 0.75
        end
    end

    local function ToggleManual() -- line 30 | captures: v6, v7, v3, v4, HelpButton, Core, v1, v2
        local v8 = if v6 then 0 else 0.5
        HelpButton.TextTransparency = v8
        local Background = HelpButton:WaitForChild("Background")
        if v6 then
            Background.BackgroundTransparency = 0
        else
            Background.BackgroundTransparency = 0.75
        end
        if v6 then
            if not v6 then
                HelpButton.TextTransparency = 0.5
                HelpButton:WaitForChild("Background").BackgroundTransparency = 0.75
            end
            v6 = false
            v7 = v1.unmount(v7)
        else
            if not v6 then
                HelpButton.TextTransparency = 0
                HelpButton:WaitForChild("Background").BackgroundTransparency = 0
            end
            v6 = true
            local v9 = v1.createElement(v2, {
                Text = v3,
                ThemeColor = v4
            })
            v7 = v1.mount(v9, Core.UI, "ToolManualWindow")
        end
    end

    v5.Activated:Connect(ToggleManual)
    HelpButton.Activated:Connect(ToggleManual)
    v5.InputBegan:Connect(BeginHover)
    v5.InputEnded:Connect(EndHover)
    HelpButton.InputBegan:Connect(BeginHover)
    HelpButton.InputEnded:Connect(EndHover)
end

return ListenForManualWindowTrigger
