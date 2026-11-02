-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")

local function SafeGet(v1, v2, v3) -- line 10
    local v4, v5 = pcall(function() -- line 12 | captures: v1, v2
        return v1[v2]
    end)
    if v4 then
        return v5
    end
    return v3
end

local function IsWindows() -- line 20 | captures: GuiService
    local v6, v7 = pcall(function() -- line 24 | captures: GuiService
        return GuiService.IsWindows
    end)
    if v6 then
        return v7
    end
    return false
end

local function GetCharacterSize(v8) -- line 32 | captures: TextService
    local v9 = utf8.char(v8)
    return TextService:GetTextSize(v9, 16, Enum.Font.SourceSans, Vector2.new(1000, 1000))
end

local v10 = TextService:GetTextSize(utf8.char(65535), 16, Enum.Font.SourceSans, Vector2.new(1000, 1000))

local function IsValidCharacter(v11) -- line 38 | captures: TextService, v10
    local v12 = utf8.char(v11)
    return TextService:GetTextSize(v12, 16, Enum.Font.SourceSans, Vector2.new(1000, 1000)) ~= v10
end

local freeze = table.freeze
local v13 = { DetectorVersion = "heuristic_v1" }

function v13.Get() -- line 46 | captures: GuiService, UserInputService
    if UserInputService.VREnabled then
        return Enum.DeviceForm.VR
    end
    if GuiService:IsTenFootInterface() then
        return Enum.DeviceForm.Console
    end
    local v14, v15 = pcall(function() -- line 56 | captures: GuiService
        return GuiService.IsWindows
    end)
    if v14 and v15 then
        return Enum.DeviceForm.Desktop
    end
    if UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled then
        return Enum.DeviceForm.Phone
    end
    if UserInputService.MouseEnabled then
        return Enum.DeviceForm.Desktop
    end
    if UserInputService.TouchEnabled then
        return Enum.DeviceForm.Phone
    end
    if UserInputService.GamepadEnabled then
        return Enum.DeviceForm.Console
    end
    return nil
end

function v13.GetPlatform() -- line 81 | captures: GuiService, TextService, UserInputService, VRService, v10
    local function v16(...)
        return (tostring(...))
    end

    local v17 = v16(version())
    local v18 = ""
    pcall(function() -- line 85 | captures: v18, UserInputService
        v18 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect):lower()
    end)
    local v19 = v17:find("^0%.") ~= nil
    local v20 = GuiService:IsTenFootInterface() and v17:find("^1%.") ~= nil
    local v21 = v17:find("^2%.") ~= nil
    local v22 = UserInputService.VREnabled and VRService.VREnabled
    local v23, v24 = pcall(function() -- line 100 | captures: GuiService
        return GuiService.IsWindows
    end)
    if not v23 then
        v24 = false
    end
    local v25 = utf8.char(63743)
    local v26 = TextService:GetTextSize(v25, 16, Enum.Font.SourceSans, Vector2.new(1000, 1000)) ~= v10
    if v20 then
        local v27 = v18:find("xbox") ~= nil
        local v28 = v18:find("ps4") ~= nil
        local v29 = v18:find("ps5") ~= nil
        if v27 or v24 then
            return Enum.Platform.XBoxOne
        end
        if v28 then
            return Enum.Platform.PS4
        end
        if v29 then
            return Enum.Platform.PS5
        end
    else
        if v21 then
            if v24 then
                return Enum.Platform.UWP
            end
            if v22 then
                return Enum.Platform.MetaOS
            end
            if v26 then
                return Enum.Platform.IOS
            end
            if UserInputService.TouchEnabled then
                return Enum.Platform.Android
            end
            return Enum.Platform.Linux
        end
        if v19 then
            if v24 then
                return Enum.Platform.Windows
            end
            return Enum.Platform.OSX
        end
    end
    return Enum.Platform.None
end

return freeze(v13)
