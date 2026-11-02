-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SafeTeleport, time of decompilation: Sun May  3 10:10:53 2026 ]]
local TeleportService = game:GetService("TeleportService")

local function SafeTeleport(n1: number, t1: {[any]: any}, p1) -- line: 7
	-- upvalues: TeleportService (copy)
	local n2 = 0
	local ok, result

	repeat
		ok, result = pcall(function() -- line: 12
			-- upvalues: TeleportService (copy), n1 (copy), t1 (copy), p1 (copy)
			return TeleportService:TeleportAsync(n1, t1, p1)
		end)
		n2 += 1

		if not ok then
			task.wait(1)
		end
	until ok or n2 == 5

	if not ok then
		warn(result)
	end

	return ok, result
end

TeleportService.TeleportInitFailed:Connect(function(p2, p3, p4, p5, p6) --[[ handleFailedTeleport ]] -- line: 28
	-- upvalues: SafeTeleport (copy)
	if p3 == Enum.TeleportResult.Flooded then
		task.wait(15)
	elseif p3 == Enum.TeleportResult.Failure then
		task.wait(1)
	else
		error(("Invalid teleport [%s]: %s"):format(p3.Name, p4))
	end

	SafeTeleport(p5, { p2 }, p6)
end)

return SafeTeleport
