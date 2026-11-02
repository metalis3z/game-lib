-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:00
-- Luau version 6, Types version 3
-- Time taken: 0.001304 seconds

local Debris_upvr = game:GetService("Debris")
return function(arg1, arg2, arg3) -- Line 6
	--[[ Upvalues[1]:
		[1]: Debris_upvr (readonly)
	]]
	if arg2 == nil then
	else
		if arg1 == nil then return end
		if arg2:IsA("Player") then
			local var3 = arg1
		end
		if var3:FindFirstChild("creator") then
			var3.creator:Destroy()
		end
		local ObjectValue = Instance.new("ObjectValue")
		ObjectValue.Name = "creator"
		ObjectValue.Value = arg2
		ObjectValue.Parent = var3
		Debris_upvr:AddItem(ObjectValue, arg3 or 1)
	end
end