-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local SoundService = game:GetService("SoundService")
local Parent = script.Parent.Parent
local Fusion = require(Parent.Parent.Fusion)
local Util = require(Parent.Util)
local Themer = require(Parent.Themer)
local peek = Fusion.peek
local OnEvent = Fusion.OnEvent
local innerScope = Fusion.innerScope
local v1 = { Base = require(script.Parent.Base) }
return function(v2, v3) -- line 73 | captures: SoundService, Fusion, Util, Themer, peek, OnEvent, innerScope, v1
    local function v4(v5, ...)
        table.insert(v5, ...)
    end

    local v6 = innerScope(v2, Fusion, Util, v1)
    local v7 = Themer.Theme:now()
    local v8 = v6:EnsureValue(Util.Fallback(v3.Text, ""))
    local v9 = Util.Fallback(v3.Disabled, false)
    local v10 = v6:EnsureValue(Util.Fallback(v3.IsFocused, false))
    local v11 = Util.Fallback(v3.OnFocused, function() -- line 80
    end)
    local v12 = Util.Fallback(v3.OnFocusLost, function() -- line 81
    end)
    local v13 = Util.Fallback(v3.Color, v7.Colors.Primary.Main)
    local v14 = Util.Fallback(v3.CharacterLimit, -1)
    local v15 = Util.Fallback(v3.ClearTextOnFocus, false)
    local v16 = Util.Fallback(v3.PlaceholderText, "")
    local v17 = Util.Fallback(v3.TextSize, v7.TextSize["1"])
    local v18 = Util.Fallback(v3.PlaceholderColor3, v7.Colors.NeutralContent.Dark)
    local v19 = Util.Fallback(v3.TextColor3, v6:Computed(function(v20) -- line 90 | captures: v7
        return v20(v7.Colors.BaseContent.Main)
    end))
    local v21 = Util.Fallback(v3.FontFace, v6:Computed(function(v22) -- line 97 | captures: v7
        return Font.new(v22(v7.Font.Body), v22(v7.FontWeight.Body))
    end))
    local v23 = Util.Fallback(v3.TextXAlignment, Enum.TextXAlignment.Left)
    local v24 = Util.Fallback(v3.TextYAlignment, Enum.TextYAlignment.Top)
    local v25 = Util.Fallback(v3.TextTransparency, v6:Computed(function(v26) -- line 106 | captures: v9, v10
        if v26(v9) then
            return 0.75
        end
        if v26(v10) then
            return 0
        end
        return 0.5
    end))
    local v27 = Util.Fallback(v3.TextProcessor, function(v28) -- line 116
        return v28
    end)
    local v29 = Util.Fallback(v3.TextEditable, v6:Computed(function(v30) -- line 121 | captures: v9
        return not v30(v9)
    end))
    local v31 = v6:Value(false)

    local function ProcessText(v32) -- line 128 | captures: v14, v27, peek
        local v33 = peek(v14)
        return (peek(v27)((v32:sub(1, utf8.offset(v32, v33)))))
    end

    local CombineProps = Util.CombineProps
    local v34 = {
        ClassName = "TextBox",
        Name = "TextInput",
        StrokeEnabled = true,
        AutoLocalize = false,
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }
    v34.CornerRadius = v6:Computed(function(v35) -- line 140 | captures: v7
        return UDim.new(0, v35(v7.CornerRadius["1"]))
    end)
    v34.Padding = v6:Computed(function(v36) -- line 143 | captures: v7
        return UDim.new(0, v36(v7.Spacing["0.5"]))
    end)
    v34.StrokeColor = v6:Spring(v6:Computed(function(v37) -- line 148 | captures: v7, v10, v13, v31
        if v37(v31) then
            return v37(v7.Colors.Error.Main)
        end
        if v37(v10) then
            return v37(v13)
        end
        return v37(v7.Colors.NeutralContent.Dark)
    end), v7.SpringSpeed.Immediate, v7.SpringDampening["1"])
    v34.StrokeTransparency = v6:Spring(v6:Computed(function(v38) -- line 161 | captures: v9, v10
        if v38(v9) then
            return 0.9
        end
        if v38(v10) then
            return 0
        end
        return 0.8
    end), v7.SpringSpeed["1"], v7.SpringDampening["1"])
    v34.AutomaticSize = Enum.AutomaticSize.XY
    v34.Active = v6:Computed(function(v39) -- line 176 | captures: v9
        return not v39(v9)
    end)
    local v40 = v6:Hydrate(v6:Base(CombineProps(v3, v34)))
    local v41 = { Text = v8 }
    v41.TextColor3 = v6:Spring(v6:Computed(function(v42) -- line 184 | captures: v7, v19, v31
        if v42(v31) then
            return v42(v7.Colors.Error.Main)
        end
        return v42(v19)
    end), v7.SpringSpeed.Immediate, v7.SpringDampening["1"])
    v41.TextSize = v17
    v41.FontFace = v21
    v41.PlaceholderColor3 = v18
    v41.PlaceholderText = v16
    v41.TextXAlignment = v23
    v41.TextYAlignment = v24
    v41.ClearTextOnFocus = v15
    v41.TextTransparency = v6:Spring(v25, v7.SpringSpeed["1"], v7.SpringDampening["1"])
    v41.TextEditable = v29
    v41.MultiLine = v3.MultiLine
    v41.TextWrapped = v3.TextWrapped

    v41[OnEvent("Focused")] = function() -- line 207 | captures: v7, v9, v10, v11, v29, SoundService, peek
        if peek(v9) or not peek(v29) then
            return
        end
        v10:set(true)
        SoundService:PlayLocalSound(peek(v7.Sound.Focus))
        peek(v11)()
    end

    v41[OnEvent("FocusLost")] = function() -- line 214 | captures: v10, v12, peek
        v10:set(false)
        peek(v12)()
    end

    v41[OnEvent("MouseEnter")] = function() -- line 218 | captures: v7, v9, SoundService, peek
        if not peek(v9) then
            SoundService:PlayLocalSound(peek(v7.Sound.Hover))
        end
    end

    v41[OnEvent("SelectionGained")] = function() -- line 223 | captures: v7, v9, v29, SoundService, peek
        if not peek(v9) and peek(v29) then
            SoundService:PlayLocalSound(peek(v7.Sound.Hover))
        end
    end

    local v43 = v40(v41)
    v4(v6, v43:GetPropertyChangedSignal("Text"):Connect(function() -- line 232 | captures: v8, v14, v27, v31, v43, peek
        local Text = v43.Text
        local v44 = peek(v14)
        local v45 = peek(v27)((Text:sub(1, utf8.offset(Text, v44))))
        v8:set(v45)
        if v43.Text ~= v45 then
            v43.Text = v45
        end
        if utf8.len(Text) == utf8.len(v45) then
            return
        end
        v31:set(true)
        task.wait(0.075)
        v31:set(false)
    end))
    return v43
end
