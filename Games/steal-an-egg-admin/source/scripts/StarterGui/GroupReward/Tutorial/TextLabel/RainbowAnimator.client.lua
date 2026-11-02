-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local RainbowGradient = script.Parent:WaitForChild("RainbowGradient")
local v1 = 0

local function updateRainbow() -- line 6 | captures: RainbowGradient
    local v2 = os.clock() * 0.16 % 1
    local v3 = {}
    for v4 = 0, 6 do
        local v5 = v4 / 6
        v3[v4 + 1] = ColorSequenceKeypoint.new(v5, Color3.fromHSV((v2 + v5) % 1, 1, 1))
    end
    RainbowGradient.Color = ColorSequence.new(v3)
end

updateRainbow()
RunService.RenderStepped:Connect(function(v6) -- line 23 | captures: v1, updateRainbow
    v1 += v6
    if not (v1 < 0.03333333333333333) then
        v1 %= 0.03333333333333333
        updateRainbow()
    end
end)
