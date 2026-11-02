-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Functions = require(game:GetService("ReplicatedStorage").Library.Functions)

function AttachTimer(p1, p2, p3, p4) --[[ AttachTimer | Line: 3 | Upvalues: Functions (copy) ]]
	task.spawn(function() --[[ Line: 4 | Upvalues: p1 (copy), p3 (copy), p4 (copy), Functions (ref) ]]
		while not p1.Parent do
			task.wait()
		end

		while p1.Parent do
			local v2 = math.max(p3(), 0)

			if p4 then
				p1.timer.Text = ("%*x"):format(Functions.Commas(v2))
			elseif v2 >= 86400 then
				p1.timer.Text = Functions.TimeString(v2)
			else
				p1.timer.Text = os.date("!%X", v2)
			end

			task.wait(0.1)
		end
	end)
end

return AttachTimer