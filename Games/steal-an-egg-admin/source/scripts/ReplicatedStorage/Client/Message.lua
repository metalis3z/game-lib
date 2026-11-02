-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Audio = require(ReplicatedStorage.Shared.Audio)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local v1 = Color3.fromRGB(255, 255, 255)
local v2 = GUI.Message()
local Contents = v2.Frame.Contents
local v3 = {
    body = Contents.Desc,
    close = v2.Frame.Close,
    heading = v2.Frame.Top.Title,
    icon = Contents.CustomIcon,
    iconBody = Contents.CustomDesc,
    no = Contents.No,
    ok = Contents.Ok,
    yes = Contents.Yes
}
local v4 = false
local v5 = {}

local function render(v6, v7, v8) -- line 28 | captures: v1, v3
    local v9 = v8.icon ~= nil
    v3.close.Visible = true
    v3.yes.Visible = v7
    v3.no.Visible = v7
    v3.ok.Visible = not v7
    v3.icon.Visible = v9
    v3.iconBody.Visible = v9
    v3.body.Visible = not v9
    v3.icon.Image = v8.icon or ""
    local v10 = v8.iconColor or v1
    v3.icon.ImageColor3 = v10
    v3.body.Text = v6
    v3.iconBody.Text = v6
    local v11 = if v8.err == true then "Oops!" else v8.title or "Hey!"
    v3.heading.Text = v11
end

local function restore(v12, v13) -- line 53 | captures: Tabs
    if v12 then
        if v13 then
            Tabs.Dismiss()
        else
            Tabs.Show(v12, true)
        end
    else
        Tabs.Dismiss()
    end
end

function v5.Prompt(v14, v15) -- line 64 | captures: v4, GUI, Save, Audio, Tabs, v2, v3, render
    local function v16(v17, ...)
        table.insert(v17, ...)
    end

    local v18
    local v19 = type(v14) == "string"
    assert(v19, "message body must be a string")
    local v20, v21
    if Save.Get() then
        if v4 or Tabs.IsShowing("Message") then
            v21 = true
        else
            v20 = v15 == true
            v21 = false
        end
    else
        v21 = true
    end
    if v21 then
        return nil
    end
    local v22 = if type(v15) == "table" then v15 else {}
    local v23 = Tabs.Current()
    v4 = true
    render(v14, v20, v22)
    if v20 then
        Audio.Cue("Question")
    else
        Audio.Cue("Statement")
    end
    local v24, v25, BindableEvent, v26
    if Tabs.Show("Message") then
        v25 = true
        BindableEvent = Instance.new("BindableEvent")
        v26 = {}
        local BindableEvent_2 = BindableEvent

        local function finish(v27) -- line 92 | captures: v18, v25, BindableEvent_2
            if not v25 then
                return
            end
            v25 = false
            v18 = v27
            BindableEvent_2:Fire()
        end

        local v28 = v26

        local function connect(v29, v30) -- line 100 | captures: v18, v25, BindableEvent_2, v28, GUI
            local v31 = GUI.ButtonActivated(v29, function() -- line 101 | captures: v30, v18, v25, BindableEvent_2
                if not v25 then
                    return
                end
                v25 = false
                v18 = v30
                BindableEvent_2:Fire()
            end)
            local Default = v31.Default
            table.insert(v28, Default)
            local Signal = v31.Signal
            table.insert(v28, Signal)
        end

        if v20 then
            v24 = false
        end
    else
        v4 = false
        return nil
    end
    local ButtonActivated = GUI.ButtonActivated
    local close = v3.close
    local BindableEvent_2 = BindableEvent
    local v32 = ButtonActivated(close, function() -- line 117 | captures: v18, v24, v25, BindableEvent_2
        if not v25 then
            return
        end
        v25 = false
        v18 = v24
        BindableEvent_2:Fire()
    end)
    local Default = v32.Default
    table.insert(v26, Default)
    local Signal = v32.Signal
    table.insert(v26, Signal)
    local v33 = GUI.ButtonActivated(v3.ok, function() -- line 128 | captures: v18, v25, BindableEvent_2
        if not v25 then
            return
        end
        v25 = false
        v18 = nil
        BindableEvent_2:Fire()
    end)
    local Default_2 = v33.Default
    table.insert(v26, Default_2)
    local Signal_2 = v33.Signal
    table.insert(v26, Signal_2)
    local v34 = GUI.ButtonActivated(v3.no, function() -- line 139 | captures: v18, v25, BindableEvent_2
        if not v25 then
            return
        end
        v25 = false
        v18 = false
        BindableEvent_2:Fire()
    end)
    local Default_3 = v34.Default
    table.insert(v26, Default_3)
    local Signal_3 = v34.Signal
    table.insert(v26, Signal_3)
    local v35 = GUI.ButtonActivated(v3.yes, function() -- line 150 | captures: v18, v25, BindableEvent_2
        if not v25 then
            return
        end
        v25 = false
        v18 = true
        BindableEvent_2:Fire()
    end)
    local Default_4 = v35.Default
    table.insert(v26, Default_4)
    local Signal_4 = v35.Signal
    table.insert(v26, Signal_4)
    local Enabled = v2:GetPropertyChangedSignal("Enabled")
    local v36 = v20
    v16(v26, Enabled:Connect(function() -- line 161 | captures: v18, v25, BindableEvent_2, v36, v2
        if not v2.Enabled then
            local v37 = if v36 then false else nil
            if v25 then
                v25 = false
                v18 = v37
                BindableEvent_2:Fire()
            end
        end
    end))
    BindableEvent.Event:Wait()
    for v38, v39 in v26 do
        v39:Disconnect()
    end
    BindableEvent:Destroy()
    if v23 then
        if v22.dontRestore then
            Tabs.Dismiss()
        else
            Tabs.Show(v23, true)
        end
    else
        Tabs.Dismiss()
    end
    v4 = false
    return v18
end

function v5.PromptGenericFailure() -- line 196 | captures: v5
    return v5.Prompt("Something went wrong.", { err = true })
end

v3.body.RichText = true
v3.iconBody.RichText = true
for v40, v41 in {
        v3.ok,
        v3.yes,
        v3.no,
        v3.close
    } do
    ButtonFX(v41)
end
Remotes.Toasts.Line.OnClientEvent:Connect(function(v42, v43) -- line 207 | captures: v5
    v5.Prompt(v42, v43)
end)

local function OnClientInvoke(v44) -- line 210 | captures: v5
    return v5.Prompt(v44, true) == true
end

Remotes.Haul.OfferFullSatchelSale.OnClientInvoke = OnClientInvoke
return table.freeze(v5)
