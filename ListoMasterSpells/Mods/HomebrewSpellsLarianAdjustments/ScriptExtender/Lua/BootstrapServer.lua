Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(char, status)
    if (status == "CRACKLE_RESET_LAUNCHER") then
        Osi.RealtimeObjectTimerLaunch(char, "HomebrewSpellsAdjustments_ResetCrackle", 1500)
    end

    if (status == "SKY_BURST_BLOCK") then
        Osi.RealtimeObjectTimerLaunch(char, "HomebrewSpellsAdjustments_ResetSkyBurst", 1500)
    end
end)

Ext.Osiris.RegisterListener("ObjectTimerFinished", 2, "after", function(char, timer)
    if (timer == "HomebrewSpellsAdjustments_ResetCrackle") then
        Osi.RemoveStatus(char, "CRACKLE_1")
        Osi.RemoveStatus(char, "CRACKLE_2")
        Osi.RemoveStatus(char, "CRACKLE_3")
    end

    if (timer == "HomebrewSpellsAdjustments_ResetSkyBurst") then
        Osi.RemoveStatus(char, "SKY_BURST_BLOCK")
    end
end)