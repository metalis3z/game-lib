-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local v1 = {
    BackgroundTransparency = 0.05,
    BorderSizePixel = 20,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextWrapped = true,
    TextSize = 18,
    TextXAlignment = "Left",
    TextYAlignment = "Top",
    AutoLocalize = false,
    PlaceholderText = "Right click to exit",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(17, 17, 17),
    BorderColor3 = Color3.fromRGB(17, 17, 17),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0.5, 0, 0.4, 0),
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(241, 241, 241)
}
local v2
local v3 = {
    Name = "edit",
    Description = "Edit text in a TextBox",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "string",
            Name = "Input text",
            Description = "The text you wish to edit",
            Default = ""
        },
        {
            Type = "string",
            Name = "Delimiter",
            Description = "The character that separates each line",
            Default = ","
        }
    }
}

function v3.ClientRun(v4, v5, v6) -- line 37 | captures: v2, Players, v1
    v2 = v2 or v4.Cmdr.Util.Mutex()
    local v7 = v2()
    v4:Reply("Right-click on the text area to exit.", Color3.fromRGB(158, 158, 158))
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CmdrEditBox"
    ScreenGui.ResetOnSpawn = false
    local TextBox = Instance.new("TextBox")
    for v8, v9 in pairs(v1) do
        TextBox[v8] = v9
    end
    TextBox.Text = v5:gsub(v6, "\n")
    TextBox.Parent = ScreenGui
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v10 = coroutine.running()
    TextBox.InputBegan:Connect(function(v11) -- line 56 | captures: v6, v7, ScreenGui, TextBox, v10
        if v11.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return
        end
        coroutine.resume(v10, TextBox.Text:gsub("\n", v6))
        ScreenGui:Destroy()
        v7()
    end)
    return coroutine.yield()
end

return v3
