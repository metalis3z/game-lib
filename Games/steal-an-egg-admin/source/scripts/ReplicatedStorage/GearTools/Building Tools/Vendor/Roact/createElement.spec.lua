-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function() -- line 1
    local Component = require(script.Parent.Component)
    local ElementKind = require(script.Parent.ElementKind)
    local GlobalConfig = require(script.Parent.GlobalConfig)
    local Logging = require(script.Parent.Logging)
    local Type = require(script.Parent.Type)
    local Portal = require(script.Parent.Portal)
    local Children = require(script.Parent.PropMarkers.Children)
    local createElement = require(script.Parent.createElement)
    it("should create new primitive elements", function() -- line 12 | captures: ElementKind, Type, createElement
        local Frame = createElement("Frame")
        expect(Frame).to.be.ok()
        expect(Type.of(Frame)).to.equal(Type.Element)
        expect(ElementKind.of(Frame)).to.equal(ElementKind.Host)
    end)
    it("should create new functional elements", function() -- line 20 | captures: ElementKind, Type, createElement
        local v1 = createElement(function() -- line 21
        end)
        expect(v1).to.be.ok()
        expect(Type.of(v1)).to.equal(Type.Element)
        expect(ElementKind.of(v1)).to.equal(ElementKind.Function)
    end)
    it("should create new stateful components", function() -- line 29 | captures: Component, ElementKind, Type, createElement
        local Foo = Component:extend("Foo")
        local v2 = createElement(Foo)
        expect(v2).to.be.ok()
        expect(Type.of(v2)).to.equal(Type.Element)
        expect(ElementKind.of(v2)).to.equal(ElementKind.Stateful)
    end)
    it("should create new portal elements", function() -- line 39 | captures: ElementKind, Type, Portal, createElement
        local v3 = createElement(Portal)
        expect(v3).to.be.ok()
        expect(Type.of(v3)).to.equal(Type.Element)
        expect(ElementKind.of(v3)).to.equal(ElementKind.Portal)
    end)
    it("should accept props", function() -- line 47 | captures: createElement
        local v4 = createElement("StringValue", { Value = "Foo" })
        expect(v4).to.be.ok()
        expect(v4.props.Value).to.equal("Foo")
    end)
    it("should accept props and children", function() -- line 56 | captures: Children, createElement
        local IntValue = createElement("IntValue")
        local v5 = createElement("StringValue", { Value = "Foo" }, { Child = IntValue })
        expect(v5).to.be.ok()
        expect(v5.props.Value).to.equal("Foo")
        expect(v5.props[Children]).to.be.ok()
        expect(v5.props[Children].Child).to.equal(IntValue)
    end)
    it("should accept children with without props", function() -- line 71 | captures: Children, createElement
        local IntValue = createElement("IntValue")
        local v6 = createElement("StringValue", nil, { Child = IntValue })
        expect(v6).to.be.ok()
        expect(v6.props[Children]).to.be.ok()
        expect(v6.props[Children].Child).to.equal(IntValue)
    end)
    it("should warn once if children is specified in two different ways", function() -- line 83 | captures: Logging, Children, createElement
        local v7 = Logging.capture(function() -- line 84 | captures: Children, createElement
            for v8 = 1, 2 do
                createElement("Frame", {
                    [Children] = {}
                }, {})
            end
        end)
        expect(#v7.warnings).to.equal(1)
        expect(v7.warnings[1]:find("createElement")).to.be.ok()
        expect(v7.warnings[1]:find("Children")).to.be.ok()
    end)
    it("should have a `source` member if elementTracing is set", function() -- line 99 | captures: GlobalConfig, createElement
        local v9 = { elementTracing = true }
        GlobalConfig.scoped(v9, function() -- line 104 | captures: createElement
            local StringValue = createElement("StringValue")
            expect(StringValue.source).to.be.a("string")
        end)
    end)
end
