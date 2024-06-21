# -*- encoding: utf-8 -*-
"""
Trinity
trinity.app.cli.commands module

"""
import argparse

from hio.base import doing

parser = argparse.ArgumentParser(description="This is the bar command")
parser.set_defaults(handler=lambda args: run(args))
parser.add_argument('--name', '-n', help='Human readable reference', required=True)
parser.add_argument('--base', '-b', help='additional optional prefix to file location of KERI keystore',
                    required=False, default="")
parser.add_argument('--alias', '-a', help='human readable alias for the new identifier prefix', required=True)
parser.add_argument('--passcode', '-p', help='21 character encryption passcode for keystore (is not saved)',
                    dest="bran", default=None)  # passcode => bran

FORMAT = '%(asctime)s [trinity] %(levelname)-8s %(message)s'

def run(args):
    name = args.name

    rotateDoer = RotateDoer(name=name, alias=args.alias, base=args.base, bran=args.bran,)

    doers = [rotateDoer]
    return doers

class RotateDoer(doing.DoDoer):

    def __init__(self, name, alias, said, base, bran, registryName, send, timestamp, **kwa):
        doers = []
        super(RotateDoer, self).__init__(doers=doers, **kwa)

    def recur(self, tymth, tock=3.0):
        print("recur")
