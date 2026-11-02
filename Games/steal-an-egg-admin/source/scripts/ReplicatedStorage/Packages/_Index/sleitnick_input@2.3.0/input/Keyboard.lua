-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local v1 = {}

v1.__index = v1

function v1.new() -- line 11 | captures: Trove, Signal, v1
    local v2 = {}
    local v3 = setmetatable(v2, v1)
    v3._trove = Trove.new()
    v3.KeyDown = v3._trove:Construct(Signal)
    v3.KeyUp = v3._trove:Construct(Signal)
    v3:_setup()
    return v3
end

function v1.IsKeyDown(v4, v5) -- line 19 | captures: UserInputService
    return UserInputService:IsKeyDown(v5)
end

local function AreKeysDown(v6, v7, v8) -- line 22
    return v6:IsKeyDown(v7) and v6:IsKeyDown(v8)
end

v1.AreKeysDown = AreKeysDown

local function AreEitherKeysDown(v9, v10, v11) -- line 29
    return v9:IsKeyDown(v10) or v9:IsKeyDown(v11)
end

v1.AreEitherKeysDown = AreEitherKeysDown

function v1._setup(v12) -- line 36 | captures: UserInputService
    v12._trove:Connect(UserInputService.InputBegan, function(v13, v14) -- line 37 | captures: v12
        if not v14 and v13.UserInputType == Enum.UserInputType.Keyboard then
            v12.KeyDown:Fire(v13.KeyCode)
        end
    end)
    v12._trove:Connect(UserInputService.InputEnded, function(v15, v16) -- line 45 | captures: v12
        if not v16 and v15.UserInputType == Enum.UserInputType.Keyboard then
            v12.KeyUp:Fire(v15.KeyCode)
        end
    end)
end

local function Destroy(v17) -- line 54
    v17._trove:Destroy()
end

v1.Destroy = Destroy
return v1
