local commands = { }

commands["4x"] = { require("lua_modules/commands/opt/boost_4x"), "Toggle experience boost by 4x"}

---@param e PlayerEventCommand
local function opt(e)
    if #e.args < 1 then
        opt_usage(e)
        return
    end

    local command = commands[e.args[1]];
    if not command then
        e.self:Message(MT.White("Unknown option: " .. e.args[2]))
        opt_usage(e)
        return
    end

    local func = command[1]
    func(e)
end

---@param e PlayerEventCommand
function opt_usage(e)
    local boost_4x = e.self:GetBucket("boost_4x");
    if boost_4x ~= "ON" then
        boost_4x = "OFF"
    end

    e.self:Message(MT.White, "exp: [".. eq.say_link("#opt 4x", true, "4x " .. boost_4x).."]");
end

return opt;