-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Base = require(script.Base),
    Text = require(script.Text),
    Frame = require(script.Frame),
    Badge = require(script.Badge),
    Avatar = require(script.Avatar),
    AutoScaleFrame = require(script.AutoScaleFrame),
    BaseButton = require(script.BaseButton),
    Button = require(script.Button),
    Card = require(script.Card),
    Checkbox = require(script.Checkbox),
    Divider = require(script.Divider),
    Group = require(script.Group),
    Heading = require(script.Heading),
    Icon = require(script.Icon),
    IconButton = require(script.IconButton),
    IconText = require(script.IconText),
    Image = require(script.Image),
    MenuFrame = require(script.MenuFrame),
    NumberSpinner = require(script.NumberSpinner),
    ProgressBar = require(script.ProgressBar),
    Scroller = require(script.Scroller),
    SwitchInput = require(script.SwitchInput),
    SwitchGroup = require(script.SwitchGroup),
    TextInput = require(script.TextInput),
    TextArea = require(script.TextArea),
    TitleBar = require(script.TitleBar),
    SwapInput = require(script.SwapInput),
    Slider = require(script.Slider)
}
task.spawn(function() -- line 34 | captures: v1
    for v2, v3 in ipairs(script:GetChildren()) do
        local Name = v3.Name
        if string.sub(Name, -6) ~= ".story" then
            local pcall_2 = pcall
            local v4 = v3
            local v5, v6 = pcall_2(function() -- line 38 | captures: v4
                return require(v4)
            end)
            if v5 then
                if v1[v3.Name] ~= v6 then
                    local v7 = ("Component %* is not listed."):format(v3)
                    assert(false, v7)
                end
            else
                local v8 = ("%* errored during require."):format(v3)
                assert(false, v8)
            end
        end
    end
end)
return v1
