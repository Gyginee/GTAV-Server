Thanks for your purchase, hope you are satisfied with the script!


1. To display a notification you should call it like below:
   1. Using Client Side:
exports['xt-notify']:Alert("Title", "Message", Time, 'type')

   2. Using Server Side:
TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không đủ <span style='color:#ff0000'>quyền hạn</span>!", 5000, 'error')


2. To set the notification display time, use:
   1. 1000 - `[1 second]`
   2. 2000 - `[2 seconds]`
   3. 5000 - `[5 seconds]`
   4. 10000 - `[10 seconds]`
   5. etc...

3. To change the type of notification, use this types of notifications:
   1. success
   2. info
   3. warning
   4. error
   5. sms
   6. long

4. To change the icon of notification, use:
   1. Icon Library: https://fontawesome.com/v5/cheatsheet
   2. Open file `styles.css`
   3. Change this lines (only value!): `content: "\f00c";`
   4. Here u are :)

5. Don't forget to delete example notifications in file `client.lua` from line `15` to `51` (or don't delete if you don't want to)
