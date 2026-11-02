-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local GetProductInfo = require(ReplicatedStorage.Library.Functions.GetProductInfo)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

require(script.Parent.Types.Interface)

local t2 = {}

t2.__index = t2
t2.__class = "PhotoInputController"

local v1 = t.interface({
	AssetTypeId = t.number
})

function t2.new(p1, p2) --[[ new | Line: 54 | Upvalues: t2 (copy), Trove (copy) ]]
	local AddPhoto = p1.AddPhoto
	local v1 = p1.Sheet.Actions.Content
	local v3 = setmetatable({}, t2)

	v3._addButton = AddPhoto.Frame.Buttons.Add
	v3._attachment = v1.TextInputWrapper.AddedPhoto
	v3._cancelButton = AddPhoto.Frame.Buttons.Cancel
	v3._composerAddPhotoButton = v1.AddPhoto
	v3._destroyed = false
	v3._imageAssetId = nil
	v3._input = AddPhoto.Frame.TextInputWrapper.TextInput
	v3._onInteraction = p2
	v3._overlay = AddPhoto
	v3._removeButton = v3._attachment.RemoveButton
	v3._requestSerial = 0
	v3._textInputWrapper = v1.TextInputWrapper
	v3._trove = Trove.new()
	v3:_init()

	return v3
end

local function parseImageAssetId(p1) --[[ parseImageAssetId | Line: 79 ]]
	local v1 = p1:match("^%s*(.-)%s*$") or ""
	local v2 = v1:match("^%d+$")

	if v2 == nil then
		v2 = string.lower(v1):match("^rbxassetid://(%d+)$")
	end

	local v4 = if v2 == nil then nil else tonumber(v2)

	if v4 == nil or (v4 <= 0 or v4 % 1 ~= 0) then
		return nil
	end

	return v4
end

local function showInvalidImageNotification() --[[ showInvalidImageNotification | Line: 94 | Upvalues: Message (copy) ]]
	Message.Top({
		Message = "Invalid image, please upload another image.",
		Time = 3,
		ShowShadow = true,
		Color = Color3.new(255/255, 255/255, 255/255)
	})
end

local function showImageLookupFailedNotification() --[[ showImageLookupFailedNotification | Line: 103 | Upvalues: Message (copy) ]]
	Message.Top({
		Message = "Something went wrong, please try again later.",
		Time = 3,
		ShowShadow = true,
		Color = Color3.new(255/255, 255/255, 255/255)
	})
end

local function isImageAsset(p1) --[[ isImageAsset | Line: 112 | Upvalues: wcall (copy), GetProductInfo (copy), v1 (copy) ]]
	local v12, v2 = wcall(GetProductInfo, p1, Enum.InfoType.Asset)

	if not v12 then
		return false, "ImageAssetLookupFailed"
	end

	if not v1(v2) then
		return false, "ImageAssetLookupFailed"
	end

	local AssetTypeId = v2.AssetTypeId

	if AssetTypeId == Enum.AssetType.Image.Value or AssetTypeId == Enum.AssetType.Decal.Value then
		return true, nil
	end

	return false, "InvalidImageAssetId"
end

function t2._setAttachment(p1, p2) --[[ _setAttachment | Line: 130 ]]
	p1._imageAssetId = p2
	p1._attachment.Visible = p2 ~= nil

	if p2 == nil then
		p1._attachment.Icon.Image = ""
	else
		p1._attachment.Icon.Image = ("rbxassetid://%*"):format(p2)
	end
end
function t2._closeOverlay(p1) --[[ _closeOverlay | Line: 140 ]]
	p1._requestSerial = p1._requestSerial + 1
	p1._addButton.Active = true
	p1._overlay.Visible = false
	p1._input.Text = ""
end
function t2.GetImageAssetId(p1) --[[ GetImageAssetId | Line: 151 ]]
	return p1._imageAssetId
end
function t2.Reset(p1) --[[ Reset | Line: 155 ]]
	p1:_closeOverlay()
	p1:_setAttachment(nil)
end
function t2.Destroy(p1) --[[ Destroy | Line: 160 ]]
	if not p1._destroyed then
		p1._destroyed = true
		p1:Reset()
		p1._trove:Destroy()
	end
end
function t2._init(p1) --[[ _init | Line: 174 | Upvalues: Players (copy), Constants (copy), ButtonFX (copy), parseImageAssetId (copy), Message (copy), isImageAsset (copy) ]]
	local v1 = if Players.LocalPlayer.UserId == Constants.OWNER_ID then true else false

	p1._overlay.Visible = false
	p1._attachment.Visible = false
	p1._composerAddPhotoButton.Visible = v1
	p1._composerAddPhotoButton.Active = v1
	p1._composerAddPhotoButton.Selectable = v1
	p1._textInputWrapper.Size = if v1 then UDim2.new(1, -105, 0, 48) else UDim2.new(1, -50, 0, 48)

	if v1 then
		p1._trove:Add(ButtonFX(p1._composerAddPhotoButton, nil, function() --[[ Line: 186 | Upvalues: p1 (copy) ]]
			p1._onInteraction()
			p1._overlay.Visible = true
			p1._input:CaptureFocus()
		end))
		p1._trove:Add(ButtonFX(p1._cancelButton, 1.08, function() --[[ Line: 191 | Upvalues: p1 (copy) ]]
			p1._onInteraction()
			p1:_closeOverlay()
		end))
		p1._trove:Add(ButtonFX(p1._removeButton, nil, function() --[[ Line: 195 | Upvalues: p1 (copy) ]]
			p1._onInteraction()
			p1:_setAttachment(nil)
		end))
		p1._trove:Add(ButtonFX(p1._addButton, 1.08, function() --[[ Line: 199 | Upvalues: p1 (copy), parseImageAssetId (ref), Message (ref), isImageAsset (ref) ]]
			p1._onInteraction()

			local v1 = parseImageAssetId(p1._input.Text)

			if v1 == nil then
				Message.Top({
					Message = "Invalid image, please upload another image.",
					Time = 3,
					ShowShadow = true,
					Color = Color3.new(255/255, 255/255, 255/255)
				})
			else
				local v2 = p1

				v2._requestSerial = v2._requestSerial + 1

				local _requestSerial = p1._requestSerial

				p1._addButton.Active = false
				task.spawn(function() --[[ Line: 210 | Upvalues: isImageAsset (ref), v1 (copy), p1 (ref), _requestSerial (copy), Message (ref) ]]
					local v12, v2 = isImageAsset(v1)

					if p1._destroyed or _requestSerial ~= p1._requestSerial then
						return
					end

					p1._addButton.Active = true

					if v12 then
						p1:_setAttachment(v1)
						p1:_closeOverlay()

						return
					end

					if v2 == "ImageAssetLookupFailed" then
						Message.Top({
							Message = "Something went wrong, please try again later.",
							Time = 3,
							ShowShadow = true,
							Color = Color3.new(255/255, 255/255, 255/255)
						})
					else
						Message.Top({
							Message = "Invalid image, please upload another image.",
							Time = 3,
							ShowShadow = true,
							Color = Color3.new(255/255, 255/255, 255/255)
						})
					end
				end)
			end
		end))
	end
end

return t2