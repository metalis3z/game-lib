-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:47
-- Luau version 6, Types version 3
-- Time taken: 0.001098 seconds

local module_upvr = {
	IsServer = game:GetService("RunService"):IsServer();
	WaitForChildTimeout = 60;
	DefaultCommFolderName = "__comm__";
	None = newproxy();
}
local Option_upvr = require(script.Parent.Parent.Option)
function module_upvr.GetCommSubFolder(arg1, arg2) -- Line 12
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Option_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 9 start (CF ANALYSIS FAILED)
	local var3
	if module_upvr.IsServer then
		var3 = arg1:FindFirstChild(arg2)
		if not var3 then
			var3 = Instance.new("Folder")
			var3.Name = arg2
			var3.Parent = arg1
			-- KONSTANTWARNING: GOTO [29] #23
		end
	else
		var3 = arg1:WaitForChild(arg2, module_upvr.WaitForChildTimeout)
	end
	-- KONSTANTERROR: [0] 1. Error Block 9 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [29] 23. Error Block 6 start (CF ANALYSIS FAILED)
	do
		return Option_upvr.Wrap(var3)
	end
	-- KONSTANTERROR: [29] 23. Error Block 6 end (CF ANALYSIS FAILED)
end
return module_upvr