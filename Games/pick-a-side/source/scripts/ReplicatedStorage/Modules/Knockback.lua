-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:08
-- Luau version 6, Types version 3
-- Time taken: 0.001049 seconds

local new_upvr_3 = Instance.new
local new_upvr_2 = CFrame.new
local new_upvr = Vector3.new
local GetModelMass_upvr = require(game.ReplicatedStorage.Modules.GetModelMass)
local Debris_upvr = game:GetService("Debris")
function Knockback(arg1, arg2, arg3, arg4, arg5) -- Line 12
	--[[ Upvalues[5]:
		[1]: new_upvr_3 (readonly)
		[2]: new_upvr_2 (readonly)
		[3]: new_upvr (readonly)
		[4]: GetModelMass_upvr (readonly)
		[5]: Debris_upvr (readonly)
	]]
	local HumanoidRootPart = arg2.HumanoidRootPart
	local new_upvr_3_result1 = new_upvr_3("VectorForce")
	new_upvr_3_result1.Force = new_upvr_2(arg1, HumanoidRootPart.Position + new_upvr(0, arg3, 0)).lookVector * GetModelMass_upvr(arg2) * arg4
	new_upvr_3_result1.Attachment0 = HumanoidRootPart.RootAttachment
	Debris_upvr:AddItem(new_upvr_3_result1, arg5)
	new_upvr_3_result1.Parent = HumanoidRootPart
end
return Knockback