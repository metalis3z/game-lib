local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Framework = shared.Framework
local Require = Framework.Require
local IsMobileDevice = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled and not UserInputService.GamepadEnabled and not GuiService:IsTenFootInterface()

Require("WeaponInitializer")	

return nil