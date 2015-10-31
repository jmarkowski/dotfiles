#!/usr/bin/env python3
import subprocess
import sys
import tempfile

def main():

    if len(sys.argv) > 1:
        tmp = tempfile.NamedTemporaryFile()

        # The --yes makes it ignore the "overwrite tmp.name?" prompt.
        cmd = 'gpg --yes -o {0} ~/notes/web-accounts.notes.gpg'.format(tmp.name)
        subprocess.call(cmd, shell=True)
        subprocess.call('echo ----', shell=True)

        cmd = 'cat {0} | grep -i '.format(tmp.name) + sys.argv[1]
        subprocess.call(cmd, shell=True)

        tmp.close()
    else:
        print("Usage: getpassword <search_string>")

    return 0

if __name__ == '__main__':
    try:
        retcode = main()
        sys.exit(retcode)
    except KeyboardInterrupt:
        print('Aborting.')
