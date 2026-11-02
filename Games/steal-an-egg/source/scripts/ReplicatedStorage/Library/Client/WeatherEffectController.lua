-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Types)

local t = {
	Effects = {},
	ActiveEffects = {}
}

function t.Activate(p1, p2) --[[ Activate | Line: 8 | Upvalues: t (copy) ]]
	local v1 = t.Effects[p2]

	if not v1 then
		return false
	end

	if type(v1.Activate) ~= "function" then
		return true
	end

	v1:Activate()

	return true
end
function t.Run(p1, p2, p3) --[[ Run | Line: 19 | Upvalues: t (copy) ]]
	local v1 = t.Effects[p3]

	if not v1 then
		return false
	end

	if not t.ActiveEffects[p3] then
		t.ActiveEffects[p3] = {}
	end

	local v2 = table.clone(t.ActiveEffects[p3])

	t.ActiveEffects[p3][p2] = true

	if next(v2) then
		return false
	end

	if type(v1.OnStart) ~= "function" then
		return true
	end

	v1:OnStart()

	return true
end
function t.Stop(p1, p2, p3) --[[ Stop | Line: 38 | Upvalues: t (copy) ]]
	local v1 = t.Effects[p3]

	if not v1 then
		return false
	end

	if not t.ActiveEffects[p3] then
		return false
	end

	if not next(t.ActiveEffects[p3]) then
		return false
	end

	t.ActiveEffects[p3][p2] = nil

	if next(t.ActiveEffects[p3]) then
		return false
	end

	t.ActiveEffects[p3] = nil

	if type(v1.OnStop) ~= "function" then
		return true
	end

	v1:OnStop()

	return true
end
function t.Load() --[[ Load | Line: 60 | Upvalues: t (copy) ]]
	for v1, v2 in script.Effects:GetChildren() do
		if v2:IsA("ModuleScript") then
			local v3, v4 = coroutine.resume(coroutine.create(require), v2)

			if v3 and type(v4) == "table" then
				if type(v4.OnLoad) == "function" then
					local v5, v6 = coroutine.resume(coroutine.create(v4.OnLoad), v4)

					if v5 then
						t.Effects[v2.Name] = v4

						continue
					end

					warn(("Effect %s failed to call Load function:\n%s"):format(v2:GetFullName(), if v6 == nil then "yielded (possibly)" else v6))
				else
					t.Effects[v2.Name] = v4
				end

				continue
			end

			warn(("Effect %s failed to load:\n%s"):format(v2:GetFullName(), if v4 == nil then "yielded (possibly)" else v4))
		end
	end
end
function t.Start() --[[ Start | Line: 90 ]] end

return t