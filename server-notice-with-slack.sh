#!/bin/sh

# サーバーの状態を通知する
# slack apiのincoming webhookを使う

TEMP_FILE_NAME="report_message_content"

# 通知内容
{
date
echo ""
echo "\`postqueue -p | tail\`"
postqueue -p | tail
echo ""
echo "\`top -b | head -n 20\`"
top -b | head -n 20
echo "\`top -b -o %MEM | head -n 20\`"
top -b -o %MEM | head -n 20
} > $TEMP_FILE_NAME

#cat "$FILE_NAME" | mail -s "status report" -r from@example.com to@example.com

SERVER_NAME=""
# slack webhook https://hooks.slack.com/services/xxxxx
WEBHOOK_URL="https://hooks.slack.com/services/xxxxx"
# slack quotation border line color
SERVER_COLOR="#38647e"
MESSAGE=$(cat $TEMP_FILE_NAME)

echo '{
  "attachments": [
    {
      "mrkdwn_in": ["text"],
      "color": "'"$SERVER_COLOR"'",
      "author_name": "'"$SERVER_NAME"'",
      "title": "'"$SERVER_NAME"' server status report",
      "text": "'"$MESSAGE"'"
    }
  ]
}' > $TEMP_FILE_NAME.json

curl -X POST \
-H 'Content-Type: application/json' \
-d "$(cat $TEMP_FILE_NAME.json)" \
$WEBHOOK_URL
rm $TEMP_FILE_NAME $TEMP_FILE_NAME.json
