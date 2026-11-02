-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: init.test, time of decompilation: Sun May  3 10:10:51 2026 ]]
local ServerScriptService = game:GetService("ServerScriptService")

require(ServerScriptService.TestRunner.Test)

local function AwaitCondition(p1: ((...any) -> ...any), n1: number?) -- line: 5
	local elapsed = os.clock()
	local v6 = n1 or 10

	while not p1() do
		if v6 < os.clock() - elapsed then
			return false
		end

		task.wait()
	end

	return true
end

return function(p2) -- line: 19
	-- upvalues: AwaitCondition (copy)
	local Parent = require(script.Parent)
	local u9 = nil

	p2:BeforeEach(function() -- line: 29
		-- upvalues: u9 (ref), Parent (copy)
		u9 = Parent.new()
	end)
	p2:AfterEach(function() -- line: 33
		-- upvalues: u9 (ref)
		u9:Destroy()
	end)
	p2:Describe("Constructor", function() -- line: 37
		-- upvalues: p2 (copy), Parent (copy), u9 (ref), AwaitCondition (copy)
		p2:Test("should create a new signal and fire it", function() -- line: 38
			-- upvalues: p2 (copy), Parent (copy), u9 (ref)
			p2:Expect(Parent.Is(u9)):ToBe(true)
			task.defer(function() -- line: 40
				-- upvalues: u9 (ref)
				u9:Fire(10, 20)
			end)

			local v11, v12 = u9:Wait()

			p2:Expect(v11):ToBe(10)
			p2:Expect(v12):ToBe(20)
		end)
		p2:Test("should create a proxy signal and connect to it", function() -- line: 48
			-- upvalues: Parent (copy), p2 (copy), AwaitCondition (copy)
			local v13 = Parent.Wrap(game:GetService("RunService").Heartbeat)

			p2:Expect(Parent.Is(v13)):ToBe(true)

			local u14 = false

			v13:Connect(function() -- line: 52
				-- upvalues: u14 (ref)
				u14 = true
			end)
			p2:Expect(AwaitCondition(function() -- line: 55
				-- upvalues: u14 (ref)
				return u14
			end, 2)):ToBe(true)
			v13:Destroy()
		end)
	end)
	p2:Describe("FireDeferred", function() -- line: 62
		-- upvalues: p2 (copy), u9 (ref), AwaitCondition (copy)
		p2:Test("should be able to fire primitive argument", function() -- line: 63
			-- upvalues: u9 (ref), p2 (copy), AwaitCondition (copy)
			local u15 = nil

			u9:Connect(function(p3) -- line: 66
				-- upvalues: u15 (ref)
				u15 = p3
			end)
			u9:FireDeferred(10)
			p2:Expect(AwaitCondition(function() -- line: 70
				-- upvalues: u15 (ref)
				return u15 == 10
			end, 1)):ToBe(true)
		end)
		p2:Test("should be able to fire a reference based argument", function() -- line: 75
			-- upvalues: u9 (ref), p2 (copy), AwaitCondition (copy)
			local t1 = {
				10,
				20
			}
			local u17 = nil

			u9:Connect(function(p4) -- line: 78
				-- upvalues: u17 (ref)
				u17 = p4
			end)
			u9:FireDeferred(t1)
			p2:Expect(AwaitCondition(function() -- line: 82
				-- upvalues: t1 (copy), u17 (ref)
				return t1 == u17
			end, 1)):ToBe(true)
		end)
	end)
	p2:Describe("Fire", function() -- line: 88
		-- upvalues: p2 (copy), u9 (ref)
		p2:Test("should be able to fire primitive argument", function() -- line: 89
			-- upvalues: u9 (ref), p2 (copy)
			local u18 = nil

			u9:Connect(function(p5) -- line: 92
				-- upvalues: u18 (ref)
				u18 = p5
			end)
			u9:Fire(10)
			p2:Expect(u18):ToBe(10)
		end)
		p2:Test("should be able to fire a reference based argument", function() -- line: 99
			-- upvalues: u9 (ref), p2 (copy)
			local t2 = {
				10,
				20
			}
			local u20 = nil

			u9:Connect(function(p6) -- line: 102
				-- upvalues: u20 (ref)
				u20 = p6
			end)
			u9:Fire(t2)
			p2:Expect(u20):ToBe(t2)
		end)
	end)
	p2:Describe("ConnectOnce", function() -- line: 110
		-- upvalues: p2 (copy), u9 (ref)
		p2:Test("should only capture first fire", function() -- line: 111
			-- upvalues: u9 (ref), p2 (copy)
			local u21 = nil
			local v22 = u9:ConnectOnce(function(p7) -- line: 113
				-- upvalues: u21 (ref)
				u21 = p7
			end)

			p2:Expect(v22.Connected):ToBe(true)
			u9:Fire(10)
			p2:Expect(v22.Connected):ToBe(false)
			u9:Fire(20)
			p2:Expect(u21):ToBe(10)
		end)
	end)
	p2:Describe("Wait", function() -- line: 124
		-- upvalues: p2 (copy), u9 (ref)
		p2:Test("should be able to wait for a signal to fire", function() -- line: 125
			-- upvalues: u9 (ref), p2 (copy)
			task.defer(function() -- line: 126
				-- upvalues: u9 (ref)
				u9:Fire(10, 20, 30)
			end)

			local v23, v24, v25 = u9:Wait()

			p2:Expect(v23):ToBe(10)
			p2:Expect(v24):ToBe(20)
			p2:Expect(v25):ToBe(30)
		end)
	end)
	p2:Describe("DisconnectAll", function() -- line: 136
		-- upvalues: p2 (copy), u9 (ref)
		p2:Test("should disconnect all connections", function() -- line: 137
			-- upvalues: u9 (ref), p2 (copy)
			u9:Connect(function() -- line: 138
			end)
			u9:Connect(function() -- line: 139
			end)
			p2:Expect(#(nil or u9):GetConnections()):ToBe(2)
			u9:DisconnectAll()
			p2:Expect(#(nil or u9):GetConnections()):ToBe(0)
		end)
	end)
	p2:Describe("Disconnect", function() -- line: 146
		-- upvalues: p2 (copy), u9 (ref), AwaitCondition (copy)
		p2:Test("should disconnect connection", function() -- line: 147
			-- upvalues: u9 (ref), p2 (copy)
			local connection = u9:Connect(function() -- line: 148
			end)

			p2:Expect(#(nil or u9):GetConnections()):ToBe(1)
			connection:Disconnect()
			p2:Expect(#(nil or u9):GetConnections()):ToBe(0)
		end)
		p2:Test("should still work if connections disconnected while firing", function() -- line: 154
			-- upvalues: u9 (ref), p2 (copy)
			local n2 = 0
			local connection = nil

			u9:Connect(function() -- line: 157
				-- upvalues: n2 (ref)
				n2 += 1
			end)
			connection = u9:Connect(function() -- line: 160
				-- upvalues: connection (ref), n2 (ref)
				connection:Disconnect()
				n2 += 1
			end)
			u9:Connect(function() -- line: 164
				-- upvalues: n2 (ref)
				n2 += 1
			end)
			u9:Fire()
			p2:Expect(n2):ToBe(3)
		end)
		p2:Test("should still work if connections disconnected while firing deferred", function() -- line: 171
			-- upvalues: u9 (ref), p2 (copy), AwaitCondition (copy)
			local n3 = 0
			local connection = nil

			u9:Connect(function() -- line: 174
				-- upvalues: n3 (ref)
				n3 += 1
			end)
			connection = u9:Connect(function() -- line: 177
				-- upvalues: connection (ref), n3 (ref)
				connection:Disconnect()
				n3 += 1
			end)
			u9:Connect(function() -- line: 181
				-- upvalues: n3 (ref)
				n3 += 1
			end)
			u9:FireDeferred()
			p2:Expect(AwaitCondition(function() -- line: 185
				-- upvalues: n3 (ref)
				return n3 == 3
			end)):ToBe(true)
		end)
	end)
end
