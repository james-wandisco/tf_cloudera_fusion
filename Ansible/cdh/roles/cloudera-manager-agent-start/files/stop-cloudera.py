#!/usr/bin/env python

from __future__ import print_function

import os
import sys
from subprocess import call, Popen, PIPE


class Process(object):
    def __init__(self, pid, ppid, args):
        self.pid = pid
        self.ppid = ppid
        self.args = args

    def kill(self):
        if self.pid == 1:
            raise Exception("Attempted to kill init!")
        print("Killing: %s" % self)
        call(['kill', '%s' % self.pid])

    def __str__(self):
        return '%d %d %s' % (self.pid, self.ppid, self.args)


class ProcessList(list):
    def populate(self):
        cmd = Popen(['ps', '-eo', 'pid=', '-o', 'ppid=', '-o', 'args='],
                    stdout=PIPE, stderr=PIPE, universal_newlines=True)
        (stdout, stderr) = cmd.communicate()
        for line in stdout.strip().split(os.linesep):
            (pid_s, ppid_s, args) = line.split(None, 2)
            pid = int(pid_s)
            if pid == cmd.pid:
                continue

            self.append(Process(pid, int(ppid_s), args))

    def find_processes(self, name):
        return [p for p in self if name in p.args]


if __name__ == '__main__':
    processes = ProcessList()
    processes.populate()

    agents = [
        '/usr/lib64/cmf/agent/build/env/bin/cmf-agent',
        '/usr/lib/cmf/agent/build/env/bin/cmf-agent',
        '/usr/lib64/cmf/agent/src/cmf/agent.py',
        '/opt/cloudera/cm-agent/bin/cm agent',
        ]

    agent_procs = []
    for agent in agents:
        agent_procs.extend(processes.find_processes(agent))

    if len(agent_procs) == 0:
        print("No processes found, probably not running")
        sys.exit(0)

    for agent_proc in agent_procs:
        agent_proc.kill()

    """
    Exit 'failure' state. This is so we can run the script in a loop in
    ansible until the processes are no longer running
    """
    sys.exit(1)
