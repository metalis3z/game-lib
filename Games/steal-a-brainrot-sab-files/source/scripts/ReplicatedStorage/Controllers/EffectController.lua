-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

game:GetService("ReplicatedStorage")
game:GetService("Players")
require(script.Types)

local t1 = {
	Effects = {},
	ActiveEffects = {}
}

function t1.Activate(_: {[any]: any}, s1: string)
	local v4 = t1.Effects[s1]

	if not v4 then
		return false
	end

	if type(v4.Activate) == "function" then
		v4:Activate()
	end

	return true
end
function t1.Run(_: {[any]: any}, s2: string, s3: string)
	local v8 = t1.Effects[s3]

	if not v8 then
		return false, false
	end

	if not t1.ActiveEffects[s3] then
		t1.ActiveEffects[s3] = {}
	end

	local v9 = table.clone(t1.ActiveEffects[s3])

	t1.ActiveEffects[s3][s2] = true

	if next(v9) then
		if type(v8.OnUpdate) == "function" then
			v8:OnUpdate()
		end

		return false, true
	end

	if type(v8.OnStart) == "function" then
		v8:OnStart()
	end

	return true, true
end
function t1.Stop(_: {[any]: any}, s4: string, s5: string)
	local v13 = t1.Effects[s5]

	if not v13 then
		return false
	end

	if not t1.ActiveEffects[s5] then
		return false
	end

	if not next(t1.ActiveEffects[s5]) then
		return false
	end

	t1.ActiveEffects[s5][s4] = nil

	if type(v13.OnUpdate) == "function" then
		v13:OnUpdate()
	end

	if next(t1.ActiveEffects[s5]) then
		return false
	end

	t1.ActiveEffects[s5] = nil

	if type(v13.OnStop) == "function" then
		v13:OnStop()
	end

	return true
end
function t1.Load(_)
	for _, child in script.Effects:GetChildren() do
		if not child:IsA("ModuleScript") then
			continue
		end

		local ok, result = coroutine.resume(coroutine.create(require), child)

		if ok and type(result) == "table" then
			if type(result.OnLoad) == "function" then
				local ok2, result2 = coroutine.resume(coroutine.create(result.OnLoad), result)

				if not ok2 then
					warn(`Effect { child:GetFullName() } failed to call Load function:\n{ (if result2 ~= nil then result2 else "yielded (possibly)") }`)

					continue
				end
			end

			t1.Effects[child.Name] = result

			continue
		end

		warn(`Effect { child:GetFullName() } failed to load:\n{ (if result ~= nil then result else "yielded (possibly)") }`)
	end
end
function t1.Start(_)
end

return t1
