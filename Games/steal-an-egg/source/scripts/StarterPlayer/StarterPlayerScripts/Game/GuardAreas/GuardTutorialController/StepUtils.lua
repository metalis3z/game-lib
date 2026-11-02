-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types.Interface)

return {
	BindOnAdapterChanged = function(p1, p2, p3) --[[ BindOnAdapterChanged | Line: 16 ]]
		local v1 = p1.Changed:Connect(function() --[[ Line: 21 | Upvalues: p2 (copy), p1 (copy), p3 (copy) ]]
			if not p2(p1) then
				return
			end

			p3()
		end)

		task.defer(function() --[[ Line: 27 | Upvalues: p2 (copy), p1 (copy), p3 (copy) ]]
			if not p2(p1) then
				return
			end

			p3()
		end)

		return function() --[[ Line: 33 | Upvalues: v1 (copy) ]]
			v1:Disconnect()
		end
	end
}