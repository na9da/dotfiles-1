#!/usr/bin/python
import re, os

def get_authinfo_password(machine, login):
    s = "machine %s login %s password ([^ ]*)\n" % (machine, login)
    p = re.compile(s)
    authinfo = os.popen("gpg -q --no-tty -d ~/.authinfo.gpg").read()
    return p.search(authinfo).group(1)
