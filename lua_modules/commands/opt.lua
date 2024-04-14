---@diagnostic disable: param-type-mismatch
local commands = {}

commands["4x"] = { require("lua_modules/commands/opt/boost_4x"), "Toggle experience boost by 4x" }
commands["exp_debug"] = { require("lua_modules/commands/opt/exp_debug"), "Toggle experience debug messaging" }
commands["mighty"] = { require("lua_modules/commands/opt/mighty"), "Toggle mighty" }
commands["mighty_solo"] = { require("lua_modules/commands/opt/mighty_solo"), "Toggle mighty solo" }
commands["mighty_debug"] = { require("lua_modules/commands/opt/mighty_debug"), "Toggle mighty debug messaging" }
commands["catchup"] = { require("lua_modules/commands/opt/boost_catchup"), "Toggle experience catchup" }
commands["return"] = { require("lua_modules/commands/opt/return_command"), "Return to last death location" }

---@param e PlayerEventCommand
local function opt(e)
    if #e.args < 1 then
        opt_usage(e)
        return
    end

    local command = commands[e.args[1]]
    if not command then
        e.self:Message(MT.Say, "Unknown option: " .. e.args[1])
        opt_usage(e)
        return
    end

    local func = command[1]
    func(e)
end

---@param e PlayerEventCommand
function opt_usage(e)
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x ~= "ON" then
        boost_4x = "OFF"
    end

    local boost_catchup = e.self:GetBucket("boost_catchup")

    if boost_catchup ~= "ON" then
        boost_catchup = "OFF"
    end



    local exp_debug = e.self:GetBucket("exp_debug")
    if exp_debug ~= "ON" then
        exp_debug = "OFF"
    end

    e.self:Message(MT.Say,
        "exp: [" ..
        eq.say_link("#opt 4x", true, "4x " .. boost_4x) ..
        "] [" ..
        eq.say_link("#opt catchup", true, "catchup " .. boost_catchup) ..
        "] [" .. eq.say_link("#opt exp_debug", true, "exp_debug " .. exp_debug) .. "]")

    local boost_mighty = e.self:GetBucket("boost_mighty")
    if boost_mighty ~= "ON" then
        boost_mighty = "OFF"
    end

    local boost_mighty_solo = e.self:GetBucket("boost_mighty_solo")
    if boost_mighty_solo ~= "ON" then
        boost_mighty_solo = "OFF"
    end

    local mighty_debug = e.self:GetBucket("mighty_debug")
    if mighty_debug ~= "ON" then
        mighty_debug = "OFF"
    end

    e.self:Message(MT.Say,
        "mighty: [" ..
        eq.say_link("#opt mighty", true, "mighty " .. boost_mighty) ..
        "] [" ..
        eq.say_link("#opt mighty_solo", true, "mighty_solo " .. boost_mighty_solo) ..
        "] [" .. eq.say_link("#opt mighty_debug", true, "mighty_debug " .. mighty_debug) .. "]")

    local return_text = "return: no recent deaths"
    local zone_id = tonumber(e.self:GetBucket("return_zone_id"))
    if not zone_id then
        zone_id = 0
    end
    if zone_id > 0 then
        local zone_name = eq.get_zone_long_name_by_id(zone_id)
        if zone_name ~= "" then
            return_text = "return: to [" .. eq.say_link("#opt return", true, zone_name) .. "]"
        end
    end

    e.self:Message(MT.Say, return_text)
end

return opt
