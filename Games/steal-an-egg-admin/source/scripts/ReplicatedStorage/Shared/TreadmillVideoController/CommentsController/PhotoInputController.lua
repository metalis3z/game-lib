-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Info = require(ReplicatedStorage.Shared.Utils.Marketplace).Info
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = {}

v1.__index = v1
v1.__class = "PhotoInputController"

local v2 = t.interface({ AssetTypeId = t.number })

function v1.new(v3, v4) -- line 20 | captures: Trove, v1
    local AddPhoto = v3.AddPhoto
    local Content = v3.Sheet.Actions.Content
    local v5 = {}
    local v6 = setmetatable(v5, v1)
    v6._addButton = AddPhoto.Frame.Buttons.Add
    v6._attachment = Content.TextInputWrapper.AddedPhoto
    v6._cancelButton = AddPhoto.Frame.Buttons.Cancel
    v6._composerAddPhotoButton = Content.AddPhoto
    v6._destroyed = false
    v6._imageAssetId = nil
    v6._input = AddPhoto.Frame.TextInputWrapper.TextInput
    v6._onInteraction = v4
    v6._overlay = AddPhoto
    v6._removeButton = v6._attachment.RemoveButton
    v6._requestSerial = 0
    v6._textInputWrapper = Content.TextInputWrapper
    v6._trove = Trove.new()
    v6:_init()
    return v6
end

local function parseImageAssetId(v7) -- line 40
    local v8 = v7:match("^%s*(.-)%s*$") or ""
    local v9 = v8:match("^%d+$")
    if v9 == nil then
        v9 = string.lower(v8):match("^rbxassetid://(%d+)$")
    end
    local v10
    if v9 == nil then
    else
        v10 = tonumber(v9)
    end
    if v10 ~= nil and not (v10 <= 0) and v10 % 1 == 0 then
        return v10
    end
    return nil
end

local function showInvalidImageNotification() -- line 57 | captures: Message
    Message.Top({
        Message = "Invalid image, please upload another image.",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function showImageLookupFailedNotification() -- line 60 | captures: Message
    Message.Top({
        Message = "Something went wrong, please try again later.",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function isImageAsset(v11) -- line 63 | captures: Info, TryCall, v2
    local v12, v13 = TryCall(Info, v11, Enum.InfoType.Asset)
    if not (v12 and v2(v13)) then
        return false, "ImageAssetLookupFailed"
    end
    local AssetTypeId = v13.AssetTypeId
    if AssetTypeId == Enum.AssetType.Image.Value or AssetTypeId == Enum.AssetType.Decal.Value then
        return true, nil
    end
    return false, "InvalidImageAssetId"
end

local function _setAttachment(v14, v15) -- line 75
    v14._imageAssetId = v15
    local v16 = v15 ~= nil
    v14._attachment.Visible = v16
    if v15 == nil then
        v14._attachment.Icon.Image = ""
    else
        v14._attachment.Icon.Image = ("rbxassetid://%*"):format(v15)
    end
end

v1._setAttachment = _setAttachment

local function _closeOverlay(v17) -- line 85
    v17._requestSerial += 1
    v17._addButton.Active = true
    v17._overlay.Visible = false
    v17._input.Text = ""
end

v1._closeOverlay = _closeOverlay

local function GetImageAssetId(v18) -- line 91
    return v18._imageAssetId
end

v1.GetImageAssetId = GetImageAssetId

local function Reset(v19) -- line 94
    v19:_closeOverlay()
    v19:_setAttachment(nil)
end

v1.Reset = Reset

local function Destroy(v20) -- line 98
    if v20._destroyed then
        return
    end
    v20._destroyed = true
    v20:Reset()
    v20._trove:Destroy()
end

v1.Destroy = Destroy

function v1._init(v21) -- line 106 | captures: Players, ButtonFX, Constants, Message, parseImageAssetId, isImageAsset
    local v22 = Players.LocalPlayer.UserId == Constants.OWNER_ID
    v21._overlay.Visible = false
    v21._attachment.Visible = false
    v21._composerAddPhotoButton.Visible = v22
    v21._composerAddPhotoButton.Active = v22
    v21._composerAddPhotoButton.Selectable = v22
    local v23
    if v22 then
        v23 = UDim2.new(1, -105, 0, 48)
    else
        v23 = UDim2.new(1, -50, 0, 48)
    end
    v21._textInputWrapper.Size = v23
    if not v22 then
        return
    end
    local _trove = v21._trove
    local _composerAddPhotoButton = v21._composerAddPhotoButton
    _trove:Add(ButtonFX(_composerAddPhotoButton, nil, function() -- line 123 | captures: v21
        v21._onInteraction()
        v21._overlay.Visible = true
        v21._input:CaptureFocus()
    end))
    local _trove_2 = v21._trove
    local _cancelButton = v21._cancelButton
    _trove_2:Add(ButtonFX(_cancelButton, 1.08, function() -- line 128 | captures: v21
        v21._onInteraction()
        v21:_closeOverlay()
    end))
    local _trove_3 = v21._trove
    local _removeButton = v21._removeButton
    _trove_3:Add(ButtonFX(_removeButton, nil, function() -- line 132 | captures: v21
        v21._onInteraction()
        v21:_setAttachment(nil)
    end))
    local _trove_4 = v21._trove
    local _addButton = v21._addButton
    _trove_4:Add(ButtonFX(_addButton, 1.08, function() -- line 136 | captures: v21, Message, parseImageAssetId, isImageAsset
        v21._onInteraction()
        local v24 = parseImageAssetId(v21._input.Text)
        if v24 == nil then
            Message.Top({
                Message = "Invalid image, please upload another image.",
                Time = 3,
                ShowShadow = true,
                Color = Color3.new(1, 1, 1)
            })
        else
            v21._requestSerial += 1
            local _requestSerial = v21._requestSerial
            v21._addButton.Active = false
            task.spawn(function() -- line 147 | captures: v24, _requestSerial, v21, Message, isImageAsset
                local v25, v26 = isImageAsset(v24)
                if not v21._destroyed and _requestSerial == v21._requestSerial then
                    v21._addButton.Active = true
                    if v25 then
                        v21:_setAttachment(v24)
                        v21:_closeOverlay()
                    elseif v26 == "ImageAssetLookupFailed" then
                        Message.Top({
                            Message = "Something went wrong, please try again later.",
                            Time = 3,
                            ShowShadow = true,
                            Color = Color3.new(1, 1, 1)
                        })
                    else
                        Message.Top({
                            Message = "Invalid image, please upload another image.",
                            Time = 3,
                            ShowShadow = true,
                            Color = Color3.new(1, 1, 1)
                        })
                    end
                end
            end)
        end
    end))
end

return v1
