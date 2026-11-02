-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Keybinds"))
local v_u_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp")).Client("Input")
if game:GetService("UserInputService").GamepadEnabled then
    script.Parent:WaitForChild("MimicAbilities").Strength.Keybind.Key.Text = "X"
    script.Parent:WaitForChild("MimicAbilities").Speed.Keybind.Key.Text = "Y"
    script.Parent:WaitForChild("MimicAbilities").Stealth.Keybind.Key.Text = "B"
end
local MimicAbilities = script.Parent:WaitForChild("MimicAbilities")
MimicAbilities.Strength.Button.MouseButton1Click:Once(function()
    v_u_1:Fire(true, {
        "Ability",
        2,
        "Strength",
        true
    })
end)
MimicAbilities.Speed.Button.MouseButton1Click:Once(function()
    v_u_1:Fire(true, {
        "Ability",
        2,
        "Speed",
        true
    })
end)
MimicAbilities.Stealth.Button.MouseButton1Click:Once(function()
    v_u_1:Fire(true, {
        "Ability",
        2,
        "Stealth",
        true
    })
end)
