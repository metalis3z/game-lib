-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ UpdateTitle | Line: 1 ]]
	p1.title.Text = p3()
	task.spawn(function() --[[ Line: 4 | Upvalues: p1 (copy), p3 (copy) ]]
		while not p1.Parent do
			task.wait()
		end

		while p1.Parent do
			p1.title.Text = p3()
			task.wait(0.1)
		end
	end)
end