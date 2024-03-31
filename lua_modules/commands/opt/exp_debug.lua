--- @param e PlayerEventCommand
local function exp_debug(e)
    local exp_debug = e.self:GetBucket("exp_debug")
    if exp_debug == "ON" then
        exp_debug = "OFF"
    else
        exp_debug = "ON"
    end
    e.self:SetBucket("exp_debug", exp_debug)
    e.self:Message(MT.Say, "Experience debug messaging is now " .. exp_debug)
end

return exp_debug;