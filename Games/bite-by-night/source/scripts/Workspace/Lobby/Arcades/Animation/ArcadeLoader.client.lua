-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait(0.5)
local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Games"):WaitForChild("SnakeGame"))
game:GetService("Players").LocalPlayer.Character:AddTag("CantMove")
local v_u_2 = v1.new()
game:GetService("GamepadService"):EnableGamepadCursor(v_u_2.Gui.Holder)

v_u_2.Gui.Holder.InfoContainer:FindFirstChild("4ExitContainer").TextButton.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_2
	game:GetService("GamepadService"):DisableGamepadCursor()
	game:GetService("Players").LocalPlayer.Character:RemoveTag("CantMove")
	v_u_2:Destroy()
	v_u_2 = nil
	script.CloseEvent:FireServer()
end)