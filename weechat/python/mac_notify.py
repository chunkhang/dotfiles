# https://github.com/chunkhang/weechat-mac-notify

import datetime
import subprocess
import weechat

SCRIPT_NAME = 'mac_notify'
SCRIPT_AUTHOR = 'Marcus Mu <chunkhang@gmail.com>'
SCRIPT_VERSION = '1.0.0'
SCRIPT_LICENSE = 'MIT'
SCRIPT_DESC = 'macOS notifications for WeeChat messages'


def notify(data, buffer, date, tags, displayed, highlight, prefix, message):
    # Ignore messages from yourself
    own_nick = weechat.buffer_get_string(buffer, 'localvar_nick')
    if prefix == ('@%s' % own_nick) or prefix in tags:
        return weechat.WEECHAT_RC_OK

    # Ignore messages from current buffer
    if buffer == weechat.current_buffer():
        return weechat.WEECHAT_RC_OK

    # Ignore messages older than 5 seconds ago
    message_time = datetime.datetime.utcfromtimestamp(int(date))
    now_time = datetime.datetime.utcnow()
    if (now_time - message_time).seconds > 5:
        return weechat.WEECHAT_RC_OK

    title = '%s ' % prefix
    # From highlight
    if int(highlight):
        channel = weechat.buffer_get_string(buffer, 'localvar_channel')
        title += channel
    # From private
    elif 'notify_private' in tags:
        title += '[private]'
    else:
        return weechat.WEECHAT_RC_OK

    # Send notification
    notification = 'display notification "%s" with title "%s"' % (message,
                                                                  title)
    process = subprocess.Popen('osascript -'.split(), stdin=subprocess.PIPE,
                               stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    process.communicate(notification)
    exit_code = process.wait()
    if exit_code == 0:
        return weechat.WEECHAT_RC_OK
    else:
        return weechat.WEECHAT_RC_ERROR


def main():
    weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION,
                     SCRIPT_LICENSE, SCRIPT_DESC, '', '')
    weechat.hook_print('', 'irc_privmsg', '', 1, 'notify', '')


if __name__ == '__main__':
    main()
