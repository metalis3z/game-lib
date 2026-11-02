-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local UserInputService = game:GetService("UserInputService")
local Touch = Enum.UserInputType.Touch
local Keyboard = Enum.UserInputType.Keyboard
local v1
local v2 = {}
local v3 = { Current = "MouseKeyboard" }

function v3.Observe(v4) -- line 14 | captures: v1, v2
    if table.find(v2, v4) then
        error("function already subscribed", 2)
    end
    table.insert(v2, v4)
    task.spawn(v4, v1.Current)
    return function() -- line 20 | captures: v4, v2
        local v5 = table.find(v2, v4)
        if not v5 then
            return
        end
        local v6 = #v2
        v2[v5] = v2[v6]
        v2[v6] = nil
    end
end

v1 = v3

local function SetPreferred(v7) -- line 30 | captures: v1, v2
    if v7 ~= v1.Current then
        v1.Current = v7
        for v8, v9 in v2 do
            task.spawn(v9, v7)
        end
    end
end

local function DeterminePreferred(v10) -- line 42 | captures: Touch, Keyboard, SetPreferred
    if v10 == Touch then
        SetPreferred("Touch")
    else
        local v11
        if v10 == Keyboard then
            v11 = true
        else
            local Name = v10.Name
            if string.sub(Name, 1, 5) == "Mouse" then
                v11 = true
            else
                local Name = v10.Name
                if string.sub(Name, 1, 7) == "Gamepad" then
                    SetPreferred("Gamepad")
                end
                v11 = false
            end
        end
        if not v11 then
            return
        end
        SetPreferred("MouseKeyboard")
    end
end

local v12 = UserInputService:GetLastInputType()

if v12 == Touch then
    SetPreferred("Touch")
elseif v12 == Keyboard then
    SetPreferred("MouseKeyboard")
else
    local Name = v12.Name
    if string.sub(Name, 1, 5) == "Mouse" then
        SetPreferred("MouseKeyboard")
    else
        local Name = v12.Name
        if string.sub(Name, 1, 7) == "Gamepad" then
            SetPreferred("Gamepad")
        end
    end
end
UserInputService.LastInputTypeChanged:Connect(DeterminePreferred)
return v1
