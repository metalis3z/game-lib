-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local InstanceCheck = require(ReplicatedStorage.Library.Functions.InstanceCheck)
local v1 = TweenInfo.new

function t.CleanUp(p1, p2) --[[ CleanUp | Line: 13 | Upvalues: InstanceCheck (copy), Debris (copy) ]]
	if InstanceCheck(p1, "Tween") then
		local v1 = nil

		v1 = p1.Completed:Connect(function() --[[ Line: 19 | Upvalues: p2 (copy), v1 (ref), p1 (copy), Debris (ref) ]]
			if typeof(p2) == "function" then
				p2()
			end

			v1 = nil

			if not p1 then
				return
			end

			Debris:AddItem(p1, 0)
		end)

		return p1, v1
	end

	return warn("Invalid Tween provided to World_Animator.CleanUp:", p1)
end
function t.Build_Spectrum(p1) --[[ Build_Spectrum | Line: 34 | Upvalues: InstanceCheck (copy) ]]
	if type(p1) ~= "table" then
		return warn("Invalid target_Data provided to World_Animator.Build_Spectrum:", p1)
	end

	local Configuration = Instance.new("Configuration")

	if not InstanceCheck(Configuration, "Configuration") then
		return
	end

	for v1, v2 in p1 do
		if v1:match("__") then
			Configuration.Name = "Configuration_" .. v2

			continue
		end

		local v3 = Instance.new("StringValue")

		v3.Parent = Configuration
		v3.Name = v1

		for v4, v5 in v2 do
			v3:SetAttribute(v4, v5)
		end
	end

	return Configuration
end
function t.Extract_Configured_TI(p1) --[[ Extract_Configured_TI | Line: 62 | Upvalues: InstanceCheck (copy), v1 (copy) ]]
	local v12 = InstanceCheck(p1, "Configuration") and p1:FindFirstChild("TweenInfo")
	local v2 = InstanceCheck(v12, "StringValue") and v12:GetAttributes()

	if typeof(v2) ~= "table" then
		return
	end

	local t = {}

	for v3, v4 in v2 do
		if not v3:match("__") then
			t[tonumber(v3:sub(-1))] = typeof(v4) == "string" and Enum[v3:split("_")[1]][v4] or v4
		end
	end

	return v1(unpack(t))
end
function t.Bulk(p1, p2, p3) --[[ Bulk | Line: 81 | Upvalues: InstanceCheck (copy), t (copy), TweenService (copy) ]]
	if typeof(p1) == "table" and (typeof(p2) == "string" or typeof(p2) == "table") then
		local t2 = {}

		for v2, v3 in typeof(p2) == "table" and p2 or { p2 } do
			for v4, v5 in p1 do
				local v6 = if typeof(v5) == "Instance" then v5:FindFirstChild("Configuration_" .. v3) else false

				if InstanceCheck(v6, "Configuration") and not v5:FindFirstAncestor("StarterGui") then
					local v7 = t.Extract_Configured_TI(v6)
					local v8 = v6.Target:GetAttributes()
					local Originale = v6:FindFirstChild("Originale")

					if typeof(v8) == "table" and typeof(v7) == "TweenInfo" then
						for k in pairs(v8) do
							if k:match("__") then
								v8[k] = nil
							end
						end

						t2[v3] = if p3 then t2[v3] or {} else p3

						local v10, v11

						if v6:GetAttribute("Use_Processing") then
							local v12 = true

							for v13, v14 in v5:GetChildren() do
								if v14 ~= v6 and (v14:GetAttribute("Use_Processing") and (v14:GetAttribute("Processing") and not ((v14:GetAttribute("Priority") or -1) <= (v6:GetAttribute("Priority") or 0)))) then
									v12 = false

									break
								end
							end

							if v12 then
								v6:SetAttribute("Processing", true)
								v10 = function() --[[ Kernel | Line: 134 | Upvalues: Originale (copy), v5 (copy), p3 (copy), t2 (ref), v3 (copy), t (ref), TweenService (ref), v7 (copy), v8 (copy), v6 (copy) ]]
									if Originale then
										for v1, v2 in Originale:GetAttributes() do
											if not v1:match("__") then
												v5[v1] = v2
											end
										end
									end

									local v4 = t.CleanUp(TweenService:Create(v5, v7, v8), function() --[[ Line: 145 | Upvalues: v6 (ref) ]]
										if v6 then
											v6:SetAttribute("Processing", false)
										end
									end);

									(p3 and t2[v3] or t2)[v5] = v4
									v4:Play()
								end
								v11 = v6:GetAttribute("Thread_Delay")

								if typeof(v11) == "number" then
									task.delay(v11, v10)

									continue
								end

								v10()
							end
						else
							v10 = function() --[[ Kernel | Line: 134 | Upvalues: Originale (copy), v5 (copy), p3 (copy), t2 (ref), v3 (copy), t (ref), TweenService (ref), v7 (copy), v8 (copy), v6 (copy) ]]
								if Originale then
									for v1, v2 in Originale:GetAttributes() do
										if not v1:match("__") then
											v5[v1] = v2
										end
									end
								end

								local v4 = t.CleanUp(TweenService:Create(v5, v7, v8), function() --[[ Line: 145 | Upvalues: v6 (ref) ]]
									if v6 then
										v6:SetAttribute("Processing", false)
									end
								end);

								(p3 and t2[v3] or t2)[v5] = v4
								v4:Play()
							end
							v11 = v6:GetAttribute("Thread_Delay")

							if typeof(v11) == "number" then
								task.delay(v11, v10)

								continue
							end

							v10()
						end
					end
				end
			end
		end

		local function v15(p1) --[[ Recurse | Line: 165 | Upvalues: v15 (copy), InstanceCheck (ref) ]]
			if typeof(p1) ~= "table" then
				return
			end

			for v1, v2 in p1 do
				if typeof(v2) == "table" then
					v15(v2)

					continue
				end

				if InstanceCheck(v2, "Tween") then
					v2:Cancel()
				end
			end
		end

		function t2.Destroy(p12) --[[ Destroy | Line: 183 | Upvalues: v15 (copy), p1 (copy), t2 (ref) ]]
			v15(p12)

			if not p1.__erase then
				return
			end

			table.clear(t2)
			t2 = nil
		end

		return t2
	end

	return warn("Invalid configuration for BulkTween:", p1, p2)
end

return t