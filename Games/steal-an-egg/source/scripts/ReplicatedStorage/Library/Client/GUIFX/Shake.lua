-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Functions = require(Library.Functions)
local t = {}

return function(p1, p2, p3, p4, p5) --[[ Line: 6 | Upvalues: t (copy), Functions (copy) ]]
	if not t[p1] then
		t[p1] = true
		task.spawn(function() --[[ Line: 9 | Upvalues: p1 (copy), p2 (copy), p3 (ref), p4 (ref), p5 (ref), Functions (ref), t (ref) ]]
			local Rotation = p1.Rotation
			local v1 = Rotation + p2
			local v2 = Rotation - p2

			if p3 == nil then
				p3 = Enum.EasingStyle.Linear
			end

			if p4 == nil then
				p4 = 0.075
			end

			local v3 = p4

			assert(v3)

			if p5 == nil then
				p5 = 1
			end

			local v4 = p5

			assert(v4)

			for i = 1, p5 do
				Functions.Tween(p1, {
					Rotation = v1
				}, { p4, p3, "Out" }).Completed:Connect(function() --[[ Line: 26 | Upvalues: Functions (ref), p1 (ref), Rotation (copy), p4 (ref), p3 (ref), v2 (copy), i (copy), p5 (ref), t (ref) ]]
					Functions.Tween(p1, {
						Rotation = Rotation
					}, { p4, p3, "Out" }).Completed:Connect(function() --[[ Line: 28 | Upvalues: Functions (ref), p1 (ref), v2 (ref), p4 (ref), p3 (ref), Rotation (ref), i (ref), p5 (ref), t (ref) ]]
						Functions.Tween(p1, {
							Rotation = v2
						}, { p4, p3, "Out" }).Completed:Connect(function() --[[ Line: 34 | Upvalues: Functions (ref), p1 (ref), Rotation (ref), p4 (ref), p3 (ref), i (ref), p5 (ref), t (ref) ]]
							Functions.Tween(p1, {
								Rotation = Rotation
							}, { p4, p3, "Out" }).Completed:Connect(function() --[[ Line: 40 | Upvalues: i (ref), p5 (ref), t (ref), p1 (ref) ]]
								if i == p5 then
									t[p1] = nil

									return true
								end
							end)
						end)
					end)
				end)
				task.wait(p4 * 4)
			end
		end)
	end
end