RegisterCommand("record", function(source , args)
    StartRecording(1)
    exports['xt-notify']:Alert("THÔNG BÁO", "Bắt đầu Quay", 5000, 'success')
end)

RegisterCommand("clip", function(source , args)
    StartRecording(0)
end)

RegisterCommand("saveclip", function(source , args)
    StopRecordingAndSaveClip()
    exports['xt-notify']:Alert("THÔNG BÁO", "Lưu file Quay", 5000, 'success')
end)

RegisterCommand("delclip", function(source , args)
    StopRecordingAndDiscardClip()
    exports['xt-notify']:Alert("THÔNG BÁO", "Xoá file Quay", 5000, 'error')
end)

RegisterCommand("editor", function(source , args)
    NetworkSessionLeaveSinglePlayer()
    ActivateRockstarEditor()
    exports['xt-notify']:Alert("THÔNG BÁO", "Từ từ", 5000, 'error')
end)
