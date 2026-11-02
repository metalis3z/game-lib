-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:56
-- Luau version 6, Types version 3
-- Time taken: 0.004720 seconds

local module_upvr = {
	CFrameModel = function(arg1, arg2, arg3) -- Line 8, Named "CFrameModel"
		local var12
		if not var12 then
			var12 = arg2.CFrame
		end
		for _, v in next, require(script.Parent).GetDescendants(arg1), nil do
			if v:IsA("BasePart") then
				({})[v] = var12.CFrame:toObjectSpace(v.CFrame)
			end
		end
		var12.CFrame = arg2
		for i_2, v_2 in next, {} do
			i_2.CFrame = arg2:toWorldSpace(v_2)
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		end
	end;
	Create = function(arg1, arg2) -- Line 29, Named "Create"
		return function(arg1_2) -- Line 30
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			local any = Instance.new(arg1)
			local var19
			for i_3, v_3 in next, arg1_2 do
				if type(i_3) == "string" then
					if i_3 == "Parent" then
					else
						any[i_3] = v_3
					end
				elseif type(i_3) == "number" then
					v_3.Parent = any
				end
			end
			any.Parent = nil
			return any
		end
	end;
}
for _, v_4 in next, script:GetChildren() do
	if v_4:IsA("ModuleScript") then
		module_upvr[v_4.Name] = require(v_4)
	end
end
setmetatable(module_upvr, {
	__index = function(arg1, arg2) -- Line 62, Named "__index"
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if arg2 == "Script" then
			local clone = script:Clone()
			clone.Name = "GLib"
			return clone
		end
		if type(arg2) == "string" then
			local SOME = script:FindFirstChild(arg2)
			if SOME then
				module_upvr[SOME.Name] = require(SOME)
			end
		end
		return rawget(module_upvr, arg2)
	end;
	__call = function(arg1) -- Line 78, Named "__call"
		return arg1.Script
	end;
})
return module_upvr