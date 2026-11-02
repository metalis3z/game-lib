-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local assertDeepEqual = require(script.Parent.assertDeepEqual)
    local createSpy = require(script.Parent.createSpy)
    local Logging = require(script.Parent.Logging)
    local SingleEventManager = require(script.Parent.SingleEventManager)
    describe("new", function() -- line 8 | captures: SingleEventManager
        it("should create a SingleEventManager", function() -- line 9 | captures: SingleEventManager
            local v1 = SingleEventManager.new()
            expect(v1).to.be.ok()
        end)
    end)
    describe("connectEvent", function() -- line 16 | captures: assertDeepEqual, createSpy, Logging, SingleEventManager
        it("should connect to events", function() -- line 17 | captures: createSpy, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v2 = SingleEventManager.new(BindableEvent)
            local v3 = createSpy()
            v2:connectEvent("Event", v3.value)
            v2:resume()
            BindableEvent:Fire("foo")
            expect(v3.callCount).to.equal(1)
            v3:assertCalledWith(BindableEvent, "foo")
            BindableEvent:Fire("bar")
            expect(v3.callCount).to.equal(2)
            v3:assertCalledWith(BindableEvent, "bar")
            v2:connectEvent("Event", nil)
            BindableEvent:Fire("baz")
            expect(v3.callCount).to.equal(2)
        end)
        it("should drop events until resumed initially", function() -- line 39 | captures: createSpy, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v4 = SingleEventManager.new(BindableEvent)
            local v5 = createSpy()
            v4:connectEvent("Event", v5.value)
            BindableEvent:Fire("foo")
            expect(v5.callCount).to.equal(0)
            v4:resume()
            BindableEvent:Fire("bar")
            expect(v5.callCount).to.equal(1)
            v5:assertCalledWith(BindableEvent, "bar")
        end)
        it("should invoke suspended events when resumed", function() -- line 56 | captures: createSpy, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v6 = SingleEventManager.new(BindableEvent)
            local v7 = createSpy()
            v6:connectEvent("Event", v7.value)
            v6:resume()
            BindableEvent:Fire("foo")
            expect(v7.callCount).to.equal(1)
            v7:assertCalledWith(BindableEvent, "foo")
            v6:suspend()
            BindableEvent:Fire("bar")
            expect(v7.callCount).to.equal(1)
            v6:resume()
            expect(v7.callCount).to.equal(2)
            v7:assertCalledWith(BindableEvent, "bar")
        end)
        it("should invoke events triggered during resumption in the correct order", function() -- line 78 | captures: assertDeepEqual, createSpy, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v8 = SingleEventManager.new(BindableEvent)
            local v9 = {}
            local v10 = createSpy(function(v11, v12) -- line 83 | captures: BindableEvent, v9
                table.insert(v9, v12)
                if v12 == 2 then
                    BindableEvent:Fire(3)
                elseif v12 == 3 then
                    BindableEvent:Fire(4)
                end
            end)
            v8:connectEvent("Event", v10.value)
            v8:suspend()
            BindableEvent:Fire(1)
            BindableEvent:Fire(2)
            v8:resume()
            expect(v10.callCount).to.equal(4)
            assertDeepEqual(v9, { 1, 2, 3, 4 })
        end)
        it("should not invoke events fired during suspension but disconnected before resumption", function() -- line 104 | captures: createSpy, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v13 = SingleEventManager.new(BindableEvent)
            local v14 = createSpy()
            v13:connectEvent("Event", v14.value)
            v13:suspend()
            BindableEvent:Fire(1)
            v13:connectEvent("Event", nil)
            v13:resume()
            expect(v14.callCount).to.equal(0)
        end)
        it("should not yield events through the SingleEventManager when resuming", function() -- line 120 | captures: SingleEventManager
            local function v15(...)
                assert(...)
            end

            local function v16(...)
                assert(...)
            end

            local BindableEvent = Instance.new("BindableEvent")
            local v17 = SingleEventManager.new(BindableEvent)
            v17:connectEvent("Event", function() -- line 124
                coroutine.yield()
            end)
            v17:resume()
            local v18 = coroutine.create(function() -- line 130 | captures: BindableEvent
                BindableEvent:Fire(5)
            end)
            v15(coroutine.resume(v18))
            expect(coroutine.status(v18)).to.equal("dead")
            v17:suspend()
            BindableEvent:Fire(5)
            local v19 = coroutine.create(function() -- line 140 | captures: v17
                v17:resume()
            end)
            v16(coroutine.resume(v19))
            expect(coroutine.status(v19)).to.equal("dead")
        end)
        it("should not throw errors through SingleEventManager when resuming", function() -- line 148 | captures: Logging, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v20 = SingleEventManager.new(BindableEvent)
            v20:connectEvent("Event", function() -- line 154
                error("Error from SingleEventManager test")
            end)
            v20:resume()
            v20:suspend()
            BindableEvent:Fire(5)
            local v21 = Logging.capture(function() -- line 167 | captures: v20
                v20:resume()
            end)
            expect(#v21.errors).to.equal(0)
            expect(#v21.warnings).to.equal(1)
            expect(#v21.infos).to.equal(0)
            expect(v21.warnings[1]:find("Error from SingleEventManager test")).to.be.ok()
        end)
        it("should not overflow with events if manager:resume() is invoked when resuming a suspended event", function() -- line 178 | captures: createSpy, SingleEventManager
            local BindableEvent = Instance.new("BindableEvent")
            local v22 = SingleEventManager.new(BindableEvent)
            local v23 = createSpy(function(v24, v25) -- line 186 | captures: BindableEvent, v22
                if v25 ~= 1 then
                    return
                end
                v22:suspend()
                BindableEvent:Fire(2)
                v22:resume()
            end)
            v22:connectEvent("Event", v23.value)
            v22:suspend()
            BindableEvent:Fire(1)
            v22:resume()
            expect(v23.callCount).to.equal(2)
        end)
    end)
    describe("connectPropertyChange", function() -- line 204 | captures: createSpy, SingleEventManager
        it("should connect to property changes", function() -- line 208 | captures: createSpy, SingleEventManager
            local Folder = Instance.new("Folder")
            local v26 = SingleEventManager.new(Folder)
            local v27 = createSpy()
            v26:connectPropertyChange("Name", v27.value)
            v26:resume()
            Folder.Name = "foo"
            expect(v27.callCount).to.equal(1)
            v27:assertCalledWith(Folder)
            Folder.Name = "bar"
            expect(v27.callCount).to.equal(2)
            v27:assertCalledWith(Folder)
            v26:connectPropertyChange("Name")
            Folder.Name = "baz"
            expect(v27.callCount).to.equal(2)
        end)
        it("should throw an error if the property is invalid", function() -- line 230 | captures: SingleEventManager
            local Folder = Instance.new("Folder")
            local v28 = SingleEventManager.new(Folder)
            expect(function() -- line 234 | captures: v28
                v28:connectPropertyChange("foo", function() -- line 235
                end)
            end).to.throw()
        end)
    end)
end
