local StarterGui = game:GetService("StarterGui")

task.spawn(function() --[[ Line: 5 | Upvalues: StarterGui (copy) ]]
	repeat
		if not task.wait(3) then
			return
		end
	until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack)

	warn("Purse and CoreGui backpack enabled at the same time")
end)