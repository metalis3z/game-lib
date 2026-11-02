
local CollectionService = game:GetService("CollectionService")

function observeTag(s1: string, p1: ((...any) -> ...any), t1: {[any]: any}?)
	local t2 = {}
	local t3 = {}
	local connection = nil

	local function IsGoodAncestor(p2)
		if t1 == nil then
			return true
		end

		for _, v17 in t1 do
			if p2:IsDescendantOf(v17) then
				return true
			end
		end

		return false
	end
	local function AttemptStartup(p3)
		t2[p3] = "__inflight__"
		task.defer(function()
			if t2[p3] ~= "__inflight__" then
				return
			end

			local ok, result = xpcall(function(p4)
				local v63 = p1(p4)

				assert(typeof(v63) == "nil" or typeof(v63) == "function", "callback must return a function")

				return v63
			end, debug.traceback, p3)

			if not ok then
				local s2 = ""
				local v44 = string.split(result, "\n")[1]
				local v45 = string.find(v44, ": ")

				if v45 then
					s2 = v44:sub(v45 + 1)
				end

				warn(`error while calling observeTag("{ s1 }") callback:{ s2 }\n{ result }`)

				return
			end

			if type(result) == "function" then
				if t2[p3] ~= "__inflight__" then
					task.spawn(result)

					return
				end

				t2[p3] = result
			end
		end)
	end
	local function AttemptCleanup(p5)
		local v20 = t2[p5]

		t2[p5] = "__dead__"

		if typeof(v20) == "function" then
			task.spawn(v20)
		end
	end
	local function OnAncestryChanged(p6)
		local v22, g25

		if t1 == nil then
			v22 = true
		else
			g25 = nil
			v22 = nil

			for _, v24 in t1 do
				if p6:IsDescendantOf(v24) then
					v22 = true
					g25 = true
				end

				if g25 then
					break
				end
			end

			if not g25 then
				v22 = false
			end
		end

		g25 = false

		if v22 then
			if t2[p6] == "__dead__" then
				t2[p6] = "__inflight__"
				task.defer(function()
					if t2[p6] ~= "__inflight__" then
						return
					end

					local ok, result = xpcall(function(p7)
						local v65 = p1(p7)

						assert(typeof(v65) == "nil" or typeof(v65) == "function", "callback must return a function")

						return v65
					end, debug.traceback, p6)

					if not ok then
						local s3 = ""
						local v49 = string.split(result, "\n")[1]
						local v50 = string.find(v49, ": ")

						if v50 then
							s3 = v49:sub(v50 + 1)
						end

						warn(`error while calling observeTag("{ s1 }") callback:{ s3 }\n{ result }`)

						return
					end

					if type(result) == "function" then
						if t2[p6] ~= "__inflight__" then
							task.spawn(result)

							return
						end

						t2[p6] = result
					end
				end)

				return
			end
		else
			local v26 = t2[p6]

			t2[p6] = "__dead__"

			if typeof(v26) == "function" then
				task.spawn(v26)
			end
		end
	end
	local function OnInstanceAdded(p8)
		if not connection.Connected then
			return
		end

		if t2[p8] ~= nil then
			return
		end

		t2[p8] = "__dead__"
		t3[p8] = p8.AncestryChanged:Connect(function()
			local v51 = p8
			local v52, g55

			if t1 == nil then
				v52 = true
			else
				g55 = nil
				v52 = nil

				for _, v54 in t1 do
					if v51:IsDescendantOf(v54) then
						v52 = true
						g55 = true
					end

					if g55 then
						break
					end
				end

				if not g55 then
					v52 = false
				end
			end

			g55 = false

			if v52 then
				if t2[v51] == "__dead__" then
					t2[v51] = "__inflight__"
					task.defer(function()
						if t2[v51] ~= "__inflight__" then
							return
						end

						local ok, result = xpcall(function(p9)
							local v74 = p1(p9)

							assert(typeof(v74) == "nil" or typeof(v74) == "function", "callback must return a function")

							return v74
						end, debug.traceback, v51)

						if not ok then
							local s4 = ""
							local v69 = string.split(result, "\n")[1]
							local v70 = string.find(v69, ": ")

							if v70 then
								s4 = v69:sub(v70 + 1)
							end

							warn(`error while calling observeTag("{ s1 }") callback:{ s4 }\n{ result }`)

							return
						end

						if type(result) == "function" then
							if t2[v51] ~= "__inflight__" then
								task.spawn(result)

								return
							end

							t2[v51] = result
						end
					end)

					return
				end
			else
				local v56 = t2[v51]

				t2[v51] = "__dead__"

				if typeof(v56) == "function" then
					task.spawn(v56)
				end
			end
		end)

		local v28, g31

		if t1 == nil then
			v28 = true
		else
			g31 = nil
			v28 = nil

			for _, v30 in t1 do
				if p8:IsDescendantOf(v30) then
					v28 = true
					g31 = true
				end

				if g31 then
					break
				end
			end

			if not g31 then
				v28 = false
			end
		end

		g31 = false

		if v28 then
			if t2[p8] == "__dead__" then
				t2[p8] = "__inflight__"
				task.defer(function()
					if t2[p8] ~= "__inflight__" then
						return
					end

					local ok, result = xpcall(function(p10)
						local v72 = p1(p10)

						assert(typeof(v72) == "nil" or typeof(v72) == "function", "callback must return a function")

						return v72
					end, debug.traceback, p8)

					if not ok then
						local s5 = ""
						local v60 = string.split(result, "\n")[1]
						local v61 = string.find(v60, ": ")

						if v61 then
							s5 = v60:sub(v61 + 1)
						end

						warn(`error while calling observeTag("{ s1 }") callback:{ s5 }\n{ result }`)

						return
					end

					if type(result) == "function" then
						if t2[p8] ~= "__inflight__" then
							task.spawn(result)

							return
						end

						t2[p8] = result
					end
				end)

				return
			end
		else
			local v32 = t2[p8]

			t2[p8] = "__dead__"

			if typeof(v32) == "function" then
				task.spawn(v32)
			end
		end
	end
	local function OnInstanceRemoved(p11)
		local v34 = t2[p11]

		t2[p11] = "__dead__"

		if typeof(v34) == "function" then
			task.spawn(v34)
		end

		local v35 = t3[p11]

		if v35 then
			v35:Disconnect()
			t3[p11] = nil
		end

		t2[p11] = nil
	end

	connection = CollectionService:GetInstanceAddedSignal(s1):Connect(OnInstanceAdded)

	local connection2 = CollectionService:GetInstanceRemovedSignal(s1):Connect(OnInstanceRemoved)

	task.defer(function()
		if not connection.Connected then
			return
		end

		for _, v37 in CollectionService:GetTagged(s1) do
			task.spawn(OnInstanceAdded, v37)
		end
	end)

	return function()
		connection:Disconnect()
		connection2:Disconnect()

		local v38 = next(t2)

		while v38 do
			local v39 = t2[v38]

			t2[v38] = "__dead__"

			if typeof(v39) == "function" then
				task.spawn(v39)
			end

			local v40 = t3[v38]

			if v40 then
				v40:Disconnect()
				t3[v38] = nil
			end

			t2[v38] = nil
			v38 = next(t2)
		end
	end
end

return observeTag
