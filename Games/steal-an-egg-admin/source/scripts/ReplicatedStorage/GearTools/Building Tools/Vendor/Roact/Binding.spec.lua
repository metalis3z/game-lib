-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local createSpy = require(script.Parent.createSpy)
    local Type = require(script.Parent.Type)
    local GlobalConfig = require(script.Parent.GlobalConfig)
    local Binding = require(script.Parent.Binding)
    describe("Binding.create", function() -- line 8 | captures: Type, Binding
        it("should return a Binding object and an update function", function() -- line 9 | captures: Type, Binding
            local v1, v2 = Binding.create(1)
            expect(Type.of(v1)).to.equal(Type.Binding)
            expect((typeof(v2))).to.equal("function")
        end)
        it("should support tostring on bindings", function() -- line 16 | captures: Binding
            local v3, v4 = Binding.create(1)
            expect((tostring(v3))).to.equal("RoactBinding(1)")
            v4("foo")
            expect((tostring(v3))).to.equal("RoactBinding(foo)")
        end)
    end)
    describe("Binding object", function() -- line 25 | captures: createSpy, Binding
        it("should provide a getter and setter", function() -- line 26 | captures: Binding
            local v5, v6 = Binding.create(1)
            expect(v5:getValue()).to.equal(1)
            v6(3)
            expect(v5:getValue()).to.equal(3)
        end)
        it("should let users subscribe and unsubscribe to its updates", function() -- line 36 | captures: createSpy, Binding
            local v7, v8 = Binding.create(1)
            local v9 = createSpy()
            local v10 = Binding.subscribe(v7, v9.value)
            expect(v9.callCount).to.equal(0)
            v8(2)
            expect(v9.callCount).to.equal(1)
            v9:assertCalledWith(2)
            v10()
            v8(3)
            expect(v9.callCount).to.equal(1)
        end)
    end)
    describe("Mapped bindings", function() -- line 56 | captures: createSpy, Binding
        it("should be composable", function() -- line 57 | captures: Binding
            local hi, hi_2 = Binding.create("hi")
            local v11 = hi:map(string.len)
            local v12 = v11:map(function(v13) -- line 61
                return v13 % 2 == 0
            end)
            expect(hi:getValue()).to.equal("hi")
            expect(v11:getValue()).to.equal(2)
            expect(v12:getValue()).to.equal(true)
            hi_2("sup")
            expect(hi:getValue()).to.equal("sup")
            expect(v11:getValue()).to.equal(3)
            expect(v12:getValue()).to.equal(false)
        end)
        it("should cascade updates when subscribed", function() -- line 76 | captures: createSpy, Binding
            local hi, hi_2 = Binding.create("hi")
            local v14 = createSpy()
            local v15 = Binding.subscribe(hi, v14.value)
            local v16 = hi:map(string.len)
            local v17 = createSpy()
            local v18 = Binding.subscribe(v16, v17.value)
            local v19 = v16:map(function(v20) -- line 90
                return v20 % 2 == 0
            end)
            local v21 = createSpy()
            local v22 = Binding.subscribe(v19, v21.value)
            expect(v14.callCount).to.equal(0)
            expect(v17.callCount).to.equal(0)
            expect(v21.callCount).to.equal(0)
            hi_2("nice")
            expect(v14.callCount).to.equal(1)
            v14:assertCalledWith("nice")
            expect(v17.callCount).to.equal(1)
            v17:assertCalledWith(4)
            expect(v21.callCount).to.equal(1)
            v21:assertCalledWith(true)
            v15()
            v18()
            v22()
            hi_2("goodbye")
            expect(v14.callCount).to.equal(1)
            expect(v21.callCount).to.equal(1)
            expect(v17.callCount).to.equal(1)
        end)
        it("should throw when updated directly", function() -- line 123 | captures: Binding
            local v23 = Binding.create(1):map(function(v24) -- line 125
                return v24
            end)
            expect(function() -- line 129 | captures: v23, Binding
                Binding.update(v23, 5)
            end).to.throw()
        end)
    end)
    describe("Binding.join", function() -- line 135 | captures: createSpy, GlobalConfig, Binding
        it("should have getValue", function() -- line 136 | captures: Binding
            local v25 = Binding.create(1)
            local v26 = Binding.create(2)
            local v27 = Binding.create(3)
            local join = Binding.join
            local v28 = { v25, v26 }
            v28.foo = v27
            local v29 = join(v28):getValue()
            expect(v29).to.be.a("table")
            expect(v29[1]).to.equal(1)
            expect(v29[2]).to.equal(2)
            expect(v29.foo).to.equal(3)
        end)
        it("should update when any one of the subscribed bindings updates", function() -- line 154 | captures: createSpy, Binding
            local v30, v31 = Binding.create(1)
            local v32, v33 = Binding.create(2)
            local v34, v35 = Binding.create(3)
            local join = Binding.join
            local v36 = { v30, v32 }
            v36.foo = v34
            local v37 = join(v36)
            local v38 = createSpy()
            Binding.subscribe(v37, v38.value)
            expect(v38.callCount).to.equal(0)
            v31(3)
            expect(v38.callCount).to.equal(1)
            local value = v38:captureValues("value")
            expect(value.value).to.be.a("table")
            expect(value.value[1]).to.equal(3)
            expect(value.value[2]).to.equal(2)
            expect(value.value.foo).to.equal(3)
            v33(4)
            expect(v38.callCount).to.equal(2)
            local value_2 = v38:captureValues("value")
            expect(value_2.value).to.be.a("table")
            expect(value_2.value[1]).to.equal(3)
            expect(value_2.value[2]).to.equal(4)
            expect(value_2.value.foo).to.equal(3)
            v35(8)
            expect(v38.callCount).to.equal(3)
            local value_3 = v38:captureValues("value")
            expect(value_3.value).to.be.a("table")
            expect(value_3.value[1]).to.equal(3)
            expect(value_3.value[2]).to.equal(4)
            expect(value_3.value.foo).to.equal(8)
        end)
        it("should disconnect from all upstream bindings", function() -- line 198 | captures: createSpy, Binding
            local v39, v40 = Binding.create(1)
            local v41, v42 = Binding.create(2)
            local v43 = Binding.join({ v39, v41 })
            local v44 = createSpy()
            local v45 = Binding.subscribe(v43, v44.value)
            expect(v44.callCount).to.equal(0)
            v40(3)
            expect(v44.callCount).to.equal(1)
            v42(3)
            expect(v44.callCount).to.equal(2)
            v45()
            v40(4)
            expect(v44.callCount).to.equal(2)
            v42(2)
            expect(v44.callCount).to.equal(2)
            local v46 = v43:getValue()
            expect(v46[1]).to.equal(4)
            expect(v46[2]).to.equal(2)
        end)
        it("should be okay with calling disconnect multiple times", function() -- line 227 | captures: Binding
            local v47 = Binding.join({})
            local v48 = Binding.subscribe(v47, function() -- line 230
            end)
            v48()
            v48()
        end)
        it("should throw if updated directly", function() -- line 236 | captures: Binding
            local v49 = Binding.join({})
            expect(function() -- line 239 | captures: v49, Binding
                Binding.update(v49, 0)
            end)
        end)
        it("should throw when a non-table value is passed", function() -- line 244 | captures: GlobalConfig, Binding
            GlobalConfig.scoped({ typeChecks = true }, function() -- line 247 | captures: Binding
                expect(function() -- line 248 | captures: Binding
                    Binding.join("hi")
                end).to.throw()
            end)
        end)
        it("should throw when a non-binding value is passed via table", function() -- line 254 | captures: GlobalConfig, Binding
            GlobalConfig.scoped({ typeChecks = true }, function() -- line 257 | captures: Binding
                expect(function() -- line 258 | captures: Binding
                    local v50 = Binding.create(123)
                    Binding.join({ v50, "abcde" })
                end).to.throw()
            end)
        end)
    end)
end
