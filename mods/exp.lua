---@param e ModGetExperienceForKill
function GetExperienceForKill(e)
    if not e.self:IsClient() then
        return e
    end
    local client = e.self:CastToClient()

    local experience = require('experience')

    local base_exp = experience.get_base(e.other)
    base_exp = base_exp * 0.6499999761581

    local multiplier = 1
    local boost_4x = e.self:GetBucket("boost_4x")
    if boost_4x == "ON" then
        multiplier = multiplier * 4
    end

    local boost_catchup = e.self:GetBucket("boost_catchup")
    if boost_catchup == "ON" then
        local level = client:GetLevel()
        multiplier = multiplier + 6
        if level >= 10 then
            multiplier = multiplier + 4
        end
        if level >= 20 then
            multiplier = multiplier + 4
        end
        if level >= 30 then
            multiplier = multiplier + 4
        end
        if level >= 40 then
            multiplier = multiplier + 6
        end
        if level >= 50 then
            multiplier = multiplier + 10
        end
    end

    local final_exp = base_exp * multiplier

    local is_debug = e.self:GetBucket("exp_debug")

    if is_debug == "ON" then
        e.self:Message(MT.Experience, string.format("Base EXP: %d, Multiplier: x%d, Before Con/Split Final: %d", base_exp, multiplier, final_exp))
    end

    e.ReturnValue = final_exp
    e.IgnoreDefault = true
    return e
end
