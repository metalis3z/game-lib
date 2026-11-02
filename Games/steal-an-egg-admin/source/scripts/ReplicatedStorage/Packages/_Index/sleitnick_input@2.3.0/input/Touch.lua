-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local v1 = {}

v1.__index = v1

function v1.new() -- line 11 | captures: Trove, Signal, UserInputService, v1
    local v2 = {}
    local v3 = setmetatable(v2, v1)
    v3._trove = Trove.new()
    v3.TouchTap = v3._trove:Construct(Signal.Wrap, UserInputService.TouchTap)
    v3.TouchTapInWorld = v3._trove:Construct(Signal.Wrap, UserInputService.TouchTapInWorld)
    v3.TouchMoved = v3._trove:Construct(Signal.Wrap, UserInputService.TouchMoved)
    v3.TouchLongPress = v3._trove:Construct(Signal.Wrap, UserInputService.TouchLongPress)
    v3.TouchPan = v3._trove:Construct(Signal.Wrap, UserInputService.TouchPan)
    v3.TouchPinch = v3._trove:Construct(Signal.Wrap, UserInputService.TouchPinch)
    v3.TouchRotate = v3._trove:Construct(Signal.Wrap, UserInputService.TouchRotate)
    v3.TouchSwipe = v3._trove:Construct(Signal.Wrap, UserInputService.TouchSwipe)
    v3.TouchStarted = v3._trove:Construct(Signal.Wrap, UserInputService.TouchStarted)
    v3.TouchEnded = v3._trove:Construct(Signal.Wrap, UserInputService.TouchEnded)
    return v3
end

function v1.IsTouchEnabled(v4) -- line 26 | captures: UserInputService
    return UserInputService.TouchEnabled
end

local function Destroy(v5) -- line 29
    v5._trove:Destroy()
end

v1.Destroy = Destroy
return v1
